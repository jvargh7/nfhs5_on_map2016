
original_list <- imap(list_of_paths,
                    function(l_p,name){
                      
                      shape_df <-  readOGR(paste0(path_india_shapefiles,l_p));
                      
                      tmap_options(check.and.fix = TRUE)
                      (tm_shape(shape_df,ext=1.2) + 
                          tm_borders()) %>% 
                        tmap_save(.,paste0("maps/",name,".png"),height=2300/300)
                      
                      shape_df@data %>% 
                        return(.)
                      
                    })


library(openxlsx)
names(original_list) = names(list_of_paths)
write.xlsx(original_list, file = paste0("maps/map details original.xlsx"))


