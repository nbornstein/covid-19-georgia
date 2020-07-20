library(dbplyr)
library(tidyverse)
library(urbnmapr)
library(viridisLite) 

# load dataset from State of Georgia (https://ga-covid19.ondemand.sas.com/docs/ga_covid_data.zip)
dph_data <- read.table("countycases.csv", header=TRUE, sep=",")

# append " County" to county name to match counties dataset
dph_data$county_name <- with(dph_data, paste(county_resident, sep = " ", "County"))

# join GA DPH data with counties dataset to get the geo information
covid_data <- left_join(dph_data, counties, by = "county_name")

# make the chloropleth
covid_data %>% 
  filter(state_name =="Georgia") %>% 
  ggplot(mapping = aes(long, lat, group = group, fill = case_rate)) +
  geom_polygon(color = "#ffffff", size = .25) +
  scale_fill_gradientn(labels = waiver(),
                       limits = c(1,10000),
                       colors = viridis(5),
                       guide = guide_colorbar(title.position = "top")) +
  coord_map(projection = "albers", lat0 = 30, lat1 = 45) +
  labs(fill = "Positive Tests per 100,000 Residents") +
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

# just for fun print today's number of cases
sum(dph_data$Positive)
