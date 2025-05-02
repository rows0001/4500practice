
clean_and_wrangle <- function(data) {
  data %>%
    filter(!is.na(some_column)) %>%
    mutate(new_var = log(some_numeric_column + 1))
}

make_plot1 <- function(data) {
  ggplot(data, aes(x = new_var)) +
    geom_histogram()
}

make_plot2 <- function(data) {
  ggplot(data, aes(x = category, y = value)) +
    geom_boxplot()
}

fit_model <- function(data) {
  lm(value ~ new_var + category, data = data)
}
