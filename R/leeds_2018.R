source("R/functions.R")
library(tmap)
tmap_mode("view")

# Get OSM Data
osm_leeds = download_osm("Leeds, UK")
saveRDS(osm_leeds, "data/osm_leeds_raw.Rds")

# Get Traffic Counts
traffic_leeds_2018 = prepare_traffic_data("data/dft_aadf_local_authority_id_63.csv", year = 2018)
saveRDS(traffic_leeds_2018, "data/traffic_leeds_2018.Rds")

# Make a boundary around the traffic data
boundary = make_boundary(traffic_leeds_2018)
saveRDS(boundary, "data/leeds_boundary.Rds")

qtm(boundary, fill = NULL) +
qtm(traffic_leeds_2018, dots.col = "traffic_flow")
