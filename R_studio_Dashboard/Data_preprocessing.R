##### Install package (only needed the first time)#####
# install.packages("flexdashboard")
# install.packages("dplyr")
# install.packages("DT")
#######################################################


library(flexdashboard)
library(dplyr)
library(DT)

# Import csv raw data-set
plant_species_data <-read.csv("rawdata/Plant_occurrence.csv", header = TRUE, stringsAsFactors = FALSE)
weather_data <-read.csv("rawdata/weather_data.csv", header = TRUE, stringsAsFactors = FALSE)
soil_data <-read.csv("rawdata/soil-profile_data.csv", header = TRUE, stringsAsFactors = FALSE)


# Extract Genus to create new column for plant_species_data
plant_species_data$taxonGenus <- sub(" .*", "", plant_species_data$scientificName)

# Extract state code from site-Name
plant_species_data$stateCode <- substr(plant_species_data$siteName,1,2)



# Since multiple soil data for same date of single site location (unique ID with multiple value)
# It is important to summarize the value in average 
# Aggregate soil data 
soil_data_clean <-soil_data %>%
  group_by(siteName, siteVisitName) %>%
  summarise(
    average_soil_pH_unitless = mean(soilPh_unitless, na.rm = TRUE),
    average_soil_EC_dSPerMetre = mean(soilElectricalConductivity_decisiemensPerMetre, na.rm = TRUE),
    soil_texture_Grade_list = list(soilTextureGrade),
    .groups = "drop"
  )

# Define Mode function
mode_fun_all <- function(x) {
  # remove NA values first
  x_no_na <- x[!is.na(x)]
  # if nothing left b return NA
  if (length(x_no_na) == 0) {
    return(NA)
  }
  
  tbl <- table(x_no_na)
  modes <- names(tbl)[tbl == max(tbl)]
  
  paste(modes, collapse = "& ")
}

# For Soil Texture, select the most sampled grade class 
soil_data_clean$soil_texture_Grade <-mapply(mode_fun_all,soil_data_clean$soil_texture_Grade_list)

# Drop the list column
soil_data_clean <- soil_data_clean %>% select(-soil_texture_Grade_list)



##############################Abundance Data Family##################################

# Aggregate species data by Family, location and date
abundance_df_family <- plant_species_data %>%
  count(siteName,
        stateCode,
        siteVisitName, 
        taxonFamily,
        latitude_Degree,
        longitude_Degree,
        siteVisitStartDate, name = "abundance")

# Joining Data-sets species and weather
join_df_ab_family <- abundance_df_family %>%
  inner_join(
    weather_data %>% select(siteName, 
                            siteVisitName,
                            precipitationAnnualMean_millimetre,
                            solarRadiationMean_megajoulePerSquareMetre,
                            maximumTemperature_degreeCelsius,
                            minimumTemperature_degreeCelsius,
                            temperatureAnnualMean_degreeCelsius,
                            climaticCondition),
    by = c("siteName", "siteVisitName"))

# Convert time format
join_df_ab_family$siteVisitStartDate <- as.POSIXct(join_df_ab_family$siteVisitStartDate, format = "%Y-%m-%dT%H:%M:%S")





# Joining Data-sets, joined and soil_clean
join_df_ab_family <- join_df_ab_family %>%
  inner_join(soil_data_clean,by = c("siteName", "siteVisitName"))

##############################Abundance Data Genus##################################

# Aggregate species data by Genus, location and date
abundance_df_genus <- plant_species_data %>%
  count(siteName,
        stateCode,
        siteVisitName, 
        taxonGenus,
        latitude_Degree,
        longitude_Degree,
        siteVisitStartDate, name = "abundance")

# Joining Data-sets species and weather
join_df_ab_genus <- abundance_df_genus %>%
  inner_join(
    weather_data %>% select(siteName, 
                            siteVisitName,
                            precipitationAnnualMean_millimetre,
                            solarRadiationMean_megajoulePerSquareMetre,
                            maximumTemperature_degreeCelsius,
                            minimumTemperature_degreeCelsius,
                            temperatureAnnualMean_degreeCelsius,
                            climaticCondition),
    by = c("siteName", "siteVisitName"))

# Convert time format
join_df_ab_genus$siteVisitStartDate <- as.POSIXct(join_df_ab_genus$siteVisitStartDate, format = "%Y-%m-%dT%H:%M:%S")





# Joining Data-sets, joined and soil_clean
join_df_ab_genus <- join_df_ab_genus %>%
  inner_join(soil_data_clean,by = c("siteName", "siteVisitName"))

##############################Abundance Data Species##################################

# Aggregate species data by Genus, location and date
abundance_df_species <- plant_species_data %>%
  count(siteName,
        stateCode,
        siteVisitName, 
        scientificName,
        latitude_Degree,
        longitude_Degree,
        siteVisitStartDate, name = "abundance")

# Joining Data-sets species and weather
join_df_ab_species <- abundance_df_species %>%
  inner_join(
    weather_data %>% select(siteName, 
                            siteVisitName,
                            precipitationAnnualMean_millimetre,
                            solarRadiationMean_megajoulePerSquareMetre,
                            maximumTemperature_degreeCelsius,
                            minimumTemperature_degreeCelsius,
                            temperatureAnnualMean_degreeCelsius,
                            climaticCondition),
    by = c("siteName", "siteVisitName"))

# Convert time format
join_df_ab_species$siteVisitStartDate <- as.POSIXct(join_df_ab_species$siteVisitStartDate, format = "%Y-%m-%dT%H:%M:%S")





# Joining Data-sets, joined and soil_clean
join_df_ab_species <- join_df_ab_species %>%
  inner_join(soil_data_clean,by = c("siteName", "siteVisitName"))


###########################Species Richness Data################################

# Aggregate species data by location and date, count distinct species
richness_df <- plant_species_data %>%
  group_by(siteName,
           stateCode,
           siteVisitName,
           latitude_Degree,
           longitude_Degree,
           siteVisitStartDate) %>%
  summarise(unique_species_count = n_distinct(
    scientificName, na.rm = TRUE), .groups = "drop")


# Joining Data-sets species and weather
join_df_rich <- richness_df %>%
  inner_join(
    weather_data %>% select(siteName, 
                            siteVisitName,
                            precipitationAnnualMean_millimetre,
                            solarRadiationMean_megajoulePerSquareMetre,
                            maximumTemperature_degreeCelsius,
                            minimumTemperature_degreeCelsius,
                            temperatureAnnualMean_degreeCelsius,
                            climaticCondition),
    by = c("siteName", "siteVisitName"))

# Convert time format
join_df_rich$siteVisitStartDate <- as.POSIXct(join_df_rich$siteVisitStartDate, format = "%Y-%m-%dT%H:%M:%S")



# Joining Data-sets, joined and soil2
join_df_rich <- join_df_rich %>%
  inner_join(soil_data_clean,by = c("siteName", "siteVisitName"))



#################################################################################

#Export processed data-frame to csv file

write.csv(join_df_ab_genus, "processed_data/join_df_ab_genus.csv", row.names = FALSE)
write.csv(join_df_ab_family, "processed_data/join_df_ab_family.csv", row.names = FALSE)
write.csv(join_df_ab_species, "processed_data/join_df_ab_species.csv", row.names = FALSE)
write.csv(join_df_rich, "processed_data/join_df_rich.csv", row.names = FALSE)
write.csv(richness_df, "processed_data/richness_df.csv", row.names = FALSE)
write.csv(abundance_df_genus, "processed_data/abundance_df_genus.csv", row.names = FALSE)
write.csv(abundance_df_family, "processed_data/abundance_df_family.csv", row.names = FALSE)
write.csv(abundance_df_species, "processed_data/abundance_df_species.csv", row.names = FALSE)


