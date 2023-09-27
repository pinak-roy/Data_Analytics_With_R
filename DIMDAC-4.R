# Load required libraries
library(dplyr)

# Importing Dataset
baby <- read.csv('https://raw.githubusercontent.com/guipsamora/pandas_exercises/master/06_Stats/US_Baby_Names/US_Baby_Names_right.csv')

# Check the first 10 entries
head(baby, 10)

# Check the data information
str(baby)

# Delete the columns 'Unnamed: 0' and 'Id'
baby <- baby %>%
  select(-c(Unnamed...0, Id))

# Check the first 5 rows after column deletion
head(baby)

# Count the occurrences of each name
names <- baby %>%
  group_by(Name) %>%
  summarize(n = n()) %>%
  arrange(desc(n))

# Print the first few rows of the names and their counts
head(names)

# Count the number of different names in the dataset
num_names <- names %>%
  summarise(num_names = n())

# Print the number of different names
print(num_names)

# Find the name with the most occurrences
most_common_name <- names %>%
  head(1)

# Print the most common name and its count
print(most_common_name)

# Calculate the standard deviation of the counts of names
std_dev <- names %>%
  summarise(std_dev = sd(n))

# Print the standard deviation
print(std_dev)

# Get a summary of the dataset with mean, min, max, std, and quartiles
summary(names$n)
