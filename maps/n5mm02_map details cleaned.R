
list_of_cleaned = list.files(paste0(path_india_shapefiles,"/cleaned"))
list_of_cleaned = list_of_cleaned[!str_detect(string =list_of_cleaned,pattern="_sp")]


cleaned_list <- imap(list_of_cleaned,
                      function(l_c,name){
                        
                        shape_df <-  readRDS(paste0(path_india_shapefiles,"/cleaned/",l_c));
                        # 
                        # tmap_options(check.and.fix = TRUE)
                        # (tm_shape(shape_df,ext=1.2) + 
                        #     tm_borders()) %>% 
                        #   tmap_save(.,paste0("maps/",name,".png"),height=2300/300)
                        # 
                        shape_df$geometry = NULL
                        shape_df %>% 
                          return(.)
                        
                      })


library(openxlsx)
names(cleaned_list) = str_replace(list_of_cleaned,".RDS","")

write.xlsx(cleaned_list, file = paste0("maps/map details cleaned.xlsx"))
