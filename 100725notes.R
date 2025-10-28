#10/7/25 class
##Practice
##Make a graph of avg weight by penguins species
##with standard devation bar
df_penguins <- penguins
df_penguins

df_penguins %>% 
  ggplot(aes(x = species,
             y = body_mass_g)) +
  geom_bar(stat = 'identity')
###Same as
df_penguins %>% 
  ggplot(aes(x = species,
             y = body_mass_g)) +
  geom_col()

##adding error bar 
df_penguins %>% 
  ggplot(aes(x = species,
             y = body_mass_g)) +
  geom_bar(stat = 'identity') +
  geom_errorbar(aes(ymin = mean() - sd(),
                    ymax = mean() + sd()))


df_penguins %>% 
  filter(!is.na(sex)) %>% 
  group_by(species, sex) %>% 
  summarise(avg_weight = mean(body_mass_g),
            sd_weight = sd(body_mass_g)) %>% 
  ggplot(aes(x = species,
             y = avg_weight,
             fill = sex)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  geom_errorbar(aes(ymin = avg_weight - sd_weight,
                    ymax = avg_weight + sd_weight),
                position = position_dodge(width = 0.9),
                width = 0.3) +
  scale_y_continuous(expand = c(0,0))

##add title to graph
df_penguins %>% 
  filter(!is.na(sex)) %>% 
  group_by(species, sex) %>% 
  summarise(avg_weight = mean(body_mass_g),
            sd_weight = sd(body_mass_g)) %>% 
  ggplot(aes(x = species,
             y = avg_weight,
             fill = sex)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  geom_errorbar(aes(ymin = avg_weight - sd_weight,
                    ymax = avg_weight + sd_weight),
                position = position_dodge(width = 0.9),
                width = 0.3) +
  scale_y_continuous(expand = c(0,0)) + 
  ggtitle("Average weight of each species by sex")

###or 

df_penguins %>% 
  filter(!is.na(sex)) %>% 
  group_by(species, sex) %>% 
  summarise(avg_weight = mean(body_mass_g),
            sd_weight = sd(body_mass_g)) %>% 
  ggplot(aes(x = species,
             y = avg_weight,
             fill = sex)) +
  geom_bar(stat = 'identity', position = 'dodge') +
  geom_errorbar(aes(ymin = avg_weight - sd_weight,
                    ymax = avg_weight + sd_weight),
                position = position_dodge(width = 0.9),
                width = 0.3) +
  scale_y_continuous(expand = c(0,0)) + 
  labs(title = "my plot title") +
  theme(plot.title = element_text(hjust = 0.5)) #0, 0.5, 1 (left, middle, right justified)

### make histogram of flipper length and body mass
df_penguins %>% 
  ggplot(aes(x = flipper_length_mm,
             y = body_mass_g,
             fill = sex)) +
  geom_histogram(stat = 'identity', position = 'dodge', 
                 alpha = 0.5)

## filter by 'big flippers' and 'small flippers'

df_penguins %>% 
  mutate(flipper_group = case_when(flipper_length_mm > 205 ~ 'Big flippers',
                                   TRUE ~ 'Small flippers')) %>% 
  ggplot(aes(x = flipper_group,
             y = body_mass_g,
             fill = species)) +
  geom_histogram(stat = 'identity', position = 'dodge', 
                 alpha = 0.5)

##other graphs

df_penguins %>% 
  ggplot(aes(x = flipper_length_mm,
             y = body_mass_g,
             color = species)) +
  geom_path() +
  geom_point(color = 'grey', size = 1) +
  stat_ellipse(level = 0.95) +
  geom_bin_2d()

## make a box plot to show weight across years 
df_penguins %>% 
  ggplot(aes(x = factor(year),
             y = body_mass_g,
             fill = species)) +
  geom_boxplot() + 
  geom_jitter(alpha = 0.5)

unique(penguins$year)
str(penguins)

## othe graph
df_penguins %>% 
  ggplot(aes(x = body_mass_g,
             fill = species)) +
  geom_density(alpha = 0.5)
  

##Notes/new material