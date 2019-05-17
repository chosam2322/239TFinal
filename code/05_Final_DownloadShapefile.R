###Download and Format Shapefile and Download County and State Borders 

# Download USDA shapefile
setwd("16_Mapping_Basics/Data_Raw/Shapefile")
US_counties <- rgdal::readOGR(dsn=".",layer="gz_2010_us_050_00_5m",
                              stringsAsFactors=FALSE)

# Save data in data slot
county_data <- US_counties@data

# Save row IDs in a column 
county_data <- cbind(id=rownames(county_data),county_data)

# Standardize county id (FIPS as 5 digit code)
county_data %<>% as_tibble() %>%
  mutate(FIPS = as.character(paste0(STATE,COUNTY)))  
county_data %<>% mutate(id = as.character(id))

# Create map dataframe
US_counties_tidy <- data.table(broom::tidy(US_counties)) 
US_counties_tidy %<>% mutate(id = as.character(id))


# County and State Borders
map_county <- ggplot2::map_data("county")
map_state <- ggplot2::map_data("state")
