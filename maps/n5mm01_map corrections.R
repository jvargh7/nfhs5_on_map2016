d2020 = read_sf(paste0(path_india_shapefiles,list_of_paths["d2020"])) %>% st_make_valid()
saveRDS(d2020,paste0(path_india_shapefiles,"cleaned/d2020.RDS"))

snfhs5 = read_sf(paste0(path_india_shapefiles,list_of_paths["snfhs5"])) %>% st_make_valid()
saveRDS(snfhs5,paste0(path_india_shapefiles,"cleaned/snfhs5.RDS"))

dnfhs5 = read_sf(paste0(path_india_shapefiles,list_of_paths["dnfhs5"])) %>% st_make_valid() %>% 
  mutate(REGCODE = case_when(REGNAME == "Hamirpur" & OTHREGNA == "Uttar Pradesh" ~ 168, # HP: 28
                             REGNAME == "Bijapur" & OTHREGNA == "Karnataka" ~ 557, # CT: 417
                             REGNAME == "Aurangabad" & OTHREGNA == "Maharashtra" ~ 515, # BH : 235
                             REGNAME == "Balrampur" & OTHREGNA == "Chhattisgarh" ~ 824, # UP: 182
                             REGNAME == "Bilaspur" & OTHREGNA == "Chhattisgarh" ~ 827, #HP: 30
                             REGNAME == "Pratapgarh" & OTHREGNA == "Uttar Pradesh" ~ 173, # RJ: 131
                             REGNAME == "Raigarh" & OTHREGNA == "Maharashtra" ~ 520, # CT: 403
                             TRUE ~ REGCODE))
saveRDS(dnfhs5,paste0(path_india_shapefiles,"cleaned/dnfhs5.RDS"))

d2018 = read_sf(paste0(path_india_shapefiles,list_of_paths["d2018"])) %>% st_make_valid()
saveRDS(d2018,paste0(path_india_shapefiles,"cleaned/d2018.RDS"))

smapsmaster = read_sf(paste0(path_india_shapefiles,list_of_paths["smapsmaster"])) %>% st_make_valid()
saveRDS(smapsmaster,paste0(path_india_shapefiles,"cleaned/smapsmaster.RDS"))

snfhs4 = read_sf(paste0(path_india_shapefiles,list_of_paths["snfhs4"])) %>% st_make_valid()
saveRDS(snfhs4,paste0(path_india_shapefiles,"cleaned/snfhs4.RDS"))

dnfhs4 = read_sf(paste0(path_india_shapefiles,list_of_paths["dnfhs4"])) %>% st_make_valid() %>% 
  mutate(REGCODE = case_when(REGNAME == "Hamirpur" & OTHREGNA == "Uttar Pradesh" ~ 168,
                             TRUE ~ REGCODE),
         OTHREGCO = case_when(OTHREGNA == "Himanchal Pradesh" ~ 13,
                              TRUE ~ OTHREGCO),
         OTHREGNA =  case_when(OTHREGNA == "Himanchal Pradesh" ~ "Himachal Pradesh",
                               TRUE ~ OTHREGNA))

saveRDS(dnfhs4,paste0(path_india_shapefiles,"cleaned/dnfhs4.RDS"))


dcensus2011 = read_sf(paste0(path_india_shapefiles,list_of_paths["dcensus2011"])) %>% st_make_valid()
saveRDS(dcensus2011,paste0(path_india_shapefiles,"cleaned/dcensus2011.RDS"))

snfhs3 = read_sf(paste0(path_india_shapefiles,list_of_paths["snfhs3"])) %>% st_make_valid()
saveRDS(snfhs3,paste0(path_india_shapefiles,"cleaned/snfhs3.RDS"))

dcensus2001 = read_sf(paste0(path_india_shapefiles,list_of_paths["dcensus2001"])) %>% st_make_valid()
saveRDS(dcensus2001,paste0(path_india_shapefiles,"cleaned/dcensus2001.RDS"))
