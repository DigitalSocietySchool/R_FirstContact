# This file sets up the working environment, including:
#   - loading the required library
#   - the "working directory" within your file system
#   - additional options for making coding easier

# To (re)start your R session, you can load the entire file 
# by opening it in R studio and pressing: Command + Shift + Enter

###########################
### LIBRARIES
###########################

###### Install a library

# Function to install library: 
#     install.packages('[libraryName]')
# Function to test if a library is already installed: 
#     if(!require('[libraryName]')) 

# Once a library is installed, you don't need to install it every time your execute R code.
# So, first check if a library is installed, or else we will re-installing it

# Install stringr
if(!require('stringr')) install.packages('stringr')

######  Load a library
# You need to load libraries every time you execute R code.
library(stringr) 

### TIDYVERSE 
# This library includes other libraries:
# stringr, ggplot2, dplyr, ...
# Check https://tidyverse.org/

if(!require('tidyverse')) install.packages('tidyverse')
library(tidyverse) 

# Conflicts are indicated when 2 libraries use functions having the same name. For example:
#      -- Conflicts -------------------------------- tidyverse_conflicts() --
#      x dplyr::filter() masks stats::filter()
# The above lines mean that  by default the function filter() refers to the "dplyr" library
# It overrides the function filter() from the "stats" library
# To use the function from the stats library, you must use:
#     stats::filter()

# Full list of all libraries:
# https://cran.r-project.org/web/packages/available_packages_by_name.html

############ EXERCISE #####
# 
# Install and load a libary called "rvest".
#
# SOLUTION:
# if(!require('rvest')) install.packages('rvest')
# library(rvest) 
#
###########################

###########################
### WORKING DIRECTORY
###########################
# It positions the relative paths used in your code.
# In this tutorial, we need to position relative paths where this R script file is located.

######  Option 1: use R studio menu
# In R-studio menu: Session -> Set Working Directory -> To Source File Location

######  Option 2: use the function getSourceEditorContext() from the library "rstudioapi"
if(!require('rstudioapi')) install.packages('rstudioapi')
library(rstudioapi) 
setwd(dirname(getSourceEditorContext()$path))

###########################

###########################
### GENERAL OPTIONS
###########################

###### Control how numbers are displayed

# By default R shows the scientific notation
options(scipen = 1)
print(1/10^10)

# This option disables the scientific notation
options(scipen = 999)
print(1/10^10)

###### Controls the encoding of text in data frames
# By default R tries to optimise text data. 
# But undesired behaviors often occur.
# So this is an IMPORTANT option. 
options(stringsAsFactors = FALSE)

###########################

###########################
### SHORTCUTS
###########################

# Comment/Uncomment one or several lines
# #   Cmd + Maj + C

###########################
