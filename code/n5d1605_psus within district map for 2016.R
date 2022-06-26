library(sf)

path_nfhs <- "C:/Cloud/OneDrive - Emory University/data/dhs_program/IA/IAGE7AFL"
shp_nfhs <-  read_sf(paste0(path_nfhs))


path_2016 <- "C:/Cloud/OneDrive - Emory University/data/NFHS/NFHS4 Factsheets/maps/sdr_subnational_boundaries_2020-12-28/shps/sdr_subnational_boundaries2.shp"
shp_2016 <-  read_sf(paste0(path_2016))
psu_2016 <- st_intersects(shp_2016,shp_nfhs)

shp_nfhs_2016 <- map2_dfr(psu_2016,1:640,
                          function(x,y){
                            
                            x_df <- shp_nfhs[x,c("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA","URBAN_RURA")];
                            x_df$geometry <- NULL;
                            y_df <- shp_2016[y,c("REGNAME","REGCODE","OTHREGNA","OTHREGCO")];
                            y_df$geometry <- NULL;
                            bind_cols(x_df,y_df) %>% 
                              return(.)
                            
                            
                          })

missing_shp_nfhs <- anti_join(shp_nfhs %>% 
                                dplyr::select(one_of("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA")),
                              shp_nfhs_2016,
                              by=c("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA")) %>% 
  left_join(shp_nfhs_2016 %>% 
              distinct_at(vars(one_of("ADM1NAME","DHSREGCO","DHSREGNA")),.keep_all=TRUE) %>% 
              dplyr::select(-DHSCLUST),
            by = c("ADM1NAME","DHSREGCO","DHSREGNA")) %>% 
  mutate(flag = "Imputed SHP 2016 data")


missing_shp_nfhs$geometry <- NULL

bind_rows(shp_nfhs_2016,
          missing_shp_nfhs) %>% 
  
  write_csv(.,paste0("data/psu_on_map2016.csv"))
