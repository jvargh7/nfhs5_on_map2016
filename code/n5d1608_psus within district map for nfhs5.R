library(sf)

path_nfhs <- "C:/Cloud/OneDrive - Emory University/data/dhs_program/IA/IAGE7AFL"
shp_nfhs <-  read_sf(paste0(path_nfhs))

path_nfhs5 <- "C:/Cloud/OneDrive - Emory University/data/dhs_program/IA/IASHP7C/shps/sdr_subnational_boundaries2.shp"
shp_nfhs5 <-  read_sf(paste0(path_nfhs5))
psu_nfhs5 <- st_intersects(shp_nfhs5,shp_nfhs)

shp_nfhs5$geometry <- NULL
shp_nfhs5 <- shp_nfhs5 %>% 
  mutate(REGCODE = case_when(REGNAME == "Hamirpur" & OTHREGNA == "Uttar Pradesh" ~ 168,
                             REGNAME == "Bijapur" & OTHREGNA == "Karnataka" ~ 557,
                             REGNAME == "Aurangabad" & OTHREGNA == "Maharashtra" ~ 515,
                             REGNAME == "Balrampur" & OTHREGNA == "Chhattisgarh" ~ 824,
                             REGNAME == "Bilaspur" & OTHREGNA == "Chhattisgarh" ~ 827,
                             REGNAME == "Pratapgarh" & OTHREGNA == "Uttar Pradesh" ~ 173,
                             REGNAME == "Raigarh" & OTHREGNA == "Maharashtra" ~ 520,
                             TRUE ~ REGCODE))

shp_nfhs_nfhs5 <- map2_dfr(psu_nfhs5,1:707,
                          function(x,y){
                            
                            x_df <- shp_nfhs[x,c("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA","URBAN_RURA")];
                            x_df$geometry <- NULL;
                            y_df <- shp_nfhs5[y,c("DHSREGEN","OTHREGNA","OTHREGCO","REGCODE","SVYYEAR")];
                            bind_cols(x_df,y_df) %>% 
                              return(.)
                            
                            
                          }) %>% 
  # New addition
  distinct(DHSCLUST,.keep_all=TRUE)

missing_shp_nfhs <- anti_join(shp_nfhs %>% 
                                dplyr::select(one_of("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA")),
                              shp_nfhs_nfhs5,
                              by=c("DHSCLUST","ADM1NAME","DHSREGCO","DHSREGNA")) %>% 
  left_join(shp_nfhs_nfhs5 %>% 
              distinct_at(vars(one_of("ADM1NAME","DHSREGCO","DHSREGNA")),.keep_all=TRUE) %>% 
              dplyr::select(-DHSCLUST),
            by = c("ADM1NAME","DHSREGCO","DHSREGNA")) %>% 
  mutate(flag = "Imputed SHP nfhs5 data")


missing_shp_nfhs$geometry <- NULL

bind_rows(shp_nfhs_nfhs5,
          missing_shp_nfhs) %>% 
  
  write_csv(.,paste0("data/psu_on_mapnfhs5.csv"))
