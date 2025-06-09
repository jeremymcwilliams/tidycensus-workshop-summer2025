<!-- Open this file in Visual mode (click "Visual" tab above) -->

# 2022 American Community Survey (5-Year Estimates) Key Variables

## Demographics

### Total Population

-   B01001_001: Total Population
-   B01002_001: Median Age
-   B01003_001: Total Population (Universe)

### Age & Sex

-   B01001_002: Male Total
-   B01001_026: Female Total
-   B01001_003 through \_025: Male age brackets
-   B01001_027 through \_049: Female age brackets

### Race & Ethnicity

-   B02001_001: Total Population (Race)
-   B02001_002: White alone
-   B02001_003: Black or African American alone
-   B02001_004: American Indian and Alaska Native alone
-   B02001_005: Asian alone
-   B02001_006: Native Hawaiian/Pacific Islander alone
-   B02001_007: Some other race alone
-   B02001_008: Two or more races

### Hispanic or Latino Origin

-   B03002_001: Total Population
-   B03002_002: Not Hispanic or Latino
-   B03002_012: Hispanic or Latino

## Economic Characteristics

### Income

-   B19013_001: Median Household Income
-   B19001_001: Total Households (Income)
-   B19001_002 through \_017: Income brackets
-   B19055_002: Social Security Income
-   B19056_002: Public Assistance Income
-   B19057_002: Food Stamp/SNAP Benefits

### Poverty

-   B17001_001: Total Population for Poverty Status
-   B17001_002: Income Below Poverty Level
-   B17001_031: Income At or Above Poverty Level

### Employment

-   B23025_001: Total Population 16+ (Employment)
-   B23025_002: In Labor Force
-   B23025_003: Civilian Labor Force
-   B23025_004: Employed
-   B23025_005: Unemployed
-   B23025_007: Not in Labor Force

## Housing

### Housing Units

-   B25001_001: Total Housing Units
-   B25002_002: Occupied Housing Units
-   B25002_003: Vacant Housing Units

### Housing Value

-   B25077_001: Median Home Value
-   B25075_001: Total Owner-Occupied Units
-   B25075_002 through \_025: Value brackets

### Monthly Rent

-   B25064_001: Median Gross Rent
-   B25063_001: Total Renter-Occupied Units
-   B25063_002 through \_025: Rent brackets

### Housing Costs

-   B25092_001: Median Selected Monthly Owner Costs (Mortgage)
-   B25092_002: Median Selected Monthly Owner Costs (No Mortgage)

## Education

### Educational Attainment (25+ years)

-   B15003_001: Total Population 25+
-   B15003_002: No schooling completed
-   B15003_017: Regular high school diploma
-   B15003_021: Bachelor's degree
-   B15003_022: Master's degree
-   B15003_023: Professional degree
-   B15003_024: Doctorate degree

## Transportation

### Commuting

-   B08006_001: Total Workers 16+
-   B08006_002: Car, truck, or van - drove alone
-   B08006_003: Car, truck, or van - carpooled
-   B08006_008: Public transportation
-   B08006_014: Walked
-   B08006_015: Other means
-   B08006_017: Worked from home

### Vehicles Available

-   B25044_001: Total Occupied Housing Units
-   B25044_002 through \_010: Number of vehicles available by tenure

## Notes:

1.  Variable Structure:
    -   B: Detailed Table
    -   Number: Table number
    -   Underscore
    -   Three-digit sequence number within table
2.  Geographic Levels Available:
    -   National
    -   State
    -   County
    -   Census Tract
    -   Block Group
    -   Place (Cities, Towns)
    -   ZCTA (ZIP Code Tabulation Areas)
3.  Margin of Error:
    -   Each estimate has an associated margin of error
    -   Add 'M' to the end of variable ID instead of 'E'
    -   Example: B01001_001M for margin of error
4.  Access Methods:
    -   Census API
    -   data.census.gov
    -   tidycensus R package
    -   censusdata Python package
