#Assignment 6
library(tidyverse)
dat <- read_csv("../../Data/BioLog_Plate_Data.csv") ## you may need to 
##modify this path to fit where this file is stored relative to your assignment 6 script

View(dat)
names(dat)


##1 Cleans this data into tidy (long) form
df <- dat

df_long <- df %>%
  pivot_longer(
    cols = starts_with("Hr_"),  # Pivot the columns starting with "Hr_" (Hr_24, Hr_48, Hr_144)
    names_to = "Time",
    values_to = "Absorbance"
  ) %>%
  mutate(
    Time = str_remove(Time, "Hr_") %>% as.numeric()  # Remove "Hr_" and convert to numeric
  )

View(df_long)

##2 Creates a new column specifying whether a sample is from soil or water
df_long <- df_long %>%
  mutate(SampleType = case_when(
    str_detect(`Sample ID`, regex("soil", ignore_case = TRUE)) ~ "Soil",
    str_detect(`Sample ID`, regex("water", ignore_case = TRUE)) ~ "Water",
    str_detect(`Sample ID`, "Clear_Creek") ~ "Water",  # Handle Clear_Creek as Water
    TRUE ~ "Unknown"  # Fallback for anything not matched
  ))

View(df_long)

##3 Generates a plot that matches this one (note just plotting dilution == 0.1):

Plot1 <- df_long %>%
  filter(Dilution == 0.1) %>%
  ggplot(aes(x = Time, y = Absorbance, color = SampleType, group = `Sample ID`)) +
  geom_smooth(method = "loess", se = FALSE, size = 0.8) +  # Add smoothing
  labs(
    title = "Just Dilution 0.1",
    x = "Time",
    y = "Absorbance"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    strip.text = element_text(size = 5),  # Reduce font size of substrate labels
    axis.text = element_text(size = 7)    # Adjust axis text size (if needed)
  ) +
  facet_wrap(~ Substrate) +  # Facet by Substrate
  scale_y_continuous(
    limits = c(0, 2),   # Set y-axis range from 0 to 2
    breaks = seq(0, 2, 0.5)  # Set breaks at 0.0, 0.5, 1.0, 1.5, 2.0
  )

##4 Generates an animated plot that matches this one 
##(absorbance values are mean of all 3 replicates for each group):

df_mean <- df_long %>%
  filter(Substrate == "Itaconic Acid") %>%  # Only use data for "Itaconic Acid"
  group_by(`Sample ID`, Dilution, Time) %>%  # Group by Sample ID, Dilution, and Time
  summarise(MeanAbs = mean(Absorbance, na.rm = TRUE), .groups = "drop")

View(df_mean)

p <- df_mean %>%
  ggplot(aes(x = Time, 
             y = MeanAbs, 
             color = `Sample ID`, 
             group = `Sample ID`)) +
  geom_line(size = 1) +  # Line plot for mean absorbance
  labs(
    x = "Time (hours)",
    y = "Mean Absorbance"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    strip.text = element_text(size = 10),  # Font size for dilution facet labels
    axis.text = element_text(size = 12)    # Font size for axis labels
  ) +
  facet_wrap(~ Dilution) +  # Facet by Dilution
  transition_reveal(Time) +  # Animate the lines by revealing them over time
  ease_aes('linear')  # Smooth the animation transitions

animate(p, fps = 10, duration = 8)

anim_save("Panimated.gif", animation = last_animation())
