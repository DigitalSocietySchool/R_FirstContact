###########################
### BASIC DATA TYPES
###########################

###### Numbers
d <- 1
print(d)

d <- 2 * d
print(d)

d <- d / 10
print(d)

###### Text a.k.a. string
d <- 'Hello'
print(d)

# Concatenate text
d <- paste(d, 'World') 

# Concatenate text WITHOUT space
d <- paste0(d, '!') 

# Concatenate text using custom separator
names <- paste('Mary', 'John', 'Peter', sep=', ')
print(names)

###### Converting Text <-> Number
# Check the type of data
typeof(d)

d <- 100
d <- as.character(d)
print(d)
d <- as.numeric(d)
print(d)

d <- '200'
d <- d/2
d <- as.numeric(d)
d <- d/2
print(d)

# Impossible to convert
d <- 'Hello'
d <- as.numeric(d)


############ EXERCISE #####
# 
# Given someone's age and name, for example:
age <- 34
name <- 'Carole'
# Make a sentence saying that "Carol is 34 year old."
#
# SOLUTION
# sentence <- paste(name, 'is', age, 'year old')
# print(sentence)
#
###########################
