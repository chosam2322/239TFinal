###Download Bill Actions

for (i in 1:51) 
{
  stateAbb <- state.abb[i]
  extractCsv <- paste0(stateAbb,"_bill_actions.csv")
  
  data <- read.csv(paste0(saveLocation,stateAbb,"/",extractCsv))
  
  data %<>% mutate(state=stateAbb)
  data %<>% mutate(session=as.character(session))
  
  data_list[[i]] <- data
}
billActions <- bind_rows(data_list)

#Save billActions
save(billActions, file = "billactions.RData")
