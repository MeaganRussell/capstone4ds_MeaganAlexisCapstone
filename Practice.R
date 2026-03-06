library(readr)
library(dplyr)
library(lubridate)
library(ggplot2)
library(tidyr)
library(scales)
prec <- read_csv("Prec.csv", show_col_types = FALSE)
storm <- read_csv("StormEvents_NWFL2.csv", show_col_types = FALSE)
names(prec)
names(storm)

glimpse(prec)
glimpse(storm)
storm <- storm %>%
  mutate(
    begin_date = mdy(BEGIN_DATE)
  ) %>%
  filter(
    begin_date >= as.Date("2020-01-01"),
    begin_date <= as.Date("2025-12-31")
  )
range(storm$begin_date, na.rm = TRUE)
nrow(storm)
storm <- storm %>%
  mutate(
    BEGIN_TIME = as.numeric(BEGIN_TIME),
    END_TIME   = as.numeric(END_TIME)
  )
storm <- storm %>%
  mutate(
    BEGIN_TIME = sprintf("%04d", BEGIN_TIME),
    END_TIME   = sprintf("%04d", END_TIME)
  )
storm <- storm %>%
  mutate(
    hour   = as.numeric(substr(BEGIN_TIME, 1, 2)),
    minute = as.numeric(substr(BEGIN_TIME, 3, 4))
  )
storm <- storm %>%
  mutate(
    begin_datetime = begin_date +
      hours(hour) +
      minutes(minute)
  )
storm %>%
  select(BEGIN_DATE, BEGIN_TIME, hour, minute, begin_datetime) %>%
  head()
