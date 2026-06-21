# TERN interactive dashboard
Hello World!

This repository contains the R scripts and Markdown files used to demonstrate and explore data collected from TERN. The project aims to improve data accessibility and understanding for students and other target audiences.

You can download the complete project by clicking Code and then Download ZIP, as shown in the image below.

![oops, it seems the image has gone :(](https://github.com/kevinthf/TERN-interactive-dashboard-showcase/blob/main/tutorial_image/001.png)


## Data Source
TERN is a research team that measures key terrestrial ecosystem attributes over time and stores these valuable observations in its database.
By leveraging this rich and valuable resource, we can explore the data and uncover interesting patterns, trends, and insights from the raw datasets.

The datasets were acquired from the [TERN EcoPlots](https://ecoplots.tern.org.au/) platform, which hosts a wide range of environmental and ecological data. 

The detailed procedure for downloading raw data from TERN EcoPlots can be found [here](https://ternaus.atlassian.net/wiki/spaces/TERNSup/pages/2682323095/Downloading+Data+in+EcoPlots).

Here we use three datasets including "plant occurence", "weather" and "soil profile" to conduct following process and visualisation.

If you are interested, you can also download other datasets, but make sure they are saved in the rawdata folder to conduct the following data preprocessing.

## Data Cleaning
The Data_preprocessing R script mainly conducting data cleaning and summarizing to produce output csv file for dashboard presentation.


You are welcome to use the cleaned dataset that have already saved in the "processed_data" folder.

**Those are the key files required to generate and display the dashboards. Please ensure they are stored in the correct folder and that their filenames remain unchanged.** 

## Static Dashboard
The "Dashboard_Create_static" file present basic flexdashboard.

Flexdashboard provide a static html file that can be easily embedded on website or shared.

You can click [Species Richness Overview](https://kevinthf.github.io/TERN-interactive-dashboard-showcase/) to see how it looks like.

The only downside is that it doesn't offer many opportunities for interaction, which can make the experience feel a little less fun.

## Interactive Dashboard
The "Dashboard_Create_shiny" creates interactve interface which is friendly for you to explore the datasset.


If you are not familiar with those species scientific name, "Dashboard_Create_shiny_description" provides the description for those species.

Have fun to explore and try if you can find some interesting facts.


## Attribution
The Land Use Base Map was sourced from the Australian Bureau of Agricultural and Resource Economics and Sciences (ABARES) ArcGIS MapServer.
Australian Bureau of Agricultural and Resource Economics and Sciences (ABARES) 2022, Land Use of Australia 2010–11 to 2015–16, 250 m, Canberra. Licensed under CC BY 4.0.
https://doi.org/10.25814/7ygw-4d64
