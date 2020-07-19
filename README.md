# covid-19-georgia
Code to visualize covid-19 cases in the US state of Georgia

The State of Georgia doesn't provide a FIPS code and just has the county name in a field called "county_resident". The counties data set expects the county_name column to be "Something County". So I'm adding a new column to the DPH data called county_name with "Something County" in it, then joining to the counties data set on that new column.

If I was going to try this with a different data set (like say https://github.com/nytimes/covid-19-data) I would just join on the FIPS code.