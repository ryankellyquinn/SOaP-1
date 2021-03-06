# combine all calibration data for initial models

# pull in climate data
worldclim <- readRDS("data/site_climate_values.rds")
worldclim$siteID <- worldclim$Site
worldclim$Site <- NULL

# daymet data
daymet <- readRDS("data/daymet_monthly.rds")

# ITS:16S ratios
microbes <- readRDS("data/calibration_abundances.rds")

# soil phys 
soil_phys <- readRDS("data/NEON_soil_phys_merge.rds")

# soil chem 
soil_chem <- readRDS("data/NEON_soil_chm_merge.rds")

# CHM
CHM <- as.data.frame(readRDS("data/MeanCHM_FiveSites_AllAreas.rds"))
CHM$CHM <- CHM$`Mean CHM`
CHM$`Mean CHM` <- NULL
CHM$dateID <- NULL

# aggregate by month and site
soil_phys <- soil_phys %>% 
  group_by(siteID, dateID) %>% 
  summarise(pH = mean(soilInCaClpH),
            pH_sd = sd(soilInCaClpH),
            standingWaterDepth = mean(standingWaterDepth),
            standingWaterDepth_sd = sd(standingWaterDepth),
            soilTemp = mean(soilTemp),
            soilTemp_sd = sd(soilTemp),
            litterDepth = mean(litterDepth),
            litterDepth_sd = sd(litterDepth))

soil_chem <- soil_chem %>% 
  group_by(siteID, dateID) %>% 
  summarise(percentC = mean(organicCPercent),
            percentC_sd = sd(organicCPercent),
            CNratio = mean(CNratio),
            CNratio_sd = sd(CNratio))

df1 <- merge(soil_phys, soil_chem, all=T)
df2 <- merge(daymet, microbes) # since we don't have all=T, we will lose any dates not in the calibration abundances
df3 <- merge(df1, df2)
df4 <- merge(worldclim, CHM)
master.df <- merge(df3, df4, all=T)

master.df$log_BF_ratio <- log(master.df$ratio)

saveRDS(master.df, "data/calibration_model_data.rds")
