# Post 2012 Health Legislation Mapping Project
  In order to understand if the re-election of President Barack Obama shifted the productivity of state legislatures with respect to health care policy, this project maps the number of proposed and passed legislation in 2012 and in 2014 to see if there are significant state-to-state differences in terms of the amount of legislation passed in 2012 and two years later in 2014. The project then conducts an independent group t-test to look for any potential significant differences in the passage. 
# Dependencies
  My code depends on R, version 3.5
  
  My code also depends on installing the R packages tidyverse, rsunlight, stringr, magrittr, lubridate, httr, data.table, rmarkdown, knitr, tinytex, magrittr, gplots, #for heatmaps  viridis, RColorBrewer, scales, #good colors grDevices, graphics, mapproj, ggmap,rgdal, tmap, maptools, tmaptools, tidycensus, censusapi
  
# Files
  The files for this project are organized into the folders Data, Code, and Results, with the documents compiled below:
  
## Data (Raw) 
  1_totalbills.Rdata - File with all bills passed or introduced for all fifty states and DC from the legacy CSV files on OpenStates.org
  2_billactions.Rdata - File with all actions taken on bills for all fifty states and DC from the legacy CSV files on OpenStates.org
  2_fips_codes.Rdata - File with fips codes for states and counties to base mapping off of 
## Data (Processed)
  1_final.Rdata - Merged file with both total bills passed as well as the actions taken on each bill
  2_final12.Rdata - Merged file with both total bills passed and actions taken for bills in 2012. Used as base for mapping
  3_final14.Rdata - Merged file with both total bills passed and actions taken for bills in 2014. Used as base for mapping

## Code
  ComputationalToolsFinal.Rmd - All subsequent code below compiled in one RMarkdown file
  00_Final_LibraryDownloads.R - download packages and libraries for project
  01_Final_DownloadBills.R - writes for loop to download each states bills. Saved as 1_totalbills.Rdata
  02_Final_DownloadBillActions.R - writes for loop to download all actions taken on state bills. Saved as 2_billactions.Rdata
  03_Final_SubsettoRelevantTopics.R - uses diplyr and tidyverse packages to subset the totalbills and billactions data to just healthcare legislation
  04_Final_MergeDatasets.R - Merges the totalbills and billactions datasets to one dataframe
  05_Final_DownloadShapefile.R - Downloads Shapefile to serve as the skeleton for the mapping project
  06_Final_Create2012Map.R - Creates a map of legislation passed in 2012 for different U.S. states
  07_Final_Create2014Map.R - Creates a map of legislation passed in 2014 for different U.S. states
  08_Final_PlotMapsTogether.R - Uses facet wrap in ggplot2 to plot maps together. Saved as LegislativeMapCombined.PDF
  09_Final_ttest.R - Conducts a simple two independent sample t-test to provide statistical backing for the map findings (no real difference in 2012 and 2014)
  
  ## Results 
  LegislativeMap2012.PDF - Map of 2012 legislation
  LegislativeMap2014.PDF - Map of 2014 legislation
  LegislativeMapCombined.PDF - 2012 and 2014 maps plotted in the same place
# Supplemental Information/Next Steps 
