# Racial Equity Impact Statement
The Racial Equity Impact Statement (REIS) is a joint effort by [Legal Services of Central New York (LSCNY)](https://www.lscny.org/) and the [Urban Jobs Task Force (UJTF)](http://www.ujtf.org/) to provide data-enabled recommendations for employers designed to ameliorate racial disparities in hiring practices for publicly-funded construction projects. 

Variables of interest for each subcontractor document are located in *target_variables.md* in the master repository.

Table names and variable definitions for each document are located in *codebook.md* in the master repository.

## Raw Data

Raw data consist of scanned PDF documents requested via [Freedom of Information Act (FOIA)](https://foia.state.gov/Learn/FOIA.aspx), sometimes referred to as Freedom of Information Law (FOIL), containing employment records for subcontractors in recent Hancock Airport construction work. 

Original PDFs are available in the "Raw Data" folder of the master repository.

## Preprocessing

### PDF Readers

Preprocessing for PDF reader software was conducted using freeware [Foxit PhantomPDF](https://www.foxitsoftware.com/pdf-reader/) for the following tasks:

* Permanent PDF Rotation
* Machine-Readable Conversion via Optical Character Recognition (OCR)

#### File Name Suffixes

Rotated PDFs are available in the "Rotated PDFs" folder of the master repository. File names contain suffix `_r`.
 
Text-readable PDFs are available in the "OCR PDFs" folder of the master repository. File names contain suffix `_rocr`.
 
#### OCR Engine Settings
 
The following parameters were selected using *Foxit PhantomPDF*:

* All Pages
* English
* Searchable Text Image

Foxit PhantomPDF converts each PDF document into machine-readable text manipulable within most PDF readers.

### JPG Images

High-resolution .JPG images were batch-converted via using [ImageMagick](https://www.imagemagick.org/script/index.php) and [Ghostscript](https://www.ghostscript.com/) and are available in the "JPG Images" folder of the master repository.
 
The following parameters were used in the command line:

* **Density:** 400
* **Quality:** 100

The following versions were used with Windows 10 OS:

* *ImageMagick* version 7.0.8-12-Q16-x64
* *Ghostscript* version 9.25, 64-bit

Although these images were not used in the final scraping process, they are preserved for alternative methods of analysis and reproducibility.

## Scraping Process

All scraping procedures were performed in the *RStudio* IDE (version 1.1.456), powered by R (version 3.5.1). *Tidyverse* packages include `readr` for writing data, `dplyr` for data.frame manipulation, `purrr` for flattening list output, and `stringr` for text manipulation. The brunt of the preprocessing, including image conversion and OCR, was performed with the `magick` package, while location data was collected using package `zipcode`.

### Preprocessing

Rotated PDFs are read in from the "Rotated PDFs" folder located in the master repository, converted to images with densities of 300 DPI (dots per inch), converted to text via OCR, and cached for later retrieval.

### Indexing & Extraction

The original location of each record is stored in a variable, as well as index of which record within the raw data corresponds to each extraction to preserve ordering. All punctuation is removed from extracted text, while line breaks are substituted with `%SPLIT%` for subsetting purposes. Further extraction may occur to isolate specific variable data. The most encompassing albeit universally-applicable regular expresssions are used for pattern detection, isolation, and extraction, and refined using a combination of `unique()` function calls to ensure uniformity and `table()` function calls to determine rarity for manual checking.

### OCR Error

Missing values (`NA`) resulting from OCR error are indexed, checked, and corrected manually *if detected*. OCR error proved particularly troublesome with numeric values, e.g. `zip` and `ssn` in [*quality_structures_scrape_1.5.r*](https://github.com/jamisoncrawford/REIS/blob/master/Scripts/quality_structures_scrape_1.5.r). To assess potential error, function `table()` was called and rare values (e.g. $n <= 3$) were visually inspected within the raw data, with confirmed values entered, concatenated, and input manually. 

# Notice

While several measures were taken to ensure accuracy in final output, *results are not 100% reliable* and caution should be taken when using these results for policy-making decisions and elsehow. While data scraping can potentially be very efficient, especially with large documents, using images, regarless of resolution, and optical character recognition (OCR) software does not ensure 100% accuracy, particularly when using information-redacted scans, compared to PDF files, e.g., with embedded texts.
