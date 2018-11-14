# data_backup <- data_cbs
# data_cbs <- data_backup

###########################
### TIBBLE
###########################
# data_cbs <- read.csv('../Data/CBS_Formatted.csv')
data_cbs <- data_cbs %>% as_tibble()
data_cbs

###########################

###########################
### FILTER
###########################

data_cbs %>% 
  filter(Periods == 2015)

data_cbs %>% 
  filter(Periods > 2001)

###########################

###########################
### SELECT
###########################

data_cbs %>% 
  select(Labour)

data_cbs %>% 
  filter(Periods == 2001) %>% 
  select(Labour)

########### EXERCISE #####
# 
# 1. Explain why this code is not working:
# data_cbs %>%
#   select(Labour) %>%
#   filter(Periods == 2001)
#
# 2. Print the types of economical activities.
# Hint: you can use the function unique() to exclude duplicates in a vector.
#
# 3. Filter the dataset to extract the data for your favorite economical activity.
# Hint: you can store the activity labels in a variable, instead of manually typing it.
#
###########################

###########################
### ADD DATA
###########################

# Make Shorter Labels
data_cbs %>% 
  mutate(Label = Activities %>% substr(1,5) )

########### EXERCISE #####
# 
# 1. Explain why this code is not working:
# data_cbs %>%
#   select(Label) 
#
# 2. Modify the tibble to add a Label column, with labels containing 10 characters
#
###########################

###########################

###########################
### MODIFY DATA
###########################

# Labels are too short
data_cbs$Label %>% unique()

data_cbs$Label <- substr(data_cbs$Activities, 1, 15) 
data_cbs$Label %>% unique()

data_cbs <- data_cbs %>% 
  mutate(Label = Activities %>% substr(1,20))

data_cbs$Label %>% unique()

########### EXERCISE #####
# 
# 1. Add the text '[...]' to the column Label to show that the labels were shortened
#
# 2. Save the dataset with the new column.
# 
###########################

###########################
### SORT DATA
###########################

data_cbs %>% 
  arrange(Periods)

data_cbs %>% 
  arrange( desc(Periods) )

data_cbs %>% 
  arrange(Activities, Periods)

head(data_cbs)
tail(data_cbs)

data_cbs <- data_cbs %>% 
  arrange(Activities, Periods)

head(data_cbs)
tail(data_cbs)

########### EXERCISE #####
# 
# 1. Select the data for the year 2015, and show which sector of activity 
# had the highest ValueAdded
#
###########################

