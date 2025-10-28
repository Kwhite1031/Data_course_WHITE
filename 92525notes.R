#9/25/25 Data Analysis Class Notes 

## install package: palmerpenguins
install.packages("palmerpenguins")
library(palmerpenguins)

penguins
?penguins

str(penguins)
dim(penguins)

df_penguin <- penguins

df_penguin
view(df_penguin)

## 1. Check column names in the dataset
names(df_penguin)
###or
df_penguin %>% names()

## 2. calculate Max, Min, ... of body mass 
max(df_penguin$body_mass_g, na.rm = T)
###or
df_penguin$body_mass_g %>% 
  max(na.rm = T)
###or
df_penguin %>% 
  pluck('body_mass_g') %>% 
  max(na.rm = T)

min(df_penguin$body_mass_g, na.rm = T)
###or
df_penguin$body_mass_g %>% 
  min(na.rm = T)
###or
df_penguin %>% 
  pluck('body_mass_g') %>% 
  min(na.rm = T)


## 3. Save file for female penguin with body mass > avg 
df_penguin %>% 
  filter(body_mass_g > 4201.754) %>% 
  filter(sex == 'female') 
###or
df_penguin %>% 
  filter(body_mass_g > 4201.754 & sex == 'female')



large_f <- df_penguin %>% 
  filter(body_mass_g > 4201.754 & sex == 'female')

## 4. calculate body mass of females with bill length > 40
## separate by species
unique(df_penguin$species)
df_penguin$species

df_penguin %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>% 
  group_by(species) %>% 
  summarize(avg_mass_g = mean(body_mass_g))
###Take the df_penguin object, then
###filter that object by bill_length_mm values greater than 40 and by sex values that equal female, then
###group that data by value of species, then
###summarize the mean of body_mass_g for each species in a column called "avg_mass_g"








### Example showing how you can summarize multiple things
df_penguin %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>% 
  group_by(species) %>% 
  summarize(avg_mass_g = mean(body_mass_g),
            max_mass_g = max(body_mass_g),
            min_mass_g = min(body_mass_g),
            sample_size = n())

###save in object
df_f_pengu_weight = df_penguin %>% 
  filter(bill_length_mm > 40 & sex == 'female') %>% 
  group_by(species) %>% 
  summarize(avg_mass_g = mean(body_mass_g),
            max_mass_g = max(body_mass_g),
            min_mass_g = min(body_mass_g),
            sample_size = n()) 

