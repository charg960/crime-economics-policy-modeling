library(targets)
source("R/helpers.R")

wpb   <- tar_read(wpb_raw)
ncrp  <- tar_read(ncrp_raw)
cps   <- tar_read(cps_raw)
wdi   <- tar_read(wdi_raw)
unodc <- tar_read(unodc_raw)
vera  <- tar_read(vera_raw)

inspect_dims(wpb,   "WPB")
inspect_dims(ncrp,  "NCRP")
inspect_dims(cps,   "CPS")
inspect_dims(wdi,   "WDI")
inspect_dims(unodc, "UNODC")
inspect_dims(vera,  "Vera")

inspect_headers(ncrp)
inspect_headers(unodc)