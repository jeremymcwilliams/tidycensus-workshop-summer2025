
# - make a template....takes a while to install
#install.packages("tidyverse")
#install.packages("tidycensus")
#install.packages("sf")

library(tidyverse)
library(tidycensus)
library(sf)


# dataset from data.gov
# Washington vehicle registrations by class and county
# from https://catalog.data.gov/dataset/vehicle-registrations-by-class-and-county

waVehicleData<-read_csv("Vehicle_Registrations_by_Class_and_County.csv")

# see what we're dealing with
unique(waVehicleData$`Fiscal Year`)
unique(waVehicleData$`Fuel Type`)
unique(waVehicleData$`Residential County`)

#remove out of state
waVehicleData <-waVehicleData %>%
  filter(`Residential County` !="Out Of State")


#limit to electric/hybrid
hybridElectricOnly<-waVehicleData %>%
  filter(`Fuel Type`=="Electric" | `Fuel Type`=="Hybrid")

# aggregate
byCountyByYear<-hybridElectricOnly %>%
  group_by(`Residential County`, `Fiscal Year`) %>%
  summarize(numPurchased=n())

# no acs5 data > 2023, so limit
byCountyByYear <-byCountyByYear %>%
  filter(`Fiscal Year`<2024)


write_csv(byCountyByYear, "data.csv")

#tidycensus

#probably need to clean this up
Sys.getenv("CENSUS_API_KEY") |> 
  census_api_key(install = TRUE)
readRenviron("~/.Renviron")

# sample pop data for 2022 from tidycensus
wa_pop <- get_acs(
  geography = "county",
  state = "WA",
  variables = "B01003_001", # Total population
  year = 2022,
  survey = "acs5",
  geometry=TRUE
) %>%
  mutate(year="2022")

#create a column so we can do a match on the ev data
#doesn't work perfectly - yields list data type
#waPopTest<-wa_pop %>%
#  mutate("Residential County"=strsplit(NAME, " County, Washington"))

waPopTest <- wa_pop %>%
  mutate(`Residential County` = str_remove(NAME, " County, Washington$"))

#limit orig data to 2022
wa2022<-byCountyByYear %>%
  filter(`Fiscal Year`==2022)

# join the data
merged22<-left_join(waPopTest, wa2022, by="Residential County")


#calculate purchases per 1000 residents
merged22<-merged22 %>%
  mutate(purchasesPerK=(numPurchased/estimate)*1000)

#map it
ggplot(merged22) +
  geom_sf(aes(fill = purchasesPerK)) +
  scale_fill_viridis_c() +
  theme_void()


#next steps:
# loop for 2017-2023
# line plots, showing rate over time by county (not all)

years <- 2017:2023

wa_pop_all_years <- map_dfr(years, function(yr) {
  get_acs(
    geography = "county",
    state = "WA",
    variables = "B01003_001",
    year = yr,
    survey = "acs5",
    geometry = TRUE
  ) %>%
    mutate("Fiscal Year" = yr)
})

waPopAllYears <- wa_pop_all_years %>%
  mutate(`Residential County` = str_remove(NAME, " County, Washington$"))


# must now join on 2 columns, county & year
mergedAllYears<-left_join(waPopAllYears, byCountyByYear, by=c("Residential County", "Fiscal Year"))

#calculate rate
mergedAllYears<-mergedAllYears %>%
  mutate(purchasesPerK=(numPurchased/estimate)*1000)


#messy line plot:

ggplot(data=mergedAllYears, mapping=aes(x=`Fiscal Year`, y=purchasesPerK, colour = `Residential County`))+
  geom_line()+
  labs(title="EV/Hybrid Purchases per year by WA County, 2017-2023", x="Year", y="Purchases per thousand residents")


#heat map
ggplot(mergedAllYears, aes(x = `Fiscal Year`, y = fct_reorder(`Residential County`, -purchasesPerK), fill = purchasesPerK)) +
  geom_tile() +
  scale_fill_viridis_c() +
  labs(title = "EV/Hybrid Purchases per 1,000 Residents",
       x = "Year", y = "County", fill = "Per 1,000")


# maybe look at 1 county, with rates for different types of cars
# Clark county

clark<-waVehicleData %>%
  filter(`Residential County`=="Clark")

fuel=c("Gasoline", "Electric", "Hybrid", "Diesel")

clrk<-clark %>%
  filter(`Fuel Type` %in% fuel & `Fiscal Year`<2025) %>%
  group_by(`Fiscal Year`, `Fuel Type`) %>%
  summarize(purchases=n())


ggplot(data=clrk, mapping=aes(x=`Fiscal Year`, y=purchases, color=`Fuel Type`))+
  geom_line()


