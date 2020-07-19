#!/bin/sh

curl --output ga_covid_data.zip https://ga-covid19.ondemand.sas.com/docs/ga_covid_data.zip

unzip -o ga_covid_data.zip

R --save < counties.r
