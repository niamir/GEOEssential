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
m <- c(10,1,11,1,12,1,20,1,30,1,40,1,190,1,
       50,NA,60,NA,61,NA,62,NA,70,NA,71,NA,72,NA,
       80,NA,81,NA,82,NA,90,NA,100,NA,110,NA,
       120,NA,121,NA,122,NA,130,NA,140,NA,
       150,NA,151,NA,152,NA,153,NA,160,NA,
       170,NA,180,NA,190,NA,200,NA,201,NA,
       202,NA,210,NA,220,NA)
rclmat <- matrix(m, ncol=2, byrow=TRUE)
esa <- reclassify(esa, rclmat,na.rm=T)

# Calculate number of Antropogenic cells withing 100 x 100 grides
f<-10
esa<-aggregate(esa,fact=f,fun=sum,na.rm=T)

# Calculate the change between 1992 and 2015
esa<-esa[[2]]-esa[[1]]
esa<-esa/(f*f)
                
# Plot                
col=colorRampPalette(c("blue","white", "red"))(20) 
plot(esa,col=col)
