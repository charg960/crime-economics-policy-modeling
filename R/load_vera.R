load_vera <- function(
    path = "data/raw/vera/incarceration_trends_state.csv"
) {
  raw <- read_csv(path, show_col_types = FALSE)
  
  vera <- raw |>
    dplyr::select(dplyr::any_of(c(
      "year", "state_name", "fips", "urbanicity",
      "total_prison_pop", "total_jail_pop",
      "total_prison_adm", "total_prison_pop_rate",
      "total_jail_pop_rate",
      "white_prison_pop", "black_prison_pop",
      "hispanic_prison_pop", "female_prison_pop",
      "male_prison_pop"
    ))) |>
    dplyr::filter(!is.na(year), !is.na(state_name))
  
  message("Vera loaded: ", nrow(vera), " rows x ", ncol(vera), " cols")
  vera
}