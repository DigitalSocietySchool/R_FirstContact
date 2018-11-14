# data_cbs <- read.csv('../Data/CBS_Formatted.csv') %>% tibble

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
# 1. Add growth rates for Output and ValueAdded data. 
#
# 2. Save the dataset with the new columns for growth rates.
# 
# 3. Visualize the data using the same graphs as before.
# 
###########################
