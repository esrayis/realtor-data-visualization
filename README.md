# realtor-data-visualization
This repository contains a comprehensive analysis of the USA Real Estate market, providing valuable insights through data analysis and visualization. The project focuses on understanding market trends using regression techniques and creating informative visualizations.

## Installation

To run this analysis, you will need to install the following R packages:

```R
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("mice")

## Additionally, ensure you have loaded the necessary libraries:

library(ggplot2)
library(tidyverse)
library(dplyr)

Data Preparation
The project starts by loading the real estate data from "realtor-data.csv" and performing data cleaning tasks, including handling missing values and removing duplicates.

Part 1: Exploratory Data Analysis
Column Types and Missing Values
Identify the types of columns in the dataset and find columns with missing values.

Boxplots by State
Create boxplots to visualize price distributions by state, filtering out categories with less than 50 observations.

Observations Count in Connecticut
Count the number of observations with prices greater than $500,000 in Connecticut.

Bedroom Size Histogram
Create a histogram to visualize the distribution of bedroom sizes, including finding the mode (most common bedroom size).

Bar Plot by State
Generate a bar plot to display the frequency of data points by state.

Part 2: Scatter Plots
Explore relationships between house size and price through scatter plots, including transformations for better visualization.

Part 3: Linear Regression
Perform linear regression analysis to predict price based on house size, including generating regression equation coefficients and visualizing the results.

Part 4: City and Zip Code Analysis
Investigate real estate trends at the city and zip code levels, including bar plots and boxplots.

Conclusion
This project provides a deep dive into USA Real Estate trends using data analysis and visualization techniques. Whether you're an investor, researcher, or enthusiast, you can gain valuable insights into this dynamic market.

Feel free to explore the code and visualizations to understand the nuances of the USA Real Estate market.

For questions or feedback, please open an issue or contact me.
