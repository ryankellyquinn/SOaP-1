library("ggplot2")
library("scales")

source("data_construction/NEON_covariates/NEON_soil_phys_iterate.R")
source("data_construction/NEON_covariates/NEON_soil_chem_iterate.R")
soil_phys_merge <- readRDS("data/NEON_soil_phys_merge.rds")
soil_chm_merge <- readRDS("data/NEON_soil_chm_merge.rds")

# first, visualize soil chemistry data 

# organic carbon
for (i in 1:length(sites)){
  soil_chm_site <- soil_chm_merge[which(soil_chm_merge$siteID==sites[i]),]
  chm.time <-as.Date(soil_chm_site$collectDate, format = "%Y-%m-%d")
  p <- ggplot(soil_chm_site, aes(x = chm.time, y = soil_chm_site$organicCPercent)) + 
    geom_point(aes(colour = soil_chm_site$plotID, fill = soil_chm_site$plotID)) + 
    scale_x_date("", labels = date_format("%b %Y"))
  print(p + ggtitle(paste0(sites[i], "   % Organic C")))
}

# percent nitrogen
for (i in 1:length(sites)){
  soil_chm_site <- soil_chm_merge[which(soil_chm_merge$siteID==sites[i]),]
  chm.time <-as.Date(soil_chm_site$collectDate, format = "%Y-%m-%d")
  p <- ggplot(soil_chm_site, aes(x = chm.time, y = soil_chm_site$nitrogenPercent)) + 
    geom_point(aes(colour = soil_chm_site$plotID, fill = soil_chm_site$plotID)) + 
    scale_x_date("", labels = date_format("%b %Y"))
  print(p + ggtitle(paste0(sites[i], "   % N")))
}

# C:N ratio
for (i in 1:length(sites)){
  soil_chm_site <- soil_chm_merge[which(soil_chm_merge$siteID==sites[i]),]
  chm.time <-as.Date(soil_chm_site$collectDate, format = "%Y-%m-%d")
  p <- ggplot(soil_chm_site, aes(x = chm.time, y = soil_chm_site$CNratio)) + 
    geom_point(aes(colour = soil_chm_site$plotID, fill = soil_chm_site$plotID)) + 
    scale_x_date("", labels = date_format("%b %Y"))
  print(p + ggtitle(paste0(sites[i], "   C:N Ratio")))
}


# now we'll look at physical measurements

# soil moisture
for (i in 1:length(sites)){
  soil_phys_site <- soil_phys_merge[which(soil_phys_merge$siteID==sites[i]),]
  chm.time <-as.Date(soil_phys_site$collectDate, format = "%Y-%m-%d")
  p <- ggplot(soil_phys_site, aes(x = chm.time, y = soil_phys_site$soilMoisture)) + 
    geom_point(aes(colour = soil_phys_site$plotID, fill = soil_phys_site$plotID)) + 
    scale_x_date("", labels = date_format("%b %Y"))
  print(p + ggtitle(paste0(sites[i], "Soil Moisture")))
}

# soil temperature
for (i in 1:length(sites)){
  soil_phys_site <- soil_phys_merge[which(soil_phys_merge$siteID==sites[i]),]
  chm.time <-as.Date(soil_phys_site$collectDate, format = "%Y-%m-%d")
  p <- ggplot(soil_phys_site, aes(x = chm.time, y = soil_phys_site$soilTemp)) + 
    geom_point(aes(colour = soil_phys_site$plotID, fill = soil_phys_site$plotID)) + 
    scale_x_date("", labels = date_format("%b %Y"))
  print(p + ggtitle(paste0(sites[i], "   Soil Temperature"))) 
}

# standing water depth
for (i in 1:length(sites)){
  soil_phys_site <- soil_phys_merge[which(soil_phys_merge$siteID==sites[i]),]
  chm.time <-as.Date(soil_phys_site$collectDate, format = "%Y-%m-%d")
  p <- ggplot(soil_phys_site, aes(x = chm.time, y = soil_phys_site$standingWaterDepth)) + 
    geom_point(aes(colour = soil_phys_site$plotID, fill = soil_phys_site$plotID)) + 
    scale_x_date("", labels = date_format("%b %Y"))
  print(p + ggtitle(paste0(sites[i], "   Standing Water Depth ")))
}

# litter depth
for (i in 1:length(sites)){
  soil_phys_site <- soil_phys_merge[which(soil_phys_merge$siteID==sites[i]),]
  chm.time <-as.Date(soil_phys_site$collectDate, format = "%Y-%m-%d")
  p <- ggplot(soil_phys_site, aes(x = chm.time, y = soil_phys_site$litterDepth)) + 
    geom_point(aes(colour = soil_phys_site$plotID, fill = soil_phys_site$plotID)) + 
    scale_x_date("", labels = date_format("%b %Y"))
  print(p + ggtitle(paste0(sites[i], "   litter depth")))
}
