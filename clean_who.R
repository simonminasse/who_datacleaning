library(tidyverse, quietly = TRUE)


med_ <- read_csv('who_rn_mid_data.csv', show_col_types = FALSE) # reading in data
#nurse <- read_csv('who_rn_mid_data.csv', show_col_types = FALSE) # decided to create a function since this is repetitive
#lab <- read_csv('who_medlab_data.csv', show_col_types = FALSE)
#comm <- read_csv('who_chw_data.csv', show_col_types = FALSE)

med <- med_ |> discard(~ all(is.na(.x))) # dropping columns that have all null values

# creating a function to replace repetitive code
cleaning <- function(filepath, name) {
  name <- read_csv({{filepath}}, show_col_types = FALSE) # reading in data
  name <- name |> discard(~ all(is.na(.x))) # dropping columns that have all null values
  glimpse(name, width = 100) # previewing dataset 
}

nurse <- cleaning('who_rn_mid_data.csv', nurse) # creating cleaned datasets 
lab <- cleaning('who_medlab_data.csv', lab) 
med <- cleaning('who_md_data.csv', med)
comm <- cleaning('who_chw_data.csv', comm)


who_summ <- rbind(nurse, lab, med, comm) # all datasets have same 16 columns so we can concatenate 

write_csv(who_summ, 'who_summ.csv') # output final data to csv for use in tableau
