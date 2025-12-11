#Assignment 9

#1. Read in CSV, clean, tidy
library(readr)
GradSchoolAdmissions <- read_csv('GradSchool_Admissions_copy.csv')
View(GradSchoolAdmissions)

names(GradSchoolAdmissions)

# Load tidyverse and janitor for data cleaning
library(tidyverse)
library(janitor)

# Clean and tidy the data
GradSchoolAdmissions <- GradSchoolAdmissions %>%
  clean_names() %>%                     
  mutate(
    admit = factor(admit, levels = c(0, 1), labels = c("No", "Yes")),
    rank  = factor(rank, ordered = TRUE)  
  )

GradSchoolAdmissions

# View structure and summary
glimpse(GradSchoolAdmissions)
summary(GradSchoolAdmissions)

#Check for missing values
sapply(GradSchoolAdmissions, function(x) sum(is.na(x)))

#Explore admission rate
GradSchoolAdmissions %>%
  count(admit) %>%
  mutate(percent = n / sum(n) * 100)

#Explore GRE and GPA distributions
GradSchoolAdmissions %>%
  pivot_longer(c(gre, gpa)) %>%
  ggplot(aes(value)) +
  geom_histogram(bins = 30, fill="steelblue", color="white") +
  facet_wrap(~name, scales="free") +
  theme_minimal()

#Explore Admission vs GRE
ggplot(GradSchoolAdmissions, aes(gre, fill = admit)) +
  geom_density(alpha = 0.4) +
  theme_minimal()

#Explore Admission vs GPA
ggplot(GradSchoolAdmissions, aes(gpa, fill = admit)) +
  geom_density(alpha = 0.4) +
  theme_minimal()

#Explore Admission by Undergrad rank
GradSchoolAdmissions %>%
  group_by(rank) %>%
  summarise(admission_rate = mean(admit == "Yes")) %>%
  ggplot(aes(rank, admission_rate)) +
  geom_col(fill="darkred") +
  scale_y_continuous(labels = scales::percent_format()) +
  labs(y = "Admission Rate", x = "Undergraduate Rank") +
  theme_minimal()

#Fit Logistic Regression model
model1 <- glm(admit ~ gre + gpa + rank, 
              data = GradSchoolAdmissions, 
              family = binomial)

summary(model1)

#Predictions
newdata <- expand_grid(
  gre = seq(min(GradSchoolAdmissions$gre), max(GradSchoolAdmissions$gre), length.out = 50),
  gpa = mean(GradSchoolAdmissions$gpa),
  rank = factor(c("1","2","3","4"), levels = levels(GradSchoolAdmissions$rank))
)

preds <- newdata %>%
  mutate(p = predict(model1, newdata = ., type="response"))
#Plot Predictions
plotpred <- ggplot(preds, aes(gre, p, color = rank)) +
  geom_line(size = 1.2) +
  labs(y = "Predicted Probability of Admission",
       color = "Rank") +
  theme_minimal()


