
clean_and_wrangle <- function(df) {
  df |>
    rename(
      country = Entity,
      life_satisfaction = `Cantril ladder score`,
      gdp_per_capita = `GDP per capita, PPP (constant 2021 international $)`
    ) |>
    select(country, Year, life_satisfaction, gdp_per_capita) |>
    dplyr::filter(country %in% c(
      "Canada", "France", "Germany", "Italy", "Japan",
      "Russia", "United States", "United Kingdom", "Australia"
    )) |>
    drop_na()
}

make_plot1 <- function(df) {
  ggplot(df, aes(x = country, y = life_satisfaction, fill = country)) + 
    geom_boxplot() + 
    labs(
      title = "Boxplot of Life Satisfaction Across Countries",
      x = "Country",
      y = "Life Satisfaction"
    ) + 
    theme_minimal() + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}
make_plot2 <- function(df) {
  ggplot(df, aes(x = Year)) +
    geom_line(aes(y = life_satisfaction, color = "Life Satisfaction"), linewidth = 1) +
    geom_line(aes(y = gdp_per_capita / 10000, color = "GDP per Capita"), linewidth = 1) +
    facet_wrap(~ country) +
    labs(
      title = "Life Satisfaction and GDP per Capita Over Time",
      x = "Year",
      y = "Value (GDP scaled by 1/10000)",
      color = "Variable"
    ) +
    scale_color_manual(values = c("Life Satisfaction" = "blue", "GDP per Capita" = "red")) +
    theme_minimal()
}

fit_model <- function(df) {
  df %>%
    group_by(country) %>%
    nest() %>%
    mutate(model = map(data, ~ lm(life_satisfaction ~ gdp_per_capita, data = .x)))
}
