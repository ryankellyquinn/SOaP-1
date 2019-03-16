library("ggplot2")
library("scales")
soil_phys_merge <- readRDS("NEON_soil_phys_merge.rds")

for (i in 1:length(sites)){
  soil_phys_site <- soil_phys_merge[which(soil_phys_merge$siteID==sites[i]),]
  chm.time <-as.Date(soil_phys_site$collectDate, format = "%Y-%m-%d")
  p <- ggplot(soil_phys_site, aes(x = chm.time, y = soil_phys_site$soilMoisture)) + 
    geom_point(aes(colour = soil_phys_site$plotID, fill = soil_phys_site$plotID)) + 
    scale_x_date("", labels = date_format("%b %Y"))
  print(p + ggtitle(paste0(sites[i], "Soil Moisture")))
}

for (i in 1:length(sites)){
  soil_phys_site <- soil_phys_merge[which(soil_phys_merge$siteID==sites[i]),]
  chm.time <-as.Date(soil_phys_site$collectDate, format = "%Y-%m-%d")
  p <- ggplot(soil_phys_site, aes(x = chm.time, y = soil_phys_site$soilTemp)) + 
    geom_point(aes(colour = soil_phys_site$plotID, fill = soil_phys_site$plotID)) + 
    scale_x_date("", labels = date_format("%b %Y"))
  print(p + ggtitle(paste0(sites[i], "   Soil Temperature"))) 
}

for (i in 1:length(sites)){
  soil_phys_site <- soil_phys_merge[which(soil_phys_merge$siteID==sites[i]),]
  chm.time <-as.Date(soil_phys_site$collectDate, format = "%Y-%m-%d")
  p <- ggplot(soil_phys_site, aes(x = chm.time, y = soil_phys_site$standingWaterDepth)) + 
    geom_point(aes(colour = soil_phys_site$plotID, fill = soil_phys_site$plotID)) + 
    scale_x_date("", labels = date_format("%b %Y"))
  print(p + ggtitle(paste0(sites[i], "   Standing Water Depth ")))
}

for (i in 1:length(sites)){
  soil_phys_site <- soil_phys_merge[which(soil_phys_merge$siteID==sites[i]),]
  chm.time <-as.Date(soil_phys_site$collectDate, format = "%Y-%m-%d")
  p <- ggplot(soil_phys_site, aes(x = chm.time, y = soil_phys_site$litterDepth)) + 
    geom_point(aes(colour = soil_phys_site$plotID, fill = soil_phys_site$plotID)) + 
    scale_x_date("", labels = date_format("%b %Y"))
  print(p + ggtitle(paste0(sites[i], "   litter depth")))
}



