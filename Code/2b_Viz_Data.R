# data_cbs <- read.csv('../Data/CBS_Growth_Rates.csv') %>% tibble

###########################
### PLOT MULTIPLE LINES
###########################

############ Visualize using Narrow Data ############ 
data_cbs %>%
  # Exclude years without growth rate data
  filter(Periods > 2001) %>%
  # Filter growth rate data
  select(Label, Periods, ends_with('Growth')) %>%
  # Make narrow data
  gather(Labour_Growth, Output_Growth, ValueAdded_Growth, 
         key='Indicator', value='Rate') %>%
  # Now we can plot multiple lines
  ggplot(aes(Periods, Rate, shape=Indicator, col=Indicator)) + 
  facet_wrap( ~ Label, ncol=3) + # Option: scales='free'
  geom_point(alpha=0.5) + geom_line(alpha=0.35)


########### EXERCISE #####
# 
# Visualize the raw data (not growth rate) for columns Labour, Output, ValueAdded
# using multiple lines.
# 
###########################



###########################
### VISUALIZE 2 DIMENSIONS
###########################
# Output Vs Valued Added
###########################


### Growth Rates
data_cbs %>% 
  filter(Periods > 2001) %>%
  ggplot(aes(Output_Growth, ValueAdded_Growth)) + 
  geom_point(alpha=0.7) + 
  geom_abline(intercept = 0, slope = 1, color="grey", 
              linetype="dashed", size=0.5)

########### EXERCISE #####
# 
# 1. Make a visualization for comparing Output Vs Valued Added
# for each economic activity separately.
#
#
# 2. Make a visualization for comparing the growth rates of Labour and ValueAdded.
#
#
# 3. Make a visualization for comparing the growth rates of Labour and Output.
#
# Bonus: Try the visualizatin with and without the option scales='free'
#
###########################

### Raw Numbers
data_cbs %>% 
  # filter(Periods > 2001) %>%
  # filter(!grepl('^Total', Label)) %>%
  ggplot(aes(Output, ValueAdded, col=Label)) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) + geom_line(alpha=0.35) 


data_cbs %>% 
  ggplot(aes(Output, ValueAdded, col=Label)) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) + geom_line(alpha=0.35) 
  

### + Time Dimension
data_cbs %>% 
  ggplot(aes(Output, ValueAdded, col=Periods)) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) +
  geom_path(alpha=0.35)

data_cbs %>% 
  filter(Periods > 2001) %>%
  ggplot(aes(Output_Growth, ValueAdded_Growth, col=Periods)) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) +
  geom_path(alpha=0.35) +
  geom_abline(intercept = 0, slope = 1, color="grey", 
              linetype="dashed", size=0.5)



### Aggregate w.Time as x-axis
data_cbs %>% 
  filter(Periods > 2001) %>%
  ggplot(aes(Periods, Output_Growth-ValueAdded_Growth, col=Label)) + 
  facet_wrap( ~ Label, ncol=3) + #
  geom_point(alpha=0.5) + geom_line(alpha=0.35)

data_cbs %>% 
  filter(!grepl('^Total', Label)) %>%
  ggplot(aes(Periods, Output-ValueAdded, col=Label)) + 
  geom_point(alpha=0.35) + geom_line(alpha=0.35, lty=2) +
  stat_smooth(method="lm", size=0.4, se = FALSE)

# Try: Output/ValueAdded

###########################
# Labour Vs Valued Added
###########################

data_cbs %>% 
  filter(Periods > 2001) %>%
  ggplot(aes(Labour_Growth, ValueAdded_Growth, col=Label)) +  
  facet_wrap( ~ Label, ncol=3) + 
  geom_point(alpha=0.5) + 
  geom_path(alpha=0.35)

data_cbs %>% 
  filter(Periods > 2001) %>%
  ggplot(aes(Labour_Growth, Output_Growth, col=Label)) + 
    facet_wrap( ~ Label, ncol=3) + 
    geom_point(alpha=0.5) + 
    geom_path(alpha=0.35)

### Aggregate w. Time as x-axis
# Rate
data_cbs %>% 
  filter(Periods > 2001) %>%
  ggplot(aes(Periods, Labour_Growth-Output_Growth, col=Label)) + 
    facet_wrap( ~ Label, ncol=3) + #
    geom_point(alpha=0.5) + geom_line(alpha=0.35)

data_cbs %>% 
  filter(Periods > 2001) %>%
  ggplot(aes(Periods, Labour_Growth-ValueAdded_Growth, col=Label)) + 
    facet_wrap( ~ Label, ncol=3) + 
    geom_point(alpha=0.5) + geom_line(alpha=0.35)


###########################
