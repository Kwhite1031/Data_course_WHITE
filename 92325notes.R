##How to do assignment 2 for loop 

list.files ('Data/', pattern = '^b', recursive = TRUE)


file_paths = list.files ('Data/', pattern = '^b', recursive = TRUE)
file_paths [1]
file_paths [2]
file_paths [3]
file_paths [4]

readLines("file_paths[1], n=1")

setwd('/')
getwd()


for (number in 1:3) {
  out = readLines(file_paths[number], n=1)
  print(out)
  
}

for (number in 1:length(file_paths)) {
  out = readLines(file_paths[number], n=1)
}

## Copy/paste r script in text editor program
## Save as text file
## Move file by dragging/dropping into Assignment folder 
## Then, in Terminal
cd Desktop/Data_Course_LASTNAME
git add
git commit -m 'test'


## Class notes
## install and library tidyverse
library(tidyverse)

##How to use masked functions from packages overwritten in package conflicts 
stats::filter()
package::function()
  
  
mtcars[mtcars$mpg > 20, ]
mtcars %>% | #pipe
  
##shift command "m" for pipe shortcut " %>% "
mtcars %>% 
  filter(mpg > 20) 


## 1. read 'cleaned_bird_data.csv'
cleaned_bird_data <- read.csv(file.choose())
attach(cleaned_bird_data)
view(cleaned_bird_data)

## 2. calculate average of egg size 
###Show the names of columns in the df object
names(df)
###Find the mean of Egg_mass values in the df object
###Will return an error because some values are n/a
mean(df$Egg_mass)
###Find the mean 
mean(df$Egg_mass, na.rm = T)
pluck(Egg_mass)
mean(Egg_mass)

cleaned_bird_data %>% mean(Egg_mass)

df = read.csv('Data/cleaned_bird_data.csv')

df %>% names()

mean(df$Egg_mass)
?mean()

mean(df$Egg_mass, na.rm = T)

##following three statements are the same as each other
#Option 1
mean(df$Egg_mass, na.rm = TRUE)
#Option 2
df$Egg_mass %>%  mean(na.rm = TRUE)
#Option 3
df %>% 
  pluck("Egg_mass") %>% 
  mean(na.rm = TRUE)



## 3. save birds with egg size > avg
###Create an object called df_1
###Within df_1 object, store the df object that filters 
###with respect to egg mass values greater than 21.784
df_1 <- df %>% 
  filter(Egg_mass > 21.784)

view(df_1)
## 4. save in to a .csv in your laptop
###Check working directory to make sure it saves in the right place
getwd()
###Create csv from df_1 object and name it "Egg_mass_practice_df_1.csv"
write_csv(df_1, "Egg_mass_practice_df_1.csv")

## 5. read this csv file back to R again 
Egg_mass_practice <- read.csv(file.choose())
attach(Egg_mass_practice)
view(Egg_mass_practice)





##OR in 1 step
df_1 %>% 
  filter(Egg_mass > 21.8) %>% 
  write.csv("Egg_mass_practice_df_1.csv")

