# Exercise 4: practicing with dplyr

# Install the `nycflights13` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
library("dplyr")
library("nycflights13")

# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
dim(flights)

# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
temp <- mutate(flights, delay = arr_delay - dep_delay)

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
temp <- arrange(temp, -delay)

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
temp <- mutate(flights, delay = dep_delay + arr_delay) %>% arrange(-delay)

# Make a histogram of the amount of time gained using the `hist()` function
hist(temp$delay)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
avg <- mean(temp$delay, na.rm = TRUE)

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created

sea <- filter(temp, dest == "SEA") %>% select(origin, dest, delay)
# On average, did flights to SeaTac gain or loose time?
avg_sea <- mean(sea$delay, na.rm = TRUE)

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
jfk_to_sea_air_time <- filter(flights, origin == "JFK", dest == "SEA") %>%
  summarise(mean = mean(air_time, na.rm = TRUE), 
            max = max(air_time, na.rm = TRUE),
            min = min(air_time, na.rm = TRUE))

            