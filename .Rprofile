library(rgdal)
library(sf)
library(tidyverse)
library(tmap)

path_india_shapefiles = "C:/Cloud/OneDrive - Emory University/data/India Shapefiles/"

list_of_paths = list(
  #District map for 2020
  d2020 = "original/india_shp_2020-master/district/in_district.shp",
  
  # State map for NFHS5
  snfhs5 = "original/IASHP7C/shps/sdr_subnational_boundaries.shp",
  
  # District map for NFHS5
  dnfhs5 = "original/IASHP7C/shps/sdr_subnational_boundaries2.shp",
  
  #District map for 2018
  d2018 = "original/INDIA_2018_DISTRICTS-master/DISTRICTS_2018.shp",
  
  #State map for maps-master after Telangana
  smapsmaster = "original/maps-master/States/Admin2.shp",
  
  #State map for NFHS4
  snfhs4 = "original/IASHP74/shps/sdr_subnational_boundaries.shp",
  
  #District map for NFHS4
  dnfhs4 = "original/IASHP74/shps/sdr_subnational_boundaries2.shp",
  
  
  #District map for Census 2011
  dcensus2011 = "original/maps-master/Districts/Census_2011/2011_Dist.shp",
  
  #State map for NFHS3
  snfhs3 = "original/IASHP52/shps/sdr_subnational_boundaries.shp",
  
  #District map for Census 2001
  dcensus2001 = "original/maps-master/Districts/Census_2001/2001_Dist.shp",
  
  # Downloaded from Survey of India Onlinemaps portal(Onlinemaps)
  dgoi2023 = "original/Administrative Boundary Database/DISTRICT_BOUNDARY.shp",
  # Downloaded from Survey of India Onlinemaps portal(Onlinemaps)
  dhqgoi2023 = "original/Administrative Boundary Database/DISTRICT_HQ.shp",
  # Downloaded from Survey of India Onlinemaps portal(Onlinemaps)
  twngoi2023 = "original/Administrative Boundary Database/MAJOR_TOWNS.shp",
  # Downloaded from Survey of India Onlinemaps portal(Onlinemaps)
  sgoi2023 = "original/Administrative Boundary Database/STATE_BOUNDARY.shp",
  # Downloaded from Survey of India Onlinemaps portal(Onlinemaps)
  shqgoi2023 = "original/Administrative Boundary Database/STATE_HQ.shp",
  # Downloaded from Survey of India Onlinemaps portal(Onlinemaps)
  sdgoi2023 = "original/Administrative Boundary Database/SUBDISTRICT_BOUNDARY.shp"
  
  
  
)
