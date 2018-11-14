###########################
### IF - THEN - ELSE
###########################

credit <- 10

if( credit <= 0 ){
  print('Your have no credit!')
} else if( credit < 5 ) {
  print('Your credit is insufficient...')
} else {
  print('You have enough credit')
}

###### Boolean
d <- TRUE
print(d)
print(!d)

as.numeric(d)
as.character(d)

as.logical('TRUE')
as.logical(0)

###### Use of booleans for tests
d <- 100
d == 100
d == 200
d = 200
print(d)
d > 10
d < 100

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
###########################

###########################
### FOR LOOP
###########################

participants <- c('Anthony', 'Barbara', 'Charlotte', 'Daniel')

for(p in participants){
  print(p)
}

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
# Data table from previous session:
# d <- data.frame()
# user1 <- c('Anthony', 'Red', 'Apple', 'Dog')
# user2 <- c('Barbara', 'Blue', 'Carrot', 'Cat')
# user3 <- c('Charlotte' ,'Black', 'Orange', 'Pig')
# user4 <- c('Daniel' ,'Orange', 'Pear', 'Cat')
# d <- rbind(d, user1, user2, user3, user4)
# d$Age <- c(11,14,21,17)
# d <- cbind(c(1:nrow(d)), d)
# colnames(d) <- c('ID', 'Name', 'Color', 'Food', 'Animal', 'Age')

print(d)

for(i in 1:nrow(d) ){
  print(d[i,])
}

for(i in 1:nrow(d) ){
  if(d$Age[i] < 18){
    print(d$Name[i])
  }
}

minors <- c()
for(i in 1:nrow(d) ){
  if(d$Age[i] < 18){
    minors <- c(minors, d$Name[i])
  }
}
print(minors)
length(minors)

minors <- d$Name[d$Age >= 18]
print(minors)

############ EXERCISE #####
# 
# 1. Write a loop that browse the table, and "prints" a sentence 
# describing the user's name and favorite color.
#
# 
# 2. Write a loop that describes whether users are minor or adults, 
# and their favorite food.
#
# Tip: use paste0() instead of paste() if you do not want extra spaces 
# when constructing sentences.
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
# 1  1   Anthony    Red  Apple    Dog  11
# 2  2   Barbara   Blue Carrot    Cat  14
# 3  3 Charlotte  Black Orange    Pig  21
# 4  4    Daniel Orange   Pear    Cat  17
#
# 2. Make a function that takes our table d and find the oldest user.
# 
# 3. Given the function max() below:
#   max(d$Age)
# Write a 1-line piece of code that will find the oldest user.
# (without using the function of EXERCISE 2.)
#
# 
# 4. Write your own function max_age()
# 
###########################