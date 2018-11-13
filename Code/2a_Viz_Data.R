# data_backup <- data_cbs
# data_cbs <- data_backup

###########################
### MULTIPLE LINES
###########################
# https://github.com/rstudio/cheatsheets/blob/master/data-import.pdf

### Narrow Data
# Transform Multiple Columns -> Label+Value Columns
data_cbs %>%
  filter(Periods > 2001) %>%
  select(Label,Periods, ends_with('Growth')) %>%
  gather(Labour_Growth, Output_Growth, ValueAdded_Growth, 
         key='Indicator', value='Rate') 

### Wide Data
# Transform Label+Value Columns -> Multiple Columns
data_narrow <- data_cbs %>%
  filter(Periods > 2001) %>%
  select(Label,Periods, ends_with('Growth')) %>%
  gather(Labour_Growth, Output_Growth, ValueAdded_Growth, 
         key='Indicator', value='Rate') 

data_narrow %>% spread(Indicator, Rate)


# Visualize
data_cbs %>%
  filter(Periods > 2001) %>%
  select(Label, Periods, ends_with('Growth')) %>%
  gather(Labour_Growth, Output_Growth, ValueAdded_Growth, 
         key='Indicator', value='Rate') %>%
  ggplot(aes(Periods, Rate, shape=Indicator, col=Indicator)) + 
  facet_wrap( ~ Label, ncol=3) + # scales='free'
  geom_point(alpha=0.5) + geom_line(alpha=0.35)

data_cbs %>%
  filter(Periods > 2001) %>%
  mutate(Labour = Labour*1000) %>%
  gather(Labour, Output, Value.Added, 
         key='Indicator', value='Rate') %>%
  ggplot(aes(Periods, Rate, shape=Indicator, col=Indicator)) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.5) + geom_line(alpha=0.35) +
  ggtitle('Unit of Labour: Year of Employement - Output & Added Value: Million Euros')





###########################
### VISUALIZE 2 DIMENSIONS
###########################
# Output Vs Valued Added
###########################


### Growth Rates
data_cbs %>% 
  filter(Periods > 2001) %>%
  ggplot(aes(Output_Growth, ValueAdded_Growth)) + 
  # facet_wrap( ~ Label, ncol=3) +
  geom_point(alpha=0.7) + 
  geom_abline(intercept = 0, slope = 1, color="grey", 
              linetype="dashed", size=0.5)


data_cbs %>% 
  filter(Periods > 2001) %>%
  ggplot(aes(Output_Growth, ValueAdded_Growth, col=Label)) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) + geom_line(alpha=0.35) +
  geom_abline(intercept = 0, slope = 1, color="grey", 
              linetype="dashed", size=0.5)

### Raw Numbers
data_cbs %>% 
  # filter(Periods > 2001) %>%
  # filter(!grepl('^Total', Label)) %>%
  ggplot(aes(Output, Value.Added, col=Label)) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) + geom_line(alpha=0.35) 


data_cbs %>% 
  ggplot(aes(Output, Value.Added, col=Label)) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) + geom_line(alpha=0.35) 
  

### + Time Dimension
data_cbs %>% 
  ggplot(aes(Output, Value.Added, col=Periods)) + 
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
  ggplot(aes(Periods, Output-Value.Added, col=Label)) + 
  geom_point(alpha=0.35) + geom_line(alpha=0.35, lty=2) +
  stat_smooth(method="lm", size=0.4, se = FALSE)

# Try: Output/Value.Added

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
