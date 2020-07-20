library(dbplyr)
library(tidyverse)
library(urbnmapr)
library(wesanderson) 

# load dataset from New York Times
nyt_data <- read.table("https://github.com/nytimes/covid-19-data/blob/master/us-counties.csv?raw=true", 
                       header=TRUE, sep=",", quote = "\"")

# append " County" to county name to match counties dataset
nyt_data$county_name <- with(nyt_data, paste(county, sep = " ", "County"))

state_data <- nyt_data %>% filter(state == "Georgia")
state_counties <- counties %>% filter(state_name == "Georgia")

# join NY Times data with counties dataset to get the geo information
covid_data <- left_join(state_data, state_counties, by = "county_name")

# make the chloropleth
covid_data %>% 
  filter(date =="2020-07-19") %>%
  ggplot(mapping = aes(long, lat, group = group, fill = cases)) +
  geom_polygon(color = "#ffffff", size = .25) +
  scale_fill_gradientn(labels = waiver(),
                       colors = wes_palette("Zissou1", 10, type = "continuous"),
                       guide = guide_colorbar(title.position = "top")) +
  coord_map(projection = "albers", lat0 = 30, lat1 = 45) +
  labs(fill = "Cases") +
  theme(legend.title = element_text(),
        legend.key.width = unit(.5, "in"),
        legend.position="bottom",
        axis.line=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        axis.title=element_blank(),
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid=element_blank())
