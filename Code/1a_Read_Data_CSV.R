###########################
### CSV
###########################

##### Example
csv_test <- 'col1, col2, col3\n 1, 2, 3\n 11, 22, 33\n 111, 222, 333'
print(csv_test)

write(csv_test, 'csv_test.csv')
read.csv('csv_test.csv')

##### CBS Data
# Source: https://opendata.cbs.nl/statline/#/CBS/en/dataset/83154ENG/table?ts=1540196011636
# Manually reset the filters to select all year to have the complete data

# Read downloaded csv file 
data_cbs <- read.csv('../Data/CBS_Environmental_sector__activities.csv')
head(data_cbs)

# Using ';' as separator instead of ','
data_cbs <- read.csv('../Data/CBS_Environmental_sector__activities.csv', sep=';')
head(data_cbs)

###########################

###########################
### BRIEF OVERVIEW
###########################

head(data_cbs)
tail(data_cbs)
glimpse(data_cbs)

###########################

###########################
### PIPE OPERATOR %>%
###########################
# library(stringr) # Included in tidyverse

head(data_cbs)
data_cbs %>% head 

###########################

###########################
### PREPARE DATA
###########################

#### Shorter column names
colnames(data_cbs) <- c('Header','Activities','Periods','Labour','Output','ValueAdded')
head(data_cbs)

#### Format Year
data_cbs$Periods %>% head

# Replace text with gsub()
txt <- 'This sentence has some text to replace'
txt <- gsub('to replace', 'replaced!', txt)
txt <- gsub('has', 'had', txt)
txt

data_cbs$Periods <- gsub('\\*','', data_cbs$Periods)
data_cbs$Periods <- as.numeric(data_cbs$Periods)


############ EXERCISE #####
# 
# Format the Labour column into numerical data type
# Hint: with R numbers must be separated by a dot '.' and not by a comma ','
# 
# SOLUTION:
# data_cbs$Labour %>% head
# data_cbs$Labour <- gsub(',','.', data_cbs$Labour)
# data_cbs$Labour <- as.numeric(data_cbs$Labour)
#
#
###########################

#### Save Data
write.csv(data_cbs, '../Data/CBS_Formatted.csv', row.names=FALSE)

###########################

###########################
### VISUALIZATION
###########################

########### Labour ###########
#### All-in-One
data_cbs %>% 
  ggplot(aes(Periods, Labour, col=Activities)) + 
  geom_point() + geom_line()  +
  ggtitle('Labour')

############ EXERCISE #####
# 
# Do the same visualization for the columns Output and ValueAdded.
# 
# SOLUTION:
# data_cbs %>% 
#   ggplot(aes(Periods, Output, col=Activities)) + 
#   geom_point() + geom_line()  +
#   ggtitle('Output')
# 
# data_cbs %>% 
#   ggplot(aes(Periods, ValueAdded., col=Activities)) + 
#   geom_point() + geom_line()  +
#   ggtitle('ValueAdded.')
#
###########################

# Separate in panels
data_cbs %>% 
  ggplot(aes(Periods, Labour, col=Activities)) + 
  facet_wrap( ~ Activities, ncol=3) +
  geom_point() + geom_line()  +
  ggtitle('Labour')

############ EXERCISE #####
# 
# Do the same visualization for the columns Output and ValueAdded.
# 
# SOLUTION:
# data_cbs %>% 
#   ggplot(aes(Periods, Output, col=Activities)) + 
#   facet_wrap( ~ Activities, ncol=3) +
#   geom_point() + geom_line()  +
#   ggtitle('Output')
# 
# data_cbs %>% 
#   ggplot(aes(Periods, ValueAdded, col=Activities)) + 
#   facet_wrap( ~ Activities, ncol=3) +
#   geom_point() + geom_line()  +
#   ggtitle('ValueAdded')
#
###########################

# Use different scales for the y-axis
data_cbs %>% 
  ggplot(aes(Periods, Labour, col=Activities)) + 
  facet_wrap( ~ Activities, ncol=3, scales='free') +
  geom_point() + geom_line()  +
  ggtitle('Labour')

############ EXERCISE #####
# 
# Do the same visualization for the columns Output and ValueAdded.
# 
# SOLUTION:
# data_cbs %>% 
#   ggplot(aes(Periods, Output, col=Activities)) + 
#   facet_wrap( ~ Activities, ncol=3, scales='free') +
#   geom_point() + geom_line()  +
#   ggtitle('Output')
# 
# data_cbs %>% 
#   ggplot(aes(Periods, ValueAdded, col=Activities)) + 
#   facet_wrap( ~ Activities, ncol=3, scales='free') +
#   geom_point() + geom_line()  +
#   ggtitle('ValueAdded')
#
###########################


############ EXERCISE #####
# 
# 1. Filter the dataset to exclude the data for all activities.
# Hint: we need to exclude the lines for which the column Activities 
# contains the label 'Total sector environment'.
# 
# SOLUTION:
# data_cbs[data_cbs$Activities != 'Total sector environment',] %>% head
# 
# 2. Re-run the visualization after filtering out the data for all activities.
# 
# SOLUTION:
# 
# ###### Labour Without Total
# # All-in-One
# data_cbs[data_cbs$Activities != 'Total sector environment',] %>% 
#   ggplot(aes(Periods, Labour, col=Activities)) + 
#   geom_point() + geom_line()  +
#   ggtitle('Labour')
# 
# # Separate in panels
# data_cbs[data_cbs$Activities != 'Total sector environment',] %>% 
#   ggplot(aes(Periods, Labour, col=Activities)) + 
#   facet_wrap( ~ Activities, ncol=3) +
#   geom_point() + geom_line()  +
#   ggtitle('Labour')
# 
# # Use different scales for the y-axis
# data_cbs[data_cbs$Activities != 'Total sector environment',] %>% 
#   ggplot(aes(Periods, Labour, col=Activities)) + 
#   facet_wrap( ~ Activities, ncol=3, scales='free') +
#   geom_point() + geom_line()  +
#   ggtitle('Labour')
# 
# ###### Output Without Total
# # All-in-One
# data_cbs[data_cbs$Activities != 'Total sector environment',] %>% 
#   ggplot(aes(Periods, Output, col=Activities)) + 
#   geom_point() + geom_line()  +
#   ggtitle('Output')
# 
# # Separate in panels
# data_cbs[data_cbs$Activities != 'Total sector environment',] %>% 
#   ggplot(aes(Periods, Output, col=Activities)) + 
#   facet_wrap( ~ Activities, ncol=3) +
#   geom_point() + geom_line()  +
#   ggtitle('Output')
# 
# # Use different scales for the y-axis
# data_cbs[data_cbs$Activities != 'Total sector environment',] %>% 
#   ggplot(aes(Periods, Output, col=Activities)) + 
#   facet_wrap( ~ Activities, ncol=3, scales='free') +
#   geom_point() + geom_line()  +
#   ggtitle('Output')
# 
# 
# ########### ValueAdded Without Total
# # All-in-One
# data_cbs[data_cbs$Activities != 'Total sector environment',] %>% 
#   ggplot(aes(Periods, ValueAdded, col=Activities)) + 
#   geom_point() + geom_line()  +
#   ggtitle('ValueAdded')
# 
# # Separate in panels
# data_cbs[data_cbs$Activities != 'Total sector environment',] %>% 
#   ggplot(aes(Periods, ValueAdded, col=Activities)) + 
#   facet_wrap( ~ Activities, ncol=3) +
#   geom_point() + geom_line()  +
#   ggtitle('ValueAdded')
# 
# # Use different scales for the y-axis
# data_cbs[data_cbs$Activities != 'Total sector environment',] %>% 
#   ggplot(aes(Periods, ValueAdded, col=Activities)) + 
#   facet_wrap( ~ Activities, ncol=3, scales='free') +
#   geom_point() + geom_line()  +
#   ggtitle('ValueAdded')
# 
###########################

###########################
### SAVE VISUALIZATION
###########################
# http://www.cookbook-r.com/Graphs/Output_to_a_file/

pdf('../Viz/CBS_Labour_Overview.pdf')
data_cbs %>% 
  ggplot(aes(Periods, Labour, col=Activities)) + 
  facet_wrap( ~ Activities, ncol=3, scales='free') +
  geom_point() + geom_line()  +
  ggtitle('Labour')
dev.off()


png('../Viz/CBS_Labour_Overview.png')
data_cbs %>% 
  ggplot(aes(Periods, Labour, col=Activities)) + 
  facet_wrap( ~ Activities, ncol=3, scales='free') +
  geom_point() + geom_line()  +
  ggtitle('Labour')
dev.off()

###########################
