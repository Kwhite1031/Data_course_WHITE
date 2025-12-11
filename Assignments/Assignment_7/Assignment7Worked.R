#Assignment 7
##Read in csv
UtahReligions <- read.csv('Utah_Religions_by_County.csv')
names(UtahReligions)

library(tidyverse)
library(janitor)

##Get names into clean format
UtahReligions <- UtahReligions %>%
  janitor::clean_names()

##Tidy the data
UtahReligions_tidy <- UtahReligions %>%
  pivot_longer(
    cols = -c(county, pop_2010),
    names_to = "Religion",
    values_to = "Adherents"
  )

##Keep tidying
UtahReligions_tidy <- UtahReligions_tidy %>%
  mutate(
    Religion = Religion %>% 
      str_replace_all("\\.", " ") %>% 
      str_to_title()
  )

##View 5 number summary for tidied dataset, view a few of the new values 
glimpse(UtahReligions_tidy)
summary(UtahReligions_tidy$Adherents)

##Plot: County Population vs Size of Each Religious Group
ggplot(UtahReligions_tidy, aes(x = pop_2010, y = Adherents, color = Religion)) +
  geom_point(alpha = 0.7) +
  facet_wrap(~ Religion, scales = "free_y") +
  theme_minimal() +
  labs(title = "Population vs Religious Group Size by County",
       x = "County Population (2010)",
       y = "Number of Adherents")

##Correlation Between County Population and Each Religion
pop_cor <- UtahReligions_tidy %>%
  group_by(Religion) %>%
  summarize(Correlation = cor(pop_2010, Adherents, use = "complete.obs")) %>%
  arrange(desc(Correlation))

pop_cor

##Plot the correlation strengths
ggplot(pop_cor, aes(x = reorder(Religion, Correlation), y = Correlation, fill = Correlation)) +
  geom_col() +
  coord_flip() +
  theme_minimal() +
  labs(title = "Correlation Between County Population and Religious Adherents",
       x = "Religion", y = "Correlation Coefficient")

#Q1: “Does population correlate with the proportion of any religion?”
UtahReligions_prop <- UtahReligions_tidy %>%
  mutate(Proportion = Adherents / pop_2010)

prop_pop_cor <- UtahReligions_prop %>%
  group_by(Religion) %>%
  summarize(Correlation = cor(pop_2010, Proportion, use = "complete.obs")) %>%
  arrange(desc(Correlation))

prop_pop_cor

ggplot(UtahReligions_prop, aes(x = pop_2010, y = Proportion)) +
  geom_point(alpha = 0.5) +
  facet_wrap(~ Religion, scales = "free") +
  theme_minimal() +
  labs(title = "County Population vs Religious Proportion")


#Q2: “Does proportion of any religion correlate with the proportion of non-religious people?”
non_rel <- UtahReligions_prop %>%
  filter(Religion == "Non.Relgious") %>%
  select(county, NonRelig_Prop = Proportion)

rel_vs_non <- UtahReligions_prop %>%
  filter(Religion != "Non.Relgious") %>%
  left_join(non_rel, by = "county")

safe_cor <- function(x, y) {
  if (sum(complete.cases(x, y)) < 2) {
    return(NA_real_)
  } else {
    return(cor(x, y, use = "complete.obs"))
  }
}

rel_non_cor <- rel_vs_non %>%
  group_by(Religion) %>%
  summarize(Correlation = safe_cor(Proportion, NonRelig_Prop)) %>%
  arrange(Correlation)

rel_non_cor

