# Multidimensional Impact Modeling of Incarceration Policy Reform
## Active Independent Research Project (In Progress Summer 2026)
An independent, data-driven research project investigating the economic and societal trade-offs between financial penalties and mass incarceration for non-violent offenses. The project conceptualizes incarceration as a binary societal choice (incarcerate vs. fine) framed as a cost‑minimization problem with four measurable components:

- Direct carceral costs  
- Fine revenue (including day‑fine systems)  
- Recidivism adjustment  
- Workforce productivity losses

## Project Architecture & Methodology

This project implements a multi-tiered analytical pipeline:

1. **Macro-Level (Country-Year Panel Dataset):** Utilizing data from the World Prison Brief, UNODC, and the World Bank to construct a reproducible panel dataset.

2. **Bayesian Hierarchical Modeling:** Built using Stan (`brms`) to evaluate baseline fiscal savings per capita across varying world regions, utilizing prior elicitation from criminology literature and full uncertainty quantification.

3. **Micro-Level Machine Learning Classifier:** An offender-level binary classifier (`tidymodels` Random Forest) engineered to predict optimal sentencing paths, interpreted via local and global SHAP (Shapley Additive ExPlanations) values.

## Current Status

- [x] Phase 1: Conceptual Framework & Hypothesis Formulation  
- [x] Phase 2: Data Collection & Wrangling
- [/] Phase 3: Exploratory Data Analysis (Active)
- [ ] Phase 4: Bayesian Statistical Modeling  
- [ ] Phase 5: ML Classification & SHAP Explainability  
- [ ] Phase 6: Synthesis & R Markdown Reporting  

## Data Access & Legal Compliance

This project uses multiple datasets with strict redistribution restrictions.  
Raw data must not be uploaded to GitHub or shared publicly.

### World Prison Brief
- Format: PDF tables  
- Access: https://www.prisonstudies.org  
- Notes: Manual extraction; country‑year incarceration rates  
- Limitation: No redistribution of PDFs  
- Use: Macro‑level incarceration rates

### UNODC Crime & Criminal Justice Data
- Format: CSV exports  
- Access: https://dataunodc.un.org  
- Notes: Crime, sentencing, police, courts, prison flows  
- Limitation: Public domain but must cite  
- Use: Macro‑level justice indicators

### World Bank Development Indicators (WDI)
- Format: CSV exports  
- Access: https://data.worldbank.org  
- Notes: GDP, labor force, unemployment, poverty  
- Limitation: None (citation required)  
- Use: Macro‑economic controls

### BJS NCRP (National Corrections Reporting Program)
- Format: ZIP → fixed‑width + SAS/Stata/SPSS syntax  
- Access: https://www.icpsr.umich.edu  
- Notes: Offender‑level incarceration, admissions, releases  
- Limitation: Strictly no redistribution  
- Use: Micro‑level sentencing + incarceration modeling

### IPUMS CPS Microdata
- Format: DAT + XML  
- Access: https://cps.ipums.org  
- Notes: Labor force, income, demographics  
- Limitation: Strictly no redistribution  
- Required citation:  
  Flood et al. IPUMS CPS: Version 13.0 [dataset]. Minneapolis, MN: IPUMS, 2025. https://doi.org/10.18128/D030.V13.0  
- Use: Productivity loss modeling, income‑based day‑fine simulation  
- Important:  
  - May 2026 data available  
  - October 2025 missing due to shutdown

## Data Processing Notes

### NCRP

* During EDA, I found that sentence length (`sentlgth`), time served (`timesrvd`), and age at admission (`ageadmit`) were stored as categorical ranges rather than exact numeric values. To make these variables usable for analysis, each range was converted to its midpoint (e.g., "2–4.9 years" → 3.5 years).

* **Life sentences, life without parole, and death sentences** do not have meaningful numeric durations. These records were coded as `NA` and flagged separately using `sentence_indeterminate` for later modeling.

* Removed 1,524,138 records with admission or release years before 1990 since they fall outside the study period.

* The `race` variable contains approximately 8.9% missing values. This appears to reflect limitations in the original data collection rather than a processing issue; the missingness was documented and retained.

### CPS

* Exploratory analysis showed that income variables are only available in the **Annual Social and Economic Supplement (ASEC)**. The dataset was therefore restricted to ASEC observations (March collections), reducing the sample from 8,168,647 to 3,063,661 records.

* Removed `hwtfinl`, `wtfinl`, and `hflag` after determining they contained no useful information within the ASEC subset. The first two are monthly survey weights that do not apply to ASEC analyses, while `hflag` is only relevant to a specific survey year.

* Verified that income measures (`inctot`, `incwage`) are already adjusted to constant 2010 dollars by IPUMS using CPI-U inflation adjustments.

* Identified a gap in **October 2025 CPS data collection** due to the federal government shutdown. This should be documented in future time-series analyses.

### WPB

* Parsed prison population tables from PDF reports using `pdftools`.

* Some values were reported as approximate (prefixed with `"c."`). These values were retained numerically and flagged using `is_approximate = TRUE` to preserve uncertainty from original source.

* Extracted records for 219 countries and territories across five continents.

### Vera

* Initial exploration revealed 156 variables, many of which represent highly specific demographic breakdowns with substantial missingness or sparse coverage.

* The pipeline focuses on core incarceration counts and incarceration rate measures while preserving the original source data for reproducibility. This reduces complexity while retaining the variables most relevant to analysis.
