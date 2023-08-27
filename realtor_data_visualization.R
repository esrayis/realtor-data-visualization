install.packages("ggplot2")
install.packages("tidyverse")
install.packages("mice")
library(ggplot2)
library(tidyverse)
library(dplyr)


df <- read.csv("realtor-data.csv")
f <- head(df)
f
summary(df)
str(df)

df <- df %>%
  mutate(status = ifelse(is.na(status), mean(status, na.rm = TRUE), status))

df <- df %>%
  mutate(bed = ifelse(is.na(bed), mean(bed, na.rm = TRUE), bed))

df <- df %>%
  mutate(bath = ifelse(is.na(bath), mean(bath, na.rm = TRUE), bath))

df <- df %>%
  mutate(acre_lot = ifelse(is.na(acre_lot), mean(acre_lot, na.rm = TRUE), acre_lot))

df <- df %>%
  mutate(house_size = ifelse(is.na(house_size), mean(house_size, na.rm = TRUE), house_size))

df <- df %>%
  mutate(price = ifelse(is.na(price), mean(price, na.rm = TRUE), price))


df <- df %>%
  distinct()    # Remove duplicate rows

df <- select(df, -prev_sold_date)
write.csv(df, 'modified_dataset.csv', row.names = FALSE)

#PART 1

# Identify column types
categorical_columns <- sapply(df, function(x) ifelse(is.numeric(x), "Numeric", "Non-Numeric"))
print(categorical_columns)

# Find missing values
missing_values <- apply(df, 2, function(x) sum(is.na(x)))
columns_with_missing <- names(missing_values[missing_values > 0])
print(columns_with_missing)


# Create boxplot by state
## Filter out categories with less than 50 observations
filtered_df <- df %>%
  group_by(state) %>%
  filter(n() >= 50)

ggplot(filtered_df, aes(x = state, y = price)) +
  geom_boxplot() +
  coord_cartesian(ylim = c(0,1e+06))+
  labs(x = "State", y = "Price", title = "Price by City")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

### Count the number of observations greater than 500,000 in Connecticut
count_greater_than_500k <- df %>%
  filter(state == "Connecticut" & price > 500000) %>%
  summarize(count = sum(!is.na(price)))






# Create histogram by bed 
## Find the maximum bedroom count in the "Bed" column
max(df$bed, na.rm = TRUE)

ggplot(df, aes(x = bed)) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(x = "Bed Size", y = "Frequency", title = "Distribution of Bed Sizes")
  
###mode of bedroom size
Mode <- function(x) {
  uniqx <- unique(x)
  uniqx[which.max(tabulate(match(x, uniqx)))]
}
most_common_bedsize <- Mode(df$bed)
most_common_bedsize

# Create barplot by state 
ggplot(df, aes(x = state )) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(x = "States", y = "Frequency", title = "Bar Plot State")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))



#PART 2

##scatter plot for presentation-1
ggplot(df, aes(x = house_size , y = price, col = state)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() + #using scale to observe easily linear relationship
  labs(x = "house size", y = "price", title = "Scatter Plot house_size vs price")

##scatter plot for only Massachusetts, Virgin Islands,  New York. 
new_data <- df %>%
  filter(state %in% c("New York", "Massachusetts", "Virgin Islands"))
ggplot(new_data, aes(x = house_size , y = price, col = state)) +
  geom_point() +
  labs(x = "house size", y = "price", title = "Scatter Plot house_size vs price")



##scatter plot for only Massachusetts, Virgin Islands, New York
  #transformation of x and y axis
new_data <- df %>%
  filter(state %in% c("New York", "Massachusetts", "Virgin Islands"))

ggplot(new_data, aes(x = house_size , y = price, col = state)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  labs(x = "house size", y = "price", title = "Scatter Plot house_size vs price")

  
#PART 3 

##
filtered_df_new <- subset(df, state %in% c("New York", "Massachusetts", "Virgin Islands"))

# Create a new column 'house_size_ny_m' with the same values as 'house_size'
filtered_df_new$house_size_ny_m <- filtered_df_new$house_size

# Plot the scatter plot
p<-ggplot(filtered_df_new, aes(x = house_size_ny_m, y = price, col = state)) +
  geom_point() +
  scale_x_log10() +
  scale_y_log10() +
  geom_smooth(method = "lm", se = FALSE, color = "darkblue") +
  labs(x = "house size", y = "price", title = "Scatter Plot house size vs price")
plot(p)

summary(lm(price ~ house_size_ny_m, data = filtered_df_new))


# Perform linear regression
model <- lm((price) ~ (house_size_ny_m), data = filtered_df_new)

# Get regression equation coefficients
intercept <- coef(model)[1]
slope <- coef(model)[2]

# Display regression equation
equation <- paste("(price) =", round(intercept, 2), "+", round(slope, 2), "*(house_size)")
print(equation)

#median for house-size
p+geom_vline(xintercept = mean(df$house_size), col = "purple", size = 1 ) #median for house-size 
p+geom_hline(yintercept = median(filtered_df_new$price), col = "darkgreen")
mean(df$house_size)


#PART 4
# Create barplot by cities of Vermont 
state_2 <- "Vermont"
ggplot(df[df$state == state_2, ], aes(x = city )) +
  geom_bar(fill = "darkgreen", color = "black") +
  labs(x = "States", y = "Frequency", title = "Bar Plot State")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

# Create boxplot by city in Virgin Islands
state_1 <- "Virgin Islands"
ggplot(df[df$state == state_1, ] ,aes(x = city, y = price)) +
  geom_boxplot() +
  coord_cartesian(ylim = c(0,2e+06))+
  labs(x = "City", y = "Price", title = "Price by City")+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))

# Create histogram by zipcode 
max(df$zip_code, na.rm = TRUE)

ggplot(df, aes(x = zip_code )) +
  geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
  labs(x = "ZipCode", y = "Frequency", title = "Distribution of ZipCode")+
  coord_cartesian(xlim = c(0,10000))

###mode of zipcode
Mode <- function(x) {
  uniqx <- unique(x)
  uniqx[which.max(tabulate(match(x, uniqx)))]
}
most_common_zipcode <- Mode(df$zip_code)
most_common_zipcode

