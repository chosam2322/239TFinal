###Cultivate Data from CSV Files 

load("total_bills.RData")

#Using diplyr, filter the bills into the year of the 2012 election and 2014 to capture the differences
final_dat %<>% mutate(date = ymd(str_sub(created_at,1,10)), year = year(date))
billSubset <- final_dat %>% filter(year %in% c(2012: 2014))
#Using diplyr, subset the bills by the subject of Health in the legislatures 
billSubset %<>% mutate(health = ifelse(str_detect("Health",title),1,0)) %>% 
  filter(environmental == 1)

rm(final_dat)
