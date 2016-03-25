##' Clean listing datasets for Jamaica dataset
##' 
##' This grabs the datafiles out of a directory, and merges them. 
##' The result should be the SSU sampling frame. 
##' 
##' @param df is the dataframe to be cleaned
##'   
##' @return A cleaned data frame
##'
##' @export
##' 

cleanDataset <- function(df = master){
  
  #clean gender
  
  #clean farmer_name
  
  #clearn parish
  df$parish[df$parish == 1] <- "Manchester"
  df$parish[df$parish == 2] <- "Trelawny"
  
  #clean EA
  df$ea[df$ea == 34] <- "Albert Town"
  df$ea[df$ea == 35] <- "Lowe River"
  df$ea[df$ea == 38] <- "Warsop"
  df$ea[df$ea == 76] <- "Comfort Hall"
  df$ea[df$ea == 77] <- "Christiana"
  
  #enumeration districts - There's alot, no names, all numeric
  
  
  #--clean column names - crop_list refers to specific crops, and 
  #--and parcel_list is redundant after the parcelId column
  names(df)[names(df) == "crop_list_1"] <- "sweetPotato"
  names(df)[names(df) == "crop_list_2"] <- "irishPotato"
  names(df)[names(df) == "crop_list_3"] <- "yellowYam"
  names(df)[names(df) == "crop_list_4"] <- "onion"
  names(df)[names(df) == "crop_list_96"] <- "otherCrop"
  
  cols <- grep(pattern = "parcel_list_[0-9]+",colnames(df))
  
  df <- df[,-cols]


df

}