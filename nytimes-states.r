library(dbplyr)
library(tidyverse)
library(urbnmapr)
library(viridisLite) 

# load dataset from New York Times
nyt_data <- read.table("https://github.com/nytimes/covid-19-data/blob/master/us-states.csv?raw=true", 
                       header=TRUE, sep=",", quote = "\"")

# load population data from the Census Bureau
census_data <- read.table("http://www2.census.gov/programs-surveys/popest/datasets/2010-2019/national/totals/nst-est2019-alldata.csv?#",
                         header=TRUE, sep=",", quote = "\"")

# join NT Times data with census data to get populatio
population_data <- left_join(nyt_data, census_data, by = c("state" = "NAME"))

# join NY Times data with counties dataset to get the geo information
covid_data <- left_join(population_data, states, by = c("state" = "state_name"))

# make the chloropleth
covid_data %>% 
  filter(date =="2020-07-19") %>%
  ggplot(mapping = aes(long, lat, group = group, fill = ( cases / POPESTIMATE2019 ) * 100000)) +
  geom_polygon(color = "grey50", size = .25) +
  scale_fill_gradientn(labels = waiver(),
                       limits = c(1,5000),
                       colors = viridis(5),
                       guide = guide_colorbar(title.position = "top")) +
  coord_map(projection = "albers", lat0 = 30, lat1 = 45) +
  labs(fill = "Cases per 100,000 residents") +
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
