# Multidimensional Impact Modeling of Incarceration Policy Reform
### Active Independent Research Project (In Progress Summer 2026)

An independent, data-driven research project investigating the economic and societal trade-offs between financial penalties and mass incarceration for non-violent offenses. The project conceptualizes incarceration as a binary societal choice (incarcerate vs. fine) framed as a cost‑minimization problem with four measurable components:

- Direct carceral costs  
- Fine revenue (including day‑fine systems)  
- Recidivism adjustment  
- Workforce productivity losses  

---

## Project Architecture & Methodology

This project implements a multi-tiered analytical pipeline:

1. **Macro-Level (Country-Year Panel Dataset):** Utilizing data from the World Prison Brief, UNODC, and the World Bank to construct a reproducible panel dataset.

2. **Bayesian Hierarchical Modeling:** Built using Stan (`brms`) to evaluate baseline fiscal savings per capita across varying world regions, utilizing prior elicitation from criminology literature and full uncertainty quantification.

3. **Micro-Level Machine Learning Classifier:** An offender-level binary classifier (`tidymodels` Random Forest) engineered to predict optimal sentencing paths, interpreted via local and global SHAP (Shapley Additive ExPlanations) values.

---

## Current Status

- [x] Phase 1: Conceptual Framework & Hypothesis Formulation  
- [/] Phase 2: Data Collection & Wrangling (Active)  
- [ ] Phase 3: Exploratory Data Analysis  
- [ ] Phase 4: Bayesian Statistical Modeling  
- [ ] Phase 5: ML Classification & SHAP Explainability  
- [ ] Phase 6: Synthesis & R Markdown Reporting  

---

## Data Access & Legal Compliance

This project uses multiple datasets with strict redistribution restrictions.  
Raw data must not be uploaded to GitHub or shared publicly.

### World Prison Brief  
- Access: https://www.prisonstudies.org  
- Redistribution: PDFs may not be redistributed.  
- Use: Manually downloaded country-level incarceration data.

### UNODC Crime & Criminal Justice Data  
- Access: https://dataunodc.un.org  
- Redistribution: Public domain; citation required.  
- Use: Crime, sentencing, and justice indicators.

### World Bank Development Indicators  
- Access: https://data.worldbank.org  
- Redistribution: Allowed with citation.  
- Use: GDP, labor force, and macroeconomic controls.

### BJS NCRP (National Corrections Reporting Program)  
- Access: https://www.icpsr.umich.edu  
- Redistribution: Strictly prohibited.  
- Use: Offender-level incarceration and sentencing records.

### IPUMS CPS Microdata  
- Access: https://cps.ipums.org  
- Redistribution: Strictly prohibited.  
- Required citation:  
  Flood et al. IPUMS CPS: Version 13.0 [dataset]. Minneapolis, MN: IPUMS, 2025. https://doi.org/10.18128/D030.V13.0

### Important CPS Note  
- May 2026 CPS data are available.  
- October 2025 CPS data were not collected due to the U.S. federal government shutdown.  
This gap must be documented in all time-series analyses.
