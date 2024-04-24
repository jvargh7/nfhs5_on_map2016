library(sf)

path_nfhs <- "C:/Cloud/OneDrive - Emory University/data/dhs_program/IA/IAGE7AFL"
shp_nfhs <-  read_sf(paste0(path_nfhs))

path_2023 <- "C:/Cloud/OneDrive - Emory University/original/INDIAN-SHAPEFILES-master/INDIA/"
sf_use_s2(FALSE)
shp_2023 <-  readRDS(paste0(path_india_shapefiles,"/cleaned/dindianshapefiles.RDS")) %>% st_make_valid() 
# shp_2023 <-  readRDS(paste0(path_india_shapefiles,"/cleaned/sdindianshapefiles.RDS")) %>% st_make_valid() 
psu_2023 <- st_intersects(shp_2023,shp_nfhs)

shp_nfhs_2023 <- map2_dfr(psu_2023,1:755,
                          function(x,y){
                            
                            x_df <- shp_nfhs[x,c("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA","URBAN_RURA")];
                            x_df$geometry <- NULL;
                            y_df <- shp_2023[y,c("dtname","stname","stcode11","dtcode11","year_stat",
                                                 "Dist_LGD","State_LGD")];
                            y_df$geometry <- NULL;
                            bind_cols(x_df,y_df) %>% 
                              return(.)
                            
                            
                          })

missing_shp_nfhs <- anti_join(shp_nfhs %>% 
                                dplyr::select(one_of("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA")),
                              shp_nfhs_2023,
                              by=c("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA")) %>% 
  left_join(shp_nfhs_2023 %>% 
              distinct_at(vars(one_of("ADM1NAME","DHSREGCO","DHSREGNA")),.keep_all=TRUE) %>% 
              dplyr::select(-DHSCLUST),
            by = c("ADM1NAME","DHSREGCO","DHSREGNA")) %>% 
  mutate(flag = "Imputed SHP 2023 data")


missing_shp_nfhs$geometry <- NULL

bind_rows(shp_nfhs_2023,
          missing_shp_nfhs) %>% 
  
  write_csv(.,paste0("data/psu_on_mapindianshapefiles.csv"))
