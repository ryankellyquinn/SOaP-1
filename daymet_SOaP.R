
## call relevant packages
library(daymetr)

## I saw the code from Exercise_06 and expanded it to grab the data from all of our sites...
#LIST OF sites
locs <- data.frame(site = c('HARV', 'DSNY', 'OSBS', 'STER', 'CPER'),
                   lat = c(42.5369, 28.12504, 29.68927, 40.4619, 40.81553),
                   lon = c(-72.17266, -81.4362, -81.99343, -103.0293, -104.7456 ))


#WRITE DATA TO CSV FILE
write.table(locs, paste0(tempdir(),"/locations.csv"),
            sep=",",
            col.names = TRUE,
            row.names = FALSE,
            quote = FALSE)

daymet_data <- download_daymet_batch(file_location = paste0(tempdir(),
                                                            "/locations.csv"),
                                     start=2010,
                                     end=2018,
                                     internal=TRUE,
                                     silent=TRUE)
#HARV can call each site 1-5
HARV <- as.matrix(daymet_data[[1]]$data)
harv_wx <- as.data.frame(HARV)

days.harv<-format(strptime(harv_wx$yday, format="%j"), format="%m-%d")
dayyear <- paste(days.harv, harv_wx$year, sep="-")
harv_wx$dayyear <-dayyear
HARVdta <- as.Date(as.character(dayyear), format="%m-%d-%Y")


#DSNY
DSNY <- as.matrix(daymet_data[[2]]$data)
dsny_wx <- as.data.frame(DSNY)

days.dsny <- format(strptime(dsny_wx$yday, format="%j"), format="%m-%d")
dayyear <- paste(days.dsny, harv_wx$year, sep="-")
dsny_wx$dayyear <-dayyear
DSNYdta <- as.Date(as.character(dayyear), format="%m-%d-%Y")

#OSBS
OSBS <- as.matrix(daymet_data[[3]]$data)
osbs_wx <- as.data.frame(OSBS)

days.osbs <- format(strptime(osbs_wx$yday, format="%j"), format="%m-%d")
dayyear <- paste(days.osbs, osbs_wx$year, sep="-")
osbs_wx$dayyear <-dayyear
OSBSdta <- as.Date(as.character(dayyear), format="%m-%d-%Y")

#STER
STER <- as.matrix(daymet_data[[4]]$data)
ster_wx <- as.data.frame(STER)

days.ster <- format(strptime(ster_wx$yday, format="%j"), format="%m-%d")
dayyear <- paste(days.ster, ster_wx$year, sep="-")
ster_wx$dayyear <-dayyear
STERdta <- as.Date(as.character(dayyear), format="%m-%d-%Y")

#CPER
CPER <- as.matrix(daymet_data[[5]]$data)
cper_wx <- as.data.frame(CPER)

days.cper <- format(strptime(cper_wx$yday, format="%j"), format="%m-%d")
dayyear <- paste(days.ster, cper_wx$year, sep="-")
cper_wx$dayyear <-dayyear
CPERdta <- as.Date(as.character(dayyear), format="%m-%d-%Y")

plot(HARVdta, harv_wx$tmin..deg.c., type='l', ylim=c(-30,25))
points(DSNYdta, dsny_wx$tmin..deg.c., type='l', col=rgb(red=1,green=0,blue=0, alpha=0.5))
points(OSBSdta, osbs_wx$tmin..deg.c., type='l', col=rgb(red=1,green=1,blue=0, alpha=0.3))
points(STERdta, ster_wx$tmin..deg.c., type='l', col=rgb(red=0,green=1,blue=1, alpha=0.5))
points(CPERdta, cper_wx$tmin..deg.c., type='l', col=rgb(red=0,green=0,blue=1, alpha=0.5))

