library(raster)

esa1992<-raster("/home/aidin/SGN/UoA_Extraction/esa_lc_1992_agg10.tif")
esa2015<-raster("/home/aidin/SGN/UoA_Extraction/esa_lc_2015_agg10.tif")

esa<-stack(esa1992,esa2015)

m <- c(10,1,11,1,12,1,20,1,30,1,40,1,190,1)
rclmat <- matrix(m, ncol=2, byrow=TRUE)

esa <- reclassify(esa, rclmat,na.rm=T)
esa[] <- ifelse(esa[]==1,1,NA)

esa<-aggregate(esa,fact=10,fun=sum,na.rm=T)

esa<-esa[[2]]-esa[[1]]
esa<-esa/100
plot(esa)
