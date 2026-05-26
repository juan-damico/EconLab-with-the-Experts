<div align="center">

<br/>

<img src="https://raw.githubusercontent.com/juan-damico/forecasting-economics/main/assets/Logo2.png" width="320" alt="EconLab with the Experts"/>

<br/><br/>

## Episode 01 — What Drives the Scenario? Interpreting Conditional Forecasts in Reduced-Form VARs

![Language](https://img.shields.io/badge/R-4.3-276DC3?style=flat-square&logo=r&logoColor=white)
![CRAN](https://img.shields.io/cran/v/cforecast?style=flat-square&label=CRAN&color=276DC3)
![Status](https://img.shields.io/badge/status-replication--ready-4a7c59?style=flat-square)
![Series](https://img.shields.io/badge/EconLab-Episode%2001-1a1a2e?style=flat-square)
![License](https://img.shields.io/badge/license-CC%20BY--NC--SA%204.0-lightgrey?style=flat-square)

</div>

---

## Presenter

<img src="https://media.licdn.com/dms/image/v2/C4D03AQHK8gusQVNNNQ/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1599928939138?e=1779926400&v=beta&t=KMO1sNYnAty9nN2Ybmjk7af0IwfR2WY8LoqiS6tWeXo" width="160" align="left" style="margin-right:20px; margin-bottom:8px;">

<strong>Tim Ginker, PhD</strong> · Bank of Israel <br/>
<em>Current Role: Econometrician</em><br/>
Fields: Applied Macroeconomics · Time Series Econometrics 

<br/>

📧 <a href="mailto:timginker@gmail.com">Contact</a> &nbsp;·&nbsp;
🔗 <a href="https://www.linkedin.com/in/tim-ginker/">LinkedIn</a> &nbsp;·&nbsp;
📄 <a href="https://scholar.google.com/citations?user=fWxgZdMAAAAJ&hl=en&oi=ao">Google Scholar</a> &nbsp;·&nbsp;
📑 <a href="https://github.com/timginker/cforecast">Personal Github</a>

<br clear="left"/>

---

## Overview

In this tutorial, Dr. Ginker — the author of `cforecast` — introduces the package he developed for conducting scenario analysis in reduced-form VAR models. The tutorial walks through how to generate conditional forecasts using a Kalman filtering framework, impose path restrictions on selected variables, and decompose forecast revisions into variable-specific contributions. It also shows how to assess the relative importance of each variable in driving forecast outcomes, with direct applications to policy analysis, stress testing, and macro-financial forecasting.

A key insight of this framework, emphasized throughout, is that reduced-form VARs serve as a **robust and transparent cross-check** for macroeconomic outlooks — complementing more complex structural models (such as DSGEs or SVARs) without relying on their identification assumptions. As Dr. Ginker and co-author Caspi put it: reduced-form forecasts are easier to implement, more robust to misspecification, and more transparent in their empirical content.

---

## What You Will Learn

By watching this tutorial, you will be able to:

- **Generate conditional forecasts** using the `cforecast` package — imposing assumed future paths on selected variables within a reduced-form VAR, and obtaining the model-implied joint forecast consistent with those assumptions.

- **Use Kalman filter observation weights** to go beyond the forecast itself and understand *what is driving it* — decomposing forecast revisions into quantifiable contributions from specific variables and specific quarters of the imposed scenario path.

- **Distinguish overall from marginal variable importance** — separating the intrinsic weight the model assigns to each variable from the realized dynamics of the evaluation period, enabling ex ante assessment of which conditioning assumptions truly matter.

- **Apply reduced-form VARs as a transparent cross-check** — interpreting scenario forecasts without requiring structural identification, and communicating results in a model-consistent, economically interpretable way.

---

## The Empirical Application

The empirical illustration uses U.S. quarterly data from 1986Q2 to 2015Q4, with a five-variable reduced-form VAR(2) selected by BIC. The variables are real GDP growth, core PCE inflation, the federal funds rate, the Moody's Baa–10Y corporate credit spread, and the WTI crude oil price.
The forecast exercise begins at 2016Q1, looking 20 quarters (five years) ahead.

## The Scenario Forecasting
The scenario combines two inputs that are common in policy and stress-testing work:
Financial tightening: the corporate credit spread widens by approximately 200 basis points relative to baseline, remains elevated for several quarters, and then gradually normalises.
Energy price disruption: the WTI oil price rises sharply above baseline, peaking around $75 per barrel within the first year, and then mean-reverts.

<div align="center">

<img src="https://github.com/timginker/cforecast/raw/master/man/figures/README-unnamed-chunk-3-1.png" width="700">

<sub>
Figure 1: Conditional forecast generated from the VAR model under a combined credit spread and oil price shock scenario.
</sub>

</div>

---

## Video Tutorial

<p align="center">
  <a href="https://www.youtube.com/watch?v=Wrbl7b7lq-M">
    <img 
      src="assets/video-thumbnail.png" 
      width="850"
      alt="Video Tutorial"
    />
  </a>
</p>

---

## Installation

The `cforecast` package was developed by **Tim Ginker, PhD** and is available on CRAN. You can install it directly in R:

```r
install.packages("cforecast")
```

---

## Repository Structure

```text
Episode-01-Interpreting Conditional Forecasts in Reduced-Form VARs/
├── Code/           # Replication Code
├── Paper/          # Research Paper
├── Slides/         # Presentation slides
└── README.md
```

---

## Citation

If you use this material in your research or teaching, please cite the intellectual author of this episode:

```bibtex
@techreport{CaspiGinker2026,
  author       = {Itamar Caspi and Tim Ginker},
  title        = {What Drives the Scenario? Interpreting Conditional Forecasts in Reduced-Form VARs},
  year         = {2026},
  institution  = {ResearchGate},
  url          = {https://www.researchgate.net/publication/401240812_What_Drives_the_Scenario_Interpreting_Conditional_Forecasts_in_Reduced-Form_VARs},
  note         = {Accessed: 2026-05-10}
}
```

---

## Additional Technical Resources

For further technical details, methodological discussion, and additional documentation related to the underlying research paper and the `cforecast` package, please visit the official repository maintained by **Tim Ginker, PhD**:

🔗 https://github.com/timginker/cforecast

🔗 https://github.com/timginker/wex

---

## Disclaimer

The views expressed here are solely those of the author and do not necessarily represent the views of the Bank of Israel or Bar-Ilan University.

---

## License

This material is licensed under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

© **Forecasting Economics — EconLab with Experts**. All rights reserved.

You are free to use and build upon this material for non-commercial purposes, provided you give appropriate credit to the author and this repository, and share any derivative work under the same license. Commercial use is not permitted.

For permissions or licensing inquiries, contact:  
📧 [juan.damico@forecastingeconomics.com](mailto:juan.damico@forecastingeconomics.com)

---

<div align="center">
<sub>EconLab with Experts · Forecasting Economics · 2026</sub>
</div>
