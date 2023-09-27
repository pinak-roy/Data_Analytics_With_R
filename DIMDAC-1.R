# Importing Essential Libraries For Data Analysis
library(dplyr)
library(stringr)  # For string manipulation

# Importing dataset
url <- 'https://raw.githubusercontent.com/justmarkham/DAT8/master/data/chipotle.tsv'
chipo <- read.delim(url, sep = '\t')

# Inspecting Dataset
head(chipo, 10)

# Check the dimensions of the dataset
dim(chipo)

# Check the structure of the dataset
str(chipo)

# Summary statistics
summary(chipo)

# Which was the most-ordered item?
most_ordered_item <- chipo %>%
  count(item_name, sort = TRUE) %>%
  slice(1) %>%
  select(item_name)

most_ordered_item

# For the most-ordered item, how many items were ordered?
most_ordered_quantity <- chipo %>%
  count(item_name, sort = TRUE) %>%
  slice(1) %>%
  select(n)

most_ordered_quantity

# What was the most ordered item in the choice_description column?
most_ordered_choice_description <- chipo %>%
  count(choice_description, sort = TRUE) %>%
  slice(1)

most_ordered_choice_description

# How many items were ordered in total?
total_items_ordered <- sum(chipo$quantity)

total_items_ordered

# Turn the item price into a numeric variable
chipo$item_price_float <- as.numeric(sub("\\$", "", chipo$item_price))

# Check the new dataset
head(chipo, 10)

# Adding a new column named "sales_revenue"
chipo$sales_revenue <- chipo$quantity * chipo$item_price_float

# Check the data
head(chipo, 10)

# How much was the revenue for the period in the dataset?
total_revenue <- sum(chipo$sales_revenue)

total_revenue

# How many orders were made in the period?
number_of_orders <- length(unique(chipo$order_id))

number_of_orders

# What is the average revenue amount per order?
average_revenue <- total_revenue / number_of_orders

average_revenue

# How many different items are sold?
num_unique_items <- length(unique(chipo$item_name))

num_unique_items
