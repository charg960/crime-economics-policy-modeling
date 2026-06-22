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
- [/] Phase 2: Data Collection & Wrangling (Active)  
- [ ] Phase 3: Exploratory Data Analysis  
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
