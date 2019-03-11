library(zoo) 
library(neonUtilities)
foldername <- "/usr3/graduate/rkq/NEON_data/"
#tree data
zipsByProduct(dpID="DP1.10098.001", site="DSNY", package="expanded", check.size = T)
zipsByProduct(dpID="DP1.10098.001", site="HARV", package="expanded", check.size = T)
zipsByProduct(dpID="DP1.10098.001", site="OSBS", package="expanded", check.size = T)
zipsByProduct(dpID="DP1.10098.001", site="CPER", package="expanded", check.size = T)
zipsByProduct(dpID="DP1.10098.001", site="STER", package="expanded", check.size = T)
stackByTable("filesToStack10098", folder = T)

# merging the tree files

x = read.csv("filesToStack10098/stackedFiles/vst_mappingandtagging.csv")
dim(x)
head(x)
unique(x$siteID)

y = read.csv("filesToStack10098/stackedFiles/vst_apparentindividual.csv")
dim(y)
head(y)
unique(y$siteID)

x.to.merge <- x[,!colnames(x) %in% colnames(y)] # reduce x to columns that AREN'T in y (Take out everything thats in y)
dim(x.to.merge)
x.to.merge$individualID <- x$individualID # add back in the identifier of x (since y has indiv id, we need to add it back into x because it was taken one line up)
z <- merge(x.to.merge, y, all = TRUE) # merge everything and keep all columns (all unique data from x, merged into y)
dim(z)

write.csv(z, "NEON_tree_merged.csv") # save data "z" as a csv file 

#for the assignment, push it github and plot it  (JUST 2013-2014, but check how much is there for 2016-2017)

z$newdate <- as.Date(as.yearmon(z$date))
just_calibration <- z[which(z$newdate < "2015-01-01"),]
write.csv(just_calibration, "NEON_tree_merged_dates.csv")

head(just_calibration)
plot(just_calibration$stemDiameter, just_calibration$stemDistance) #plot is good, although not what i expected 
plot(just_calibration$siteID, just_calibration$newdate)

just_calibration$siteID
#tons of columns with NA's, but it is not due to the merge. 
