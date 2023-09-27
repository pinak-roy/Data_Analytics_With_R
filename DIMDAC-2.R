# Loading Essential Libraries
library(dplyr)

# Loading Dataset from URL
url <- 'https://raw.githubusercontent.com/guipsamora/pandas_exercises/master/02_Filtering_%26_Sorting/Euro12/Euro_2012_stats_TEAM.csv'
euro <- read.csv(url)

# Checking the Data for analysis
head(euro)

# Check the structure of the dataset
str(euro)

# Summary statistics
summary(euro)

# How many teams participated in the Euro2012?
euro %>%
  summarize(Num_Teams = n_distinct(Team))

# What is the number of columns in the dataset?
ncol(euro)

# View only the columns Team, Yellow Cards and Red Cards and assign them to a dataframe called discipline.
discipline <- euro %>%
  select(Team, Yellow.Cards, Red.Cards)

head(discipline)

# Sort the discipline dataframe by Red Cards and then by Yellow Cards
discipline %>%
  arrange(Red.Cards, Yellow.Cards)

# Calculate the mean Yellow Cards given per Team.
discipline %>%
  group_by(Team) %>%
  summarize(mean_yellow_cards = mean(Yellow.Cards))

# Filter teams that scored more than 6 goals
euro %>%
  filter(Goals > 6) %>%
  select(Team, Goals)

# Select the teams that start with the letter G.
euro %>%
  filter(substr(Team, 1, 1) == "G") %>%
  select(Team)

# Select the first 7 columns
euro %>%
  select(1:7)

# Present only the Shooting Accuracy from England, Italy and Russia.
euro %>%
  filter(Team %in% c("England", "Italy", "Russia")) %>%
  select(`Shooting Accuracy`)

# Select all columns except the last 3
euro %>%
  select(-(Players.Used:Subs.off))
