###Download Legacy CSV Files


### Get state abbreviations
data(state)

### Convert state abbreviations to lower case
state.abb <- str_to_lower(state.abb)

### Create empty list 
data_list <- list()

### Set location to save data
saveLocation <- "C:/Users/Christian/Box/Computation/"

### Set index (for testing)
i <- 51

##Add DC 
state.abb[51] <- "dc"

#Create for loop to construct 
for(i in 1:51)
{
  
  stateAbb <- state.abb[i]
  
  #construct URL to grab CSV files 
  url <- paste0("https://data.openstates.org/legacy/csv/",stateAbb,".zip")
  saveLocationZip <- paste0(saveLocation,stateAbb,".zip")
  extractCsv <- paste0(stateAbb,"_bills.csv")
  
  download.file(url, saveLocationZip)
  unzip(saveLocationZip, exdir=paste0(saveLocation,stateAbb))
  data <- read.csv(paste0(saveLocation,stateAbb,"/",extractCsv))
  
  data %<>% mutate(state=stateAbb)
  data %<>% mutate(session=as.character(session))
  
  data_list[[i]] <- data
  
}

final_dat <- bind_rows(data_list)

#Save final_dat 
save(final_dat, file = "total_bills.RData")

