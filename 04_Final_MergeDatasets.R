###Merge Subsetted Bill DataFrame with Bill Actions

load("billactions.RData")

#Subset the billActions dataset to if the bill was passed by both chambers or not (signified by being sent to the Governor's Office)
billActions %<>% 
  mutate(governor = ifelse(type=="governor:received" | type=="governor:signed",1,0)) %>%
  mutate(date = ymd(str_sub(date,1,10)),
         year = year(date))

#Aggregate the billActions dataset to the year that each piece of health care legislation was introduced and passed 
billActions_agg <- billActions %>%
  group_by(bill_id, state, year, session) %>%
  summarise(governor = max(governor)) %>%
  ungroup() %>%
  filter(year %in% c(2011:2014)) %>%
  spread(key=year, value=governor) %>%
  rename(passed2011 = "2011",
         passed2012 = "2012",
         passed2013 = "2013",
         passed2014 = "2014") %>%
  mutate_at(vars(contains("passed")), funs(ifelse(is.na(.),0,.)))

#Combine the subsetted totalBills dataset and the billActions dataset 
final <- left_join(x=billSubset, y=billActions_agg, by=c("bill_id","state","session"))

### State and County codes from tigris package
##data(fips_codes)
fips_codes %<>% 
  distinct(state, state_code) %>%
  mutate(state = str_to_lower(state))

final %<>% left_join(x=., y=fips_codes, by=c("state"))

#Create a dataset just for the 2012 bills
final12 <- final %>% filter((year==2011 & passed2011==0) | (year==2012)) %>%
  select(-passed2011, -passed2013, -passed2014)

#Create a dataset just for the 2014 bills 
final14 <- final %>% filter((year==2013 & passed2011==0) | (year==2014)) %>%
  select(-passed2011, -passed2012, -passed2013)

final12 %<>% group_by(state, state_code) %>% 
  summarise(numerator = sum(passed2012, na.rm=T),
            denominator = n(), 
            pct_passed = numerator / denominator) %>%
  ungroup()


final14 %<>% group_by(state, state_code) %>% 
  summarise(numerator = sum(passed2014, na.rm=T),
            denominator = n(), 
            pct_passed = numerator / denominator) %>%
  ungroup()



#Save Final datasets
save(final, file = "final.RData")
save(final12, file = "final12.RData")
save(final14, file = "final14.RData")
