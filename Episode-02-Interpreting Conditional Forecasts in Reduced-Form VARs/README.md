<div align="center">

<br/>

<img src="https://raw.githubusercontent.com/juan-damico/forecasting-economics/main/assets/Logo2.png" width="320" alt="EconLab with the Experts"/>

<br/><br/>

## Episode 02 — What Drives the Scenario? Interpreting Conditional Forecasts in Reduced-Form VARs

![Language](https://img.shields.io/badge/R-4.3-276DC3?style=flat-square&logo=r&logoColor=white)
![Status](https://img.shields.io/badge/status-replication--ready-4a7c59?style=flat-square)
![Series](https://img.shields.io/badge/EconLab-Episode%2001-1a1a2e?style=flat-square)
![License](https://img.shields.io/badge/license-CC%20BY--NC--ND%204.0-lightgrey?style=flat-square)

</div>

---

## Presenter

<img src="https://media.licdn.com/dms/image/v2/C4D03AQHK8gusQVNNNQ/profile-displayphoto-shrink_800_800/profile-displayphoto-shrink_800_800/0/1599928939138?e=1779926400&v=beta&t=KMO1sNYnAty9nN2Ybmjk7af0IwfR2WY8LoqiS6tWeXo" width="160" align="left" style="margin-right:20px; margin-bottom:8px;">

<strong>Tim Ginker, PhD</strong> · Bank of Israel <br/>
<em>Current Role: Econometrician</em><br/>
Fields: Applied Macroeconomics · Time Series Econometrics 

<br/>

📧 <a href="mailto:timginker@gmail.com">Email Me</a> &nbsp;·&nbsp;
🔗 <a href="https://www.linkedin.com/in/tim-ginker/">LinkedIn</a> &nbsp;·&nbsp;
📄 <a href="https://scholar.google.com/citations?user=fWxgZdMAAAAJ&hl=en&oi=ao">Google Scholar</a> &nbsp;·&nbsp;
📑 <a href="https://github.com/timginker/cforecast">Personal Github</a>

<br clear="left"/>

---

## Overview

In the present tutorial, Dr. Ginker introduces the main functionalities of `cforecast`, an R package for scenario analysis in reduced-form VAR models. The tutorial demonstrates how to generate conditional forecasts using a Kalman filtering framework, impose path restrictions on selected variables, and decompose forecast revisions into variable-specific contributions. It also illustrates how to evaluate the relative importance of variables in shaping forecast outcomes, highlighting applications to policy analysis, stress testing, and macro-financial forecasting.

---

## Repository Structure

```
Episode-01-VAR-Forecasting/
├── code/           # Replication scripts
├── data/           # Dataset
├── figures/        # Output figures and plots
├── paper/          # References and related readings
├── slides/         # Presentation slides
└── README.md
---

---

## Replication

All results in this tutorial are fully replicable. Run the scripts in the following order:

```r
source("code/install_packages.R")   # Install dependencies
source("code/main.R")               # Run full analysis
```

Expected runtime: < 1 minute on a standard laptop.

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
## Disclaimer
The views expressed here are solely of the author and do not necessarily represent the views of the Bank of Israel or Bar-Ilan University

## License & Intellectual Property

This material is licensed under [CC BY-NC-ND 4.0](https://creativecommons.org/licenses/by-nc-nd/4.0/).

© **Forecasting Economics — EconLab with Experts**. All rights reserved.

The replication code, slides, and all intellectual content are the property of **Forecasting Economics — EconLab with Experts** and of the episode presenter as the intellectual author of the material.

**You may not:**
- Use this material for commercial purposes or economic gain
- Reproduce, distribute, or adapt this content without proper citation
- Use the replication code without citing the intellectual author

**If you use this material, you must cite:**
- The presenter/author of the episode (see Presenter section above)
- This repository and Forecasting Economics as the source

For permissions, licensing inquiries, or any questions on proper use, contact:  
📧 [juan.damico@forecastingeconomics.com](mailto:juan.damico@forecastingeconomics.com)

---

<div align="center">
<sub>EconLab with Experts · Forecasting Economics · 2026</sub>
</div>
