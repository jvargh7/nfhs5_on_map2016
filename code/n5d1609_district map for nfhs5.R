library(sp)
library(rgdal)

path_shape_files <- "C:/Cloud/OneDrive - Emory University/data/dhs_program/IA/IASHP7C/shps"
shape_df <-  readOGR(paste0(path_shape_files),"sdr_subnational_boundaries2")


(tm_shape(shape_df,ext=1.2) + 
    tm_borders()) %>% 
  tmap_save(.,paste0(path_shape_files,"/sdr_subnational_boundaries2.png"),height=2300/300)


shape_df@data %>% 
  mutate(REGCODE = case_when(REGNAME == "Hamirpur" & OTHREGNA == "Uttar Pradesh" ~ 168,
                             REGNAME == "Bijapur" & OTHREGNA == "Karnataka" ~ 557,
                             REGNAME == "Aurangabad" & OTHREGNA == "Maharashtra" ~ 515,
                             REGNAME == "Balrampur" & OTHREGNA == "Chhattisgarh" ~ 824,
                             REGNAME == "Bilaspur" & OTHREGNA == "Chhattisgarh" ~ 827,
                             REGNAME == "Pratapgarh" & OTHREGNA == "Uttar Pradesh" ~ 173,
                             REGNAME == "Raigarh" & OTHREGNA == "Maharashtra" ~ 520,
                             TRUE ~ REGCODE)) %>% 
  saveRDS(.,paste0(path_shape_files,"/sdr_subnational_boundaries2_data.RDS"))
shape_df@data %>% 
  mutate(REGCODE = case_when(REGNAME == "Hamirpur" & OTHREGNA == "Uttar Pradesh" ~ 168,
                             REGNAME == "Bijapur" & OTHREGNA == "Karnataka" ~ 557,
                             REGNAME == "Aurangabad" & OTHREGNA == "Maharashtra" ~ 515,
                             REGNAME == "Balrampur" & OTHREGNA == "Chhattisgarh" ~ 824,
                             REGNAME == "Bilaspur" & OTHREGNA == "Chhattisgarh" ~ 827,
                             REGNAME == "Pratapgarh" & OTHREGNA == "Uttar Pradesh" ~ 173,
                             REGNAME == "Raigarh" & OTHREGNA == "Maharashtra" ~ 520,
                             TRUE ~ REGCODE)) %>% 
  write.csv(.,paste0(path_shape_files,"/sdr_subnational_boundaries2_data.csv"),row.names = FALSE)

