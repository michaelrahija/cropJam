# tabulate listing data
library(memisc)
library(dplyr)


#set wd
setwd("~/Dropbox/CROP/Jamaica/cropJam")
data.dir <- "~/Dropbox/CROP/Jamaica/data_listing"


#create data sets
source("R/createDataset.R")
master <- createDataset()


###I think interviews a153adf0d43e472794211be60d15cbcd and 940281e1c43d41cb84dd4dbf9b2b26dd
###have data entry errors b/c there are instances when parcelId != parcel_list

#clean data set
source("R/cleanDataset.R")
master <- cleanDataset(df = master)
