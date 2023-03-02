source("R/functions.R")
library(tmap)
tmap_mode("view")

#settings
location = "Leeds"
year = 2018

# Get OSM Data
osm = download_osm(paste0(location,", UK"))
saveRDS(osm, paste0("data/osm_",location,"_raw.Rds"))

# Get Traffic Counts
traffic_leeds_2018 = prepare_traffic_data("data/dft_aadf_local_authority_id_63.csv", year = year)
saveRDS(traffic_leeds_2018, "data/traffic_leeds_2018.Rds")

# Make a boundary around the traffic data
boundary = make_boundary(traffic_leeds_2018)
saveRDS(boundary, "data/leeds_boundary.Rds")

qtm(boundary, fill = NULL) +
qtm(traffic_leeds_2018, dots.col = "traffic_flow")
