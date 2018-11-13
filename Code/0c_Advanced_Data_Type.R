###########################
### ADVANCED DATA TYPES
###########################

###### Vector ###### 
d <- c(1:100)
print(d)
typeof(d)

d <- d/10
print(d)

d <- c('Apple', 'Carrot', 'Orange')
print(d)
typeof(d)

d <- paste(d, 'Juice')
print(d)

###### Table of data ###### 
user1 <- c('Anthony', 'Red', 'Apple', 'Dog')
user2 <- c('Barbara', 'Blue', 'Carrot', 'Cat')
user3 <- c('Charlotte' ,'Black', 'Orange', 'Pig')

# Bind as rows
d <- rbind(user1, user2, user3)
print(d)

colnames(d) <- c('Name', 'Color', 'Food', 'Animal')
print(d)

# Bind as columns
d <- cbind(user1, user2, user3)
print(d)

rownames(d) <- c('Name', 'Color', 'Food', 'Animal')
print(d)

# Reverse Column <-> Rows
d <- t(d)
print(d)

# Add row
user4 <- c('Daniel' ,'Orange', 'Pear', 'Cat')
d <- rbind(d,user4)
print(d)

# Add column
nrow(d)
ID <- c(1:4) 
ID <- c(1:nrow(d)) 
d <- cbind(ID,d)
print(d)

# Browse data
d[1,]
d[,1] 
d[1,1]
d[2:3,]
d[2:3,c(1,2,4)]

###### Data frame ###### 
d <- data.frame(d)
print(d)

# Browse data with column name
print(d$Name)
print(d$Name[2])

# Add column
d$Age <- c(11,14,21,17)
print(d)

# Using data frame allow different data type 
typeof(d$Age)
typeof(d$ID)
d$ID <- as.numeric(d$ID)

# Data types in data frames
typeof(d$ID)
d$ID <- as.numeric(d$ID)
typeof(d$Age)

# Use filters to browse data frames
d$Animal
d$Animal == 'Cat'
d[d$Animal == 'Cat', ]
d$Animal[d$Animal == 'Cat']


############ EXERCISE #####
# 
# 1. Filter the data frame to select only the users that are minor
#
# SOLUTION:
# d[d$Age < 18, ]
# d$Age[d$Age < 18]
#
# 2. Find the Animal of the users that are minor
#
# SOLUTION:
# d[d$Age < 18, 5]
# d$Animal[d$Age < 18]
#
###########################


###########################
### EXTRA
###########################

###### List (container)
# d <- list(d)
# print(d)
# print(d[[1]])
# 
# d[[2]] <- 'Metadata: This is a sample of user preference.'
# print(d)
# 
# d[[3]] <- 1:4
# print(d)
# 
# # Manipulate lists
# d <- rev(d)
# print(d)
# 
# print(d[[1]][,2])
# rownames(d[[1]]) <- c()
# print(d[[1]][,2])
# 
# d[[1]] <- rev(d[[1]])
# print(d)

###########################