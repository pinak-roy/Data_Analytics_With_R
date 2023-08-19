#Loading essential libraries for data analysis
pacman::p_load(tidyverse, here, janitor, skimr, lubridate)

# Loading .csv files with tidyverse. File names will be in terms of month name
 
JAN <- read_csv("202201-divvy-tripdata.csv")
FEB <- read_csv("202202-divvy-tripdata.csv")
MAR <- read_csv("202203-divvy-tripdata.csv")
APR <- read_csv("202204-divvy-tripdata.csv")
MAY <- read_csv("202205-divvy-tripdata.csv")
JNE <- read_csv("202206-divvy-tripdata.csv")
JLY <- read_csv("202207-divvy-tripdata.csv")
AGS <- read_csv("202208-divvy-tripdata.csv")
SEP <- read_csv("202209-divvy-publictripdata.csv")
OCT <- read_csv("202210-divvy-tripdata.csv")
NOV <- read_csv("202211-divvy-tripdata.csv")
DEC <- read_csv("202212-divvy-tripdata.csv")

#combining the data as four quarters to keep the data integrity  
q1 <- rbind(JAN,FEB,MAR)
q2 <- rbind(APR,MAY,JNE)
q3 <- rbind(JLY,AGS,SEP)
q4 <- rbind(OCT,NOV,DEC)

#combining all the quarters
all_data <- rbind(q1,q2,q3,q4)

# lEt's have asummary statistics
skim_without_charts(all_data)

# removing empty rows and columns by Janitor
all_data <- remove_empty(all_data, which=c("cols"))
all_data <-remove_empty(all_data, which=c("rows"))
# check the data types
str(all_data)

# we need to change the data types of the start date and end date to find the difference
all_data$started_at_1 <- ymd_hms(all_data$started_at)
all_data$ended_at_1 <- ymd_hms(all_data$ended_at)

# Let's find the trip duration in minutes by difftime function
all_data$trip_duration <- difftime(all_data$ended_at_1,all_data$started_at_1, units = c("mins"))

# Now we will extract the month name by lubridate
all_data$Month_name <- month(all_data$started_at_1, label = TRUE)
all_data$Weekday_name <- wday(all_data$started_at_1, label = TRUE)
 
# filtering the trip_duration to get acceptable values
all_data_filtered <- all_data %>% filter(trip_duration >0) %>% drop_na()

# it's time for basic plotting
ggplot(all_data_filtered,aes(member_casual,fill=member_casual))+
  geom_bar()+scale_fill_brewer(palette = "Set2")+labs(title= "Members X Casual riders distribution")

all_data_filtered %>% 
  ggplot(aes(Month_name, fill=member_casual))+
  geom_bar()+labs(x='Month',y='No of rides', title='Distribution by Month')

all_data_filtered %>% 
  ggplot(aes(x=Weekday_name, fill=member_casual))+geom_bar()+
  labs(x="Day", y="No of Rides")+ coord_flip()

all_data_filtered %>% 
  ggplot(aes(x=member_casual, fill=rideable_type))+geom_bar(position = "dodge")+
  labs(x="Bike", y="No of Rides")

