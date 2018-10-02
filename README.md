# Racial Equity Impact Statement
The Racial Equity Impact Statement (REIS) is a joint effort by [Legal Services of Central New York (LSCNY)](https://www.lscny.org/) and the [Urban Jobs Task Force (UJTF)](http://www.ujtf.org/) to provide data-enabled recommendations for employers designed to ameliorate racial disparities in hiring practices for publicly-funded construction projects. 

Variables of interest for each subcontractor document are located in *target_variables.md*.

## Raw Data

Raw data consist of scanned PDF documents requested via [Freedom of Information Act (FOIA)](https://foia.state.gov/Learn/FOIA.aspx), sometimes referred to as Freedom of Information Law (FOIL), containing employment records for subcontractors in recent Hancock Airport construction work. 

Original PDFs are available in the "Raw Data" folder of the master repository.

## Preprocessing

Preprocessing was conducted using freeware [Foxit PhantomPDF](https://www.foxitsoftware.com/pdf-reader/) for the following tasks:

* Permanent PDF Rotation
* Text-Readable Conversion via Optical Character Recognition (OCR)

### File Suffixes

Rotated PDFs are available in the "Rotated PDFs" folder of the master repository. File names contain suffix `_r`.
 
Text-readable PDFs are available in the "OCR PDFs" folder of the master repository. File names contain suffix `_rocr`.
 
### OCR Engine Settings
 
The following parameters were selected using Foxit PhantomPDF:

* All Pages
* English
* Searchable Text Image
