# Load required libraries
library(dplyr)

# Reading Dataset From Remote Server
wine <- read.csv('https://raw.githubusercontent.com/justmarkham/DAT8/master/data/drinks.csv')

# Display the structure of the data
str(wine)

# View the first 10 rows of the data
head(wine, 10)

# Dropping the 'continent' column
wine <- wine %>%
  select(-continent)

# Adding a new column with automated continent names
library(countrycode)
wine$Continent <- countrycode(sourcevar = wine$country,
                               origin = "country.name",
                               destination = "continent")

# Handling missing values in the 'Continent' column
wine$Continent[is.na(wine$Continent)] <- "Oceania"

# Display the structure of the data after cleaning
str(wine)

# Calculate the continent that drinks the most beer on average
beer_avg <- wine %>%
  group_by(Continent) %>%
  summarize(avg_beer_con = mean(beer_servings)) %>%
  arrange(desc(avg_beer_con)) %>%
  head(1)

# Print the result
print(beer_avg)

# Calculate statistics for wine consumption by continent
wine_stats <- wine %>%
  group_by(Continent) %>%
  summarize(mean_wine_servings = mean(wine_servings),
            median_wine_servings = median(wine_servings),
            min_wine_servings = min(wine_servings),
            max_wine_servings = max(wine_servings),
            std_wine_servings = sd(wine_servings))

# Print the result
print(wine_stats)

# Calculate the mean alcohol consumption per continent for every column
alcohol_mean <- wine %>%
  group_by(Continent) %>%
  summarize(mean_beer_servings = mean(beer_servings),
            mean_wine_servings = mean(wine_servings),
            mean_spirit_servings = mean(spirit_servings),
            mean_total_litres_of_pure_alcohol = mean(total_litres_of_pure_alcohol))

# Print the result
print(alcohol_mean)

# Calculate the median alcohol consumption per continent for every column
alcohol_median <- wine %>%
  group_by(Continent) %>%
  summarize(median_beer_servings = median(beer_servings),
            median_wine_servings = median(wine_servings),
            median_spirit_servings = median(spirit_servings),
            median_total_litres_of_pure_alcohol = median(total_litres_of_pure_alcohol))

# Print the result
print(alcohol_median)
