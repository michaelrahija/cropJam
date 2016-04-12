##' Merge Listing datasets for Jamaica dataset
##' 
##' This grabs the datafiles out of a directory, and merges them. 
##' The result should be the SSU sampling frame. 
##' 
##' @param data.dir directory containing data files exported from server
##'   
##' @return A data frame that has merged properly all of the different data files. Each row is a parcel.
##'
##' @export
##' 
createDataset <- function(data.dir = "~/Dropbox/CROP/Jamaica/data_listing"){
  
  ##-------MERGE DATASETS W/O OTHER
  
  #create data files pathes
  top <- grepl("no_other_Listing ",list.files(data.dir)) 
  bot <- grepl("no_other_Roster ",list.files(data.dir))
  top <- list.files(data.dir)[top]
  bot <- list.files(data.dir)[bot]
  
  
  #read first set pre-exported data files, NO OTHER
  data.top <- as.data.set(spss.system.file(paste0(data.dir,"/",top)))
  data.top <- as.data.frame(data.top, stringsAsFactors = FALSE)
  names(data.top)[names(data.top) == "idnum"] <- "qId"
  
  data.bot <- as.data.set(spss.system.file(paste0(data.dir,"/",bot)))
  data.bot <- as.data.frame(data.bot, stringsAsFactors = FALSE)
  names(data.bot)[names(data.bot) == "idnum"] <- "qId"
  names(data.bot)[names(data.bot) == "id"] <- "parcelId"
  
  
  #remove columns containing only NAs
  cols <- sapply(data.top, function(x) length(x) == sum(is.na(x)))

  data.top <- data.top[!cols]

  master.no <- merge(data.top,
                     data.bot,
                     by = "qId",
                     all = TRUE)
  
  ##-------MERGE DATASETS WITH OTHER
  
  #create data files pathes
  top <- grepl("^Listing ",list.files(data.dir)) 
  bot <- grepl("^parcel",list.files(data.dir))
  top <- list.files(data.dir)[top]
  bot <- list.files(data.dir)[bot]
  
  
  #read datasets with OTHER column. Could not import 
  data.top <- read.table(paste0(data.dir,"/",top),
                         sep = "\t",
                         stringsAsFactors = FALSE,
                         header = TRUE)
  names(data.top)[names(data.top) == "Id"] <- "qId"
  
  data.bot <- read.table(paste0(data.dir,"/",bot),
                         sep = "\t",
                         stringsAsFactors = FALSE,
                         header = TRUE)
  names(data.bot)[names(data.bot) == "ParentId1"] <- "qId"
  names(data.bot)[names(data.bot) == "Id"] <- "parcelId"
  
  #remove columns of na
  cols <- sapply(data.top, function(x) length(x) == sum(is.na(x)))
  data.top <- data.top[!cols]
  
  master.other <- merge(data.top,
                        data.bot,
                        by = "qId",
                        all = TRUE)
  
  master.other <- arrange(master.other, qId)
  
  ##-----Merge dataframes to one master
  master <- merge(master.other, 
                  master.no, 
                  all = TRUE)
  
  # master <- select(master, -c(sssys_irnd,
  #                             ssSys_IRnd,
  #                             parcel_list))

  
master
  
}