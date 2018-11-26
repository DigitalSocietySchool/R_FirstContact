# data_cbs <- read.csv('../Data/CBS_Growth_Rates.csv') %>% tibble


###########################
### VISUALIZE 2 VARIABLES
###########################
# Check relationship between Output and Valued Added

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
# 2. Make a visualization for comparing the growth rates of Labour and ValueAdded.
#
# 3. Make a visualization for comparing the growth rates of Labour and Output.
#
# Bonus: Try the visualizatin with and without the option scales='free'
#
###########################

###########################
### WHAT EXACTLY DID WE SEE?
###########################

### Show the Time Dimensionn with colors
data_cbs %>% 
  filter(Periods > 2001) %>%
  ggplot(aes(Output_Growth, ValueAdded_Growth, col=Periods)) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) +
  geom_line(alpha=0.35) +
  geom_abline(intercept = 0, slope = 1, color="grey", 
              linetype="dashed", size=0.5)

# We need to use factor() to have discrete legends, 
# and group() to indicate what to link with a line
data_cbs %>% 
  filter(Periods > 2001) %>%
  ggplot(aes(Output_Growth, ValueAdded_Growth, 
             group=factor(Label), col=factor(Periods) )) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) +
  geom_line(alpha=0.35) +
  geom_abline(intercept = 0, slope = 1, color="grey", 
              linetype="dashed", size=0.5)

########### EXERCISE #####
# 
# 1. In the previous visualization (recap below), was the line between the data points  
# showing the evolution of growth rate over time?
#
### Previous Visualization
data_cbs %>% 
  filter(Periods > 2001) %>%
  ggplot(aes(Output_Growth, ValueAdded_Growth, col=Label)) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) +
  geom_line(alpha=0.35) +
  geom_abline(intercept = 0, slope = 1, color="grey", 
              linetype="dashed", size=0.5)

# 
###########################

### Use geom_path()
data_cbs %>% 
  filter(Periods > 2001, Label==data_cbs$Label[1]) %>%
  ggplot(aes(Output_Growth, ValueAdded_Growth, 
             group=factor(Label), col=factor(Periods) )) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) +
  geom_path(alpha=0.35) +
  geom_abline(intercept = 0, slope = 1, color="grey", 
              linetype="dashed", size=0.5)

# The order of the data matters when using geom_path() !
data_cbs %>% 
  filter(Periods > 2001, Label==data_cbs$Label[1]) %>%
  arrange(Output_Growth) %>%
  ggplot(aes(Output_Growth, ValueAdded_Growth, 
             group=factor(Label), col=factor(Periods) )) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) +
  geom_path(alpha=0.35) +
  geom_abline(intercept = 0, slope = 1, color="grey", 
              linetype="dashed", size=0.5)

data_cbs %>% 
  filter(Periods > 2001, Label==data_cbs$Label[1]) %>%
  arrange(ValueAdded_Growth) %>%
  ggplot(aes(Output_Growth, ValueAdded_Growth, 
             group=factor(Label), col=factor(Periods) )) + 
  facet_wrap( ~ Label, ncol=3, scales='free') +
  geom_point(alpha=0.7) +
  geom_path(alpha=0.35) +
  geom_abline(intercept = 0, slope = 1, color="grey", 
              linetype="dashed", size=0.5)


########### EXERCISE #####
# 
# 1. Visualize the growth rates for all activities,
# using a line connecting the point by chronological order.
# 
#
# 2. Play with the colors and other parameters, 
# to make the graph easier to read.
# Hint: You can use transparency to encode data, for example
# alpha=Periods instead of col=Periods.
# Hint2: the parameters of geom_point() can override the aes() parameters.
#
#
# 3. Visualize the relationships between Labour_Growth and Output_Growth,
# and Labour_Growth and ValueAdded_Growth
#
#########################
