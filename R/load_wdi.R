load_wdi <- function(
    path_ny = "data/raw/wdi/wdi_ny",
    path_sl = "data/raw/wdi/wdi_sl"
) {
  # World Bank CSVs have a 4-row metadata header before real column names
  read_wb_folder <- function(folder) {
    csvs <- list.files(folder, pattern = "\\.csv$", full.names = TRUE)
    csvs <- csvs[!str_detect(basename(csvs), "^Metadata")]
    map_dfr(csvs, ~ read_csv(.x, skip = 4, show_col_types = FALSE))
  }
  
  ny <- read_wb_folder(path_ny)
  sl <- read_wb_folder(path_sl)
  
  wdi <- bind_rows(ny, sl) |>
    rename(
      country        = `Country Name`,
      country_code   = `Country Code`,
      indicator      = `Indicator Name`,
      indicator_code = `Indicator Code`
    ) |>
    select(-last_col()) |>  # WB always adds a trailing empty column
    pivot_longer(
      cols      = matches("^\\d{4}$"),
      names_to  = "year",
      values_to = "value"
    ) |>
    mutate(year = as.integer(year)) |>
    filter(!is.na(value))
  
  message("WDI loaded: ", nrow(wdi), " rows")
  wdi
} 