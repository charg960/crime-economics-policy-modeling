library(ipumsr)

load_cps <- function(
    ddi_path  = "data/raw/ipums_cps/cps_00001.xml",
    data_path = "data/raw/ipums_cps/cps_00001.dat.gz"
) {
  ddi <- read_ipums_ddi(ddi_path)
  raw <- read_ipums_micro(ddi, data_file = data_path, verbose = FALSE)
  names(raw) <- tolower(names(raw))
  
  message("CPS before filter: ", nrow(raw), " rows")
  message("ASECFLAG values: ", paste(sort(unique(raw$asecflag)), collapse = ", "))
  
  # Filter to ASEC supplement only — income variables only collected here
  # ASECFLAG == 1 identifies ASEC respondents
  raw <- raw |> dplyr::filter(asecflag == 1)
  
  message("CPS after ASEC filter: ", nrow(raw), " rows x ", ncol(raw), " cols")
  raw <- raw |> dplyr::select(-hwtfinl, -wtfinl, -hflag)
  
  raw
}