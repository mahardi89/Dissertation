dir.create("tmp")
unzip("Raw_data/Lower_Layer_Super_Output_Areas_(Dec_2011)_Boundaries_Full_Clipped_(BFC)_EW_V3.zip",
      exdir = "tmp")
LSOA= sf::st_read("tmp/Lower_Layer_Super_Output_Areas_(Dec_2011)_Boundaries_Full_Clipped_(BFC)_EW_V3.shp")
LSOA = LSOA[,c("LSOA11CD","geometry")]
LSOA = LSOA[substr(LSOA$LSOA11CD,1,1) == "E",]
saveRDS(LSOA,"data/LSOA_England.Rds")
unlink("tmp",recursive = TRUE)
