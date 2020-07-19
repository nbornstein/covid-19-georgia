#!/bin/sh

# get today's data zip file
curl --output ga_covid_data.zip https://ga-covid19.ondemand.sas.com/docs/ga_covid_data.zip

# extract it
unzip -o ga_covid_data.zip

# create the chloropleth
R --save < counties.r
