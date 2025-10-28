#9/30/25 class notes
df_penguin <- penguins
df_penguin

## find the fat penguins with body mass > 5000
df_penguin %>% 
  filter(body_mass_g > 5000)
## count how many of them are male and female 
df_penguin %>% 
  filter(body_mass_g > 5000) %>% 
  group_by(sex) %>% 
  summarize(no_bird = n())
## return the max body mass for male and female 
df_penguin %>% 
  filter(body_mass_g > 5000) %>% 
  group_by(sex) %>% 
  summarize(no_bird = n(),
            max_weight = max(body_mass_g))
## add new column to penguin data to tell whether they're fat 
df_penguin$body_mass_g > 5000
df_penguin$fat_or_not <- df_penguin$body_mass_g > 5000
###or
df_penguin %>% 
  mutate(fat_penguin = case_when(body_mass_g > 5000 ~ 'Yes',
                                 body_mass_g <= 5000 ~ 'No')) %>% 
  View()
### Take the df_penguin object
### Make a new column called "fat_penguin"
### That new column's values are defined by whether: 
### The body mass is greater than 5000, in which case the value is "yes"
### The body mass is less than 5000, in which case the value is "no"

df_penguin %>% 
  filter(!is.na(sex)) %>%  
  filter(body_mass_g > 5000) %>% 
  group_by(sex, species) %>% 
  summarize(no_bird = n(),
            max_weight = max(body_mass_g)) %>% 
  arrange(max_weight)


###or
mutate()

iris
dim(iris)
names(iris)

iris %>% 
  mutate(new_col = Sepal.Length*Sepal.Width) %>% 
  view()

df_penguin %>% 
  mutate(new_fat = df_penguin$body_mass_g > 5000) %>% 
  view()

df_penguin %>% 
  mutate(fatstat = case_when(body_mass_g > 5000 ~ 'fattie',
                             body_mass_g <= 5000 ~ 'not fattie',
                             TRUE ~ 'skinny')) %>% 
  View()

?case_when()

##if penguin has body mass > 5000, that's fat 
## condition ~ if conidition is TRUE, then do ...
## if (1st con), then ...
## if (2nd con), then ...
## else ...
## "True ~" function means "else" 
  

#Notes
is.na(df_penguin$sex) ##shows all dataframe elements with "true" or "false" if its value is NA
  
df_penguin %>% 
  filter(!is.na(sex)) %>%  
  filter(body_mass_g > 5000) %>% 
  group_by(sex, species) %>% 
  summarize(no_bird = n(),
            max_weight = max(body_mass_g))



#install ggplot2
library(ggplot2)

## Create a chart from penguins data and set axis values
## + sign adds a layer to the chart
## geom functions relate to graphs
ggplot(data = penguins,
       aes(x = body_mass_g,
           y = bill_length_mm)) + 
  geom_point()


df_penguin %>% ## take the df_penguin object
  filter(!is.na(sex)) %>% ## filter by values that have the opposite of "na" values in regards to sex
  ggplot(aes(x = body_mass_g, ##use ggplot to create a graph and set axes of x = body_mass_g column,
             y = bill_length_mm, ##set y axis = bill_length_mm column
             color = sex, ##differentiate sex data values by color
             shape = island)) + ##differentiate island data values by shape
  geom_point() + ##create a graph element of a point type (add points to graph)
  scale_color_manual(values = c("magenta3", "seashell")) + ##manually change the colors assigned to the sex data points to magenta and seashell
  scale_shape_manual(values = c(8, 11, 3)) ##manually change the shapes assigned to the island data points to shapes with numeric values pulled from the online chart of ggplot shape values 
  labs(x = "weight (g)", ##assign labels (to the x axis, calling it "weight (g))
       y = "bill length (mm)", ##assign a label to the y axis called "bill length (mm)
       title = "Penguins something") + ##assign a title called "Penguins somehing"
  geom_smooth(se = F) ##applies trendlines, excludes standard error visuals

  
?geom_smooth

plot = df_penguin %>% 
  filter(!is.na(sex)) %>% 
  ggplot(aes(x = body_mass_g,
             y = bill_length_mm,
             color = sex,
             shape = island)) + 
  geom_point() +
  scale_color_viridis_b()


plot








empty_plot = ggplot(data = penguins,
                    aes(x = body_mass_g,
                        y = bill_length_mm))

empty_plot
empty_plot + geom_point()

plot(penguins$body_mass_g, penguins$bill_length_mm)







