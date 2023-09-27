# Load required libraries
library(ggplot2)

# Importing Dataset
data <- read.csv('https://raw.githubusercontent.com/guipsamora/pandas_exercises/master/07_Visualization/Titanic_Desaster/train.csv')

# Set PassengerId as the index
data <- data[order(data$PassengerId), ]
rownames(data) <- data$PassengerId

# Create a pie chart presenting the male/female as proportions
gender_proportions <- data %>%
  count(Sex)

pie_chart <- ggplot(gender_proportions, aes(x = "", y = n, fill = Sex)) +
  geom_bar(stat = "identity") +
  coord_polar(theta = "y") +
  labs(title = "Sex Proportions") +
  theme_void()

print(pie_chart)

# Create a scatterplot with the Fare paid and the Age, differ the plot color by gender
scatter_plot <- ggplot(data, aes(x = Fare, y = Age, color = Sex)) +
  geom_point() +
  labs(title = "Scatterplot of Fare vs. Age by Gender", x = "Fare", y = "Age") +
  scale_color_manual(values = c("blue", "red")) +
  theme_minimal()

print(scatter_plot)

# How many people survived?
survived_count <- data %>%
  count(Survived) %>%
  filter(Survived == "Yes")

print(survived_count)

# Create a histogram with the Fare paid
fare_histogram <- ggplot(data, aes(x = Fare)) +
  geom_histogram(binwidth = 10, fill = "blue", color = "white") +
  labs(title = "Fare Distribution", x = "Fare", y = "Count") +
  theme_minimal()

print(fare_histogram)

# Additional bonus analysis

# What is the distribution of passenger classes (Pclass) in the dataset?
passenger_class_dist <- data %>%
  count(Pclass)

bar_chart_passenger_class <- ggplot(passenger_class_dist, aes(x = Pclass, y = n, fill = Pclass)) +
  geom_bar(stat = "identity") +
  labs(title = "Distribution of Passenger Classes", x = "Passenger Class", y = "Number of Passengers") +
  theme_minimal()

print(bar_chart_passenger_class)

# What is the average age of passengers?
average_age <- mean(data$Age, na.rm = TRUE)

print(average_age)

# How many passengers embarked from each of the three ports (Embarked)?
embarkation_port <- data %>%
  count(Embarked)

bar_chart_embarkation_port <- ggplot(embarkation_port, aes(x = Embarked, y = n, fill = Embarked)) +
  geom_bar(stat = "identity") +
  labs(title = "Passengers Embarked by Port", x = "Embarkation Port", y = "Number of Passengers") +
  theme_minimal()

print(bar_chart_embarkation_port)

# Calculate and display the correlation coefficient between age (Age) and fare paid (Fare)
correlation_coefficient <- cor(data$Age, data$Fare, use = "complete.obs")

print(correlation_coefficient)

# Create a box plot to visualize the distribution of fares paid by each passenger class (Pclass)
box_plot_fare_by_class <- ggplot(data, aes(x = Pclass, y = Fare, fill = Pclass)) +
  geom_boxplot() +
  labs(title = "Distribution of Fares by Passenger Class", x = "Passenger Class", y = "Fare") +
  theme_minimal()

print(box_plot_fare_by_class)
