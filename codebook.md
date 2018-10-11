# Code Book

The following lists the table names, variables, and definitions for each employment document scraped.

## Quality Structures, Inc.

**Table Name:** `quality_structures_scrape.csv`

### Related Files

Original PDF files:

* *quality_structures_1.r*
* *quality_structures_2.r*
* *quality_structures_3.r*

Post-OCR files:

* *quality_structures_text.rds*

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

Employee-related variables include:

* 

Location-related variables include:

* 

Scraping-related variables:

* 

## Edward Schalk & Son, Inc.

Employee-related variables include:

* 

Location-related variables include:

* 

Scraping-related variables:

* 

## Longhouse Construction LLC

Employee-related variables include:

* 

Location-related variables include:

* 

Scraping-related variables:

* 

## Niagara Erecting, Inc.

Employee-related variables include:

* 

Location-related variables include:

* 

Scraping-related variables:

* 

## NRC NY Environmental Services, Inc.

Employee-related variables include:

* 

Location-related variables include:

* 

Scraping-related variables:

* 

## Patricia Electric, Inc.

Employee-related variables include:

* 

Location-related variables include:

* 

Scraping-related variables:

* 

## Stone Bridge Iron & Steel, Inc.

Employee-related variables include:

* 

Location-related variables include:

* 

Scraping-related variables:

* 
