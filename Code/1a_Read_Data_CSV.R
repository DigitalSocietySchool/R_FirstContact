###########################
### CSV 
###########################
# CSV means Comma Separated Value

##### Toy example
# \n is a special character indicating a new line
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

# It's not well encoded...
# We need to use ';' as separator instead of ','
data_cbs <- read.csv('../Data/CBS_Environmental_sector__activities.csv', sep=';')
head(data_cbs)

###########################


###########################
### BRIEF OVERVIEW
###########################

# Print the first rows
head(data_cbs)
# Print the last rows
tail(data_cbs)

# Print the column names and the first values
glimpse(data_cbs)

###########################


###########################
### PIPE OPERATOR %>%
###########################
# From the library "stringr", which is included in tidyverse

# Teh following line are equivalent:
head(data_cbs)
data_cbs %>% head 

name <- 'Emma'
print( paste(name, 'is happy') )
paste(name, 'is happy') %>% print

###########################



###########################
### PREPARE DATA
###########################

#### Shorter column names
colnames(data_cbs) <- c('Header','Activities','Periods','Labour','Output','ValueAdded')
head(data_cbs)
data_cbs %>% glimpse

#### Format Data
# We need to remove the character "*" in the column Periods
# We need to replacve the character "," by "." in the column Labour
# and we need to convert both columns from text data to numerical data 
data_cbs$Periods %>% head 
data_cbs$Labour %>% head

# Replace text with the function gsub()
# Example:
txt <- 'This sentence has some text to replace'
txt <- gsub('to replace', 'replaced!', txt)
txt <- gsub('has', 'had', txt)
txt

prices <- c('10e', '25e')
good_prices <- gsub('e', ' euro', prices)

# Replace & convert
data_cbs$Periods <- gsub('\\*','', data_cbs$Periods)
data_cbs$Periods <- as.numeric(data_cbs$Periods)

############ EXERCISE #####
# 
# Format the Labour column into numerical data type
# Hint: with R numbers must be separated by a dot '.' and not by a comma ','
#
# SOLUTION:
data_cbs$Labour <- gsub(',','.', data_cbs$Labour)
data_cbs$Labour <- as.numeric(data_cbs$Labour)
#
###########################

#### Save the formatted ata
write.csv(data_cbs, '../Data/CBS_Formatted.csv', row.names=FALSE)

###########################

###########################
### VISUALIZATION
###########################

data_cbs %>% 
  ggplot(aes(Periods, Labour, col=Activities)) + 
  geom_point() +  geom_line() +
  ggtitle('Labour')

#### Remove data showing the Total 
# It change the scale of the Y-axis and makes the rest of the data hard to read

# Option 1: user filters with TRUE/FALSE values
data_cbs[data_cbs$Activities != "Total sector environment", ] %>% 
  filter(Activities != "Total sector environment") %>%
  ggplot(aes(Periods, Labour, col=Activities)) + 
  geom_point() + geom_line() +
  ggtitle('Labour')

# Option 2: user the function filter()
data_cbs %>% 
  filter(Activities != "Total sector environment") %>%
  ggplot(aes(Periods, Labour, col=Activities)) + 
  geom_point() + geom_line() +
  ggtitle('Labour')

############ EXERCISE #####
# 
# Do the same visualization for the columns Output and ValueAdded.
#
###########################

# Separate in panels
data_cbs %>% 
  filter(Activities != "Total sector environment") %>%
  ggplot(aes(Periods, Labour, col=Activities)) + 
  facet_wrap( ~ Activities, ncol=3) +
  geom_point() + geom_line()  +
  ggtitle('Trends in Labour')

############ EXERCISE #####
# 
# Do the same visualization for the columns Output and ValueAdded.
#
###########################

# Use different scales for the y-axis
# This way we can keep the "Total" information
data_cbs %>% 
  ggplot(aes(Periods, Labour, col=Activities)) + 
  facet_wrap( ~ Activities, ncol=3, scales='free') +
  geom_point() + geom_line()  +
  ggtitle('Trends in Labour')

############ EXERCISE #####
# 
# Do the same visualization for the columns Output and ValueAdded.
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
  ggtitle('Trends in Labour')
dev.off()


png('../Viz/CBS_Labour_Overview.png')
data_cbs %>% 
  ggplot(aes(Periods, Labour, col=Activities)) + 
  facet_wrap( ~ Activities, ncol=3, scales='free') +
  geom_point() + geom_line()  +
  ggtitle('Trends in Labour')
dev.off()

# Use custom width & height (default unit is pixels)
png('../Viz/CBS_Labour_Overview.png', width=600, height=1000)
data_cbs %>% 
  ggplot(aes(Periods, Labour, col=Activities)) + 
  facet_wrap( ~ Activities, ncol=3, scales='free') +
  geom_point() + geom_line()  +
  ggtitle('Trends in Labour')
dev.off()

###########################
