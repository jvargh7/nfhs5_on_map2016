library(sp)
library(rgdal)
library(tmap)
path_shape_files <- "C:/Cloud/OneDrive - Emory University/data/dhs_program/IA/IAGE7AFL"
shape_df <-  readOGR(paste0(path_shape_files))

(tm_shape(shape_df,ext=1.2) + 
    tm_dots()) %>% 
  tmap_save(.,paste0(path_shape_files,"/IAGE7AFL.png"),height=2300/300)


shape_df@data %>% 
  saveRDS(.,paste0(path_shape_files,"/IAGE7AFL_data.RDS"))
shape_df@data %>% 
  write.csv(.,paste0(path_shape_files,"/IAGE7AFL_data.csv"),row.names = FALSE)
