# Scrape Manipulation: Hancock Airport
# Organization: Edward Schalk & Son, Inc.
# Version: 1.2

# VERSIONS & DATE

# R Version: 3.5.1
# RStudio Version: 1.1.456
# Date: 2018-10-29

# CLEAR WORKSPACE; LOAD PACKAGES

rm(list = ls())

if(!require(readr)){install.packages("readr")}
if(!require(dplyr)){install.packages("dplyr")}
if(!require(stringr)){install.packages("stringr")}
if(!require(zipcode)){install.packages("zipcode")}

library(readr)
library(dplyr)
library(stringr)
library(zipcode)

# READ IN MANUAL SCRAP CSV

url <- "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Manual%20Scrapes/schalk_and_son_manual_scrape_1.1.csv"

dat <- read_csv(url)                                                           # Read in data

rm(url)                                                                        # Remove obsolete

# MERGE LOCATION DATA

data(zipcode)

dat <- dat %>% 
  mutate_at(.vars = c("ssn", "zip"), .funs = as.character) %>%                 # Coerce variable classes
  mutate_at(.vars = c("race", "sex", "vocation", "title", "grade"), .funs = as.factor) %>%
  left_join(zipcode) %>%                                                       # Merge location data
  select(ssn:title, grade:ot, zip, city:longitude, pdf_pg:occur) %>%           # Reorder variables
  arrange(pdf_pg, occur)                                                       # Arrange by page, occurrence

# CORRECTIONS: MISSING DATA & VALUE FREQUENCY

index <- which(is.na(dat$city))                                                # Index missing city values
ssn <- as.character(dat[index, "ssn"])                                         # Determine ssn
match <- which(dat$ssn == "7702")                                              # Index ssn matches

table(dat$zip[match])                                                          # Determine fix

fix <- zipcode[which(zipcode$zip == "13209"), ]
dat[index, 11:15] <- fix                                                       # Apply fix

rm(fix, zipcode, index, match, ssn)

# WRITE TO CSV

write_csv(dat, "schalk_and_son_1.2.csv")
