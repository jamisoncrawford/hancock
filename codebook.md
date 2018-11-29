# Code Book

The following lists the table names, variables, units of measurement if applicable, processing tasks, and definitions for each employment document scraped, as well as the "Master Table", merging and homogenizing variables uniformly where possible.

# Publication Variables

The latest available version of published findings, ["Hancock Renovations: Importing Whites, Exporting Wealth"](http://rpubs.com/JamisonCrawford/hancock) (Crawford, 2018), is available on the *RPubs* platform. The *R Markdown* script, an `.Rmd` file, is also available in the ["Scripts" Folder](https://github.com/jamisoncrawford/REIS/tree/master/Scripts) of the REIS repository, titled `reis_hancock_publication_*.rmd`, with `*` indicating a 3-figure version ID. *Hancock Renovations* features a variety of tables with variables created within the *R Markdown* script, itself, so all steps in variable transformations are built into the publication. This concept, known as [literate programming](https://en.wikipedia.org/wiki/Literate_programming), is further explained in `README.md`, located in the REIS repository. The following therefore defines any novel variable transformations occurring within the analysis.

## Metadata Tables

The following table corresponds to *Section 4.1: On Demographic Data* and describes the "Master Dataset" in terms of available and missing records, as well as available and missing unique worker data regarding variables `zip code`, `net` (net pay), and `race`.

###  Table 1: Data Overview

* `Unique Payment Records`: Total observations for each pay period across all workers and companies.
* `Unique Workers`: Total number of unique workers when grouped by company `name`, social security number (`ssn`), `title`, `race`, `sex`, and hourly `rate`, as seen in `hancock_master_1.3.r`.
* `Status`: Indicates whether data are "Available" or "Missing", determinind via filtering on `race`, `zip`, and `net` pay.
* `Race`: Total number of `Unique Payment Records` or `Unique Workers` with disclosed `race` data.
  - One unit is equal to one observation.
* `Race (%)`: Proportion of `Unique Payment Records` or `Unique Workers` with disclosed `race` data.
* `Zip Code`: Total number of `Unique Payment Records` or `Unique Workers` with disclosed `zip` code data.
  - One unit is equal to one observation.
* `Zip Code (%)`: Proportion of `Unique Payment Records` or `Unique Workers` with disclosed `zip` code data.
* `Net Pay`: Total number of `Unique Payment Records` or `Unique Workers` with disclosed `net` pay data.
  - One unit is equal to one observation.
* `Net Pay (%)`: Proportion of `Unique Payment Records` or `Unique Workers` with disclosed `net` pay data.

## Tables on Race

The following corresponds to all tables ranging from *Section 4.2: Workers by Race* to *Section 4.11: Net Pay by Race & Company*. These data break down total quantities and proportions of unique workers, pay periods, titles or positions, hourly wages, and net pay conditioned on both race and company and race, alone. 

### Table 2: Unique Workers by Race

* `Unique Workers`: Total number of individual workers identified in *Table 1*, reconditioned on `race`, where `race` data are disclosed.
  - One unit is equal to one worker.
* `Percentage`: Proportion of unique workers conditioned on `race`, where `race` data are disclosed.
  - Percentage determined using unique workers conditioned on `race` as numerator and total unique workers, where `race` data are disclosed, as denominator.

### Table 3: Unique Workers by Race & Company

* `Company`: Expansion of *Table 2* `Unique Workers` and `Percentage` to include further conditioning on company `name`.

### Table 4: Total Weeks Worked by Race

* `Periods`: Total number of payment periods conditioned on `race`.
* `Periods (%)`: Proportion of total payment periods per each `race` compared to total `Periods`.
* `Workers`: Total number of unique workers conditioned on `race`.
* `Workers (%)`: Proportion of total unique workers per each `race` comapred to total `Workers`.  

### Table 5: Total Weeks Worked by Race & Company

No new variables transformations.

### Table 6: Aggregate Titles by Race

Proportions are calculated using the total unique workers in each company (`name`), each `race`, and each `title` as denominators.

* `Title`: Ordinal variable indicating rank, position, or status of unique workers, homogenized/aggregated for uniformity.
  - Categories include, in descending order: "Foreman", "Operator", "Journeyman", "Apprentice", "Unspecified".
  - Variations in original `title` values were homogenized via pattern detection and extraction per the following:
    - "Foreman" derives from "Foreman", "General Foreman", "Subforeman", and "Foreman 2"
    - "Apprentice" derives from "Apprentice 1st Year" or "1st Year Apprentice", "2nd Year Apprentice", etc.
  - Fields indicating `Title` contained mixed values reflecting in part the US Apprenticeship system.
    - I.e., the same field may contain, e.g., "Operator", "Foreman", "Apprentice 2nd Year", and/or "Journeyman"

### Table 7: Titles by Race & Company

* `Total Workers`: Total count of unique workers grouped by company `name`, worker `race`, and worker `title` .
* `Company (%)`: Proportion of company's workers out of `Total Workers` within company.
* `Race (%)`: Proportion of workers with `race` out of `Total Workers` of same `race`, `title`, and `company`.
* `Title (%)`: Proportion of workers with `title` out of `Total Workers` of same `race`, `title`, and `company`.

### Table 8: Summary Statistics of Hourly Wage by Race

* `Minimum`: Lowest hourly `rate` earned among unique workers within each `race`.
* `Median`: Hourly `rate` earned among unique workers within each `race` at 50th percentile.
* `Average`: Average `rate` earned among unique workers within each `race`.
* `Maximum`: Highest hourly `rate` earned among unique workers within each `race`.

### Table 9: Summary Statistics of Hourly Wage by Race & Company

Variable definitions are identical to *Table 8*, albeit further conditioned on both `race` and company `name`.

### Table 10.1: Total Net Earnings by Race

* `Payments`: Total number of pay periods (and, ergo, paychecks), where `race` and `net` are disclosed, for each `race`.
* `Total Net ($)`: Total amount of `net` pay earned, where `race` and `net` are disclosed, for each `race`.
  - Measured in US dollars.
* `Total Net (%)`: Proportion of `net` pay earned, where `race` and `net` are disclosed, for each `race`.
  - Numerator, measured in US dollars, is total `net` earned per `race`.
  - Denominator, measured in US dollars, is total `net` earned among all unique workers.

### Table 10.2: Summary Statistics on Individual Net Payments by Race

Variable definitions are identical to *Table 8*, albeit describing individual `net` payments grouped by `race`.

### Table 11.1: Net Earnings by Race & Company

* `Company Net ($)`: Total `net` earnings per `race` out of total company `net` earnings.
* `Company Net (%)`: Proportion of total `net` earnings per `race` out of total company `net` earnings.
* `Workforce Net (%)`: Proportion of total `net` earnings per `race` out of total `net` earnings among all unique workers.
* `Workers`: Total unique workers per `race` and company `name`.
* `Company (%)`: Proportion of unique workers per `race` among all unique workers within company (`name`).

### Table 11.2 Summary Statistics on Net Pay by Race & Company

Variable definitions are identical to *Table 8*, albeit describing total `net` payments grouped by individual workers and `race`.

## Tables on Location

The following corresponds to all tables ranging from *Section 5.1: Total Workers by County & State* to *Section 5.6: Net Wages by Distance*. These data break down total quantities and proportions of unique workers, worker race, net wages, and individual payments conditioned on county and state, city, Onondaga County, and distance. Tables on net wages typically feature descriptive statistics as well as comparisons, via percentage and raw dollar differences, to Onondaga County workers.

### Table 12: Total Workers by County & State

* `County`: Pennsylvania of New York State county where unique workers reside.
  - Extrapolated by merging disclosed `zip` codes with R packages `zipcode` and `noncensus`.
  - Uses dataset `zipcode` and datasets `zip_code` and `counties` from packages `zipcode` and `noncensus`, respectively.
  - Determined using variable `cfips`, the county FIPS code in `hancock_master_1.3.r`
* `State`: State of worker residence.
  - Extrapolated from `zip` and `sfips` in `hancock_master_1.3.r` in same manner as `County`.
* `Total Workers`: Total unique workers grouped by `County`.
* `Total Workers (%)`: Proportion of total unique workers by `County` out of total unique workers in workforce.

### Table 13.1: Top 10 Cities of Worker Origin

* `City`: One of ten cities where most unique workers reside.
  - Extrapolated from `zip` using R package `zipcode` and dataset `zipcode`.
* `County`: See `County` definition in *Table 12*.
* `State`: See `State` definition in *Table 12*.
* `Total Workers`: See `Total Workers` definition in *Table 12*.
* `Total Workers (%)`: See `Total Workers (%)` definition in *Table 12*.

### Table 14.1: Top 12 Counties of Worker Origin for All Races

* `County`: PA and NY counties representing all minority races, and top 5 counties with greatest total White workers.
* `State`: See `State` definition in *Table 12*.
* `Race`: Worker `race`.
* `Total`: Total unique workers of given `race` and `County`.
* `Race (%)`: Proportion of unique workers of given `race` within given `County`.
* `Workforce (%)`: Proportion of unique workers for each `race` within given `County` out of total workers for each `race`.

### Table 15: Location of Onondaga County Workers by Race

* `Location`: Village, town, or city of workers within Onondaga County.
  - Extrapolated via `zip` codes using R package `zipcode` and dataset `zipcode`.
* `Total`: Total unique workers of each `Race` conditioned on `Location`.
* `Workers in Location (%)`: Proportion of unique workers in `Location` for each `race` out of total workers in `Location`.
* `Race in Location (%)`: Proportion of unique workers in `Location` for each `race` out of total workers in `race`.
* `Workers in County (%)`: Proportion of unique workers in `Location` for each `race` out of total workers in `County`.
* `Total Workforce (%)`: Proportion of unique workers in `Location` for each `race` out of total workers in all counties.

### Table 16.1: Total Workforce Earnings & Average Total Worker Earnings by County

* `County`: See `County` definition in *Table 12*.
* `State`: See `State` definition in *Table 12*.
* `Total Net`: Total `net` earnings per `County` among all unique workers.
* `Total Net (%)`: Proportion of `net` earnings per `County` out of total `net` earnings in all counties.
* `Total Workers`: Total unique workers within each `County`.
* `Total Workers (%)`: Proportion of unique workers within `County` out of total unqiue workers in all counties.
* `Average Net/Worker`: Mean total `net` earnings per unique worker within `County`.
  - Measured in US dollars.
* `Worker Difference`: Raw difference between `Average Net/Worker` in `County` compared to `Average Net/Worker` in Onondaga.
* `Worker Difference (%)`: Percent difference between `Average Net/Worker` in `County` compared to `Average Net/Worker` in Onondaga.
  - Formula: |County Average - Onondaga Average| / ( (County Average + Onondaga Average) / 2 ) * 100
  - I.e., absolute difference in `net` divided by average `net` value; all multiplied by 100

### Table 16.2: Summary Statistics on Total Worker Earnings by County

Variable definitions are identical to *Table 8*, albeit describing total `net` payments per unique worker grouped by `county`.

### Table 16.3 Total Workforce Earnings & Average Net Payment Size by County

Variable definitions are identical to *Table 16.1*, albeit describing individual `net` payments grouped by `county`.

### Table 17: Overview of Earnings & Pay Periods by Distance Ranges from Syracuse

* `Range (Miles)`: Range of Euclidean distance in 25-mile increments between worker `zip` code and Syracuse, NY.
  - Longitude-latitude coordinates for each `zip` extrapolated using R package `zipcode` and dataset `zipcode`.
  - Package `zipcode` uses August, 2004 *CivicSpace Database*, with documentation available on [CRAN: Package zipcode](https://cran.r-project.org/web/packages/zipcode/zipcode.pdf).
  - Syracuse longitude-latitude coordinates provided by *Google*, though varies slightly with other sources.
  - Worker longitude-latitude coordinates from *CivicSpace Database* typically use geographic centroid of *zip* shapefile.
  - Euclidean distance determined using R package `geosphere` and function `distMeeus()`, i.e. the *Meeus Great Circle Distance*.
    - *Meeus Great Circle Distance* function `distMeeus()` available in [Package geosphere documentation](https://cran.r-project.org/web/packages/geosphere/geosphere.pdf)
    - Parameters for greatest equatorial distance and ellipsoid flattening uses default: "WGS-84 Ellipsoid"
    - "WGS-84" is a [fixed radius](https://en.wikipedia.org/wiki/Earth_radius#Fixed_radius) from the World Geodetic System (WGS)
* `Workers`: Total unique workers within `Range (Miles)`.
* `Workers (%)`: Proportion of unique workers within `Range (Miles)` out of total workers in all ranges.
* `Minority`: Total minority workers within `Range (Miles)`.
* `Minority (%)`: Proportion of minority workers within `Range (Miles)` out of total minority workers in all ranges.
* `Weeks`: Total pay periods (`ending`) among all unique workers within `Range (Miles)`.
* `Weeks (%)`: Proportion of pay periods (`ending`) worked within `Range (Miles)` out of total pay periods worked in all ranges.
* `Average Weeks/Worker`: Average pay periods (`ending`) worked per worker within given `Range (Miles)`.
* `Total Net`: Total `net` earnings within given `Range (Miles)`.
* `Total Net (%)`: Proportion of `net` earnings within given `Range (Miles)` out of total `net` earnings by all workers.
* `Average Net/Worker`: Mean `net` earnings within given `Range (Miles)`.

# Master Table

## Overview

The "Master Table", `hancock_master_table_*.csv`, with `*` indicating the version number, may be found in the REIS repository folder, ["Tables"](https://github.com/jamisoncrawford/REIS/tree/master/Scripts), and is comprised of merged tables scraped from employment records, with uniform variables listed below. The merging script, `hancock_master_*.r`, is available in the REIS repository folder: ["Scripts"](https://github.com/jamisoncrawford/REIS/tree/master/Scripts).

## Employee & Company Variables

Employee related variables include:

* `name`: The company or contractor of the employee, partially abbreviated for legibility
* `ssn`: Last four digit of employee social security number
  - In instances where `ssn` is missing, redacted, or illegible, unique combinations of variables `name`, `title`, `position`, `race`, `sex`, `rate`, and `zip` are used to infer `ssn`
  - If `ssn` is missing, redacted, illegible, and uninferrable, a unique ID is provided for distinction, indicated in variable `ssn_sub`
* `title`: Employee position per company specification, partially aligned with the US Apprenticeship system; categories within documentation include:
  - `Journeyman`
  - `Foreman`
  - `General Foreman`
  - `Operator Class 1`
  - `Operator Class A`
  - `Apprentice 1st Year`
  - `Apprentice 2nd Year`
  - `Apprentice 3rd Year`
* `position`: Employee vocation or specialization, e.g. "Sheet Metal Worker"
* `union`: Employee union, partially abbreviated for legibility, and availbale only for company: *Quality Structures, Inc.*
  - If records indicate multiple values of `union`, only the first value was recorded
* `sex`: Employee gender
* `race`: Racial classification of employee per [EEOC taxonomy](https://www.eeoc.gov/eeoc/statistics/employment/jobpat-eeo1/glossary.cfm); categories within documentation include:
  - `White`
  - `Two or More Races`
  - `American Indian or Alaskan`
  - `Black or African American`
* `ssn_sub`: Binary or logical value indicating whether the `ssn` value is missing and substituted with a unique ID for distinction

## Finance- & Time-Related Variables

Finance- and time-related variables include:

* `rate`: Hourly pay of employee
  - In instances of wage increases during the project or in instances where multiple pay rates are provided, the lowest value of `rate` is chosen and competing values are homogenized
  - In rare instances where only overtime (OT) wages are provided, there was no attempt to regularize them
* `net`: The gross amount earned less all deductions during the pay period for the week of `ending` (see below)
* `ending`: The date for the ending of each 7-day payment period in POSIXlt format, i.e. "YYYY-MM-DD"

## Location Variables

Location-related variables include:

* `zip`: The employee zip code provided in each record
  - In instances where zip code is missing, redacted, or illegible, unique combinations of variables `name`, `ssn`, `title`, `position`, `race`, `sex`, and `rate` are used to infer `zip`
  - Only one value of `zip` was uninferrable
  - Derived from 2004 *CivicSpace Database*
* `city`: The city or town of the employee
  - Transformation output of `zip` using 2010 US Census data, stored in R package `noncensus`
* `county`: The county of the employee
  - Transformation output of `zip` using 2010 US Census data FIPS codes, stored in R package `noncensus`
* `state`: The state of the employee
  - Transformation output of `zip` using 2010 US Census data FIPS codes, stored in R package `noncensus`
* `longitude`: The longitude coordinate of the `zip` via R package `zipcode` via R package `noncensus`
* `latitude`: The latitude coordinate of the `zip` via R package `zipcode` via R package `noncensus`
* `sfips`: State FIPS code per R package `noncensus`, derived by merging datasets `zip_codes` and `counties`
* `cfips`: County FIPS code per R package `noncensus`, derived by merging datasets `zip_codes` and `counties`

Additional information on location-related variables are available in CRAN documentation for R packages ["zipcodes"](https://cran.r-project.org/web/packages/zipcode/zipcode.pdf) and ["noncensus"](https://cran.r-project.org/web/packages/noncensus/noncensus.pdf).

## Data Source Variables

These variables are for reference purposes in corroborating scraped variable values with original data sources, as well as additional investigation into particular observations. Original sources are located in REIS repository folders ["Raw Data"](https://github.com/jamisoncrawford/REIS/tree/master/Raw%20Data), ["Rotated PDFs"](https://github.com/jamisoncrawford/REIS/tree/master/Rotated%20PDFs), and ["OCR PDFs"](https://github.com/jamisoncrawford/REIS/tree/master/OCR%20PDFs). Data source variables include:

* `pdf_no`: Indicates the PDF from which the observation derives
  - Typically "1", excepting observations from *Quality Structures, Inc.*
* `pdf_pg`: Indicates the page number in the PDF containing the observation
* `occur`: Indicates the position of the record on the given page, `pdf_pg`, and PDF number, `pdf_no`
  - For example, observation 39, with an `occur` value of "6", references the sixth record on the eigth page (`pdf_pg`) of the first PDF (`pdf_no`) in `danforth_table_1.1.csv`

# Scraped Tables

Scraped tables include all output from both automated scrapes. The variable definitions, processing tasks, units of measurement, and other metadata correspond to the latest versions, also supplied, which may be found in the REIS repository folder: ["Tables"](https://github.com/jamisoncrawford/REIS/tree/master/Tables). Scraping and processing scripts are available in the REIS repository folder: ["Scripts"](https://github.com/jamisoncrawford/REIS/tree/master/Scripts). Lastly, for some tables, `*_narm_**.csv` versions are available, where `*` indicates the company or contractor name and `**` indicates the version number. `*_narm_**.csv` scripts have `NA` values (missing, redacted, or illegible data) replaced with empty cells for ease of import to spreadsheet software. 

## Quality Structures, Inc.

Tables (see ["Tables"](https://github.com/jamisoncrawford/REIS/tree/master/Tables)): 

* `quality_structures_scrape_1.1.csv`

### Related Files

Original PDF files (see ["Raw Data"](https://github.com/jamisoncrawford/REIS/tree/master/Raw%20Data)):

* *quality_structures_1.pdf*
* *quality_structures_2.pdf*
* *quality_structures_3.pdf*

Scripts (see ["Scripts"](https://github.com/jamisoncrawford/REIS/tree/master/Scripts)):

* `quality_structures_scrape_1.6.r`

### Variables

Employee-related variables include:

* `ssn`: Last four digit of employee social security number
* `race`: Racial classification of employee per [EEOC taxonomy](https://www.eeoc.gov/eeoc/statistics/employment/jobpat-eeo1/glossary.cfm); categories within documentation include:
  - `White`
  - `Two or More Races`
  - `American Indian or Alaskan`
  - `Black or African American`
* `sex`: Employee gender
* `position`: Employee position per union classification; categories within documentation include:
  - `Journeyman`
  - `Foreman`
  - `General Foreman`
  - `Operator Class 1`
  - `Operator Class A`
  - `Apprentice 1st Year`
  - `Apprentice 2nd Year`
  - `Apprentice 3rd Year`
* `union`: Employee union
* `eeo`: General employee classification under *EEOC*

Location-related variables include:

* `zip`: Five-digit home zip code of employee
* `city`: Home city of employee determined using R extension `zipcode`
* `state`: Home state of employee determined using R extension `zipcode`
* `latitude`: Home city latitude coordinates determined using R extension `zipcode`
* `longitude`: Home city longitude coordinates determined using R extension `zipcode`

Scraping-related variables:

* `page`: Page number, out of total, where record is located
* `pdf_no`: PDF document number where record is located
* `pdf_pg`: Page number, within PDF, where record is located
* `occur`: Indicates whether observation was first or second record on page
* `string`: Sequence of relevant record text extracted using R extension `magick`, maintained by [ImageMagick](https://www.imagemagick.org/script/index.php), with punctuation removed during preprocessing

## John W. Danforth Company

Tables (see ["Tables"](https://github.com/jamisoncrawford/REIS/tree/master/Tables)):

* `danforth_table_1.0.csv`
* `danforth_table_narm_1.0.csv`

### Related Files

Original PDF files (see ["Raw Data"](https://github.com/jamisoncrawford/REIS/tree/master/Raw%20Data)):

* `danforth_company.pdf`

Post-Scrape files (see ["Manual Scrapes"](https://github.com/jamisoncrawford/REIS/tree/master/Manual%20Scrapes)):

* `danforth_company_manual_scrape_1.0.csv`

Scripts (see ["Scripts"](https://github.com/jamisoncrawford/REIS/tree/master/Scripts)):

* `manual_scrape_edits_multiple_1.0.r`

### Variables

Employee-related variables include:

* `ssn`: Last four digit of employee social security number
* `ending`: End of week of particular employment record
* `class`: Employee pay grade
* `position`: Employee vocation
* `Title`: Employee rank, e.g. "General Foreman" or "Journeyman"
* `Wage`: Gross wage for week of `ending`, including net and deductions (USD)

Location-related variables include:

* `zip`: Five-digit home zip code of employee
* `city`: Home city of employee determined using R extension `zipcode`
* `state`: Home state of employee determined using R extension `zipcode`
* `latitude`: Home city latitude coordinates determined using R extension `zipcode`
* `longitude`: Home city longitude coordinates determined using R extension `zipcode`

Scraping-related variables:

* `pdf_pg`: Page number, within PDF, where record is located
* `occur`: Indicates which observation on `pdf_pg` in ascending order

## Edward Schalk & Son, Inc.

Tables (see ["Tables"](https://github.com/jamisoncrawford/REIS/tree/master/Tables)):

* `schalk_and_son_table_1.2.csv`

### Related Files

Original PDF files (see ["Raw Data"](https://github.com/jamisoncrawford/REIS/tree/master/Raw%20Data)):

* `edward_schalk_and_son.pdf`

Post-Scrape files (see ["Manual Scrapes"](https://github.com/jamisoncrawford/REIS/tree/master/Manual%20Scrapes)):

* `schalk_and_son_manual_scrape_1.0.csv`

Scripts (see ["Scripts"](https://github.com/jamisoncrawford/REIS/tree/master/Scripts)):

* `edward_schalk_and_son_edits_1.0.r`

### Variables

Employee-related variables include:

* `ssn`: Last four digit of employee social security number
* `race`: Racial classification of employee
* `grade`: Employee pay grade
* `sex`: Employee gender
* `vocation`: Employee trade, e.g. "Carpenter"
* `title`: Employee rank, e.g. "Foreman" or "Apprentice"
* `rate`: Hourly wage (USD)
* `net`: Total earnings during week (USD)
* `hours`: Total regular hours worked in reported week
* `ot`: Total overtime hours worked in reported week

Location-related variables include:

* `zip`: Five-digit home zip code of employee
* `city`: Home city of employee determined using R extension `zipcode`
* `state`: Home state of employee determined using R extension `zipcode`
* `latitude`: Home city latitude coordinates determined using R extension `zipcode`
* `longitude`: Home city longitude coordinates determined using R extension `zipcode`

Scraping-related variables:

* `pdf_pg`: Page number, within PDF, where record is located
* `occur`: Indicates which observation on `pdf_pg` in ascending order

## Longhouse Construction LLC

Tables (see ["Tables"](https://github.com/jamisoncrawford/REIS/tree/master/Tables)):

* `longhouse_1.0.csv`
* `longhouse_narm_1.0.csv`

### Related Files

Original PDF files (see ["Raw Data"](https://github.com/jamisoncrawford/REIS/tree/master/Raw%20Data)):

* `longhouse_construction.pdf`

Post-Scrape files (see ["Manual Scrapes"](https://github.com/jamisoncrawford/REIS/tree/master/Manual%20Scrapes)):

* `longhouse_manual_scrape_1.0.csv`

Scripts (see ["Scripts"](https://github.com/jamisoncrawford/REIS/tree/master/Scripts)):

* `manual_scrape_edits_multiple_1.0.r`

### Variables

Employee-related variables include:

* `ssn`: Last four digit of employee social security number
* `race`: Racial classification of employee
* `ending`: End of week of particular employment record
* `sex`: Employee gender
* `class`: Employee rank, e.g. "Foreman" or "Journeyman"
* `exempt`: Employee pay grade
* `ending`: End of week of particular employment record
* `week_wg`: Gross earnings during week of `ending`, including net and deductions (USD)

Location-related variables include:

* `zip`: Five-digit home zip code of employee
* `city`: Home city of employee determined using R extension `zipcode`
* `state`: Home state of employee determined using R extension `zipcode`
* `latitude`: Home city latitude coordinates determined using R extension `zipcode`
* `longitude`: Home city longitude coordinates determined using R extension `zipcode`

Scraping-related variables:

* `pdf_pg`: Page number, within PDF, where record is located
* `occur`: Indicates which observation on `pdf_pg` in ascending order

## Niagara Erecting, Inc.

Tables (see ["Tables"](https://github.com/jamisoncrawford/REIS/tree/master/Tables)):

* `niagara_1.0.csv`
* `niagara_narm_1.0.csv`

### Related Files

Original PDF files (see ["Raw Data"](https://github.com/jamisoncrawford/REIS/tree/master/Raw%20Data)):

* `niagra.pdf`

Post-Scrape files (see ["Manual Scrapes"](https://github.com/jamisoncrawford/REIS/tree/master/Manual%20Scrapes)):

* `niagara_manual_scrape_1.0.csv`

Scripts (see ["Scripts"](https://github.com/jamisoncrawford/REIS/tree/master/Scripts)):

* `manual_scrape_edits_multiple_1.0.r`

### Variables

Employee-related variables include:

* `ssn`: Last four digit of employee social security number
* `ending`: End of week of particular employment record
* `wage`: Total earnings during week of `ending`, including net and deductions (USD)

Location-related variables include:

* `zip`: Five-digit home zip code of employee
* `city`: Home city of employee determined using R extension `zipcode`
* `state`: Home state of employee determined using R extension `zipcode`
* `latitude`: Home city latitude coordinates determined using R extension `zipcode`
* `longitude`: Home city longitude coordinates determined using R extension `zipcode`

Scraping-related variables:

* `pdf_pg`: Page number, within PDF, where record is located
* `occur`: Indicates which observation on `pdf_pg` in ascending order

## NRC NY Environmental Services, Inc.

Tables (see ["Tables"](https://github.com/jamisoncrawford/REIS/tree/master/Tables)):

* `environmental_table_1.0.csv`
* `environmental_table_narm_1.0.csv`

### Related Files

Original PDF files (see ["Raw Data"](https://github.com/jamisoncrawford/REIS/tree/master/Raw%20Data)):

* `nrc_ny_environmental_services.pdf`

Post-Scrape files (see ["Manual Scrapes"](https://github.com/jamisoncrawford/REIS/tree/master/Manual%20Scrapes)):

* `environmental_services_manual_scrape_1.0.csv`

Scripts (see ["Scripts"](https://github.com/jamisoncrawford/REIS/tree/master/Scripts)):

* `manual_scrape_edits_multiple_1.0.r`

### Variables

Employee-related variables include:

* `ssn`: Last four digit of employee social security number
* `ending`: End of week of particular employment record
* `class`: Employee vocation status, including "Laborer" and "Operator"
* `gross`: Total earnings during week of `ending`, including net and deductions (USD)

Location-related variables include:

* `zip`: Five-digit home zip code of employee
* `city`: Home city of employee determined using R extension `zipcode`
* `state`: Home state of employee determined using R extension `zipcode`
* `latitude`: Home city latitude coordinates determined using R extension `zipcode`
* `longitude`: Home city longitude coordinates determined using R extension `zipcode`

Scraping-related variables:

* `pdf_pg`: Page number, within PDF, where record is located
* `occur`: Indicates which observation on `pdf_pg` in ascending order

## Patricia Electric, Inc.

Tables (see ["Tables"](https://github.com/jamisoncrawford/REIS/tree/master/Tables)):

* `patricia_1.0.csv`
* `patricia_narm_1.0.csv`

### Related Files

Original PDF files (see ["Raw Data"](https://github.com/jamisoncrawford/REIS/tree/master/Raw%20Data)):

* `patricia_electric.pdf`

Post-Scrape files (see ["Manual Scrapes"](https://github.com/jamisoncrawford/REIS/tree/master/Manual%20Scrapes)):

* `patricia_manual_scrape_1.0.csv`

Scripts (see ["Scripts"](https://github.com/jamisoncrawford/REIS/tree/master/Scripts)):

* `manual_scrape_edits_multiple_1.0.r`

### Variables

Employee-related variables include:

* `ssn`: Last four digit of employee social security number
* `race`: Racial classification of employee
* `sex`: Employee gender
* `ending`: End of week of particular employment record
* `vocation`: Employee trade, e.g. "Electrician"
* `class`: Employee rank, title, or skill level, including "Foreman", "Journeyman", etc.
* `gross`: Total earnings during week of `ending`, including net and deductions (USD)

Location-related variables include:

* `zip`: Five-digit home zip code of employee
* `city`: Home city of employee determined using R extension `zipcode`
* `state`: Home state of employee determined using R extension `zipcode`
* `latitude`: Home city latitude coordinates determined using R extension `zipcode`
* `longitude`: Home city longitude coordinates determined using R extension `zipcode`

Scraping-related variables:

* `pdf_pg`: Page number, within PDF, where record is located
* `occur`: Indicates which observation on `pdf_pg` in ascending order

## Stone Bridge Iron & Steel, Inc.

Tables (see ["Tables"](https://github.com/jamisoncrawford/REIS/tree/master/Tables)):

* `stone_bridge_1.0.csv`
* `stone_bridge_narm_1.0.csv`

### Related Files

Original PDF files (see ["Raw Data"](https://github.com/jamisoncrawford/REIS/tree/master/Raw%20Data)):

* `stone_bridge_iron_and_steel.pdf`

Post-Scrape files (see ["Manual Scrapes"](https://github.com/jamisoncrawford/REIS/tree/master/Manual%20Scrapes)):

* `stone_bridge_manual_scrape_1.0.csv`

Scripts (see ["Scripts"](https://github.com/jamisoncrawford/REIS/tree/master/Scripts)):

* `manual_scrape_edits_multiple_1.0.r`

### Variables

Employee-related variables include:

* `ssn`: Last four digit of employee social security number
* `race`: Racial classification of employee
* `ending`: End of week of particular employment record
* `vocation`: Employee trade, e.g. "Iron Worker"
* `title`: Employee rank or skill level, all of which are "Journeyman"
* `hourly`: Employee hourly wage (USD)
* `week_wg`: Total earnings during week of `ending`, including net and deductions (USD)

Location-related variables include:

* `zip`: Five-digit home zip code of employee
* `city`: Home city of employee determined using R extension `zipcode`
* `state`: Home state of employee determined using R extension `zipcode`
* `latitude`: Home city latitude coordinates determined using R extension `zipcode`
* `longitude`: Home city longitude coordinates determined using R extension `zipcode`

Scraping-related variables:

* `pdf_pg`: Page number, within PDF, where record is located
* `occur`: Indicates which observation on `pdf_pg` in ascending order
