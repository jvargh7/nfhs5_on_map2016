library(sf)

path_nfhs <- "C:/Cloud/OneDrive - Emory University/data/dhs_program/IA/IAGE7AFL"
shp_nfhs <-  read_sf(paste0(path_nfhs))

# path_2011 <- "C:/Cloud/OneDrive - Emory University/data/maps-master/Districts/Census_2011"
shp_2011 <-  readRDS(paste0(path_india_shapefiles,"/cleaned/dcensus2011.RDS"))
psu_2011 <- st_intersects(shp_2011,shp_nfhs)

# Specification is intersected district and row number
shp_nfhs_2011 <- map2_dfr(psu_2011,1:641,
                          function(x,y){
                            
                            x_df <- shp_nfhs[x,c("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA","URBAN_RURA")];
                            x_df$geometry <- NULL;
                            y_df <- shp_2011[y,c("DISTRICT","DT_CEN_CD","ST_NM","ST_CEN_CD")];
                            y_df$geometry <- NULL;
                            bind_cols(x_df,y_df) %>% 
                              return(.)
                            
                            
                          })

missing_shp_nfhs <- anti_join(shp_nfhs %>% 
                                dplyr::select(one_of("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA")),
                              shp_nfhs_2011,
                              by=c("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA")) %>% 
  left_join(shp_nfhs_2011 %>% 
              distinct_at(vars(one_of("ADM1NAME","DHSREGCO","DHSREGNA")),.keep_all=TRUE) %>% 
              dplyr::select(-DHSCLUST),
            by = c("ADM1NAME","DHSREGCO","DHSREGNA")) %>% 
  mutate(flag = "Imputed SHP 2011 data")


missing_shp_nfhs$geometry <- NULL

bind_rows(shp_nfhs_2011,
          missing_shp_nfhs) %>% 

write_csv(.,paste0("data/psu_on_map2011.csv"))

