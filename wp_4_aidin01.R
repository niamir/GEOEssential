# GEOEssential
# SDG Workflow for WP5 Biodiversity and Ecosystem Services

# 15.3.1 Proportion of land that is degraded over total land area

# http://maps.elie.ucl.ac.be/CCI/viewer/index.php

# install.packages("raster","R.utils")
library(raster)
library(R.utils)

# Unzip raster files
gunzip(paste0(getwd(),"esa_lc_1992_agg10.tif.gz",overwrite=T))
gunzip(paste0(getwd(),"esa_lc_2015_agg10.tif.gz",overwrite=T))

# Load raster files
esa1992<-raster(paste0(getwd(),"esa_lc_1992_agg10.tif.gz"))
esa2015<-raster(paste0(getwd(),"esa_lc_2015_agg10.tif.gz"))
esa<-stack(esa1992,esa2015)

# Reclass to Anthropogenic Classes (i.e. Cultivated and Urban Areas)
# See http://maps.elie.ucl.ac.be/CCI/viewer/download/CCI-LC_Maps_Legend.pdf
m <- c(10,1,11,1,12,1,20,1,30,1,40,1,190,1)
rclmat <- matrix(m, ncol=2, byrow=TRUE)
esa <- reclassify(esa, rclmat,na.rm=T)
esa[] <- ifelse(esa[]==1,1,NA)

# Calculate number of Antropogenic cells withing 100 x 100 grides
esa<-aggregate(esa,fact=10,fun=sum,na.rm=T)

# Calculate the change between 1992 and 2015
esa<-esa[[2]]-esa[[1]]
esa<-esa/100
                
# Plot                
plot(esa)
