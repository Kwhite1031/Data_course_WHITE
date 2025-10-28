#Exam 1 - Kenny White
## Question 1: read the csv
covid_df <- read.csv('cleaned_covid_data.csv')
covid_df
View(covid_df)

## Question 2: subset the data
A_states <- covid_df %>% 
  filter(str_starts(Province_State, "A"))
A_states
View(A_states)

## Question 3: plot the subsetted data
  A_states %>%
    mutate(Last_Update = as.Date(Last_Update, format = "%Y-%m-%d")) %>%
    filter(!is.na(Last_Update), !is.na(Deaths), !is.na(Province_State)) %>%
    ggplot(aes(x = Last_Update,
               y = Deaths,
               color = Province_State)) +
    geom_point(alpha = 0.5, size = .5) +
    facet_wrap(~ Province_State, scale = 'free') +
    geom_smooth(method = 'loess', formula = 'y ~ x')


##Question 4: (Back to the full dataset) Find the “peak” of Case_Fatality_Ratio for each state 
##and save this as a new data frame object called state_max_fatality_rate.
state_max_fatality_rate <- covid_df %>% 
  group_by(Province_State) %>% 
  summarise(Maximum_Fatality_Ratio = max(Case_Fatality_Ratio, na.rm = TRUE))

state_max_fatality_rate <- state_max_fatality_rate %>%
  arrange(desc(Maximum_Fatality_Ratio))

state_max_fatality_rate

##Question 5: Use that new data frame from task IV to create another plot
state_max_fatality_rate$Province_State <- factor(state_max_fatality_rate$Province_State,
                                                 levels = state_max_fatality_rate$Province_State)

ggplot(state_max_fatality_rate, aes(x = Province_State, y = Maximum_Fatality_Ratio)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Maximum Fatality Ratio by State",
       x = "Province_State",
       y = "Maximum_Fatality_Ratio") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) 
