# Code Book

The following lists the table names, variables, and definitions for each employment document scraped.

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

* 

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

* 

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

* 

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

* 

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

* 

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

* 

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

* 

Location-related variables include:

* `zip`: Five-digit home zip code of employee
* `city`: Home city of employee determined using R extension `zipcode`
* `state`: Home state of employee determined using R extension `zipcode`
* `latitude`: Home city latitude coordinates determined using R extension `zipcode`
* `longitude`: Home city longitude coordinates determined using R extension `zipcode`

Scraping-related variables:

* `pdf_pg`: Page number, within PDF, where record is located
* `occur`: Indicates which observation on `pdf_pg` in ascending order
