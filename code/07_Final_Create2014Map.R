###Create 2014 Map

# Use crosswalk to merge race data with shapefile IDs
data_wID_14 <- left_join(x = county_data, 
                         y = final14, 
                         by = c("STATE" = "state_code"))
# Merge census data with map dataframe 
map_df_14 <- left_join(x = US_counties_tidy, 
                       y = data_wID_14, 
                       by = "id")
# Subset to mainland USA
map_df_14 <- map_df_14[!(map_df_14$STATE %in% c("02","15","72")),]  

# Create map
map_df_14 %>% 
  ggplot(aes(x=long, y=lat, group=group)) +
  geom_polygon(aes(fill = pct_passed), color = NA) +
  geom_path(data = map_state , colour = "white", size=.1) +
  coord_quickmap() +
  labs(title="Legislative Concentration 2014", x="", y="") +
  theme_void() + 
  scale_fill_viridis(alpha = 1, begin = 0.5, end = 1, 
                     direction = -1, discrete = FALSE, option = "C",
                     # trans=log10_trans(),
                     name = "Key:",
                     labels = scales::percent, limits = c(0, 0.4))

ggsave("LegislativeMap2014.pdf", #plot name
       plot = last_plot(), #save last plot outputted 
       width=8, height=6, units="in" #dimensions of saved plot
) 
