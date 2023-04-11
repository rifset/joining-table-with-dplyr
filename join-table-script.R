library(tidyverse)

characters <- read_csv("characters.csv")
series <- read_csv("series.csv")
releasedate <- read_csv("releasedate.csv")

# INNER join
characters %>% 
  inner_join(series, by = c("id" = "characters_id"))

# LEFT join
characters %>% 
  left_join(series, by = c("id" = "characters_id"))

# RIGHT join
characters %>% 
  right_join(series, by = c("id" = "characters_id"))

# FULL join
characters %>% 
  full_join(series, by = c("id" = "characters_id"))

# SEMI join
characters %>% 
  semi_join(series, by = c("id" = "characters_id"))

# ANTI join
characters %>% 
  anti_join(series, by = c("id" = "characters_id"))

# Case 1
characters %>% 
  right_join(series, by = c("id" = "characters_id")) %>% 
  filter(series_name == "The Falcon and The Winter Soldier")

# Case 2 (approach 1)
characters %>% 
  inner_join(
    series %>% 
      left_join(releasedate, by = "series_id"),
    by = c("id" = "characters_id")
  ) %>% 
  filter(release_date == "TBA")

# Case 2 (approach 2)
characters %>% 
  left_join(series, by = c("id" = "characters_id")) %>% 
  left_join(releasedate, by = "series_id") %>% 
  filter(release_date == "TBA")

# Case 3
characters %>% 
  semi_join(
    series %>% 
      left_join(releasedate, by = "series_id") %>% 
      filter(release_date == "TBA"),
    by = c("id" = "characters_id")
  )

# Case 4
characters %>% 
  anti_join(
    series %>% 
      left_join(releasedate, by = "series_id") %>% 
      filter(!is.na(release_date)),
    by = c("id" = "characters_id")
  )
