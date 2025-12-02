#BIOL3100 Final Presentation
#Dinosaur Data

##Attach dataframe and save in object
df <- read.csv('dinosaurs.csv')
attach(df)
View(df)

##Question 1: Top 5 regions by occurence
###Identify the top 5 regions by number of rows (occurrences)
####Clean "type" (replace blanks or NA with "unspecified")
df_clean <- df %>%
  mutate(type = ifelse(is.na(type) | type == "", "unspecified", type))
####Top 5 regions by count
top5_occ_regions <- df_clean %>%
  count(region, sort = TRUE) %>%
  slice_max(n, n = 5) %>%
  pull(region)
top5_occ_regions
####Filter data to only those regions
df_top_occ <- df_clean %>%
  filter(region %in% top5_occ_regions)
####Calculate proportions of “type” within each region
df_prop_type <- df_top_occ %>%
  count(region, type) %>%
  group_by(region) %>%
  mutate(prop = n / sum(n))
df_prop_type
####Create faceted proportional bar plot
dino_plot_occ <- ggplot(df_prop_type, aes(x = type, y = prop, fill = type)) +
  geom_col() +
  facet_wrap(~ region, scales = "free_x") +
  scale_y_continuous(labels = scales::percent_format()) +
  labs(
    title = "Proportion of Fossil Types in Top 5 Regions by Occurrence",
    x = "Fossil Type",
    y = "Proportion of Finds",
    fill = "Type"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



##Question 2: Top 5 regions by diversity (most unique species)
###Find the 5 regions with the highest number of unique dinosaur names
top5_diverse_regions <- df_clean %>%
  group_by(region) %>%
  summarize(unique_species = n_distinct(name)) %>%
  arrange(desc(unique_species)) %>%
  slice_max(unique_species, n = 5) %>%
  pull(region)
top5_diverse_regions
###Subset to only those regions
df_top_div <- df_clean %>%
  filter(region %in% top5_diverse_regions)

###Prep for species richness bar plot
species_richness <- df_top_div %>%
  group_by(region) %>%
  summarise(unique_species = n_distinct(name)) %>%
  arrange(desc(unique_species))
###Species richness bar plot
dino_plot_div <- ggplot(species_richness, aes(x = reorder(region, -unique_species), 
                             y = unique_species, 
                             fill = region)) +
  geom_col() +
  labs(
    title = "Species Richness in the 5 Most Diverse Regions",
    x = "Region",
    y = "Number of Unique Species"
  ) +
  theme_minimal() +
  theme(legend.position = "none")


##Comparison in diversity between occurrence and diversity regions 
##Adding England to the species richness plot
# Find species richness for just the top 5 diverse regions
species_richness_top5 <- df_top_div %>%
  group_by(region) %>%
  summarise(unique_species = n_distinct(name))
# Calculate species richness for England
species_richness_england <- df %>%
  filter(region == "England") %>%
  summarise(region = "England",
            unique_species = n_distinct(name))
# Combine
species_richness_with_england <- bind_rows(
  species_richness_top5,
  species_richness_england
)

dino_plot_div_eng <- ggplot(species_richness_with_england, 
       aes(x = reorder(region, -unique_species), 
           y = unique_species,
           fill = region)) +
  geom_col() +
  labs(
    title = "Species Richness in Top 5 Diverse Regions + England",
    x = "Region",
    y = "Number of Unique Species"
  ) +
  theme_minimal() +
  theme(legend.position = "none")



###Comparison in occurrences between occurrence and diverse regions
###Add Utah to bar graph
####Compute total occurrence counts for those regions + Utah
regions_of_interest <- c(top5_occ_regions, "Utah")

occurrence_counts <- df %>%
  filter(region %in% regions_of_interest) %>%
  count(region, name = "total_occurrences") %>%
  arrange(desc(total_occurrences))
####Create bar graph
dino_plot_occ_ut <- ggplot(occurrence_counts,
       aes(x = reorder(region, -total_occurrences),
           y = total_occurrences,
           fill = region)) +
  geom_col() +
  labs(
    title = "Total Fossil Occurrences: Top 5 Regions + Utah",
    x = "Region",
    y = "Number of Fossil Occurrences"
  ) +
  theme_minimal() +
  theme(legend.position = "none")



