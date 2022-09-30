# Project Title: Urban Area Biomes
# Description: Script to download and clean census data
# Author: Troy Weber
# Date: Sept. 28, 2022

# Libraries-----------------------------------------------

library(tidyverse)
library(tidycensus)

# Set work drive------------------------------------------

setwd("U:/My Files/Grad School/Analyses/01_Urban Area Biomes/R Studio")

# Load census data----------------------------------------

# Insert API census key into quotes
census_api_key("9793e27d8c3fc1ac1616c418e400187433e2f909", install = TRUE, overwrite = TRUE)

# Get variables ready
geom = "urban area"
year = 2020
var = c("B01003_001")

# Use tidycensus to get data
census_data = get_acs(geography = geom, variables = var, year = year) # extracts all US urban area/cluster total populations from 2020
fil_census = census_data %>% filter(estimate >= 403500) # filters to top 100 urban areas by population size


# plot data so it makes sense
fil_census$NAME = gsub("Urbanized Area", "", as.character(fil_census$NAME))
fil_census$NAME = gsub(r"{\s*\([^\)]+\)}","",as.character(fil_census$NAME))
fil_census %>%
  ggplot(aes(estimate, reorder(NAME, estimate))) +
  geom_point() +
  labs(title = "Top 100 Urban Areas by Population") +
  xlab("Population") +
  ylab("Urban Area")
     
