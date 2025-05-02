library(targets)
library(tarchetypes)

source("R/functions.R")

tar_option_set(packages = c("tidyverse", "readr", "ggplot2", "broom", "purrr"))

list(
  tar_target(raw_data, read_csv("data/gdp-vs-happiness.csv")),
  tar_target(clean_data, clean_and_wrangle(raw_data)),
  tar_target(plot1, make_plot1(clean_data)),
  tar_target(plot2, make_plot2(clean_data)),
  tar_target(model_fit, fit_model(clean_data)),  # returns nested df with models
  tar_target(model_summary,
             model_fit %>%
               mutate(tidy_model = map(model, broom::tidy)) %>%
               select(country, tidy_model) %>%
               unnest(tidy_model)
  )
)
