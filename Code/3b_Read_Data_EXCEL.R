###########################
### READ EXCEL
###########################
if(!require('readxl')) install.packages("readxl")
library(readxl)

### Let's start with the Air Pollution dataset
data_airpollution <- file_names[1] %>% read_excel
data_airpollution

# The first column name is a descriptor
colnames(data)[1] %>% print
# The first row contains a longer descriptor
data_airpollution[1,1] %>% as.character 

# The 4th row contains the colum names
data_airpollution[4,] %>% as.character
colnames(data_airpollution) <- data_airpollution[4,] %>% as.character

# Rows 1-4 must be deleted
data_airpollution <- data_airpollution[5:nrow(data_airpollution),]
# Improvement: The function is.na() can test if data cells are empty.
# It's a more robust solution, in case some datasets 
# have different numbers of rows with empty values. 
data_airpollution[!data_airpollution[,2] %>% is.na(),]
# We still need to remove the 1st column: it contains labels not data.
data_airpollution[2:nrow(data_airpollution),]

### Function to read and prepare any of these datasets
get_compareyourcountry_data <- function(file_name){
  
  # 1. Read Excel File
  data <- file_name %>% read_excel
  
  # 2. Print Description
  print('### Reading Dataset ###')
  print(file_name)
  colnames(data)[1] %>% print
  data[1,1] %>% as.character %>% print
  
  # 3. Make Column Names
  colnames(data) <- data[4,]  %>% as.character
  
  # 4. Delete First Rows
  data <- data[!data[,2] %>% is.na(),]
  data <- data[2:nrow(data),]
  
  # 5. Output the result
  return(data)
}

# Applying the function
data_airparticule <- get_compareyourcountry_data(file_names[2])

###########################
### VISUALIZE
###########################

data_airpollution %>% 
  # Make narrow data
  gather(c(1998:2015) %>% as.character, 
         key='Year', value='Value') %>%
  # Make year column numerical
  mutate(Year=as.numeric(Year)) %>%
  # Now we can plot multiple lines
  ggplot(aes(Year, Value, group=Country)) +
  geom_line(alpha=0.2) 

# Note: We do not use 1 color per country, 
# because there are too many countries.

###########################
### ALL-IN-ONE FUNCTION
###########################
# We can make a function that prepare the data,
# and displays the visualization all at once.

# This way, wee can also improve the visualization by adding a title   
# that uses the descriptor in the 1st column's name.

get_compareyourcountry_data <- function(file_name){
  
  # 1. Read Excel File
  data <- file_name %>% read_excel
  
  # 2. Print & Store Description
  print('#######################')
  print('### Reading Dataset ###')
  print(file_name)
  
  descr <- colnames(data)[1]
  print(descr) 
  
  data[1,1] %>% as.character %>% print
  
  # 3. Make Column Names
  col_names <- data[4,]  %>% as.character
  colnames(data) <- col_names
  print(col_names)
  
  # 4. Delete First Rows
  data <- data[!data[,2] %>% is.na(),]
  data <- data[2:nrow(data),]
  
  # 5. Visualize data
  # Because draw visualizations from a function,
  # we need to store the graph as a variable, and use print()
  viz <- data %>% 
    gather(col_names[-1], 
           key='Year', value='Value') %>%
    mutate(Year=as.numeric(Year)) %>%
    mutate(Value=as.numeric(Value)) %>%
    ggplot(aes(Year, Value, group=Country)) +
    geom_line(alpha=0.2) +
    ggtitle(descr)
  
  print(viz)
  
  # 6. Output the result
  return(data)
}

# Applying the function
for(f in file_names) {
  get_compareyourcountry_data(f)
}


######## Improving the function (one last time!):
# Some datasets do not contain data for each year.
# For example:
data <- get_compareyourcountry_data(file_names[7])
print(data)

get_compareyourcountry_data <- function(file_name){
  
  # 1. Read Excel File
  data <- file_name %>% read_excel
  
  # 2. Print & Store Description
  print('#######################')
  print('### Reading Dataset ###')
  print(file_name)
  descr <- colnames(data)[1]
  data[1,1] %>% as.character %>% print
  print(descr) 
  
  # 3. Make Column Names
  col_names <- data[4,]  %>% as.character
  colnames(data) <- col_names
  print(col_names)
  
  # 4. Delete First Rows
  data <- data[!data[,2] %>% is.na(),]
  data <- data[2:nrow(data),]
  
  # 5. Visualize data
  # We check if data is available for several years
  # and adapt the visualization accordingly
  
  if(length(col_names) > 2){
    
    # Option for datasets with 1 column per year
    viz <- data %>% 
      gather(col_names[-1], 
             key='Year', value='Value') %>%
      mutate(Year=as.numeric(Year)) %>%
      mutate(Value=as.numeric(Value)) %>%
      ggplot(aes(Year, Value, group=Country)) +
      geom_line(alpha=0.2) +
      ggtitle(descr)
    
  } else {
    
    # Option for smaller datasets with only 2 columns
    descr <- paste(descr, 'in', col_names[2])
    colnames(data) <- c('Country', 'Values')
    
    # Make Value column numerical
    data <- data %>% mutate(Values=as.numeric(Values))
    
    # Prepare ordered list of countries
    country_list <- data %>% arrange(Values) %>% pull(Country)
    
    viz <- data %>% 
      ggplot(aes(Values, Country)) +
      geom_point() +
      # Order the countries with this trick:
      scale_y_discrete(limits = country_list) +
      ggtitle(descr)
  }
  
  # Now we can print the "adapted" visualization
  print(viz)
  
  # 6. Output the result
  return(data)
}

# Applying the function
for(f in file_names) {
  get_compareyourcountry_data(f)
}
