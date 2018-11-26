#### Restoring the working environment (if you just restarted R Studio)
if(!require('rstudioapi')) install.packages('rstudioapi')
library(rstudioapi) 
setwd(dirname(getSourceEditorContext()$path))
source('0a_Basics_Environment.R')

### Reload the data
# data_cbs <- read.csv('../Data/CBS_Formatted.csv')

###########################
### APPLICATION: ADDING ERROR RATE
###########################

# NOTE: This approach uses a for loop to browse the data and calculate growth rate.
# It works ONLY if we sorted the table properly.

data_cbs <- data_cbs %>% 
  arrange(Activities, Periods)

head(data_cbs)
tail(data_cbs)

Labour_Growth <- c()

for(i in 1:nrow(data_cbs)){
  
  # For Year 2001: No Rate (no data for year 2000)
  if( data_cbs$Periods[i] == 2001 ) {
    Labour_Growth[i] <- NA
  } else {
    Labour_Growth[i] <- data_cbs$Labour[i]/data_cbs$Labour[i-1]
  }
  
}

Labour_Growth %>% head %>% print

data_cbs <- data_cbs %>% 
  mutate(Labour_Growth=Labour_Growth)

########### EXERCISE #####
# 
#### 1. Add growth rates for Output and ValueAdded data. 
#
# SOLUTION:
# Labour_Growth <- Output_Growth <- ValueAdded_Growth <- c()
# 
# for(i in 1:nrow(data_cbs)){
# 
#   # For Year 2001: No Rate (no data for year 2000)
#   if( data_cbs$Periods[i] == 2001 ) {
#     Labour_Growth[i] <- Output_Growth[i] <- ValueAdded_Growth[i] <- NA
#   } else {
#     Labour_Growth[i] <- data_cbs$Labour[i]/data_cbs$Labour[i-1]
#     Output_Growth[i] <- data_cbs$Output[i]/data_cbs$Output[i-1]
#     ValueAdded_Growth[i] <- data_cbs$ValueAdded[i]/data_cbs$ValueAdded[i-1]
#   }
# 
# }
# 
# data_cbs <- data_cbs %>%
#   mutate(Labour_Growth=Labour_Growth,
#          Output_Growth=Output_Growth,
#          ValueAdded_Growth=ValueAdded_Growth)
#
#
#
#### 2. Save the dataset with the new columns for growth rates.
#
# SOLUTION:
# write.csv(data_cbs, '../Data/CBS_Growth_Rates.csv', row.names=FALSE)
# 
#
#### 3. Visualize the data using the same graphs as before.
#
# SOLUTION:
# 
### VISUALIZATION - Step 1
# 
# data_cbs %>% 
#   filter(!is.na(Labour_Growth)) %>%
#   ggplot(aes(Periods, Labour_Growth, col=Label)) + 
#   facet_wrap( ~ Label, ncol=3) +
#   geom_point() + geom_line()  +
#   ggtitle('Labour_Growth')
# 
# data_cbs %>% 
#   filter(!is.na(Output_Growth)) %>%
#   ggplot(aes(Periods, Output_Growth, col=Label)) + 
#   geom_point() + geom_line()  +
#   ggtitle('Output_Growth')
# 
# data_cbs %>% 
#   filter(!is.na(ValueAdded_Growth)) %>%
#   ggplot(aes(Periods, ValueAdded_Growth, col=Label)) + 
#   geom_point() + geom_line()  +
#   ggtitle('ValueAdded_Growth')
#
#
### VISUALIZATION - Step 2
# 
# data_cbs %>% 
#   filter(Periods > 2001) %>%
#   ggplot(aes(Periods, Labour_Growth, col=Label, group=1)) + 
#   facet_wrap( ~ Label, ncol=3) +
#   geom_point() + geom_line() 
# 
# data_cbs %>% 
#   filter(Periods > 2001) %>%
#   ggplot(aes(Periods, Output_Growth, group=1)) + 
#   facet_wrap( ~ Label, ncol=3) +
#   geom_point() + geom_line() 
# 
# data_cbs %>% 
#   filter(Periods > 2001) %>%
#   ggplot(aes(Periods, ValueAdded_Growth, group=1)) + 
#   facet_wrap( ~ Label, ncol=3) +
#   geom_point() + geom_line() 
# 
###########################

### ADVANCED EXERCISE #####
# This exercise is complicated. 
# it is intended for more experienced developpers.
#
#### 4. Add a column with the Labour growth rates without using a for loop.
# 
# data_cbs <- data_cbs %>%
#   arrange(Activities, Periods)
# 
# # Copy the Labour column in a vector
# labour_vector <- data_cbs$Labour
# # Move the vector by 1 position
# labour_vector <- c(0, labour_vector)
# # Delete the last value
# labour_vector <- labour_vector[1:(length(labour_vector)-1)]
# 
# # Use this vector to calculate the growth rate
# data_cbs <- data_cbs %>%
#   mutate(Labour_Growth_v2 = Labour/labour_vector)
# # Delete growth rates results for Year 2001, using ifelse() function
# data_cbs <- data_cbs %>%
#   mutate(Labour_Growth_v2 = ifelse(Periods==2001, NA, Labour_Growth_v2))
# 
# # Check Results
# data_cbs %>% head
# data_cbs %>% filter(Periods==2001)
# 
# ### Bonus: all in one!
# data_cbs <- data_cbs %>%
#   mutate(Labour_Growth_v3 = ifelse(Periods==2001, NA, Labour/labour_vector )) 
#
###########################
