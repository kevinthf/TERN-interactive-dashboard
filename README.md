# TERN interactive dashboard
Developing educational product to enhance the data accessibility to students or target audience.
## Data Source
The datasets were acquired from the TERN EcoPlots platform, which hosts a wide range of environmental and ecological data. 
https://ecoplots.tern.org.au/

The following link provides detail procedure to download the raw data from TERN EcoPlots.
https://ternaus.atlassian.net/wiki/spaces/TERNSup/pages/2682323095/Downloading+Data+in+EcoPlots

Here we use three datasets including "plant occurence", "weather" and "soil profile" to conduct following process and visualisation.
## Data Cleaning
The Data_preprocessing R script mainly conducting data cleaning and summarizing to produce output csv file for dashboard presentation.

## Static Dashboard
The R markdown files present basic flexdashboard and interactive shiny dashboard.

Flexdashboard provide a static html file that can be easily embedded on website or shared. </br>
https://kevinthf.github.io/TERN-interactive-dashboard-showcase/

## Interactive Dashboard
Shiny version creates interactve interface which is friendly for user to explore the datasset. 


## Attribution
The Land Use Base Map was sourced from the Australian Bureau of Agricultural and Resource Economics and Sciences (ABARES) ArcGIS MapServer.
Australian Bureau of Agricultural and Resource Economics and Sciences (ABARES) 2022, Land Use of Australia 2010–11 to 2015–16, 250 m, Canberra. Licensed under CC BY 4.0.
https://doi.org/10.25814/7ygw-4d64
