library(pdftools)
library(tidyverse)

load_wpb <- function(
    path = "data/raw/wpb/wpb_prison_population_14th.pdf"
) {
  pages <- pdf_text(path)[3:16]
  lines <- unlist(str_split(pages, "\n"))
  
  region_headers <- c(
    "Northern Africa", "Western Africa", "Central Africa",
    "Eastern Africa", "Southern Africa",
    "Northern America", "Central America", "Caribbean", "South America",
    "Western Asia", "Central Asia", "Southern Asia", "South-Eastern Asia",
    "Eastern Asia", "Northern Europe", "Southern Europe", "Western Europe",
    "Central & Eastern Europe", "Europe/Asia", "Oceania"
  )
  
  records        <- list()
  current_region <- NA_character_
  
  for (line in lines) {
    trimmed <- str_trim(line)
    if (trimmed == "") next
    
    if (trimmed %in% region_headers) {
      current_region <- trimmed
      next
    }
    
    if (str_detect(trimmed, "^\\d")) next
    if (str_detect(trimmed, "^(World|Table|Prison|Date|Estim|Trend|Part|year|total|rate|population|Figures)")) next
    if (!str_detect(trimmed, "\\d")) next
    
    cleaned <- str_replace_all(trimmed, "c\\.\\s+", "c.")
    parts   <- str_split(cleaned, "\\s{2,}")[[1]]
    parts   <- parts[parts != ""]
    
    if (length(parts) < 4) next
    
    country_name <- str_trim(parts[1])
    if (str_length(country_name) < 2) next
    if (str_detect(country_name, "^[\\*\\+\\d]")) next
    
    # Scan parts for total and rate by value rather than fixed position
    # Handles multi-word country names shifting column indices
    total_idx <- NA
    rate_idx  <- NA
    
    for (i in 2:min(length(parts), 7)) {
      val <- suppressWarnings(as.numeric(str_remove_all(parts[i], "c\\.|,")))
      if (!is.na(val)) {
        if (is.na(total_idx) && val > 50 && val == round(val))        total_idx <- i
        else if (!is.na(total_idx) && val >= 1 && val <= 2000 
                 && val == round(val))                            { rate_idx <- i; break }
      }
    }
    
    if (is.na(total_idx) | is.na(rate_idx)) next
    
    raw_total <- parts[total_idx]
    raw_rate  <- parts[rate_idx]
    is_approx <- str_detect(raw_total, "c\\.") | str_detect(raw_rate, "c\\.")
    pop_total <- str_remove_all(raw_total, "c\\.|,") |> as.numeric()
    pop_rate  <- str_remove_all(raw_rate,  "c\\.") |> as.numeric()
    
    if (is.na(pop_total) | is.na(pop_rate)) next
    if (pop_rate <= 0 | pop_rate > 2000)    next
    
    records[[length(records) + 1]] <- tibble(
      region           = current_region,
      country          = country_name,
      prison_pop_total = pop_total,
      prison_pop_rate  = pop_rate,
      is_approximate   = is_approx
    )
  }
  
  # El Salvador parses incorrectly due to c. on both total and rate
  # with a decimal date field confusing the scanner — hardcoded from WPB p.6
  records[[length(records) + 1]] <- tibble(
    region           = "Central America",
    country          = "El Salvador",
    prison_pop_total = 71000,
    prison_pop_rate  = 1086,
    is_approximate   = TRUE
  )
  
  wpb <- bind_rows(records) |>
    mutate(
      continent = case_when(
        str_detect(region, "Africa")            ~ "Africa",
        str_detect(region, "America|Caribbean") ~ "Americas",
        str_detect(region, "Asia")              ~ "Asia",
        str_detect(region, "Europe")            ~ "Europe",
        str_detect(region, "Oceania")           ~ "Oceania",
        TRUE ~ NA_character_
      )
    )
  
  message("WPB loaded: ", nrow(wpb), " countries")
  wpb
}
