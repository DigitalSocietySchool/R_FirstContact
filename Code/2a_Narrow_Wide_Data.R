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
# SOLUTION:
# data_cbs %>%
#   select(ends_with('Growth'))
# 
###########################


###########################
### NARROW & WIDE DATA
###########################
# Narrow data encodes several columns into only 2 columns:
# one column contains all the column values, from the different columns,
# the other column indicate the column name corresponding  to each value.
# Making "narrow" data is necessary to visualize the data from different columns,
# using 1 line per column.

############ Narrow Data ############ 
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
# SOLUTION:
# data_cbs %>%
#   filter(Periods > 2001) %>%
#   select(Label, Periods, ends_with('Growth')) %>%
#   gather(Labour_Growth, Output_Growth, ValueAdded_Growth, 
#          key='Indicator', value='Rate')
# 
###########################


############ Wide Data ############ 
# Making "wide" data can reverse the "narrowing" of data (as done above)
data_narrow <- data_cbs %>%
  select(Label, Periods, Output) %>%
  gather(Output, 
         key='Output', value='MEuro')

data_narrow %>% spread(Output, MEuro)

########### EXERCISE #####
# 
# Given the narrow data for growth rate (resulting for the previous exercise),
# make it wide again.
data_narrow <- data_cbs %>%
  filter(Periods > 2001) %>%
  select(Label,Periods, ends_with('Growth')) %>%
  gather(Labour_Growth, Output_Growth, ValueAdded_Growth,
         key='Indicator', value='Rate')
#
# SOLUTION:
# data_narrow %>% spread(Indicator, Rate)
# 
###########################


###########################
### PLOT MULTIPLE LINES
###########################

data_cbs %>% 
  # Exclude years without growth rate data
  filter(Periods > 2001) %>%
  ggplot(aes(Periods, Output_Growth, col=Label)) + 
  facet_wrap( ~ Label, ncol=3) + #
  geom_point(alpha=0.5) + geom_line(alpha=0.35)


############ Visualize using Narrow Data ############ 
data_cbs %>%
  filter(Periods > 2001) %>%
  # Filter growth rate data
  select(Label, Periods, ends_with('Growth')) %>%
  # Make narrow data
  gather(Labour_Growth, Output_Growth, ValueAdded_Growth, 
         key='Indicator', value='Rate') %>%
  # Now we can plot multiple lines
  ggplot(aes(Periods, Rate, shape=Indicator, col=Indicator)) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.5) + geom_line(alpha=0.35)


########### EXERCISE #####
# 
# Visualize the raw data (not growth rate) for columns Labour, Output, ValueAdded
# using multiple lines.
#
# SOLUTION:
# data_cbs %>%
#   # Bonus: Transforms the unit of Labour for a more readable scale on the Y-axis
#   mutate(Labour = Labour*1000) %>% 
#   gather(Labour, Output, ValueAdded, 
#          key='Indicator', value='Rate') %>%
#   ggplot(aes(Periods, Rate, shape=Indicator, col=Indicator)) + 
#   facet_wrap( ~ Label, ncol=3, scales='free') +
#   geom_point(alpha=0.5) + geom_line(alpha=0.35) +
#   ggtitle('Unit of Labour: 1 Year of Employement - Output & Added Value: Million Euros')
# 
###########################