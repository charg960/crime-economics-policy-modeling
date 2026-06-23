load_ncrp <- function(
    path = "data/raw/ICPSR_38048/DS0001/ncrp_term_records.rda"
) {
  env <- new.env()
  load(path, envir = env)
  raw <- get(ls(env)[[1]], envir = env)
  names(raw) <- tolower(names(raw))
  
  message("NCRP raw: ", nrow(raw), " rows x ", ncol(raw), " cols")
  
  # Convert all factor columns to character first, then select
  # This is faster than converting inside mutate row by row
  raw <- raw |>
    dplyr::mutate(dplyr::across(
      dplyr::where(is.factor), as.character
    ))
  
  ncrp <- raw |>
    dplyr::select(
      offense_general  = offgeneral,
      offense_detail   = offdetail,
      sentence_bracket = sentlgth,
      time_served      = timesrvd,
      year_admit       = admityr,
      year_release     = releaseyr,
      age_admit        = ageadmit,
      age_release      = agerelease,
      race, sex, education,
      state
    ) |>
    dplyr::mutate(
      # Convert sentence bracket to midpoint years for cost calculation
      sentence_years_mid = dplyr::case_when(
        grepl("< 1 year",       sentence_bracket) ~ 0.5,
        grepl("1-1.9",          sentence_bracket) ~ 1.5,
        grepl("2-4.9",          sentence_bracket) ~ 3.5,
        grepl("5-9.9",          sentence_bracket) ~ 7.5,
        grepl("10-24.9",        sentence_bracket) ~ 17.5,
        grepl(">=25",           sentence_bracket) ~ 30.0,
        grepl("Life|Death|LWOP",sentence_bracket) ~ NA_real_,
        TRUE ~ NA_real_
      ),
      sentence_indeterminate = grepl("Life|Death|LWOP", sentence_bracket),
      time_served_years_mid = dplyr::case_when(
        grepl("< 1 year",  time_served) ~ 0.5,
        grepl("1-1.9",     time_served) ~ 1.5,
        grepl("2-4.9",     time_served) ~ 3.5,
        grepl("5-9.9",     time_served) ~ 7.5,
        grepl(">=10",      time_served) ~ 12.0,
        TRUE ~ NA_real_
      ),
      age_admit_mid = dplyr::case_when(
        grepl("18-24", age_admit) ~ 21,
        grepl("25-34", age_admit) ~ 30,
        grepl("35-44", age_admit) ~ 40,
        grepl("45-54", age_admit) ~ 50,
        grepl("55\\+", age_admit) ~ 60,
        TRUE ~ NA_real_
      ),
    ) |>
    dplyr::filter(
      !is.na(year_admit),
      !is.na(year_release),
      as.numeric(as.character(year_admit))   >= 1990,
      as.numeric(as.character(year_release)) >= 1990
    )
  
  message("NCRP cleaned: ", nrow(ncrp), " rows")
  message("Offense types: ", paste(sort(unique(ncrp$offense_general)),
                                   collapse = ", "))
  ncrp
}