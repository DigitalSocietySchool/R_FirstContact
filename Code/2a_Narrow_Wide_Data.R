# data_cbs <- read.csv('../Data/CBS_Growth_Rates.csv')

###########################
### SELECT WITH PATTERN
###########################
# https://github.com/rstudio/cheatsheets/blob/master/data-import.pdf

data_cbs %>%
  select(starts_with('L'))

data_cbs %>%
  select(ends_with('s'))

########### EXERCISE #####
# 
# Select the columns that contain the growth rates.
# 
###########################

###########################
### NARROW & WIDE DATA
###########################

############ Narrow Data ############ 
# Transform Multiple Columns -> Label+Value Columns

# Transform Multiple Columns -> Label+Value Columns
data_cbs %>%
  select(Label, Periods, Output) %>%
  gather(Output, 
         key='Output', value='MEuro')

########### EXERCISE #####
# 
# Make narrow data for all the growth rate indicators, 
# and include the Label and Periods information.
# 
###########################



############ Wide Data ############ 
# Transform Label+Value Columns -> Multiple Columns
data_narrow <- data_cbs %>%
  select(Label, Periods, Output) %>%
  gather(Output, 
         key='Output', value='MEuro')

data_narrow %>% spread(Output, MEuro)

########### EXERCISE #####
# 
# Given the narrow data for growth rate (resulting for the previous exercise),
# make it wide again.
# 
###########################


