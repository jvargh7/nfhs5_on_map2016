d2020 = read_sf(paste0(path_india_shapefiles,list_of_paths["d2020"])) %>% st_make_valid()

d2020_sp = rgdal::readOGR(paste0(path_india_shapefiles,list_of_paths["d2020"]))


snfhs5 = read_sf(paste0(path_india_shapefiles,list_of_paths["snfhs5"])) %>% st_make_valid()

dnfhs5 = read_sf(paste0(path_india_shapefiles,list_of_paths["dnfhs5"])) %>% st_make_valid() %>% 
  mutate(REGCODE = case_when(REGNAME == "Hamirpur" & OTHREGNA == "Uttar Pradesh" ~ 168, # HP: 28
                             REGNAME == "Bijapur" & OTHREGNA == "Karnataka" ~ 557, # CT: 417
                             REGNAME == "Aurangabad" & OTHREGNA == "Maharashtra" ~ 515, # BH : 235
                             REGNAME == "Balrampur" & OTHREGNA == "Chhattisgarh" ~ 824, # UP: 182
                             REGNAME == "Bilaspur" & OTHREGNA == "Chhattisgarh" ~ 827, #HP: 30
                             REGNAME == "Pratapgarh" & OTHREGNA == "Uttar Pradesh" ~ 173, # RJ: 131
                             REGNAME == "Raigarh" & OTHREGNA == "Maharashtra" ~ 520, # CT: 403
                             TRUE ~ REGCODE))

dnfhs5_sp = rgdal::readOGR(paste0(path_india_shapefiles,list_of_paths["dnfhs5"])) 
dnfhs5_sp@data = dnfhs5_sp@data %>% 
  mutate(REGCODE = case_when(REGNAME == "Hamirpur" & OTHREGNA == "Uttar Pradesh" ~ 168, # HP: 28
                             REGNAME == "Bijapur" & OTHREGNA == "Karnataka" ~ 557, # CT: 417
                             REGNAME == "Aurangabad" & OTHREGNA == "Maharashtra" ~ 515, # BH : 235
                             REGNAME == "Balrampur" & OTHREGNA == "Chhattisgarh" ~ 824, # UP: 182
                             REGNAME == "Bilaspur" & OTHREGNA == "Chhattisgarh" ~ 827, #HP: 30
                             REGNAME == "Pratapgarh" & OTHREGNA == "Uttar Pradesh" ~ 173, # RJ: 131
                             REGNAME == "Raigarh" & OTHREGNA == "Maharashtra" ~ 520, # CT: 403
                             TRUE ~ REGCODE))



d2018 = read_sf(paste0(path_india_shapefiles,list_of_paths["d2018"])) %>% st_make_valid()
d2018_sp = rgdal::readOGR(paste0(path_india_shapefiles,list_of_paths["d2018"]))


smapsmaster = read_sf(paste0(path_india_shapefiles,list_of_paths["smapsmaster"])) %>% st_make_valid()
smapsmaster_sp = rgdal::readOGR(paste0(path_india_shapefiles,list_of_paths["smapsmaster"]))


snfhs4 = read_sf(paste0(path_india_shapefiles,list_of_paths["snfhs4"])) %>% st_make_valid()


dnfhs4 = read_sf(paste0(path_india_shapefiles,list_of_paths["dnfhs4"])) %>% st_make_valid() %>% 
  mutate(REGCODE = case_when(REGNAME == "Hamirpur" & OTHREGNA == "Uttar Pradesh" ~ 168,
                             TRUE ~ REGCODE),
         OTHREGCO = case_when(OTHREGNA == "Himanchal Pradesh" ~ 13,
                              TRUE ~ OTHREGCO),
         OTHREGNA =  case_when(OTHREGNA == "Himanchal Pradesh" ~ "Himachal Pradesh",
                               TRUE ~ OTHREGNA))
dnfhs4_sp =  rgdal::readOGR(paste0(path_india_shapefiles,list_of_paths["dnfhs4"]))
dnfhs4_sp@data = dnfhs4_sp@data %>% 
  mutate(REGCODE = case_when(REGNAME == "Hamirpur" & OTHREGNA == "Uttar Pradesh" ~ 168,
                             TRUE ~ REGCODE),
         OTHREGCO = case_when(OTHREGNA == "Himanchal Pradesh" ~ 13,
                              TRUE ~ OTHREGCO),
         OTHREGNA =  case_when(OTHREGNA == "Himanchal Pradesh" ~ "Himachal Pradesh",
                               TRUE ~ OTHREGNA))



dcensus2011 = read_sf(paste0(path_india_shapefiles,list_of_paths["dcensus2011"])) %>% st_make_valid()

snfhs3 = read_sf(paste0(path_india_shapefiles,list_of_paths["snfhs3"])) %>% st_make_valid()

dcensus2001 = read_sf(paste0(path_india_shapefiles,list_of_paths["dcensus2001"])) %>% st_make_valid()



saveRDS(d2020,paste0(path_india_shapefiles,"cleaned/d2020.RDS"))
saveRDS(snfhs5,paste0(path_india_shapefiles,"cleaned/snfhs5.RDS"))
saveRDS(dnfhs5,paste0(path_india_shapefiles,"cleaned/dnfhs5.RDS"))
saveRDS(d2018,paste0(path_india_shapefiles,"cleaned/d2018.RDS"))
saveRDS(smapsmaster,paste0(path_india_shapefiles,"cleaned/smapsmaster.RDS"))
saveRDS(snfhs4,paste0(path_india_shapefiles,"cleaned/snfhs4.RDS"))
saveRDS(dcensus2011,paste0(path_india_shapefiles,"cleaned/dcensus2011.RDS"))
saveRDS(snfhs3,paste0(path_india_shapefiles,"cleaned/snfhs3.RDS"))
saveRDS(dcensus2001,paste0(path_india_shapefiles,"cleaned/dcensus2001.RDS"))

saveRDS(d2020_sp,paste0(path_india_shapefiles,"cleaned/d2020_sp.RDS"))
saveRDS(d2018_sp,paste0(path_india_shapefiles,"cleaned/d2018_sp.RDS"))
saveRDS(dnfhs5_sp,paste0(path_india_shapefiles,"cleaned/dnfhs5_sp.RDS"))
saveRDS(smapsmaster_sp,paste0(path_india_shapefiles,"cleaned/smapsmaster_sp.RDS"))
saveRDS(dnfhs4_sp,paste0(path_india_shapefiles,"cleaned/dnfhs4_sp.RDS"))

