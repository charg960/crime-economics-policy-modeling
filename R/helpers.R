library(tidyverse)

inspect_headers <- function(df) names(df)

inspect_structure <- function(df) str(df)

inspect_years <- function(df) {
  year_col <- intersect(c("year", "Year", "YEAR", "yr", "yrrel"), names(df))
  if (length(year_col) == 0) {
    message("No year column found. Columns are: ", paste(names(df), collapse = ", "))
    return(NULL)
  }
  table(df[[year_col[1]]])
}

inspect_missing <- function(df) {
  df |>
    summarise(across(everything(), ~ mean(is.na(.)) * 100)) |>
    tidyr::pivot_longer(everything(),
                        names_to  = "variable",
                        values_to = "pct_missing") |>
    dplyr::arrange(desc(pct_missing)) |>
    dplyr::filter(pct_missing > 0)
}

inspect_dims <- function(df, name = "") {
  cat(name, "->", nrow(df), "rows x", ncol(df), "cols\n")
}