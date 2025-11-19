#Exam 2

##1. Read in the unicef data (10 pts) 

unicefdf <- read.csv('Exam/Exam_2/unicef-u5mr.csv')
View(unicefdf)


##2. Get it into tidy format (10 pts) 
unicef_tidy <- unicefdf %>%
  pivot_longer(
    cols = starts_with("U5MR."),
    names_to = "year",
    values_to = "U5MR"
  ) %>%
  mutate(
    year = str_remove(year, "U5MR\\."),   
    year = as.integer(year)              
  ) %>%
  filter(!is.na(U5MR))

View(unicef_tidy)



##3. Plot each country’s U5MR over time (20 points)
ggplot(unicef_tidy, 
       aes(x = year, y = U5MR, 
           group = CountryName, color = CountryName)) +
  geom_line(size = 0.7, alpha = 0.9) +
  facet_wrap(~ Continent, scales = "free_y") +
  labs(
    title = "Under-5 Mortality Rate Over Time by Country",
    x = "Year",
    y = "U5MR (deaths per 1,000 live births)"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",   
    strip.text = element_text(size = 12, face = "bold")
  )




##4. Save this plot as LASTNAME_Plot_1.png
plot_u5mr <- ggplot(unicef_tidy, 
                    aes(x = year, y = U5MR, 
                        group = CountryName, color = CountryName)) +
  geom_line(size = 0.7, alpha = 0.9) +
  facet_wrap(~ Continent, scales = "free_y") +
  labs(
    title = "Under-5 Mortality Rate Over Time by Country",
    x = "Year",
    y = "U5MR (deaths per 1,000 live births)"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",   
    strip.text = element_text(size = 12, face = "bold")
  )

ggsave("WHITE_Plot_1.png", 
       width = 10, height = 6, dpi = 300)


##5. Create another plot that shows the mean U5MR for all the countries 
## within a given continent at each year (20 pts)
continent_means <- unicef_tidy %>%
  group_by(Continent, year) %>%
  summarize(mean_U5MR = mean(U5MR, na.rm = TRUE), .groups = "drop")

ggplot(continent_means, aes(x = year, y = mean_U5MR, color = Continent)) +
  geom_line(size = 1) +
  labs(
    title = "Mean Under-5 Mortality Rate by Continent Over Time",
    x = "Year",
    y = "Mean U5MR (deaths per 1,000 live births)"
  ) +
  theme_minimal() +
  theme(
    legend.title = element_blank(),
    strip.text = element_text(size = 12, face = "bold")
  )


##6. Save that plot as LASTNAME_Plot_2.png (5 pts)
plot_u5mr_means <- ggplot(continent_means, aes(x = year, y = mean_U5MR, color = Continent)) +
  geom_line(size = 1) +
  labs(
    title = "Mean Under-5 Mortality Rate by Continent Over Time",
    x = "Year",
    y = "Mean U5MR (deaths per 1,000 live births)"
  ) +
  theme_minimal() +
  theme(
    legend.title = element_blank(),
    strip.text = element_text(size = 12, face = "bold")
  )

ggsave("WHITE_Plot_2.png", plot = plot_u5mr_means,
       width = 10, height = 6, dpi = 300)



##7. Create three models of U5MR (20 pts)

### Model 1
mod1 <- lm(U5MR ~ year, data = unicef_tidy)
summary(mod1)
### Model 2
mod2 <- lm(U5MR ~ year + Continent, data = unicef_tidy)
summary(mod2)
### Model 3
mod3 <- lm(U5MR ~ year * Continent, data = unicef_tidy)
summary(mod3)


##8. Compare the three models with respect to their performance
anova(mod1, mod2, mod3)
AIC(mod1, mod2, mod3)
### mod3 is probably the best, as it conveys continent-specific trends over time. 



##9. Plot the 3 models’ predictions like so: (10 pts)
###9.1 Create a grid of all year-continent combinations
years <- seq(min(unicef_tidy$year), max(unicef_tidy$year))
continents <- unique(unicef_tidy$Continent)

pred_grid <- expand.grid(
  year = years,
  Continent = continents
)

###9.2 Create a grid of all year-continent combinations
pred_grid <- pred_grid %>%
  mutate(
    pred_mod1 = predict(mod1, newdata = pred_grid),
    pred_mod2 = predict(mod2, newdata = pred_grid),
    pred_mod3 = predict(mod3, newdata = pred_grid)
  )

###9.3 Reshape predictions to long format for easy plotting
pred_long <- pred_grid %>%
  pivot_longer(
    cols = starts_with("pred_mod"),
    names_to = "Model",
    values_to = "Predicted_U5MR"
  ) %>%
  mutate(
    Model = case_when(
      Model == "pred_mod1" ~ "Model 1: Year",
      Model == "pred_mod2" ~ "Model 2: Year + Continent",
      Model == "pred_mod3" ~ "Model 3: Year * Continent"
    )
  )

###9.4 Plot predictions, facet by model and color by continent
ggplot(pred_long, aes(x = year, y = Predicted_U5MR, color = Continent)) +
  geom_line(size = 1) +
  facet_wrap(~ Model, scales = "free_y") +
  labs(
    title = "Predicted U5MR from Three Models by Continent",
    x = "Year",
    y = "Predicted U5MR",
    color = "Continent"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    strip.text = element_text(size = 9, face = "bold")
  )
