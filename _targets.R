library(targets)
library(tarchetypes)
library(purrr)

source("R/functions.R")

tar_option_set(packages = c("tidyverse", "readr", "ggplot2", "broom", "purrr"))

list(
  tar_target(raw_data, read_csv("data/gdp-vs-happiness.csv")),
  tar_target(clean_data, clean_and_wrangle(raw_data)),
  tar_target(plot1, make_plot1(clean_data)),
  tar_target(plot2, make_plot2(clean_data)),
  tar_target(model_fit, fit_model(clean_data)),  # Fit the model, returns nested df with models
  tar_target(model_summary,
             model_fit %>%
               mutate(tidy_model = map(model, broom::tidy)) %>%  # Apply broom::tidy to each model
               select(country, tidy_model) %>%  # Select country and the tidy model
               unnest(tidy_model)  # Unnest the tidy model data
  )
)
