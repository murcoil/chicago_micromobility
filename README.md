# chicago_micromobility
A very simple tool for looking at GBFS feeds in Chicago. 

Running the script 'chicago_micromobility_gbfs.r' in R will leave you with an object, div_full, that lists all the station statuses, including e-bike counts, across the Divvy system, as well as locations of free-floating e-Divvys. (Right now, it assumes that any free-floating bikes it sees are electric but that may not always be the case.)

The last few lines have commands to make a map like the one below and save a time-stamped csv from this data. 

![Free Divvy E-bikes](/images/free-edivvy.png)

This is just snapshot of a moment in time. Run the script a few times or schedule it to build a time-series. 

