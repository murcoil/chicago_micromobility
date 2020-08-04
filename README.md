# chicago_micromobility
A very simple tool for looking at GBFS feeds in Chicago. 

Running the script in R will leave you with an object, div_full, that lists all the station statuses, including e-bike counts, across the Divvy system, as well as locations of free-floating e-Divvys. (Right now, it assumes that any free-floating bikes it sees are electric but that may not always be the case.)

The last few lines have commands to make a map and save a time-stamped csv. 

This is just snapshot of a moment in time. Run the script a few time or schedule it to build a time-series. 
