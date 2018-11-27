# Racial Equity Impact Statement
The Racial Equity Impact Statement (REIS) is a joint effort by [Legal Services of Central New York (LSCNY)](https://www.lscny.org/) and the [Urban Jobs Task Force (UJTF)](http://www.ujtf.org/) to provide data-enabled recommendations for employers designed to ameliorate racial disparities in hiring practices for publicly-funded construction projects. 

Variables of interest for each subcontractor document are located in *target_variables.md* in the master branch.

Table names and variable definitions for each document are located in *codebook.md* in the master branch.

## Raw Data

Raw data consist of scanned PDF documents requested via [Freedom of Information Act (FOIA)](https://foia.state.gov/Learn/FOIA.aspx), sometimes referred to as Freedom of Information Law (FOIL), containing employment records for subcontractors in recent Hancock Airport construction work. 

Original PDFs are available in the "Raw Data" folder of the master branch.

## Preprocessing

### PDF Readers

Preprocessing for PDF reader software was conducted using freeware [Foxit PhantomPDF](https://www.foxitsoftware.com/pdf-reader/) for the following tasks:

* Permanent PDF Rotation
* Machine-Readable Conversion via Optical Character Recognition (OCR)

#### File Name Suffixes

Rotated PDFs are available in the "Rotated PDFs" folder of the master branch. File names contain suffix `_r`.
 
Text-readable PDFs are available in the "OCR PDFs" folder of the master branch. File names contain suffix `_rocr`.
 
#### OCR Engine Settings
 
The following parameters were selected using *Foxit PhantomPDF*:

* All Pages
* English
* Searchable Text Image

Foxit PhantomPDF converts each PDF document into machine-readable text manipulable within most PDF readers.

### JPG Images

High-resolution .JPG images were batch-converted via using [ImageMagick](https://www.imagemagick.org/script/index.php) and [Ghostscript](https://www.ghostscript.com/) and are available in the "JPG Images" folder of the master branch.
 
The following parameters were used in the command line:

* **Density:** 400
* **Quality:** 100

The following versions were used with Windows 10 OS:

* *ImageMagick* version 7.0.8-12-Q16-x64
* *Ghostscript* version 9.25, 64-bit

Although these images were not used in the final scraping process, they are preserved for alternative methods of analysis and reproducibility.

## Automated Scraping Process

All scraping procedures were performed in the *RStudio* IDE (version 1.1.456), powered by R (version 3.5.1). *Tidyverse* packages include `readr` for writing data, `dplyr` for data.frame manipulation, `purrr` for flattening list output, and `stringr` for text manipulation. The brunt of the preprocessing, including image conversion and OCR, was performed with the `magick` package, while location data was collected using package `zipcode`.

### Preprocessing

Rotated PDFs are read in from the "Rotated PDFs" folder located in the master repository, converted to images with densities of 300 DPI (dots per inch), converted to text via OCR, and cached for later retrieval.

### Indexing & Extraction

The original location of each record is stored in a variable, as well as index of which record within the raw data corresponds to each extraction to preserve ordering. All punctuation is removed from extracted text, while line breaks are substituted with `%SPLIT%` for subsetting purposes. Further extraction may occur to isolate specific variable data. The most encompassing albeit universally-applicable regular expresssions are used for pattern detection, isolation, and extraction, and refined using a combination of `unique()` function calls to ensure uniformity and `table()` function calls to determine rarity for manual checking.

### OCR Error: Numeric Data

Missing numeric values (`NA`) resulting from OCR error are indexed, checked, and corrected manually *if detected*. Emphasis was placed on particular variables which were obstructed via redaction in preprocessing, e.g. `zip` in [*quality_structures_scrape_1.5.r*](https://github.com/jamisoncrawford/REIS/blob/master/Scripts/quality_structures_scrape_1.6.r). To assess potential error, function `table()` was called and values with uncommon frequencies (n < 4) were visually inspected within the raw data, with confirmed values entered, concatenated, and input manually. 

### OCR Error: Character Data

Missing character values (`NA`) where treated similarly to numeric data. Values cleaned using regular expressions and calls to function `unique()` to determine the most encompassing and distinguishing regular expressions. Low-frequency character values detected with `table()` were visually inspected within the raw data, with confirmed values entered, concatenated, and input manually. Categorical variables were coerced to factors where appropriate.

## Manual Scraping Process

Rotated PDFs, available in the "Rotated PDFs" folder, are visually inspected, while variables of interest are recorded in *Excel*. Additional variables, apart from those targeted, are included and defined in *codebook.md*, located in the master branch of the present repository. Each PDF page and occurrence number are checked between page transitions to ensure alignment.

## Accuracy

The following addresses the variable detection accuracy for each document scrape. Using the above treatment of OCR error detection, data were then visually inspected using a paired reviewing process in which the analyst reads each data point in each record, variable-wise, and an assistant confirms whether each datum was correct.

### Quality Structures, Inc.

Of the 607 employee records, 606 were detected. Review determined the missing record, which has been corrected. Discounting said record, all variable values scraped were correct except variable `zip`, which contained 2 errors (99.67% accuracy). A total of 7 extracted variables, at 606 instances each, resulted in 4,242 data points, with 4,240 correct, resulting in a total accuracy of 99.95%.

Following review, all output in *quality_structures_scrape_1.1.csv*, located in the "Tables" folder, are 100% accurate.

### All Other Employers

Remaining documentation, excluding "Quality Strictires, Inc.", remains to undergo paired review for accuracy; to be determined.

## Scraped Table Modifications

All manually scraped data are stored in the "Manual Scrapes" folder of the present repository. Some variables were further processed for each dataset within R, which is documented in the "Scripts" folder. Principally, data underwent the following modifications:

* Summing `net` and `deduction` variables to determine gross wages for the pay period (`ending`)
* Summing `st` (regular or standard) and `ot` (overtime) values to determine gross wages for the pay period (`ending`)
* Merging `zip` values with the `zipcode` database, an R package, to determine `city`, `state`, `latitude`, and `longitude`
* Writing `na.rm` versions of tables (see "Tables") in which missing values (`NA`) are replaced with empty cells
* Rearranging variables in order of:
  - Employee demographic data
  - Employee compensation data
  - Employee location data
  - Record data, e.g. `pdf_pg`

## Caveats

**Automatic Numeric Conversion:** When importing .csv files into *Microsoft Excel* or other spreadsheet software, it may automatically convert character values into numeric values. If those values begin with one or more leading zeroes ("0"), e.g. `ssn` in *quality_structures_scrape_1.1.csv*, they will be removed automatically. It is strongly advised that users ensure automatic formatting for numeric data is disabled in their spreadsheet software, or else users ensure that converted values are reverted back to character format and leading zeroes are appended.

**Accuracy:** All manually scraped documents, i.e. all barring *quality_structures_scrape_1.1.csv*, remain to be reviewed by a third party for accuracy. Use these data judiciously until it is confirmed that they have been reviewed. It may be assumed that all, if not the vast majority of manually scraped data are accurate, however.

## Contributors

The following individuals contributed to this project in the manner described below:

* **Jamison Crawford, MPA:** Principal analyst.
* **Andrew Croom, JD:** Retrieved and manually organized all raw data, as well as provided variables of interest.
* **Shannon Connor, MA:** Assisted in all paired data inspection and corroboration processes.
* **Legal Services of Central New York:** Co-creator of the Racial Equity Impact Statement (REIS).
* **Urban Jobs Task Force:** Co-creator of the Racial Equity Impact Statement (REIS).
* **Central New York Community Foundation:** *Community Data Meetings.* Facilitating volunteer recruitment, peer review.
