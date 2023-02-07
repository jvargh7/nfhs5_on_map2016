library(sp)
library(rgdal)
library(tmap)
library(tidyverse)
path_shape_files <- "C:/Cloud/OneDrive - Emory University/data/maps-master/Districts"
shape_df <-  readOGR(paste0(path_shape_files,"/Census_2011"),"2011_Dist")

(tm_shape(shape_df,ext=1.2) + 
    tm_borders()) %>% 
  tmap_save(.,paste0(path_shape_files,"/Census_2011/2011_Dist.png"),height=2300/300)


shape_df@data %>% 
  saveRDS(.,paste0(path_shape_files,"/Census_2011/2011_Dist_data.RDS"))
shape_df@data %>% 
  write.csv(.,paste0(path_shape_files,"/Census_2011/2011_Dist_data.csv"),row.names = FALSE)
