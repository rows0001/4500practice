library(targets)
library(tarchetypes)

source("R/functions.R")

tar_option_set(packages = c("tidyverse", "readr", "ggplot2", "broom"))

list(
  tar_target(raw_data, read_csv("data/your_data.csv")),
  tar_target(clean_data, clean_and_wrangle(raw_data)),
  tar_target(plot1, make_plot1(clean_data)),
  tar_target(plot2, make_plot2(clean_data)),
  tar_target(model_fit, fit_model(clean_data)),
  tar_target(model_summary, broom::tidy(model_fit))
)