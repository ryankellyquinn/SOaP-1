# script to download soil chemical data, distributed periodic, dp.10008.001, from NEON
#IMPORTANT: From what I'm seeing, this dataset doesn't even start until 2015?? Someone please confirm. 
# load packages and set file paths
library(neonUtilities)
library(zoo)
foldername <- "/usr3/graduate/rkq/NEON_data/"

# list of our 5 sites
zipsByProduct(dpID="DP1.10008.001", site="DSNY", package="expanded", check.size = T)
zipsByProduct(dpID="DP1.10008.001", site="HARV", package="expanded", check.size = T)
zipsByProduct(dpID="DP1.10008.001", site="OSBS", package="expanded", check.size = T)
zipsByProduct(dpID="DP1.10008.001", site="CPER", package="expanded", check.size = T)
zipsByProduct(dpID="DP1.10008.001", site="STER", package="expanded", check.size = T)

#this loop isn't working 100%
#sites <- c("DSNY", "HARV", "OSBS", "CPER", "STER")

# loop through 5 sites to download data from each
#for (s in 1:length(sites)){
#  zipsByProduct(dpID="DP1.10008.001", site=s, package="expanded", check.size = T)
#}

# combine them all into fewer files
stackByTable("filesToStack10008", folder = T)

# read in soil biogeochm data
biogeochm <- read.csv("filesToStack10008/stackedFiles/spc_biogeochem.csv")
dim(biogeochm) #rows and column in b 
unique(biogeochm$siteID)
head(biogeochm)
#isolate dates wer're interested in 
biogeochm$newdate <- as.Date(as.yearmon(biogeochm$collectDate))
just_calibration <- biogeochm[which(biogeochm$newdate < "2015-01-01"),]
dim(just_calibration)



write.csv(just_calibration, "NEON_soilchm_merged_dates.csv")