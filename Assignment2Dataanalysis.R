#Assignment 2

##Write a command that lists all of the .csv files found in the Data/ directory 
##and stores that list in an object called “csv_files”
csv_files <- list.files('Data/', pattern = '.csv')

##Find how many files match that description using the length() function  
length(csv_files)

##Open the wingspan_vs_mass.csv file and store the contents as an 
##R object named “df” using the read.csv() function
df <- read.csv(file.choose())
attach(df)

##Inspect the first 5 lines of this data set using the head() function
head(df, n = 5)

##Find any files (recursively) in the Data/ directory that begin with 
##the letter “b” (lowercase)
list.files('Data/', pattern = '^b', recursive = T )

##Write a command that displays the first line of each of those “b” files 
##(this is tricky… use a for-loop)
bfiles <- list.files('Data/', pattern = '^b', full.names = T, recursive = T ) 
bfiles

?list.files
bfiles [1]
bfiles [2]
bfiles [3]
bfiles [4]

new_filepath = paste0('Data/', bfiles [1])
readLines(new_filepath, n=1)

readLines(bfiles[1], n=1)
?readLines

getwd()
setwd('/Users/kenny/Desktop/Data_course_WHITE/')

/Users/kenny/Desktop/Data_course_WHITE/data-shell/creatures/basilisk.dat
for (number in 1:3) {
  out = readLines(bfiles[number], n = 1)
  print(out)
}

for (file in bfiles) {
  #out = readLines(bfiles[number], n = 1)
  print(file)
  out = readLines(file, n = 1)
  print(out)
}



#Do the same thing for all files that end in “.csv”
csv_files_1 <- list.files('Data/', pattern = '.csv$', full.names = T, recursive = T ) 
csv_files_1


readLines(csv_files_1[1], n=1)

for (i in csv_files_1) {
  out = readLines(csv_files_1[1], n=1)
  print(out)
  
}
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



