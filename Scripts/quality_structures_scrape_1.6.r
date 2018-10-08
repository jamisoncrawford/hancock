# PDF Scraper: Hancock Airport
# Organization: Quality Scructures
# Version: 1.6

# Versions & Date

# R Version: 3.5.1
# RStudio Version: 1.1.456
# Date: 2018-10-05

# CLEAR WORKSPACE; LOAD PACKAGES

rm(list = ls())

if(!require(readr)){install.packages("readr")}
if(!require(dplyr)){install.packages("dplyr")}
if(!require(purrr)){install.packages("purrr")}
if(!require(magick)){install.packages("magick")}
if(!require(stringr)){install.packages("stringr")}
if(!require(zipcode)){install.packages("zipcode")}

library(readr)
library(dplyr)
library(purrr)
library(magick)
library(stringr)
library(zipcode)


# READ IN PDFs; CONVERT TO IMAGES; CONVERT TO TEXT (OCR); CACHE TEXT

url1 <- "https://github.com/jamisoncrawford/REIS/raw/master/Rotated%20PDFs/quality_structures_1_r.pdf"
url2 <- "https://github.com/jamisoncrawford/REIS/raw/master/Rotated%20PDFs/quality_structures_2_r.pdf"
url3 <- "https://github.com/jamisoncrawford/REIS/raw/master/Rotated%20PDFs/quality_structures_3_r.pdf"

img1 <- image_read_pdf(url1, density = 300)                       # Convert to image
img2 <- image_read_pdf(url2, density = 300)
img3 <- image_read_pdf(url3, density = 300)

txt1 <- image_ocr(img1)                                           # Convert to text
txt2 <- image_ocr(img2)
txt3 <- image_ocr(img3)

txt <- c(txt1, txt2, txt3)                                        # Merge text data

save(txt, file = "quality_structures_text.rds")                   # Cache text data

rm(img1, img2, img3, txt1, txt2, txt3, url1, url2, url3)          # Remove obsolete

# RELOAD DATA, IF NECESSARY

load("quality_structures_text.rds")

# EXTRACT RELEVANT TEXT BY PAGE

txt <- txt %>%
  str_replace_all(pattern = "[:punct:]", replacement = "") %>%    # Remove punctuation
  str_replace_all(pattern = "\n", replacement = " %SPLIT% ")      # Replace breaks: " %SPLIT% "

dat <- txt %>% 
  str_extract_all(pattern = "[xX]{1,}.{40,140}Check", simplify = TRUE) %>% 
  as_data_frame() %>% 
  rename(first = V1, second = V2) %>%
  mutate(page = row_number(),                                     # Initialize page indices
         pdf_no = NA,
         pdf_pg = NA)

for (i in seq_along(dat$page)){
  if (dat$page[i] <= 129){
    dat$pdf_no[i] <- 1
    dat$pdf_pg[i] <- i
  } else if (dat$page[i] >= 130 & dat$page[i] <= 258){
    dat$pdf_no[i] <- 2
    dat$pdf_pg[i] <- i - 129
  } else if (dat$page[i] >= 259){
    dat$pdf_no[i] <- 3
    dat$pdf_pg[i] <- i - 258
  }
}

# SPLIT & STACK INDEXED TABLES

tb1 <- select(dat, first, page:pdf_pg) %>% rename(string = first) %>% mutate(occur = 1)
tb2 <- select(dat, second, page:pdf_pg) %>% rename(string = second) %>% mutate(occur = 2)
dat <- bind_rows(tb1, tb2) %>% arrange(page, occur)

dat <- dat[which(dat$string != ""), ]                                          # Remove empty strings

rm(i, tb1, tb2, txt)

dat[41, "string"] <- paste0(str_split(dat[41, "string"],          
                                      pattern = " %SPLIT% ", 
                                      simplify = TRUE)[3:5], collapse = " ")   # Manual correction

# EXTRACT SSN

ssn <- map(str_split(string = dat$string, pattern = " %SPLIT% "), 1) %>%
  str_replace_all(pattern = "[xX]*", replacement = "") %>%                     # Incremental isolation
  str_replace_all(pattern = "ME.*$|MIE.*$", replacement = "") %>%
  str_replace_all(pattern = "[a-zA-Z]| |<|>|~|\\|", replacement = "") %>%
  str_extract(pattern = "(\\d){4}")

dat$ssn <- ssn                                                                 # Merge

rm(ssn)

# MANUAL CORRECTIONS: MISSING SSN VALUES

index <- which(is.na(dat$ssn))                                                 # Index missing values
print(dat[index, 3:5], n = 40)

new <- c("7981", "0095", "0497", "9145", "8035", "2078", "1700", "4074", "2085", "4074", 
         "9784", "0497", "0497", "4128", "2133", "2002", "7981", "4341", "0095", "1700", 
         "3712", "4674", "4341", "0497", "0497", "0095", "0079", "2133", "4034", "1390",
         "7738", "1390", "4000", "9585", "3906", "9784", "1829", "6155", "2002", "2495")

for (i in seq_along(new)){dat$ssn[index][i] <- new[i]}                         # Replace missing values

# MANUAL CORRECTIONS: RARE SSN VALUES

ssn <- as_data_frame(table(dat$ssn)) %>% arrange(n)                            # Index instances < 4
ssn <- ssn$Var1[1:45]

index <- which(dat$ssn %in% ssn)
dat[index, 3:5]


new <- c("3712", "1390", "8035", "4128", "6366", "2495", "1017", "1017", "1017", "3555", 
         "4341", "8607", "9976", "3423", "4373", "4000", "1017", "3423", "4373", "3877", 
         "3423", "7881", "6977", "3712", "6155", "8107", "6286", "4034", "9585", "4373", 
         "7881", "0966", "8186", "8607", "6019", "2237", "4944", "5681", "0966", "7718", 
         "3906", "8186", "2133", "8607", "1793", "5496", "8025", "6019", "2237", "4944", 
         "5681", "9585", "6977", "2085", "8025", "6977", "3131", "6366", "8035", "2495", 
         "5113", "7025", "6155", "5496", "6977", "7025", "6155")

sum(as.vector(dat$ssn[which(dat$ssn %in% ssn)]) != new)/67                     # 53.7% OCR error

for (i in seq_along(new)){                                                     # Replace values
  dat$ssn[index][i] <- new[i]
}

rm(ssn)

# EXTRACT RACE

race <- map(str_split(string = dat$string, pattern = " %SPLIT% "), 1) %>% 
  unlist() %>%
  str_sub(start = -7, end = -1)

old <- c(".*Races.*",         ".*can.*|.*can.*",           ".*te.*", ".*ian.*", "0 28017| MNVhKe|m wwwue| wwme 1|x MW|n Check")
new <- c("Two or More Races", "Black or African American", "White",  "American Indian or Alaskan", NA)

for (i in seq_along(old)){
  race <- str_replace_all(string = race, pattern = old[i], replacement = new[i])
}

dat$race <- race                                                               # Merge
index <- which(is.na(dat$race))
dat$race[index] <- "White"                                                     # Manual correction

rm(race, new, old)

# EXTRACT ZIP

zip <- map(str_split(string = dat$string, pattern = " %SPLIT% "), 3) %>%
  str_replace_all(pattern = "[^0-9]| ", replacement = "")

for (i in seq_along(zip)){
  if (nchar(zip[i]) == 4 ){
    zip[i] <- paste0("1", zip[i])
  } else if (nchar(zip[i]) > 5){
    zip[i] <- str_sub(zip[i], start = -5, end = -1)
  }
}

index <- which(nchar(zip) == 3)
correct <- c("13207", "16936", "14432")
for (i in 1:3){zip[index][i] <- correct[i]}                                    # Manual correction

zip[which(nchar(zip) <= 2)] <- NA
dat$zip <- zip                                                                 # Merge

rm(correct, i, index, zip)

# EXTRACT EEO

eeo <- map(str_split(string = dat$string, pattern = " %SPLIT% "), 3) %>%
  str_extract(pattern = "EEO.*Check") %>%
  str_replace_all(pattern = "EEO|Check| ", replacement = "")

old <- c("ADPFBMiCE",  "Joumeyman")
new <- c("Apprentice", "Journeyman")

for (i in 1:2){
  eeo <- str_replace_all(string = eeo, pattern = old[i], new[i])
}

eeo[which(eeo == "")] <- "None"                                                # Explicitly missing

dat$eeo <- eeo                                                                 # Merge

rm(eeo, i, new, old)

# MANUAL CORRECTIONS: MISSING EEO CLASS

index <- which(is.na(dat$eeo))
dat[index, ]

dat$eeo[index] <- "Journeyman"

# EXTRACT UNION

union <- map(str_split(string = dat$string, pattern = " %SPLIT% "), 2) %>%
  str_sub(start = 1, end = 15) %>%
  str_trim(side = "both") %>%
  str_replace_all(pattern = "W |m |1|NULL", replacement = "")

old <- c(".*ester Mas.*",             ".*vania C.*",             ".*ing Car,*",              ".*ester Lab.*", 
         ".*ester Op.*|.*esterOpe.*", ".*ira Lab.*",             ".*cuse Ope.*",             ".*cuse Lab.*", 
         ".*cuse Car.*",              ".*aca Car.*",             ".*ightLoc.*|.*ight Loc.*", ".*pire Sta.*", 
         ".*bany Car.*",              ".*mton Car.*",            ".*cuse Mas.*",             ".*mton Lab.*")

new <- c("Rochester Masons",          "Pennsylvania Carpenters", "Corning Carpenters",       "Rochester Laborers", 
         "Rochester Operators",       "Elmira Laborers",         "Syracuse Operators",       "Syracuse Laborers",
         "Syracuse Carpenters",       "Ithaca Carpenters",       "Millwright Local 1163",    "Empire State-Sullivan", 
         "Albany Carpenters",         "Binghamton Carpenters",   "Syracuse Masons",          "Binghamton Laborers")

for (i in seq_along(old)){
  union <- str_replace_all(string = union, pattern = old[i], replacement = new[i])
}

index <- which(union == "")
correct <- c("Elmira Laborers", "Syracuse Laborers")

for (i in 1:2){union[index][i] <- correct[i]}                                  # Manual Correction

dat$union <- union                                                             # Merge

rm(correct, i, index, new, old, union)

dat$union <- str_replace_all(string = dat$union, 
                             pattern = "^Corning Carp.*", 
                             replacement = "Corning Carpenters")               # Minor fix

# EXTRACT POSITION

position <- map(str_split(string = dat$string, pattern = " %SPLIT% "), 2) %>%
  str_sub(start = -14, end = -1) %>%
  str_trim(side = "both") %>%
  str_replace_all(pattern = "American|Alaskan", replacement = "")

old <- c(".*yman.*|man  1|man  i|NULL", ".*eral.*",            ".*orema.*",            ".*1st.*|.*1 st.*", 
         ".*2nd.*",                     ".*3rd.*",             ".*lass A$|.*lass A.*", ".*lass 1$|.*lass 1.*|.*lass1.*|.*3551$")
new <- c("Journeyman",                  "General",             "Foreman",              "Apprentice 1st Year", 
         "Apprentice 2nd Year",         "Apprentice 3rd Year", "Operator Class A",     "Operator Class 1")

for (i in seq_along(old)){
  position <- str_replace_all(position, pattern = old[i], replacement = new[i])
}

position[which(position == "1")] <- "Journeyman"                               # Manual Correction
position[which(position == "General")] <- "General Foreman"

dat$position <- position                                                       # Merge

rm(i, new, old, position)

# APPEND GENDER (ALL MALE)

dat$sex <- "Male"                                                              # Append

# MANUAL CORRECTIONS: 15 LEAST COMMON ZIP CODES

zip <- as_data_frame(table(dat$zip)) %>% arrange(n) %>% head(12)
zip <- as_vector(zip[,1])
which(dat$zip %in% zip)                                                        # Index

new <- c("13208", "13219", "13165", "13126", "13202", 
         "13165", "14422", "13132", "13036", "13030", 
         "13036", "16936", "16933", "13030", "16901")

index <- which(dat$zip %in% zip)

for (i in seq_along(new)){
  dat$zip[index][i] <- new[i]
}                                                                              # Correction

rm(i, index, new, zip)

# MANUAL CORRECTIONS: MISSING ZIP VALUES

index <- which(is.na(dat$zip))                                                 # Index rows
print(dat[index, 3:5], n = 60)

new <- c("14825", "16932", "16933", NA,      "14873", "13224", "16933", "16933", "13795", "13204", 
         "14432", "13044", "13032", "13165", "14825", "13084", "13069", "14489", "13044", "13211", 
         "14839", "13045", "13045", "12175", "13493", "13069", "13219", "13224", "13069", "13045", 
         "13082", "14456", "13084", "13208", "14489", "13126", "14873", "13069", NA,      NA, 
         NA,      NA,      NA,      NA,      NA,      NA,      NA,      NA,      NA,      NA, 
         NA,      NA,      NA,      NA,      "14816", "14432", "13069", "13045", "17771", "13145")

dat$zip[index] <- new                                                          # Merge

rm(index, new)

# DETERMINE LOCATION BY ZIP

data(zipcode)                                                                  # Load database

dat$city <-  NULL                                                              # Initialize variables
dat$state <- NULL

dat <- left_join(dat, zipcode)                                                 # Merge zip data

rm(zipcode)

# ASSIGN CLASSES; ARRANGE VARIABLES

dat$race <- as.factor(dat$race) 
dat$eeo <- as.factor(dat$eeo)
dat$position <- as.factor(dat$position)
dat$sex <- as.factor(dat$sex)
dat$state <- as.factor(dat$state)

dat <- dat %>% select(ssn:race, sex:position, union:eeo, zip, 
                      city:longitude, page:occur, string)

# WRITE TABLE TO .CSV: `DAT`

write_csv(x = dat, "quality_structures_scrape.csv")

# RAW DATA VS. SCRAPE ACCURACY CHECK

url <- "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Review%20Tables/quality_structures_scrape_check_1.0.csv"

chk <- read_csv(url)                                                           # Read check table

col <- which(str_detect(names(chk), "_correct$"))                              # Detect, index inaccuracies
for (i in seq_along(col)){print(which(!is.na(chk[, col[i]])))}
names(chk)[col[1:2]]

ssn_index <- which(!is.na(chk$ssn_correct))                                    # Index inaccurate variables
zip_index <- which(!is.na(chk$zip_correct))

rm(i, col, url)

# RESTORE MISSING RECORD

chk[ssn_index, c(1:5, 18)]                                                     # Determine missing record

fix <- c("2078", "White", "Male", "Apprentice 1st Year", "Ithaca Carpenters", 
         "Apprentice", "16933", NA, NA, NA, NA, 344, 3, 86, 2, NA)

rec <- nrow(dat) + 1

dat[rec, ] <- fix                                                              # Assign missing record values     

rm(fix, ssn_index)                                                             # Remove obsolete objects

zip <- dat$zip[rec]                                                            # Store new zip code

data(zipcode)
new <- zipcode[which(zipcode$zip == zip), ]                                    # Pull location data

dat[rec, 8:11] <- new[, 2:5]                                                   # Store location data

rm(new, rec, zip)

# CORRECT ZIP CODES

zip_index <- zip_index[1:2]                                                    # Index corrections

dat[zip_index, 7] <- chk[zip_index, 7]                                         # Replace zip codes
dat[zip_index, 8:11] <- NA                                                     # Remove former location data

index <- rev(which(zipcode$zip %in% dat$zip[zip_index]))                       # Index new location data
for (i in 1:2){dat[zip_index[i], 8:11] <- zipcode[index[i], 2:5]}              # Replace location data

rm(chk, zipcode, i, index, zip_index)

# REARRANGE BY PAGE & OCCURENCE

col <- c("page", "pdf_no", "pdf_pg", "occur")
dat <- dat %>% mutate_at(.vars = col, .funs = as.integer) %>%                  # Coerce and rearrange
  arrange(page, occur)

rm(col)

# WRITE TABLE TO .CSV: `DAT`

write_csv(x = dat, "quality_structures_scrape_1.1.csv")
