
# - make a template....takes a while to install
#install.packages("tidyverse")
#install.packages("tidycensus")
install.packages("sf")

library(tidyverse)
library(tidycensus)
library(sf)


# dataset from data.gov
# Washington vehicle registrations by class and county
# from https://catalog.data.gov/dataset/vehicle-registrations-by-class-and-county

waVehicleData<-read_csv("Vehicle_Registrations_by_Class_and_County.csv")

unique(waVehicleData$`Fiscal Year`)
unique(waVehicleData$`Fuel Type`)
unique(waVehicleData$`Residential County`)

#remove out of state
waVehicleData <-waVehicleData %>%
  filter(`Residential County` !="Out Of State")



hybridElectricOnly<-waVehicleData %>%
  filter(`Fuel Type`=="Electric" | `Fuel Type`=="Hybrid")

byCountyByYear<-hybridElectricOnly %>%
  group_by(`Residential County`, `Fiscal Year`) %>%
  summarize(numPurchased=n())


byCountyByYear <-byCountyByYear %>%
  filter(`Fiscal Year`<2024)


write_csv(byCountyByYear, "data.csv")

#tidycensus

Sys.getenv("CENSUS_API_KEY") |> 
  census_api_key(install = TRUE)
readRenviron("~/.Renviron")


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



