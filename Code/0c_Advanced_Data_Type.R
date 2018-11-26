###########################
### VECTOR (a.k.a. array)
###########################
# A vector is variables that contains a series of values, of the same data type

###### Series of numbers 
d <- c(1:10)
print(d)
typeof(d)

# This operation is done on all the numbers stored in variable d
d <- d/10
print(d)

###### Series of text 
c(letters)

###### Series of numbers 
d <- c('Apple', 'Carrot', 'Orange')
print(d)
typeof(d)

# This operation is done on all the numbers stored in variable d
d <- paste(d, 'Juice')
print(d)

###### Adding a value

# Add value at the beginning
d <- c('Kiwi', d)

# Add value at the end
d <- c(d, 'Tomato')

# Add value at specific position. 
# The folloowing replaces the 2nd element:
d[2] <- 'Lemon'

# The following creates empty elements, containing NA values (Not Available):
d[10] <- 'Pear'

###### Get the number of elements in a vector
length(d)

###########################
### TABLE OF DATA
###########################

user1 <- c('Anthony', 'Red', 'Apple', 'Dog')
user2 <- c('Barbara', 'Blue', 'Carrot', 'Cat')
user3 <- c('Charlotte' ,'Black', 'Orange', 'Pig')

###### Assemble as rows
d <- rbind(user1, user2, user3)
print(d)

# Use specific column names
colnames(d) <- c('Name', 'Color', 'Food', 'Animal')
print(d)

###### Assemble as columns
d <- cbind(user1, user2, user3)
print(d)

# Use specific row names (row names are just aesthetics, and should not contain important data)
rownames(d) <- c('Name', 'Color', 'Food', 'Animal')
print(d)

###### Reverse Column <-> Rows
d <- t(d)
print(d)

###### Get the numebr of columns and rows
nrow(d)
ncol(d)

###### Add row
user4 <- c('Daniel' ,'Orange', 'Pear', 'Cat')
d <- rbind(d,user4)
print(d)

###### Add column
# If you know the number of rows
ID <- c(1:4) 
# Alternative using nrow() instead of hard-coded number of rows
ID <- c(1:nrow(d))

d <- cbind(ID,d)
print(d)

###### Browse tables 
# (note where the comma is within the brackets [ , ] )

# Select a row, using its row number:
d[3,]
# Select a raneg of lines:
d[1:3,]


# Select a column, using its column number:
d[ ,1] 
# Select a range of columns:
d[ , c(1:2,4)]

# Select a table cell, using its row & column numbers:
d[1,3]

# Select a range of cells, using row & column numbers:
d[2:3, c(1:2,4)]



###########################
### DATA FRAME
###########################
# Data frames allow more flexibility to store different data types,
# and to select columns using the column names.

##### Transform tables into data frame
d <- data.frame(d)
print(d)
typeof(d)

##### Select a column's data, using the column name
print(d$Name)
# Select a specific value in a column's data
print(d$Name[2])

##### Add a column, with a specific column name
d$Age <- c(11,14,21,17)
print(d)

##### Adjust data types 
# The column ID was created when the table was not a data frame.
# and its values were converted to text.
typeof(d$ID)
# The column Age was created after the table was amde a data frame,
# and its avlues were kept as numerical
typeof(d$Age)

# Using data frame allow different data type,
# so now we can convert the column ID to numerical data.
d$ID <- as.numeric(d$ID)


##### Use filters to browse data frames

# This test checks all values of the column Animal,
# and provide a list of TRUE/FALSE values (i.e., TRUE is the value is "Cat")
d$Animal == 'Cat'

# The list of TRUE/FALSE values can be used to select specific rows of the table.
# For example: if the 1st value is FALSE, the 1st row of the table is not selected. 
# If the 2nd value is TRUE, the 2nd row is selected. 
d[d$Animal == 'Cat', ]

# The list of TRUE/FALSE values can also be used to select specific values of a vector.
# For example, with the vector of values from the column Name: 
# if the 1st value is FALSE, the 1st value of the column is not selected. 
# IF the 2nd value is TRUE, the 2nd value of the column is selected. 
d$Name[d$Animal == 'Cat']



############ EXERCISE #####
# 
# 1. Filter the data frame to select only the users that are minor.
# Hint: the filter can be obtained using d$Age < 18
# 
# SOLUTION:
# d[d$Age < 18, ]
#
# 2. Find the Animal of the users that are minor
#
# SOLUTION:
# d$Animal[d$Age < 18]
#
###########################
