# Master Table: Hancock Airport

# VERSIONS & DATE

## Script Version: 1.4
## R Version: 3.5.1
## RStudio Version: 1.1.456
## Date: 2018-11-09

# CLEAR WORKSPACE; LOAD PACKAGES & DATA

rm(list = ls())

if(!require(plyr)){install.packages("plyr")}
if(!require(readr)){install.packages("readr")}
if(!require(dplyr)){install.packages("dplyr")}
if(!require(tidyr)){install.packages("tidyr")}
if(!require(stringr)){install.packages("stringr")}
if(!require(zipcode)){install.packages("zipcode")}
if(!require(lubridate)){install.packages("lubridate")}
if(!require(noncensus)){install.packages("noncensus")}

library(plyr)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(zipcode)
library(lubridate)
library(noncensus)

# READ IN TABLES

urls <- c("https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Tables/danforth_table_1.1.csv",
          "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Tables/environmental_table_1.1.csv",
          "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Tables/longhouse_1.1.csv",
          "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Tables/niagara_1.1.csv",
          "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Tables/patricia_1.1.csv",
          "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Tables/stone_bridge_1.1.csv",
          "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Tables/schalk_and_son_1.2.csv",
          "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Tables/quality_structures_scrape_1.1.csv")

name <- c("danfo", "envir", "longh", "niagr", "patri", "stone", "sands", "quali") # List names
for (i in seq_along(name)){assign(x = name[i], read_csv(file = urls[i]))}         # Read in and assign names
rm(i, name, urls)                                                                 # Remove obsolete

# ADDITIONAL CLEAN; UNIFY VARIABLE NAMES & CLASSES

## Danforth Company

danfo$ending <- mdy(danfo$ending)
danfo$net <- str_replace_all(string = danfo$net, 
                             pattern = "\\$|\\,", 
                             replacement = "") %>% as.numeric()
danfo <- danfo %>% select(ssn, position:title, net, ending:zip, city:occur)
danfo$name <- as.factor("John W. Danforth Company")
danfo$state <- as.factor(danfo$state)
danfo$zip <- as.factor(danfo$zip)
danfo$title <- as.factor(danfo$title)
danfo$rate <- NA
danfo$ssn <- str_pad(string = danfo$ssn, width = 4, side = "left", pad = 0)
danfo$sex <- NA
danfo$race <- NA
danfo$pdf_no <- 1
danfo$union <- NA

## Environmental Services

envir$ending <- mdy(envir$ending)
names(envir)[2] <- "position"
envir$position <- as.factor(envir$position)
envir$zip <- as.factor(envir$zip)
envir$state <- as.factor(envir$state)
envir$ssn <- str_pad(envir$ssn, width = 4, "left", pad = 0)
envir <- envir %>% select(-gross)
envir$rate <- NA
envir$title <- NA
envir$sex <- NA
envir$race <- NA
envir$name <- as.factor("Environmental Services")
envir$pdf_no <- 1
envir$union <- NA

## Longhouse Construction

longh$ssn <- as.character(longh$ssn)
names(longh)[2] <- "title"
longh$sex <- as.factor(longh$sex)
longh$race <- as.factor(longh$race)
longh$zip <- as.factor(longh$zip)
longh$state <- as.factor(longh$state)
longh <- longh %>% select(-week_wg, -exempt)
longh$ending <- mdy(longh$ending)
longh$name <- as.factor("Longhouse Construction")
longh$net <- str_replace_all(string = longh$net, 
                             pattern = "\\$|\\,", 
                             replacement = "") %>% as.numeric()
longh$position <- NA
longh$rate <- as.numeric(c(32.00, 34.00, 17.00, 32.00, 32.00, 34.00, 
                           17.00, 32.00, 32.00, 32.00, 29.00, 34.00, 
                           17.00, 32.00, 32.00, 29.00, 34.00, 17.00, 
                           32.00, 29.00, 34.00, 17.00))
longh$pdf_no <- 1
longh$union <- NA

## Niagara Erecting

niagr$ssn <- str_pad(string = niagr$ssn, width = 4, 
                     side = "left", pad = 0) %>% as.character()
niagr$ending <- mdy(niagr$ending)
niagr$zip <- as.factor(niagr$zip)
niagr$state <- as.factor(niagr$state)
niagr <- niagr %>% select(-wage)
niagr$position <- NA
niagr$title <- NA
niagr$rate <- NA
niagr$net <- NA
niagr$race <- NA
niagr$sex <- NA
niagr$pdf_no <- 1
niagr$name <- as.factor("Niagara Erecting")
niagr$union <- NA

## Patricia Electric

patri$ssn <- str_pad(string = patri$ssn, width = 4, 
                     side = "left", pad = 0) %>% as.character()
patri$race <- as.factor(patri$race)
patri$sex <- as.factor(patri$sex)
names(patri)[4:5] <- c("position", "title")
patri$position <- as.factor(patri$position)
patri$title <- as.factor(patri$title)
patri <- patri %>% select(-gross)
patri$zip <- as.factor(patri$zip)
patri$state <- as.factor(patri$state)
patri$pdf_no <- 1
patri$rate <- NA
patri$ending <- mdy(patri$ending)
patri$union <- NA
patri$name <- as.factor("Patricia Electric")
patri$net <- as.numeric(c(614.79,  1419.05, 678.31,  1496.43, 1197.49, 963.93, 
                          1231.99, 465.08,  1125.26, 1246.96, 730.55,  1717.65, 
                          807.09,  1572.32, 1444.52, 1444.67, 516.25,  1147.69, 
                          576.83,  1387.79, 1071.71, 1072.38, 536.10,  1006.09, 
                          553.71,  1286.27, 990.37,  963.55,  1117.55, 555.94, 
                          1343.41, 727.85,  1404.65, 1103.58, 1079.59, 492.45, 
                          1279.08, 588.39,  1165.78, 1055.44, 1110.03, 606.76, 
                          1219.83, 588.39,  1303.19, 990.37,  1095.13, 634.09, 
                          1141.40, 708.02,  1337.03, 906.66,  1197.49, 978.94, 
                          370.21,  1416.34, 646.17,  1303.19, 1039.18, 1155.49))

## Quality Structures

quali$ssn <- str_pad(string = quali$ssn, width = 4, 
                     side = "left", pad = 0) %>% as.character()
quali$race <- as.factor(quali$race)
quali$sex <- as.factor(quali$sex)
names(quali)[4] <- "title"
quali$title <- as.factor(quali$title)
quali$zip <- as.factor(quali$zip)
quali$state <- as.factor(quali$state)
quali$position <- NA
quali <- quali %>% select(-eeo, -page, -string)
quali$name <- as.factor("Quality Structures")
quali$ending <- mdy(quali$ending)
quali$rate <- str_replace_all(string = quali$rate, pattern = "\\$|\\,", 
                              replacement = "") %>% as.numeric()
quali$net <- str_replace_all(string = quali$net, pattern = "\\$|\\,", 
                             replacement = "") %>% as.numeric()

## Edward Schalk & Son

sands$ssn <- str_pad(string = sands$ssn, width = 4, 
                     side = "left", pad = 0) %>% as.character()
sands$race <- as.factor(sands$race)
sands$sex <- as.factor(sands$sex)
names(sands)[4:5] <- c("position", "title")
sands$position <- as.factor(sands$position)
sands$title <- as.factor(sands$title)
sands[76, 12:16] <- sands[76, 11:15]
sands$ending[76] <- "4/29/2018"
sands$ending <- mdy(sands$ending)
sands$zip <- as.factor(sands$zip)
sands$state <- as.factor(sands$state)
sands$name <- "Schalk & Son"
sands$pdf_no <- 1
sands <- sands %>% select(-grade, -hours, -ot)
sands$latitude <- as.numeric(sands$latitude)
sands$union <- NA

## Stone Bridge

stone$ssn <- str_pad(string = stone$ssn, width = 4, 
                     side = "left", pad = 0) %>% as.character()
stone$race <- as.factor(stone$race)
stone$sex <- NA
names(stone)[3] <- c("position")
stone$pdf_no <- 1
stone$ending <- mdy(stone$ending)
stone$zip <- as.factor(stone$zip)
stone$state <- as.factor(stone$state)
stone$name <- as.factor("Stone Bridge Iron & Steel")
stone <- stone %>% select(-week_wg)
stone$union <- NA

# MERGE TO MASTER DATAFRAME; CORRECT CLASSES & CONFORM FACTORS

master <- bind_rows(danfo, envir, longh, niagr, patri, quali, sands, stone)
rm(danfo, envir, longh, niagr, patri, quali, sands, stone)

master$race <- str_replace_all(string = master$race, 
                               pattern = "^Black$|^Black or African American$", 
                               replacement = "African American") %>%
  str_replace_all(string = ., 
                  pattern = "American Indian or Alaskan", 
                  replacement = "Native American") %>%
  as.factor()

master$title <- str_replace_all(string = master$title, pattern = "^Not Specified$", replacement = "Unspecified") %>%
  str_replace_all(string = ., pattern = "^Foreman 2$", replacement = "Foreman") %>%
  str_replace_all(string = ., pattern = "Period", replacement = "Year") %>%
  str_replace_all(string = ., pattern = "2nd Year Apprentice", replacement = "Apprentice 2nd Year") %>%
  str_replace_all(string = ., pattern = "3rd Year Apprentice", replacement = "Apprentice 3rd Year") %>%
  str_replace_all(string = ., pattern = "4th Year Apprentice", replacement = "Apprentice 4th Year") %>%
  str_replace_all(string = ., pattern = "Operator.*", replacement = "Operator") %>%
  as.factor()

master$name <- as.factor(master$name)
master$zip <- as.factor(master$zip)
master$city <- as.factor(master$city)
master$state <- as.factor(master$state)
master$position <- as.factor(master$position)
master$union <- as.factor(master$union)

master <- master %>% select(name, ssn, title, position, union, sex:race, rate, net, ending, 
                            zip:state, longitude, latitude, pdf_no, pdf_pg, occur)

# MERGE COUNTY NAMES BY FIPS

data(zip_codes)
data(counties)

zip_codes <- zip_codes %>% select(zip, fips)
counties <- counties %>% select(county_name, state_fips, county_fips)

master <- left_join(master, zip_codes)
master$state_fips <- str_extract_all(string = master$fips, 
                                     pattern = "^.{2}", simplify = TRUE)
master$county_fips <- str_extract_all(string = master$fips, 
                                      pattern = ".{3}$", simplify = TRUE)

master <- left_join(master, counties)
names(master)[19:21] <- c("sfips", "cfips", "county")
master$county <- str_replace_all(string = master$county, 
                                 pattern = " County$", replacement = "")
master <- master %>% select(name:city, county, state:latitude, sfips:cfips, pdf_no:occur)

rm(counties, zip_codes)

# CORRECT FALSE UNIQUES & SUBSTITUTE NA VALUES WITH UNIQUE ID: `ssn`

na_ssn <- master %>% 
  filter(is.na(ssn))                                                    # Filter by missing values: `ssn`

uniq_jwdc <- master %>%
  filter(name == "John W. Danforth Company") %>%
  select(name, ssn, title, position, zip) %>%
  unique()                                                              # Determine unique observations

master <- master %>%
  mutate(ssn_sub = FALSE)                                               # Variable distinguishing substitutes

index <- master$name == "John W. Danforth Company" & master$ssn == "1160" & master$title == "Unspecified"
master[index, "title"] <- as.factor("Journeyman")                       # Replace: `title` (Determined manually)

index <- master$name == "John W. Danforth Company" & master$ssn == "6357" & master$zip == "13068"
master[index, "zip"] <- "13088"                                         # Replace: `zip` (Determined manually)

index <- master$name == "John W. Danforth Company" & master$zip == "13108"
master[index, "ssn_sub"] <- TRUE
master[index, "ssn"] <- 1                                               # Substitute NA with unique ID

index <- master$name == "John W. Danforth Company" & master$zip == "13316"
master[index, "ssn_sub"] <- TRUE
master[index, "ssn"] <- 2                                               # Substitute NA with unique ID

rm(na_ssn, uniq_jwdc, index)                                            # Remove obsolete objects

# SUBSTITUE DETERMINABLE MISSING VALUES: `zip`

na_zip <- master %>%
  filter(is.na(zip))                                                    # Filter by missing values: `zip`

uniq_qs <- master %>%
  filter(name == "Quality Structures") %>%
  select(name:union, zip) %>%
  unique() %>%
  arrange(ssn)                                                          # Determine duplicative uniques

index <- c(2, 3, 5, 6, 9, 10, 19, 20, 34, 35, 54:57, 
           63:70, 72, 73, 76:79, 81, 82, 84, 85)                        # Index NA and non-NA pairs: `zip`

replace <- uniq_qs[index, ]                                             # Filter by ordered pairs: `zip`
replace <- replace[!is.na(replace$zip), ] %>%
  select(name:ssn, zip)

na_qs <- master[is.na(master$zip) & master$ssn != "3906", ]
na_qs <- na_qs %>% mutate(id = NA) %>% select(-zip)

final <- left_join(na_qs, replace, by = c("name", "ssn")) %>%
  select(name:ending, zip, city:ssn_sub)                                # Reorder via merge on `name` & `ssn`

master[is.na(master$zip) & master$ssn != "3906", ] <- final             # Replace missing values

rm(final, na_qs, na_zip, replace, uniq_qs, index)                       # Remove obsolete objects

# SUBSTITUE DETERMINABLE DUPLICATIVE VALUES: `position` & `title`

uniq_all <- master %>% 
  select(name:position, zip) %>% 
  group_by(name) %>% 
  unique() %>% 
  arrange(name, ssn, zip)                                               # Determine all unique permutations

uniq_all_trunc <- uniq_all %>%
  select(name, ssn, zip)                                                # Dimension reduction: Key variables

index <- which(duplicated(x = uniq_all_trunc))
uniq_all[c(index, index - 1), ]                                         # Determine duplicate values; replace

index_dup <- master$name == "Environmental Services" & master$ssn == "5774" 
master[index_dup & master$position == "Operator", "position"] <- as.factor("Laborer")

index_dup <- master$name == "Stone Bridge Iron & Steel" & master$ssn == "7832"
master[index_dup & master$position == "Unspecified", "position"] <- as.factor("Iron Worker")

rm(uniq_all, uniq_all_trunc, index, index_dup)                          # Remove obsolete objects

# CONFIRM UNIQUENESS: `rate`

uniq_all <- master %>% 
  select(name, ssn, zip, rate) %>% 
  group_by(name, ssn, zip) %>% 
  unique() %>% 
  arrange(name, ssn, zip, rate) %>%
  filter(!is.na(rate))

uniq_all_trunc <- as_data_frame(uniq_all) %>%
  select(name, ssn, zip) %>%
  arrange(name, ssn, zip)

index <- which(duplicated(x = uniq_all_trunc))
dups <- uniq_all[c(index, index - 1), ] %>%
  arrange(name, ssn, zip, rate)                                         # Determine duplicates; replace

index_dup <- master$name == "Stone Bridge Iron & Steel" & master$ssn == "9027"
master[index_dup, "rate"] <- 32.05

index_dup <- master$name == "Stone Bridge Iron & Steel" & master$ssn == "6056"
master[index_dup, "rate"] <- 29.00

index_dup <- master$name == "Schalk & Son" & master$ssn == "7702" & master$rate == 13.22
master[index_dup, "rate"] <- 19.22

index_dup <- master$name == "Schalk & Son" & master$ssn == "9487" & master$rate == 28.45
master[index_dup, "rate"] <- 27.45

ssns <- dups %>%
  as_data_frame() %>% 
  filter(name == "Quality Structures") %>% 
  select(ssn) %>% unique(); ssns <- ssns$ssn

rate <- c(36.84, 24.20, 36.30, 24.20, 24.20, 24.20, 28.25, 24.20, 36.84, 27.45, 25.69, 
          24.20, 35.51, 27.45, 24.20, 26.62, 28.88, 26.62, 19.22, 24.20, 24.20)

for (i in 1:nrow(master)){
  for(j in seq_along(ssns)){
    if (master$name[i] == "Quality Structures" & master$ssn[i] == ssns[j]){
      master$rate[i] <- rate[j]
    }
  }
}

rm(dups, uniq_all, uniq_all_trunc, i, index, index_dup, j, rate, ssns)

# REMERGE ZIP CODE, COUNTY, & LATITUDE/LONGITUDE VALUES

data("zipcode", "zip_codes", "counties")

master <- master %>%
  select(-city, -city, -county, -state, -longitude, -latitude, -sfips, -cfips) %>%
  left_join(zipcode, by = "zip")

zip_codes <- zip_codes %>% select(zip, fips)
counties <- counties %>% select(county_name, state_fips, county_fips)

master <- left_join(master, zip_codes)

master$state_fips <- str_extract_all(string = master$fips, 
                                     pattern = "^.{2}", simplify = TRUE)
master$county_fips <- str_extract_all(string = master$fips, 
                                      pattern = ".{3}$", simplify = TRUE)

master <- left_join(master, counties, by = c("state_fips", "county_fips"))
names(master)[21:23] <- c("sfips", "cfips", "county")
master$county <- str_replace_all(string = master$county, 
                                 pattern = " County$", replacement = "")
master <- master %>% 
  select(name:zip, city, county, state, longitude, latitude, sfips:cfips, ssn_sub, pdf_no:occur)

rm(counties, zip_codes, zipcode)

# IDENTIFY & REMOVE REMAINING DUPLICATES SANS PDF DATA

index <- which(!duplicated(master[, c(1:19)]))

master <- master[index, ]; rm(index)

# WRITE TO CSV

setwd("~/Projects/REIS/Final Tables")
write_csv(master, "hancock_master_table_1.4.csv")
