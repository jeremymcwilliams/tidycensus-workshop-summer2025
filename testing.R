
# - make a template....takes a while to install
#install.packages("tidyverse")
#install.packages("tidycensus")

library(tidyverse)
library(tidycensus)


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




