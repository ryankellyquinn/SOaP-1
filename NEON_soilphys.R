# script to download soil physical data, distributed periodic, dp.10086.001, from NEON
#PLEASE READ: something isn't correct here. all sites download, not just the sites specified (whether using loop or individually by site)

# load packages and set file paths
library(zoo)
library(neonUtilities)
foldername <- "/usr3/graduate/rkq/NEON_data/"

# list of our 5 sites
sites <- c("DSNY", "HARV", "OSBS", "CPER", "STER")

# loop through 5 sites to download data from each
for (s in 1:length(sites)){
  zipsByProduct(dpID="DP1.10086.001", site=s, package="expanded", check.size = T)
}

# combine them all into fewer files
stackByTable("filesToStack10086", folder = T)

# read in soil pH data
a <- read.csv("filesToStack10086/stackedFiles/sls_soilpH.csv")
dim(a) #row and column number
unique(a$siteID) 

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
d <- merge(a.to.merge, b, all = TRUE) # merge everything and keep all columns (all unique data from x, merged into y)
dim(d)

write.csv(z, "NEON_tree_merged.csv") # save data "z" as a csv file 

