#Exam 3

##1. Load, clean, and plot data
library(tidyverse)
library(janitor)

###Load and clean column names
FacultySalaries1995 <- read_csv("FacultySalaries_1995.csv") %>%
  clean_names()

###Pivot longer 
FacultySalaries1995_tidy <- FacultySalaries1995 %>%
  pivot_longer(
    cols = matches("avg.*prof.*"), 
    names_to = c("avg", "rank", "prof", "measure"),
    names_pattern = "(avg)(full|assoc|assist|prof)(prof)?(salary|comp)",
    values_to = "value"
  ) %>%
  mutate(
    rank = recode(rank,
                  "full" = "Full",
                  "assoc" = "Associate",
                  "assist" = "Assistant",
                  "prof" = "All"),   # handles AvgProfSalaryAll & AvgProfCompAll
    measure = recode(measure,
                     "salary" = "Salary",
                     "comp"   = "Compensation")
  ) %>%
  select(-avg, -prof)   # Drop unused components
names(FacultySalaries1995)

###Tidy even more
FacultySalaries1995_tidy <- FacultySalaries1995 %>%
  pivot_longer(
    cols = matches("^avg_.*_prof_.*$"),
    names_to = c("rank", "measure", "all_flag"),
    names_pattern = "avg_(full|assoc|assist|prof)_prof_(salary|comp)(_all)?",
    values_to = "value"
  ) %>%
  mutate(
    rank = recode(rank,
                  "full" = "Full",
                  "assoc" = "Associate",
                  "assist" = "Assistant",
                  "prof" = "All"),
    measure = recode(measure,
                     "salary" = "Salary",
                     "comp" = "Compensation"),
    all_flag = ifelse(is.na(all_flag), FALSE, TRUE)
  )

###Make a boxplot
FSPlot1 <- ggplot(
  FacultySalaries1995_tidy %>%
    filter(
      measure == "Salary",
      tier %in% c("I", "IIA", "IIB")
    ),
  aes(x = rank, y = value, fill = rank)
) +
  geom_boxplot(color = "black") +
  facet_wrap(~ tier) +
  labs(
    x = "Rank",
    y = "Salary",
    fill = "Rank"
  ) +
  scale_fill_manual(values = c(
    "Assistant" = "salmon",
    "Associate" = "green",
    "Full" = "blue"
  )) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "right",
    strip.text = element_text(size = 12),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

FSPlot1

##2. Anova
###Filter to salary values only
salary_data <- FacultySalaries1995_tidy %>%
  filter(measure == "Salary")

###Build ANOVA model (additive, no interactions)
anova_model <- aov(value ~ state + tier + rank, data = salary_data)

###Display summary output
summary(anova_model)


##3. Load and tidy Juniper Oils data
JuniperOils <- read.csv('Juniper_Oils.csv')

###Clean column names
JuniperOils <- JuniperOils %>%
  clean_names()  

###Convert chemical columns to tidy format and plot
###The chemical compounds are all columns from alpha.pinene to alpha.eudesmol and cedr.8.en.13.ol, etc.
###Select all columns that are NOT metadata for pivoting

chemical_cols <- JuniperOils %>%
  select(alpha_pinene:alpha_eudesmol, cedr_8_en_13_ol:thujopsenal, compound_1:compound_2) %>%
  colnames()

JuniperOils_tidy <- JuniperOils %>%
  pivot_longer(
    cols = all_of(chemical_cols),
    names_to = "compound",
    values_to = "value"
  )

###4. Plot
library(tidyverse)
####Prepare data
plot_data <- JuniperOils_tidy %>%
  group_by(compound, years_since_burn) %>%
  summarize(
    mean_conc = mean(value, na.rm = TRUE),
    sd_conc = sd(value, na.rm = TRUE),
    .groups = "drop"
  )
####Plot
JuniperPlot1 <- ggplot(JuniperOils_tidy, aes(x = years_since_burn, y = value)) +
  geom_smooth(
    aes(group = 1),
    method = "loess",
    se = TRUE,           # shaded area for SD/SE
    color = "blue",
    fill = "blue",
    alpha = 0.2,
    size = 0.8
  ) +
  facet_wrap(~ compound, scales = "free_y") +
  labs(
    x = "Years Since Burn",
    y = "Concentration"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(size = 12),
    plot.subtitle = element_text(size = 10),
    strip.text = element_text(size = 8),
    axis.title = element_text(size = 14),
    axis.text.x = element_text(size = 10),
    axis.text.y = element_text(size = 6)
  )
JuniperPlot1

##5. Linear model
library(broom)

# Fit GLM for each chemical
glm_results <- JuniperOils_tidy %>%
  group_by(compound) %>%
  do(
    tidy(glm(value ~ years_since_burn, data = .))
  ) %>%
  ungroup()

# Filter to significant chemicals (p < 0.05 for years_since_burn)
significant_chemicals <- glm_results %>%
  filter(term == "years_since_burn", p.value < 0.05)

# View results
significant_chemicals



