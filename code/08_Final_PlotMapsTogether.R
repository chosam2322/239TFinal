#Plot Maps Together 

map_df_12 %<>% mutate(year=2012)
map_df_14 %<>% mutate(year=2014)

map_df <- rbind(map_df_12, map_df_14)

# Create map
map_df %>% 
  ggplot(aes(x=long, y=lat, group=group)) +
  geom_polygon(aes(fill = pct_passed), color = NA) +
  geom_path(data = map_state , colour = "white", size=.1) +
  coord_quickmap() +
  labs(title="Legislative Concentration 2014", x="", y="") +
  facet_wrap(~year, ncol = 2) +
  theme_void() + 
  scale_fill_viridis(alpha = 1, begin = 0.5, end = 1, 
                     direction = -1, discrete = FALSE, option = "C",
                     # trans=log10_trans(),
                     name = "Key:",
                     labels = scales::percent, limits = c(0, 0.5))

ggsave("LegislativeMapCombined.pdf", #plot name
       plot = last_plot(), #save last plot outputted 
       width=8, height=6, units="in" #dimensions of saved plot
) 
```
