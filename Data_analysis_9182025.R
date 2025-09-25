## 1. create a dateframe using mtcars, for mpg > 20
## and cyl equal to 6 

df_cars=mtcars ##takes the original dataset mtcars and stores it in the object dfcars

#first way 
df_6 = df_cars[df_cars$cyl == 6, ] 
##creates object "df_6" and sets it equal to the df_cars object, but only inasmuch as the "cyl" column of the data therein is = 6
df_6_20 = df_cars[df_6$mpg > 20, ]
##creates object df_6_20 and sets it equal to the df_6 object, but only inasmuch as the "mpg" column of the data therein is > 20

#second way
df_v3 = df_cars[df_cars$cyl == 6 & df_cars$mpg > 20, ] 
##creates object "df_v3" and sets it equal to the df_cars object, but only inasmuch as the "cyl" values are = 6 and the "mpg" values are > 20
View(df_v3)



## 2. in the date frame add a new column mpg x cyl 
df_v3$mpg ##pulls out (displays) just the "mpg" column from the dataframe
df_v3$cyl ##pulls out (displays) just the "cyl" column from the dataframe
is.numeric(df_v3$mpg) ##verifies that df_v3$mpg is numeric
is.numeric(df_v3$cyl) ##verifies that df_v3$cyl is numeric 

new_col = df_v3$mpg*df_v3$cyl ##creates a new object called "new_col" that multiplies the df_v3$mpg by df_v3$cyl

df_v3$new_col = new_col ##Creates a new column in the dataframe with the name "new_col" that pulls in values from the "new_col" object

view (df_v3) ##views the dataframe 


## 3. write a for loop to bring out each car (rowname)
df_v3[1, ] ##display the first row of object/dataframe df_v3
df_v3[2, ] ##display the second row of object/dataframe df_v3
df_v3[3, ] ##display the third row of object/dataframe df_v3

df_v3[ ,1] ##display the first column of object/dataframe df_v3
df_v3[ ,2] ##display the second column of object/dataframe df_v3
df_v3[ ,3] ##display the third column of object/dataframe df_v3

for (i in 1:nrow(df_v3)) {
  print(df_v3[i, ])
}
##From 1 to however many rows are in dataframe df_v3, print the row
##OR - Where i is a row in the df_v3 dataframe, print the row from the first row to however many rows are in the dataframe

nrow(df_v3) ##Display the number of rows that dataframe df_v3 has

ncol(df_v3) ##Display the number of columns that dataframe df_v3 has 





##9/18/25 class notes after opening exercise
## read/load data
read.csv() 
##read in a csv file
write.csv(df_v3, 'my_wonderful_cars.csv')
##turn the df_v3 object/dataframe into a csv with name "my_wonderful_cars" and save it in the default file path (can be modified by writing ../, absolute filepath, etc.)

as.data.frame(myfile) 
## treat a file as a dataframe

getwd()
##what is my working directory? 



install.packages('')
library()


##install tidyverse package 





##notes from previous classes 
df_cars = mtcars
df_cars$mpg > 20
df_good_car = df_cars[df_cars$mpg > 20, ]
df_cars[1:3, ]
df_cars[df_cars$mpg > 20, ]
df_cars[df_cars$cyl == 4, ]
View(df_cars[df_cars$mpg > 20 & df_cars$cyl == 6, ])
new_obj = df_cars[df_cars$mpg > 20 & df_cars$cyl == 6, ]
View(new_obj)
df_cars
View(df_cars)
View(df_cars[df_cars$mpg>20, ])



