## Script to look at the Divvy bikeshare GBFS feed
## JSON endpoint https://gbfs.divvybikes.com/gbfs/gbfs.json
## based on gbfs tools at https://github.com/simonpcouch/gbfs

library(gbfs)
library(tidyverse)

divfeed <- "https://gbfs.divvybikes.com/gbfs/gbfs.json"


div_station_info <- get_station_information(divfeed)
div_station_status <- get_station_status(divfeed)

# full join these two datasets on station_id and select a few columns
div_stations <- full_join(div_station_info,
                          div_station_status,
                          by = "station_id") %>%
        # just select columns we're interested in visualizing
        select(id = station_id,
               lon,
               lat,
               num_bikes_available,
               num_ebikes_available,
               num_docks_available) %>%
        mutate(type = "docked")

# grab data on free bike status and save it as a dataframe
div_free_bikes <- get_free_bike_status(divfeed, output = "return") %>%
        # just select columns we're interested in visualizing
        select(id = bike_id, lon, lat, type) %>%
        # make columns analogous to station_status for row binding
        # this assumes that all free floating bikes are e-bikes but that's not necessarily the case
        mutate(num_bikes_available = 1,
               num_ebikes_available = 1,
               num_docks_available = NA)

# row bind stationed and free bike info
div_full <- bind_rows(div_stations, div_free_bikes)

# filter out stations with 0 available e-bikes
div_plot <- div_full %>%
        filter(num_ebikes_available > 0) %>%
        # plot the geospatial distribution of bike counts
        ggplot() +
        aes(x = lon,
            y = lat,
            size = num_ebikes_available,
            col = type) +
        geom_point() +
        # make aesthetics slightly more cozy
        theme_minimal() +
        scale_color_brewer(type = "qual")

# uncomment the next line to produce the plot
# div_plot

# uncomment the next line to save a timestamped csv in the working directory
# write.csv(div_full,paste0("divvystatus",format(Sys.time(), "_%Y%m%d_%H%M%S"),".csv"), row.names = FALSE)
