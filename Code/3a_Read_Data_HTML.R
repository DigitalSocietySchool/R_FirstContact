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
links <- links[16:27]
links <- paste0('https://www.compareyourcountry.org', links)

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
  download.file(links[i], file_names[i], mode='wb')
}

###########################


