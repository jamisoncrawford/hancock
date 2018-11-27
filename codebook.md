# Code Book

The following lists the table names, variables, units of measurement if applicable, processing tasks, and definitions for each employment document scraped, as well as the "Master Table", merging and homogenizing variables uniformly where possible.

# Publication

The latest available version of published findings, ["Hancock Renovations: Importing Whites, Exporting Wealth"](http://rpubs.com/JamisonCrawford/hancock) (Crawford, 2018), is available on the *RPubs* platform. The *R Markdown* script, an `.Rmd` file, is also available in the ["Scripts" Folder](https://github.com/jamisoncrawford/REIS/tree/master/Scripts) of the REIS repository, titled `reis_hancock_publication_*.rmd`, with `*` indicating a 3-figure version ID. *Hancock Renovations* features a variety of tables with variables created within the *R Markdown* script, itself, so all steps in variable transformations are built into the publication. This concept, known as [literate programming](https://en.wikipedia.org/wiki/Literate_programming), is further explained in `README.md`, located in the REIS repository. The following therefore defines any novel variable transformations occurring within the analysis.

## Metadata Tables

###  Table 1: Data Overview

### Tables on Race

### Table 2: Unique Workers by Race

### Table 3: Unique Workers by Race & Company

### Table 4: Total Weeks Worked by Race

### Table 5: Total Weeks Worked by Race & Company

### Table 6: Aggregate Titles by Race

### Table 7: Titles by Race & Company

### Table 8: Summary Statistics of Hourly Wage by Race

### Table 9: Summary Statistics of Hourly Wage by Race & Company

### Table 10.1: Total Net Earnings by Race

### Table 10.2: Summary Statistics on Individual Net Payments by Race

### Table 11.1: Net Earnings by Race & Company

### Table 11.2 Summary Statistics on Net Pay by Race & Company

## Tables on Location

### Table 12: Total Workers by County & State

### Table 13.1: Top 10 Cities of Worker Origin

### Table 14.1: Top 12 Counties of Worker Origin for All Races

### Table 15: Location of Onondaga County Workers by Race

### Table 16.1: Total Workforce Earnings & Average Total Worker Earnings by County

### Table 16.2: Summary Statistics on Total Worker Earnings by County

### Table 16.3 Total Workforce Earnings & Average Net Payment Size by County

### Table 17: Overview of Earnings & Pay Periods by Distance Ranges from Syracuse

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
