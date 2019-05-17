###Create 2012 Map

# Use crosswalk to merge race data with shapefile IDs
data_wID_12 <- left_join(x = county_data, 
                         y = final12, 
                         by = c("STATE" = "state_code"))
# Merge census data with map dataframe 
map_df_12 <- left_join(x = US_counties_tidy, 
                       y = data_wID_12, 
                       by = "id")
# Subset to mainland USA
map_df_12 <- map_df_12[!(map_df_12$STATE %in% c("02","15","72")),]  

# Create map
map_df_12 %>% 
  ggplot(aes(x=long, y=lat, group=group)) +
  geom_polygon(aes(fill = pct_passed), color = NA) +
  geom_path(data = map_state , colour = "white", size=.1) +
  coord_quickmap() +
  labs(title="Legislative Concentration 2012", x="", y="") +
  theme_void() + 
  scale_fill_viridis(alpha = 1, begin = 0.5, end = 1, 
                     direction = -1, discrete = FALSE, option = "B",
                     # trans=log10_trans(),
                     name = "Key:",
                     labels = scales::percent, limits = c(0, 0.4))

ggsave("LegislativeMap2012.pdf", #plot name
       plot = last_plot(), #save last plot outputted 
       width=8, height=6, units="in" #dimensions of saved plot
) 
