### Working Environment ###########
if(!require('rstudioapi') ){ 
  install.packages('rstudioapi')
}
library(rstudioapi) 
setwd( 
  dirname( 
    getSourceEditorContext()$path
  ))

# Disable scientific notation
options(scipen = 999)

# Disable text encoding as 'factors'
options(stringsAsFactors = FALSE)

library(tidyverse)

# COMMENT
# Shortcut: Command + C

################################
### P.8-9 - Variable
################################
my_variable <- "my data"
my_variable

my_text_variable <- "Hello!"

my_number_variable <- 2019

my_texts <- c("Hi","Salut","Ciao")
my_texts[4] <- "Hallo"

my_numbers <- c(3, 5, 7, 11, 13, 17)
my_numbers[7] <- 19

my_months <- 1:12

### Try it #####################
### Count from 10 to 1
10:1

### Count from -5 to 5
-5:5
# Alternative
0:10 - 5

### Count from 0 to 1 with 0.2 increment
0:5 / 5


################################
### P.10-11 - Table
################################

### Boolean
success <- TRUE
failure <- FALSE

### Date & Time
intro_R_date <- as.Date("2019-03-07")

today <- Sys.Date()
tomorrow <- today + 1
# intro_R_date <- intro_R_date + 4

### Make 2x2 Table #############
my_table <- rbind(c("A","alpha"),
                  c("B","beta"))

### Add Column
my_table <- cbind(my_table,
                  c("alpha","bravo"))

### Modify Column
my_table[ ,3] <- c("ALPHA","BRAVO")

### Modify Row
my_table[2,] <- c("B","Bravo")
my_table[2,] <- c("B","beta","bravo")

### Modify Cell
my_table[2,3] <- "BRAVO"

### Call Columns by Name
my_table <- as.data.frame(my_table) 
#  
colnames(my_table) <- c("letter","greek","code")
my_table$code <- c("Alpha","Bravo")


### Add Column to Table
my_table[ ,4] <- 1:2


### List
my_list <- list(my_table, my_texts,
                my_numbers, "etc")

my_list[[4]] <- "anything"

# Access Table Within List
my_list[[1]][,3] <- c("Alpha","Bravo")


### Tibble
my_tibble <- tibble(1:2, c("a","b"),
                list(my_texts, my_numbers),
                list(my_table, my_list))

my_tibble[ ,2] <- c("A","B")

# Access Table Within Tibble
my_tibble[1,3][[1]][[1]][5] <- "Hola"


################################
### P.14-15 - If Then Else
################################

### IF THEN ELSE
age <- 12
if( age < 18 ){
  print("Warning!")
} else {
  print("Welcome")
}

# Boolean
success = TRUE
if( success ){
  print("This is executed")
} else {
  print("Not happenning!")
}

### IF - THEN IF - THEN ELSE
grade = 0
if( grade == 0 ){
  print("Terribe Fail!")
} else if( grade < 5 ){
  print("Fail")
} else if( grade < 5 ){
  print("Pass")
} else {
  print("Awesome!")
}

### Try it #####################
message <- "Bonjour"

if( message == "Hello" ){
  print("How are you doing?")
  
} else if( message == "Bonjour" ){
  print("Comment ca va?")
  
} else {
  print("?!")
}

### All Conditions
if(grade > 4 & grade < 5) {
  print("Almost there!")
}

### At Least One Condition
if(grade < 2 | grade > 8) {
  print("That's extreme!")
}

### Complex Conditions
if( (dish == "Soup" & wine == "None") |
    (dish == "Fish" & wine != "Red") |
    (dish == "Duck" & wine == "Red") ) {
  print("I want to eat this.")
}

if( (dish == "Fish" & wine != "Red") &
    (wine == "Ros??" & 
    (hour > 23 | temperature > 25) ) ) {
  print("This is an exception.")
}

################################
### P.16-18 - Function
################################

### Function
my_function <- function(grade){
  if(grade < 5) {
    print("Fail")
  } else {
    print("Pass")
  }
}

my_function(0)
my_function(8)

### Input & Output Data
give_grade <- function(Q1, Q2){
  grade <- 0
  if(Q1 == "France") {
    grade <- grade + 1
  }  if(Q2 == "Louis XIV") {
    grade <- grade + 1
  }
 print(grade)
}

test_Q1 <- function(Q1){
  if(Q1 == "France") {
    return(TRUE)
  }
}

grade_Q1 <- function(Q1, grade = 0){
  if( test(Q1) ) {
    return(grade + 1)
  }
}

################################
### P.19-21 - Pipe
################################

### Pipe
my_function <- function(my_variable) {
  return( my_variable * 2 )
}
grade <- 3

if(grade %>% my_function() > 5){
  print("Pass")
}

### Pipe Anywhere
my_function <- function(grade, my_variable) {
  # if(my_variable == 0) return( 0 )
  return( grade / my_variable )
}
grade <- 6.5
time <- 2.2

grade %>% round() %>%
  my_function( my_variable = time %>% round ) 

################################
### P.22-24 - Loops
################################

### FOR Loop
for( i in 1:10 ){
  print(i)
}

for( my_letter in my_table$letter ){
  print(my_letter)
}

### WHILE Loop
i <- 5
while( i > 0 ){
  print( my_table$letter[i] )
  i <- i - 1
}

### Interruption
# Terminate
for( my_letter in my_table$letter ){
  print(my_letter)
  if( my_letter == "B") {
    break
  }
}

# Skipto Next Element
for( i in 1:10 ){
  if( i %in% c(2,4,6,8,10) ) {
    next
  } 
  print(i)
}

################################
### P.29-33 - Read & Write Data
################################

### Text Data #################
# Write File
write("My text", "my_text.txt")

write("Next Line", "my_text.txt",
      append = TRUE)

# Read File
read_file("my_text.txt")

# Write & Format Table
for( i in 1:nrow(my_table) ){
  paste( my_table$name[i], "has grade", my_table$grade[i] ) %>% 
    write( "class_grade.txt", append = TRUE )
}

# Write Raw Console Output
my_table %>% 
  print() %>%
  capture.output() %>% 
  write("my_text.txt")


### CSV Data #################
# Write File
write.csv( "A, alpha\n
           B, beta", "my_data.csv")

write.csv("C, gamma", "my_data.csv",
          append = TRUE)

# Read File
read_file("my_text.txt")

# Write Table
write.csv( my_table, "my_data.csv",
           row.names = FALSE)

# Specify Separator
read.csv( my_table, "my_data.csv",
          sep = "," )


### XML Data #################

library(xml2)
read_xml("<client>
         <name> Emma </name> 
         </client>")

library(XML)
xmlTreeParse('<client name="Emma">')

### HTML Data #################

# rvest Library
library(rvest)
url <- "https://digitalsocietyschool.org"

url %>%
  read_html()

# Browse Hypertext Links
url %>%
  read_html() %>% 
  html_nodes( "a" ) %>%
  html_attr( "href" )

# Read HTML Table
read_html("http://w3schools.com/html/html_tables.asp") %>% 
  html_table()


################################
### P.34-40 - Manipulate Data
################################
### Overview #####################
# data <- tibble(1:20,letters[1:20])
data <- tibble(number=1:20, my_column=10*1:20)

# Get row names & first values
data %>% glimpse() 

# Get first & last rows
data %>% head()
data %>% tail()

### Summary #####################

# Get mean & sum of each column
data %>% colMeans()
data %>% colSums()

# Get summary statistics of each column
data %>% summary()

# Get specific statistics of any column
data %>% summarise( min(my_column), 
                    max(my_column) )

# Get statistics for groups of row
data <- tibble(number=1:20, my_column=10*1:20, 
               other_column=c(1:5,1:5,1:5,1:5) )

data %>% group_by( other_column ) %>%
  summarise( min(my_column), 
             max(my_column) )


### Order Data #####################

# From lowest to highest column value
data %>% arrange( my_column )

# From highest to lowest column value
data %>% arrange( desc(my_column) )

# Order by one column then another
data %>% arrange( my_column,
                  other_column )

data %>% arrange( other_column,
                  my_column )

### Group Data #####################

# Group rows with the same column value
data %>% group_by( other_column )
data %>% group_by( other_column,
                   my_column  )

# Best value per group
data %>% group_by( other_column ) %>%
  top_n( 1, my_column )

### Try it #####################

# Best 3 values per group
# Display by group order
data %>% group_by( other_column ) %>%
  top_n( 3, my_column ) %>% 
  arrange( other_column )


### Extract Data #####################
data <- tibble(number=1:20, my_column=1:20/2, 
               other_column=c(1:5,1:5,1:5,1:5),
               my_letters=letters[1:20],
               my_other_letters=LETTERS[1:20])

# Get certain columns
data %>% select( my_column,
                 other_column )
data %>% select( starts_with("my_") )
data %>% select( contains("other") )
  
# Get rows with certain column values
data %>% filter( my_column > 5 ) 
data %>% filter( my_column > 5 &
                   my_column < 8 )
data %>% filter( my_column > 5,
                 other_column == 2 )

# Randomly sample 10 rows 
data %>% sample_n( 5 )

# Get rows with the 10 highest values 
data %>% top_n( 5, my_column )

# Get rows with the 10 lowest values 
data %>% top_n( -5, my_column ) 

### Add Data #####################

### Add Column
data %>% 
  mutate( new_column = paste0('var_',letters[1:20]) )

# Make a column from another column 
data %>% 
  mutate( bonus = my_column + 2 )

### Add Row
data %>% add_row( number = 21, 
                  my_column = 10.5, 
                  other_column = 1, 
                  my_letters = 'u', 
                  my_other_letters = 'U' ) %>%
  tail



### Merge Data #####################

### Add All Rows & Columns
my_data <- data %>% filter( number < 5)
other_data <- data %>% filter( number > 15)

full_join( 
  other_data,
  my_data )

### Add Columns
my_data <- data %>% select(number, other_column)
other_data <- data %>% select(number, my_letters)

left_join( 
  my_data,
  other_data,
  by = c('number'='number') )

right_join( 
  other_data,
  my_data,
  by = c('number'='number') )


### Add Matching Rows
my_data <- data %>% select(number, other_column, my_letters) %>% 
  filter( number < 5) %>% 
  mutate( test = 5:2*100)
other_data <- data %>% select(number, other_column, my_other_letters) %>%
  filter( number > 15) %>% 
  mutate( test = 1:5*100)

# Match on 1 Column values
inner_join( 
  my_data,
  other_data,
  by =  c('other_column'='other_column') )

# inner_join( 
#   other_data,
#   my_data,
#   by =  c('other_column'='other_column') )


# Match on 2 Column values
inner_join( 
  my_data,
  other_data,
  by =  c('other_column'='other_column',
          'test'='test') )



