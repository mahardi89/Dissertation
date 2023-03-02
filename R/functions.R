### Return an OSM Overpass query as an osmdata object in sf format
download_osm = function(place){
  
  if(!curl::has_internet()){
    assign("has_internet_via_proxy", TRUE, environment(curl::has_internet))
  }
  
  q = osmdata::opq(osmdata::getbb(place))
  q = osmdata::add_osm_feature(q, key = "highway")
  osm_raw = osmdata::osmdata_sf(q = q)
  return(osm_raw)
}


prepare_traffic_data = function(path, year){
  traffic <- read.csv(file=path, header=TRUE)
  
  # Change the lon and lat to the 4326 crs
  traffic <- sf::st_as_sf(traffic,coords = c("longitude","latitude"),crs = 4326) 
  
  # Filter the count points in year
  traffic <- traffic[traffic$year == year, ] 
  traffic <- traffic[ , c("road_name","road_type","all_motor_vehicles")] 
  
  names(traffic)<-c("road_name","road_type","traffic_flow","geometry")
  traffic <- sf::st_transform(traffic,27700)
  
  return(traffic)
}

make_boundary = function(x){
  # Make Polygon Around Traffic Data
  bound_buf <- sf::st_convex_hull(sf::st_union(x)) 
  
  # Buffer Polygon by 1km
  bound_buf <- sf::st_buffer(bound_buf, 1000) 
  
  return(bound_buf)
}
