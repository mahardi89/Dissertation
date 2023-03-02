### Return an OSM Overpass query as an osmdata object in sf format
download_osm = function(place){
  q = osmdata::opq(osmdata::getbb(place))
  q = osmdata::add_osm_feature(q, key = "highway")
  osm_raw = osmdata::osmdata_sf(q = q)
  return(osm_raw)
}