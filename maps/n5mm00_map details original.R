
original_list <- imap(list_of_paths,
                    function(l_p,name){
                      
                      shape_df <-  read_sf(paste0(path_india_shapefiles,l_p)) %>% 
                        st_make_valid();
                      
                      tmap_options(check.and.fix = TRUE)
                      
                      try((tm_shape(shape_df,ext=1.2) + 
                             tm_borders()) %>% 
                            tmap_save(.,paste0("maps/",name,".png"),height=2300/300))
                      
                      shape_df$geometry = NULL
                      
                      shape_df %>% 
                        return(.)
                      
                    })


library(openxlsx)
names(original_list) = names(list_of_paths)
write.xlsx(original_list, file = paste0("maps/map details original.xlsx"))


