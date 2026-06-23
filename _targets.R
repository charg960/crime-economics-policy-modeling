library(targets)

tar_option_set(
  packages = c("tidyverse", "ipumsr", "pdftools")
)

source("R/load_wpb.R")
source("R/load_unodc.R")
source("R/load_wdi.R")
source("R/load_ncrp.R")
source("R/load_cps.R")
source("R/load_vera.R")

list(
  tar_target(wpb_raw,   load_wpb()),
  tar_target(unodc_raw, load_unodc()),
  tar_target(wdi_raw,   load_wdi()),
  tar_target(ncrp_raw,  load_ncrp()),
  tar_target(cps_raw,   load_cps()),
  tar_target(vera_raw,  load_vera())
)