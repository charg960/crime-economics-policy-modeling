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
    
    # Region subheading
    if (trimmed %in% region_headers) {
      current_region <- trimmed
      next
    }
    
    # Skip any line that starts with a number (trend rows)
    # or known boilerplate
    if (str_detect(trimmed, "^\\d")) next
    if (str_detect(trimmed, "^(World|Table|Prison|Date|Estim|Trend|Part|year|total|rate|population|Figures)")) next
    
    # Must contain digits to be a country row
    if (!str_detect(trimmed, "\\d")) next
    
    # Collapse "c. " (with space) into "c." so it doesn't split separately
    cleaned <- str_replace_all(trimmed, "c\\.\\s+", "c.")
    
    # Split on 2+ spaces
    parts <- str_split(cleaned, "\\s{2,}")[[1]]
    parts <- parts[parts != ""]
    
    # Need at least 5 parts: name, total, date, nat_pop, rate
    if (length(parts) < 5) next
    
    country_name <- str_trim(parts[1])
    
    # Skip if name looks like a footnote or single symbol
    if (str_length(country_name) < 2) next
    if (str_detect(country_name, "^[\\*\\+\\d]")) next
    
    raw_total <- parts[2]
    raw_rate  <- parts[5]
    
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