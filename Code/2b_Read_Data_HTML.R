###########################
### BROWSE HTML DATA 
###########################
# https://github.com/hadley/rvest
# https://cran.r-project.org/web/packages/rvest/rvest.pdf
if(!require('rvest')) install.packages('rvest')
library(rvest)

### Economic Indicators - Tourism
url <- 'https://tradingeconomics.com/country-list/tourism-revenues' 

tourism <- url %>% read_html() %>% html_nodes('table') %>% html_table() 
print(tourism)
tourism <- tourism[[1]]

colnames(tourism) <- c('Country','Last','Last.Date','Previous','Highest','Lowest','Currency','TimeUnit')

###########################
### GET WEB DATA 
###########################
# Green Growth Indicators

url <- 'https://www.compareyourcountry.org/green-growth-indicators?cr=oecd&lg=en&page=0&charts=c1497545982336+c1497545790794&template=10'

links <- url %>% read_html %>% html_nodes('a') %>% html_attr('href')
links %>% print
links[16:27]
links <- paste0('https://www.compareyourcountry.org', links[16:27])

labels <- url %>% read_html %>% xml_nodes(xpath='//a/../..')
labels %>% print
labels[8:19]
url %>% read_html %>% xml_nodes('.indicatorName')

labels <- url %>% read_html %>% xml_nodes('.indicatorName') %>% html_text
labels %>% print
labels <- gsub('^[^A-Za-z]*|[^A-Za-z]*$', '', labels)
labels %>% print

file_names <- gsub(' ', '_', labels)
labels %>% gsub(pattern=' ', replacement='_') -> file_names

dir.create('../Indicators')
file_names <- paste0('../Indicators/',file_names,'.xlsx')

length(file_names)
length(links)

for(i in 1:length(file_names)){
  download.file(links[i], file_names[i])
}

# url <- 'http://www.oecd.org/greengrowth/green-growth-indicators/'
# 
# url <- 'https://opendata.cbs.nl/statline/#/CBS/en/dataset/81810eng/table?ts=1538476093737'
# url <- 'https://en.wikipedia.org/wiki/Green_economy'
# url <- 'https://tradingeconomics.com/country-list/tourism-revenues'
# 
# tbl[[1]] %>% html_children()
# tbl[[1]] %>% html_nodes('td') %>% html_text
# 
# xmlToDataFrame(nodes=tbl[[1]])


# url %>% read_html %>% xml_find_all("//*[name()='body']") %>% xml_children
# url %>% read_html %>% xml_find_all("//*[name()='div']")

###########################


###########################
### EXCEL
###########################

### Air Pollution
data_airpollution <- file_names[1] %>% read_excel

data_airpollution
data_airpollution[1,1] %>% as.character 
data_airpollution[1,1] %>% as.character -> data_airpollution_descr

data_airpollution[4,] %>% as.character
names(data_airpollution) <- data_airpollution[4,]  %>% as.character

data_airpollution
data_airpollution <- data_airpollution[5:nrow(data_airpollution),]

data_airpollution %>% filter(Country=='France')


### Air Particules
data_airparticule <- file_names[2] %>% read_excel

data_airparticule
data_airparticule[1,1] %>% as.character
data_airparticule[1,1] %>% as.character -> data_airparticule_descr

data_airparticule[4,]  %>% as.character
names(data_airparticule) <- data_airparticule[4,]  %>% as.character

data_airparticule
data_airparticule <- data_airparticule[5:nrow(data_airparticule),]

data_airparticule %>% filter(Country=='France')

### Function
get_compareyourcountry_data <- function(file_name){
  
  # 1. Read Excel File
  data <- file_name %>% read_excel
  
  # 2. Print Description
  print('### Reading Dataset ###')
  print(file_name)
  names(data)[1] %>% print
  data[1,1] %>% as.character %>% print
  
  # 3. Make Column Names
  names(data) <- data[4,]  %>% as.character
  
  # 4. Delete First Rows
  data <- data[5:nrow(data),]
  
  # 5. Output the result
  return(data)
}

data_airparticule <- get_compareyourcountry_data(file_names[2])

data_compareyourcountry <- list()

for(i in 1:length(file_names)){
  print('#####################')
  print(paste0('data_compareyourcountry[[',i,']]'))
  data_compareyourcountry[[i]] <- get_compareyourcountry_data(file_names[i])
}



### Example
# readxl_example()[5] %>% readxl_example() %>% read_excel

### CBS Data
## Wrong Excel Format # data_cbs_excel <- read_xls('../Data/Green_Growth.xls') 
# data_greengrowth <- read_xml('../Data/Green_Growth.xls')
# 
# data_greengrowth %>% xml_text
# data_greengrowth %>% xml_children
# 
# data_greengrowth %>% xml_find_all("//*[name()='Table']") %>% xml_children
# 
# xmlToDataFrame(data_greengrowth, 
#                nodes = data_greengrowth %>% xml_find_all("//*[name()='Row']"),
#                collectNames=FALSE)


###########################
