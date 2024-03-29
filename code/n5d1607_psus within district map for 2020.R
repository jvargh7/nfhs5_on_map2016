library(sf)

path_nfhs <- "C:/Cloud/OneDrive - Emory University/data/dhs_program/IA/IAGE7AFL"
shp_nfhs <-  read_sf(paste0(path_nfhs))

path_2020 <- "C:/Cloud/OneDrive - Emory University/data/India Shapefiles/india_shp_2020-master/district"
shp_2020 <-  readRDS(paste0(path_india_shapefiles,"/cleaned/d2020.RDS"))
psu_2020 <- st_intersects(shp_2020,shp_nfhs)

shp_nfhs_2020 <- map2_dfr(psu_2020,1:735,
                          function(x,y){
                            
                            x_df <- shp_nfhs[x,c("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA","URBAN_RURA")];
                            x_df$geometry <- NULL;
                            y_df <- shp_2020[y,c("dtname","stname","stcode11","dtcode11","year_stat",
                                                 "Dist_LGD","State_LGD","JID")];
                            y_df$geometry <- NULL;
                            bind_cols(x_df,y_df) %>% 
                              return(.)
                            
                            
                          })

missing_shp_nfhs <- anti_join(shp_nfhs %>% 
                                dplyr::select(one_of("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA")),
                              shp_nfhs_2020,
                              by=c("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA")) %>% 
  left_join(shp_nfhs_2020 %>% 
              distinct_at(vars(one_of("ADM1NAME","DHSREGCO","DHSREGNA")),.keep_all=TRUE) %>% 
              dplyr::select(-DHSCLUST),
            by = c("ADM1NAME","DHSREGCO","DHSREGNA")) %>% 
  mutate(flag = "Imputed SHP 2020 data")


missing_shp_nfhs$geometry <- NULL

bind_rows(shp_nfhs_2020,
          missing_shp_nfhs) %>% 
  
  write_csv(.,paste0("data/psu_on_map2020.csv"))
