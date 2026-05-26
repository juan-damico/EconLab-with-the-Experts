### Disclaimer

# The following script is the original work of Tim Ginker, PhD,
# and was included in this R script by Juan D'Amico (Forecasting Economics)
# as part of the EconLab with the Experts interview series.
#
# The code and methodology are derived from the `cforecast` package
# available in the author's GitHub repository:
# https://github.com/timginker/cforecast
#
# Please refer to the original repository for detailed documentation
# and explanations of each step implemented in the code.
#
# If you use the `cforecast` package in R, or build upon the related
# research, please ensure that you properly cite the original author.
#
# Additional interview materials and citation information are available at:
# https://github.com/juan-damico/EconLab-with-the-Experts/tree/main/Episode-01-Interpreting%20Conditional%20Forecasts%20in%20Reduced-Form%20VARs

# Installation
# install.packages("devtools")
devtools::install_github("timginker/cforecast")

suppressPackageStartupMessages({
  library(cforecast)
  library(tidyverse)
  library(vars)
  library(lubridate)
  library(scales)
  library(patchwork)
})

# Load packaged dataset
data(fred_macro)
data("DCOILWTICO_level")

# Restrict estimation sample'
df <- fred_macro %>%
  filter(year(date) >= 1986,
         year(date) <= 2015)

# Estimate VAR(2)
fit <- VAR(df[, -1], p = 2, type = "const")

# Baseline forecast
pred_base <- predict(fit, n.ahead = 20)

###########################################
## Scenario Design


# Slicing Oil data
DCOILWTICO_level %>% 
  mutate(date = as.Date(date)) %>% 
  dplyr::filter(year(date) >= 1986, year(date) <= 2015) %>% 
  slice(-1) -> DCOILWTICO_level

# Baseline path for oil prices (reconstructed in levels)
pred_base <- predict(fit, n.ahead = 20)
oil_base <- rep(NA, 20)
oil_base[1] <- tail(DCOILWTICO_level$DCOILWTICO, 1) *
  (1 + pred_base$fcst$DCOILWTICO[1, 1] / 100)

for (i in 2:20) {
  oil_base[i] <- oil_base[i - 1] *
    (1 + pred_base$fcst$DCOILWTICO[i, 1] / 100)
}

# Imposed scenario paths for credit spreads and oil prices
delta <- 0.7
BAA10YM_future <- c(
  rep(tail(df$BAA10YM, 1) + 2, 3),
  (tail(df$BAA10YM, 1) + 2 * delta^(1:17))
)

DCOILWTICO_future <- c(
  tail(DCOILWTICO_level$DCOILWTICO, 1) * (1.155061^(1:4)),
  tail(DCOILWTICO_level$DCOILWTICO, 1) + 33.06 * delta^(1:16)
)

# Extended date vector covering the forecast horizon
dates_0 <- fred_macro$date[1:(nrow(df) + 20)]

# Construct plotting data for the credit-spread scenario input:
#   - y: historical series (in-sample)
#   - y_base: baseline (unconditional) VAR forecast appended after the sample end
#   - y_fcst: imposed scenario path appended after the sample end
# Missing values are used to prevent ggplot from drawing lines outside the
# intended segments (history vs forecast).

df_plot <- data.frame(
  date = dates_0,
  y = c(df$BAA10YM, rep(NA,length(BAA10YM_future))),
  y_base = c(rep(NA,nrow(df)-1),
             tail(df$BAA10YM,1),pred_base$fcst$BAA10YM[,1]),
  y_fcst = c(rep(NA,nrow(df)-1),
             tail(df$BAA10YM,1),BAA10YM_future)
)

# Plot the credit-spread path:
# Solid line: historical data
# Dashed line: imposed scenario path used for conditioning
# Dotted line: baseline path implied by the VAR
p_baa <- ggplot(df_plot, aes(x = date)) +
  geom_line(aes(y = y), color = "black", linewidth = 0.8) +
  geom_line(
    aes(y = y_fcst),
    color = "black",
    linewidth = 0.7,
    linetype = "dashed"
  ) +
  geom_line(
    aes(y = y_base),
    color = "black",
    linewidth = 0.7,
    linetype = "dotted"
  )+
  labs(
    title = "Moody's Seasoned Baa Corporate Bond Yield Relative to \nYield on 10-Year Treasury Constant Maturity",
    #caption = "Notes: The solid line shows historical data. The dashed line denotes the conditional \nforecast under the imposed scenario. The dotted line shows the unconditional (baseline) forecast.",
    x = NULL,
    y = "Percentage points"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    plot.title = element_text(size = 12),
    axis.text.y = element_text(size = 8)
    #plot.title = element_text(face = "bold")
  )


# Construct plotting data for the oil price scenario input (in levels):
#   - y: historical oil price (levels series)
#   - y_fcst: imposed scenario oil price path in levels
#   - y_base: baseline oil price path reconstructed from VAR forecasts
# As above, NA padding separates the historical segment from forecast segments.

df_plot_oil <- data.frame(
  date = dates_0,
  y = c(DCOILWTICO_level$DCOILWTICO, rep(NA,length(DCOILWTICO_future))),
  y_fcst = c(rep(NA,nrow(df)-1), 
             tail(DCOILWTICO_level$DCOILWTICO,1),DCOILWTICO_future),
  y_base = c(rep(NA,nrow(df)-1), 
             tail(DCOILWTICO_level$DCOILWTICO,1),oil_base)
)

# Plot the oil price path:
# Solid line: historical data
# Dashed line: imposed scenario path used for conditioning
# Dotted line: baseline path implied by the VAR (in levels)
p_oil <- ggplot(df_plot_oil, aes(x = date)) +
  geom_line(aes(y = y), color = "black", linewidth = 0.8) +
  geom_line(
    aes(y = y_fcst),
    color = "black",
    linewidth = 0.7,
    linetype = "dashed"
  ) +
  geom_line(
    aes(y = y_base),
    color = "black",
    linewidth = 0.7,
    linetype = "dotted"
  )+
  labs(
    title = "WTI Crude Oil Price",
    subtitle = "History (solid), baseline (dotted), and scenario (dashed)",
    x = NULL,
    y = "USD per barrel"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    plot.title = element_text(size = 12),
    axis.text.y = element_text(size = 8)
  )


# Align x-axis limits across the two panels to ensure consistent time coverage
# and facilitate direct visual comparison of the two conditioning paths.
x_rng <- range(c(df_plot_oil$date, df_plot$date), na.rm = TRUE)

# Combine the two scenario-input panels into a single figure:
# Oil price on top; credit spread below. X-axis annotations are removed from
# the top panel to avoid duplication and improve readability.
combined_plot_scenarios <-
  (p_oil + scale_x_date(limits = x_rng) +
     theme(axis.title.x = element_blank(),
           axis.text.x  = element_blank(),
           axis.ticks.x = element_blank())) /
  (p_baa + scale_x_date(limits = x_rng))


suppressWarnings(combined_plot_scenarios)

####################################################
## Interpreting Variable Importance

v_imp=variable_importance_stat(fit=fit,
                               cond_var = 4:5,
                               target_var = 2,
                               horizon = 20)

# Visualize variable importance as stacked shares by horizon (normalized to 100%)
plt = ggplot(v_imp$variable_importance,
             aes(x = factor(horizon),
                 y = share,
                 fill = variable)) +
  geom_col(position = "fill", width = 0.75, color = "white", linewidth = 0.2) +
  scale_y_continuous(
    labels = percent_format(accuracy = 1),
    expand = expansion(mult = c(0, 0.02))
  ) +
  scale_fill_viridis_d(option = "cividis", end = 0.9) +
  labs(
    title = "Decomposition of Conditional Core Inflation Forecast",
    subtitle = "Overall variable importance by forecast horizon",
    x = "Forecast horizon (quarters ahead)",
    y = "Share of information (percent)",
    fill = NULL
  ) +
  theme_classic(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 11),
    plot.subtitle = element_text(size = 10),
    axis.title = element_text(size = 11),
    axis.text  = element_text(size = 10),
    legend.position = "top",
    legend.text = element_text(size = 10),
    legend.key.size = unit(0.35, "cm"),
    axis.line = element_line(linewidth = 0.3),
    axis.ticks = element_line(linewidth = 0.3)
  )

plt 

####################################################
## Marginal Variable Importance


plt_mimp = ggplot(subset(v_imp$marginal_variable_importance,share!=0),
                  aes(x = factor(horizon),
                      y = share,
                      fill = variable)) +
  geom_col(position = "fill", width = 0.75, color = "white", linewidth = 0.2) +
  scale_y_continuous(
    labels = percent_format(accuracy = 1),
    expand = expansion(mult = c(0, 0.02))
  ) +
  scale_fill_viridis_d(option = "cividis", end = 0.9) +
  labs(
    title = "Decomposition of Conditional Core Inflation Forecast",
    subtitle = "Marginal variable importance by forecast horizon",
    x = "Forecast horizon (quarters ahead)",
    y = "Share of information (percent)",
    fill = NULL
  ) +
  theme_classic(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 11),
    plot.subtitle = element_text(size = 10),
    axis.title = element_text(size = 11),
    axis.text  = element_text(size = 10),
    legend.position = "top",
    legend.text = element_text(size = 10),
    legend.key.size = unit(0.35, "cm"),
    axis.line = element_line(linewidth = 0.3),
    axis.ticks = element_line(linewidth = 0.3)
  )


plt_mimp

#########################################
## Construct Conditional Forecast

# Construct conditioning matrix
cond_path <- cbind(BAA10YM_future, DCOILWTICO_future)

# Generate conditional forecast
fct_constr <- cforecast(
  fit,
  cond_path = cond_path,
  cond_var  = 4:5
)

# Build a plotting data set for core inflation with history and both forecasts
df_plot_infl = data.frame(
  date = dates_0,
  y = c(df$PCEPILFE, rep(NA,length(BAA10YM_future))),
  y_base = c(rep(NA,nrow(df)-1),
             tail(df$PCEPILFE,1),pred_base$fcst$PCEPILFE[,1]),
  y_fcst = c(rep(NA,nrow(df)-1),
             tail(df$PCEPILFE,1),fct_constr$forecast[,2])
)

# Plot historical inflation and the conditional/unconditional forecasts
plt_fct_scenarios <-ggplot(df_plot_infl, aes(x = date)) +
  geom_line(aes(y = y), color = "black", linewidth = 0.8) +
  geom_line(
    aes(y = y_fcst),
    color = "black",
    linewidth = 0.7,
    linetype = "dashed"
  ) +
  geom_line(
    aes(y = y_base),
    color = "black",
    linewidth = 0.7,
    linetype = "dotted"
  ) +
  labs(
    title = "Core Inflation Forecasts (PCE Excluding Food and Energy)",
    #subtitle = "Conditional and unconditional projections",
    x = NULL,
    y = "Percent, quarterly rate",
    caption = "Notes: The solid line shows historical core PCE inflation. The dashed line denotes the conditional \nforecast under the imposed scenario. The dotted line shows the unconditional (baseline) forecast."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    plot.title = element_text(face = "bold", size = 11),
    plot.subtitle = element_text(size = 10),
    axis.text.y = element_text(size = 8),
    axis.text.x = element_text(size = 9),
    plot.caption = element_text(
      hjust = 0,
      size = 9,
      color = "grey30"
    )
  )

suppressWarnings(plt_fct_scenarios)

##########################################################################
# Decomposing the Conditional Forecast into Variable-Specific Contributions

fct_comp <- cforecast_composition(
  fct_constr,
  target_var = 2
)

# Add explicit horizon index
fct_comp$horizon <- 1:20

# Reshape to long format
df_long <- fct_comp %>%
  pivot_longer(
    cols      = -horizon,
    names_to  = "variable",
    values_to = "contribution"
  )

# Plot stacked contributions by horizon
ggplot(
  df_long,
  aes(x = factor(horizon),
      y = contribution,
      fill = variable)
) +
  geom_col(width = 0.8) +
  labs(
    title = "Composition of the Conditional Forecast",
    subtitle = "Contributions by variable and forecast horizon",
    x = "Forecast horizon (quarters ahead)",
    y = "Contribution to forecast",
    fill = NULL
  ) +
  scale_fill_viridis_d(option = "cividis", end = 0.9) +
  theme_classic(base_size = 12) +
  theme(
    plot.title    = element_text(face = "bold", size = 11),
    plot.subtitle = element_text(size = 10),
    axis.title    = element_text(size = 11),
    axis.text     = element_text(size = 10),
    legend.position = "top",
    legend.text     = element_text(size = 10),
    legend.key.size = unit(0.35, "cm")
  )
