# script to download soil chemical data, distributed periodic, dp.10078.001, from NEON. Also merges files downloaded from neonUtilities function, isolates dates we need, and writes into a csv.

# load packages and set file paths
library(neonUtilities)
library(zoo)
foldername <- "/usr3/graduate/rkq/NEON_data/"

# list of our 5 sites
sites <- c("DSNY", "HARV", "OSBS", "CPER", "STER")

# loop through 5 sites to download data from each
for (s in 1:length(sites)){
  zipsByProduct(dpID="DP1.10078.001", site=s, package="expanded", check.size = T)
}

# combine them all into fewer files
stackByTable("filesToStack10078", folder = T)

# read in soil chemical data
l <- read.csv("filesToStack10078/stackedFiles/sls_soilChemistry.csv")
dim(l) #rows and column in b 
unique(l$siteID)

#isolate dates wer're interested in 
l$newdate <- as.Date(as.yearmon(l$dataQF))
just_calibration <- l[which(l$newdate < "2015-01-01"),]
write.csv(just_calibration, "NEON_soilchm_merged_dates.csv")

head(just_calibration)
plot(l$nitrogenPercent, l$organicCPercent)
