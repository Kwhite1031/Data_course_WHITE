#10/2/25 class  

##Practice: convert the following into 'pipe format'
## max(round(iris$Sepal.Length),0)

max(round(iris$Sepal.Length),0)

iris$Sepal.Length %>% 
  round() %>% 
  max()

?round

# New material notes 
## Dataset resources
### https://datasetsearch.research.google.com/
### https://www.kaggle.com/datasets 
### Can also use other resources, or do my own experiment and collect my own data 

## Package resource
### https://cran.r-project.org/web/packages/available_packages_by_name.html 

##Assignment 4 has little to no coding needed; just brainstorm and figure out 
##what I want the final project to be

## ! = NOT/opposite 
x = c(1,2,3,NA, 5)
x
is.na(x) # is this NA?
!is.na(x) # is this NOT NA? 

## filter(we want to keep)

## select(we want to remove)

penguins %>% 
  names()

penguins [row,column]

View(penguins[,-8])

penguins %>% 
  select(year)

df_peng <- penguins
df_peng

df_peng %>% 
  select(-c(year, island)) %>% 
  mutate(year = 100) %>% 
  view()

df_peng %>% 
  filter(!is.na(sex)) %>% 
  ggplot(aes(x = body_mass_g,
             y = bill_length_mm,
             color = sex)) +
  geom_point() +
  theme(axis.text = element_text(angle = 180, face = 'bold'))

## make an interesting graph using penguins
## no geom_point()

df_peng %>% 
  filter(!is.na(island)) %>% 
  ggplot(aes(x = body_mass_g,
             y = bill_length_mm,
             color = island)) +
  geom_line() +
  theme(axis.text = element_text(face = 'bold'))

###or

df_peng %>% 
  ggplot(aes(x = species,
             fill = island)) +
  geom_bar(position = 'dodge') +
  theme_bw() +
  scale_y_continuous(limits = c(0, 150))

plot = df_peng %>% 
  ggplot(aes(x = species,
             fill = island)) +
  geom_bar(position = 'dodge') +
  theme_bw()

plot

plot + theme_bw()
str(plot)

plot_2 = plot + theme_dark()

plot_2

ggsave('my_cool_plot.png')


##Change wd with setwd(name of directory) command

# GGplot notes from last time 9/30/25
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
