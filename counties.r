library(dbplyr)
library(tidyverse)
library(urbnmapr)

dph_data <- read.table("~/src/covid-19-georgia/countycases.csv", header=TRUE, sep=",")

covid_data <- left_join(dph_data, counties, by = "county_name") 

covid_data %>% 
  ggplot(mapping = aes(long, lat, group = group, fill = case_rate)) +
  geom_polygon(color = "#ffffff", size = .25) +
  scale_fill_gradientn(labels = scales::percent,
                       guide = guide_colorbar(title.position = "top"), colors = heat.colors) +
  coord_map(projection = "albers", lat0 = 30, lat1 = 45) +
  theme(legend.title = element_text(),
        legend.key.width = unit(.5, "in")) +
  labs(fill = "Positive Tests Per Capita") +
  theme(legend.position="bottom",
        axis.line=element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        axis.title=element_blank(),
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid=element_blank())
