# Multidimensional Impact Modeling of Incarceration Policy Reform
### Active Independent Research Project (In Progress — Summer 2026)

An independent, data-driven research project investigating the economic and societal trade-offs between financial penalties and mass incarceration for non-violent offenses. 

## Project Architecture & Methodology
This project implements a multi-tiered analytical pipeline:
1. **Macro-Level (Country-Year Panel Dataset):** Utilizing data from the World Prison Brief, UNODC, and the World Bank to construct a reproducible panel dataset.
2. **Bayesian Hierarchical Modeling:** Built using Stan (`brms`) to evaluate baseline fiscal savings per capita across varying world regions, utilizing prior elicitation from criminology literature and full uncertainty quantification.
3. **Micro-Level Machine Learning Classifier:** An offender-level binary classifier (`tidymodels` Random Forest) engineered to predict optimal sentencing paths, interpreted via local and global SHAP (Shapley Additive exPlanations) values.

## Current Status
- [x] Phase 1: Conceptual Framework & Hypothesis Formulation
- [/] Phase 2: Data Collection & Wrangling (Active)
- [ ] Phase 3: Exploratory Data Analysis
- [ ] Phase 4: Bayesian Statistical Modeling
- [ ] Phase 5: ML Classification & SHAP Explainability
- [ ] Phase 6: Synthesis & R Markdown Reporting
