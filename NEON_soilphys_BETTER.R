# script to download soil physical data, distributed periodic, dp.10086.001, from NEON

# load packages and set file paths
library(zoo)
library(neonUtilities)
foldername <- "/usr3/graduate/rkq/NEON_data/"

# list of our 5 sites
#sites <- c("DSNY", "HARV", "OSBS", "CPER", "STER")

# loop through 5 sites to download data from each
#for (s in 1:length(sites)){
zipsByProduct(dpID="DP1.10086.001", site=s, package="expanded", check.size = T)
#}
zipsByProduct(dpID="DP1.10086.001", site="DSNY", package="expanded", check.size = T)
zipsByProduct(dpID="DP1.10086.001", site="HARV", package="expanded", check.size = T)
zipsByProduct(dpID="DP1.10086.001", site="OSBS", package="expanded", check.size = T)
zipsByProduct(dpID="DP1.10086.001", site="CPER", package="expanded", check.size = T)
zipsByProduct(dpID="DP1.10086.001", site="STER", package="expanded", check.size = T)

# combine them all into fewer files
stackByTable("filesToStack10086", folder = T)

# read in soil pH data
a <- read.csv("filesToStack10086/stackedFiles/sls_soilpH.csv")
dim(a) #row and column number
unique(x$siteID) 

# read in soil moisture data
b <- read.csv("filesToStack10086/stackedFiles/sls_soilMoisture.csv")
dim(b)
head(b)
unique(b$siteID)

# read in soil core data 
c <- read.csv("filesToStack10086/stackedFiles/sls_soilCoreCollection.csv")
dim(c)
head(c)
unique(c$siteID)

# subset moisture and pH

a.to.merge <- a[,!colnames(a) %in% colnames(b)] # reduce a to columns that AREN'T in b (Take out everything thats in y)
dim(a.to.merge)
a.to.merge$individualID <- a$individualID # add back in the identifier of x (since y has indiv id, we need to add it back into x because it was taken one line up)
b.merge <- merge(a.to.merge, b, all = TRUE) # merge everything and keep all columns (all unique data from x, merged into y)
dim(b.merge)
c.to.merge <- b.merge[,!colnames(b.merge) %in% colnames(c)] # reduce a to columns that AREN'T in b (Take out everything thats in y)
dim(c.to.merge)

write.csv(c.to.merge, "NEON_soilphys_merged.csv") # save data as a csv file 

#for the assignment, push it github and plot it  (JUST 2013-2014, but check how much is there for 2016-2017)

c.to.merge$newdate <- as.Date(as.yearmon(c.tom.merge$date))
just_calibration <- c.to.merge[which(c.to.merge$newdate < "2015-01-01"),]
write.csv(just_calibration, "NEON_soilphys_merged_dates.csv")

just_calibration$siteID #also think 



# merge moisture and pH into soil core

# save csv file
