library(sp)
library(rgdal)

path_shape_files <- "C:/Cloud/OneDrive - Emory University/data/NFHS/NFHS4 Factsheets/maps/sdr_subnational_boundaries_2020-12-28/shps"
shape_df <-  readOGR(paste0(path_shape_files),"sdr_subnational_boundaries2")


(tm_shape(shape_df,ext=1.2) + 
    tm_borders()) %>% 
  tmap_save(.,paste0(path_shape_files,"/sdr_subnational_boundaries2.png"),height=2300/300)


shape_df@data %>% 
  mutate(REGCODE = case_when(REGNAME == "Hamirpur" & OTHREGNA == "Uttar Pradesh" ~ 168,
                             TRUE ~ REGCODE)) %>% 
  saveRDS(.,paste0(path_shape_files,"/sdr_subnational_boundaries2_data.RDS"))
shape_df@data %>% 
  mutate(REGCODE = case_when(REGNAME == "Hamirpur" & OTHREGNA == "Uttar Pradesh" ~ 168,
                             TRUE ~ REGCODE)) %>% 
  write.csv(.,paste0(path_shape_files,"/sdr_subnational_boundaries2_data.csv"),row.names = FALSE)
