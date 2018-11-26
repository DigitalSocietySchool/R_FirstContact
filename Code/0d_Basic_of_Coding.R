###########################
### IF - THEN - ELSE
###########################

credit <- 4

if( credit <= 0 ){
  print('Your have no credit!')
} else if( credit < 5 ) {
  print('Your credit is insufficient...')
} else {
  print('You have enough credit')
}

###### Boolean 
# Booleans are special variables that can only contain 2 values: TRUE or FALSE
d <- TRUE
print(d)
typeof(d)

# You can tranform TRUE to FALSE (and vice versa) using the operator !
d <- !d
print(d)

###### Use of booleans for tests
d <- 100
d > 10
d < 100
d <= 100
d == 100
d == 200

# BEWARE: tests must use 2 equal signs == using a single sign = will change the value fo teh variable!
# This is a common source of bug.
d = 200
print(d)


if( d > 0 ){
  print('The test was passed!')
} 

d <- FALSE

if( d ){
  print('The test was passed!')
} else {
  print('The test has failed...')
}

if( !d ){
  print('The test was passed!')
} 

############ EXERCISE #####
# 
# Given someone's age, for example:
 # age <- 17
# age <- 72
# Make a test (with if-then-else) that tells you when someone is minor 
# (less than 18 year old)
#
# SOLUTION:
# if( age < 18 ){
#   print('This person is minor')
# } else {
#   print('This person is adult')
# }
#
###########################

###########################
### FOR LOOP
###########################

participants <- c('Anthony', 'Barbara', 'Charlotte', 'Daniel')

for(p in participants){
  print(p)
}
print(p)

for(i in 1:10){
  print(i)
}
print(i)

for(i in 1:10){
  result <- paste(i, 'times 2 =', i*2)
  print(result)
}
print(result)

##### Loop to browse tables

# First let's reconstruct the data table from the previous session:
d <- data.frame()
user1 <- c('Anthony', 'Red', 'Apple', 'Dog')
user2 <- c('Barbara', 'Blue', 'Carrot', 'Cat')
user3 <- c('Charlotte' ,'Black', 'Orange', 'Pig')
user4 <- c('Daniel' ,'Orange', 'Pear', 'Cat')
d <- rbind(d, user1, user2, user3, user4)
d$Age <- c(11,14,21,17)
d <- cbind(c(1:nrow(d)), d)
colnames(d) <- c('ID', 'Name', 'Color', 'Food', 'Animal', 'Age')
print(d)


# Browse rows one by one
for(i in 1:nrow(d) ){
  print(d[i,])
}

# Test row values row by row
for(i in 1:nrow(d) ){
  if(d$Age[i] < 18){
    print(d$Name[i])
  }
}

# Store row values if test is passed
minors <- c()
for(i in 1:nrow(d) ){
  if(d$Age[i] < 18){
    minors <- c(minors, d$Name[i])
  }
}
print(minors)

# But this can be done in 1 line of code, 
# using the filters we learned in the previous session!
minors <- d$Name[d$Age < 18]
print(minors)

############ EXERCISE #####
# 
# 1. Write a loop that browse the table, and "prints" a sentence 
# describing the user's name and favorite color.
# "Carol likes Blue"
#
# SOLUTION:
# for(i in 1:nrow(d) ){
#   sentence <- paste(d$Name[i], 'likes the color', d$Color[i])
#   print(sentence)
# }
# 
# 2. Write a loop that describes whether users are minor or adults, 
# and their favorite food.
#
# SOLUTION:
# for(i in 1:nrow(d) ){
#   if(d$Age[i] < 18){
#     sentence <- paste(d$Name[i], 'is a minor that likes to eat', d$Food[i])
#   } else {
#     sentence <- paste(d$Name[i], 'is an adult that likes to eat', d$Food[i])
#   }
#   print(sentence)
# }
#
#
###########################


###########################
### FUNCTIONS
###########################

make_double <- function(number){
  number <- number*2
  return(number)
}

make_double(3)
make_double('hello')

make_multiplication <- function(number, factor=2){
  number <- number*factor
  return(number)
}

make_multiplication(3)
make_multiplication(3, 10)

print(number)

############ EXERCISE #####
# 
# 1. Make a function that takes our table d (recap below)
# and prints the name and favorite color of each user.
# 
# ID      Name  Color   Food Animal Age
#  1   Anthony    Red  Apple    Dog  11
#  2   Barbara   Blue Carrot    Cat  14
#  3 Charlotte  Black Orange    Pig  21
#  4    Daniel Orange   Pear    Cat  17
#
# SOLUTION:
# print_color <- function(d){
#   for(i in 1:nrow(d) ){
#     sentence <- paste(d$Name[i], 'likes the color', d$Color[i])
#     print(sentence)
#   }
# }
# print_color(d)
#
#
# 2. Make a function that takes our table d and find the row containing the oldest user.
#
# SOLUTION:
# find_oldest <- function(d){
#   max_index <- 1
#   for(i in 2:nrow(d)){
#     if(d$Age[i] > d$Age[max_index]){
#       max_index <- i
#     }
#   }
#   return(d[max_index,])
# }
# find_oldest(d)
# 
# DISCUSSION: Why line 212 loops "i in 2:nrow(d)" and not "i in 1:nrow(d)"?
# Because setting the variable "max_index <- 1" 
# will make the program test the 1st element of the vector.
#
# 3. Given the function max() below:
#   max(d$Age)
# Write a 1-line piece of code that will find the oldest user.
# (without using the function of EXERCISE 2.)
#
# SOLUTION:
# d[d$Age==max(d$Age),]
# 
###########################