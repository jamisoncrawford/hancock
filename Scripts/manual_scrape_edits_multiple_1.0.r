# Manual Scrape Manipulation: Hancock Airport
# Organizations:
  ## Danforth Company
  ## Environmental Services
  ## Longhouse Construction
  ## Niagara Erecting
  ## Patricia Electric
  ## Stone Bridge

# VERSIONS & DATE

  ## Script Version: 1.0
  ## R Version: 3.5.1
  ## RStudio Version: 1.1.456
  ## Date: 2018-10-10

# CLEAR WORKSPACE; LOAD PACKAGES & DATA

rm(list = ls())

if(!require(readr)){install.packages("readr")}
if(!require(dplyr)){install.packages("dplyr")}
if(!require(tidyr)){install.packages("tidyr")}
if(!require(stringr)){install.packages("stringr")}
if(!require(zipcode)){install.packages("zipcode")}

library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(zipcode)

data(zipcode)

# READ IN MANUAL SCRAPES

urls <- c("https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Manual%20Scrapes/danforth_company_manual_scrape_1.0.csv",
          "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Manual%20Scrapes/environmental_services_manual_scrape_1.0.csv",
          "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Manual%20Scrapes/longhouse_manual_scrape_1.0.csv",
          "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Manual%20Scrapes/niagara_manual_scrape_1.0.csv",
          "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Manual%20Scrapes/patricia_manual_scrape_1.0.csv",
          "https://raw.githubusercontent.com/jamisoncrawford/REIS/master/Manual%20Scrapes/stone_bridge_manual_scrape_1.0.csv")

name <- c("danfo", "envir", "longh", "niagr", "patri", "stone")                # List names
for (i in seq_along(name)){assign(x = name[i], read_csv(file = urls[i]))}      # Read in and assign names
rm(i, name, urls)                                                              # Remove obsolete

# EDITS: DANFORTH COMPANY

danfo <- danfo %>% 
  mutate(zip = as.character(zip)) %>%                                          # Coerce class: zip
  left_join(y = zipcode, by = "zip") %>%                                       # Merge location data
  rowwise() %>%
  mutate(st = sum(st_1, st_2, st_3, na.rm = TRUE),
         ot = sum(ot_1, ot_2, na.rm = TRUE),
         wage = sum(st, ot, na.rm = TRUE)) %>%                                 # Compute weekly earnings: wage
  select(-c(st_1:ot_2, st:ot))                                                 # Remove obsolete variables

ssn_na <- unique(danfo[which(is.na(danfo$ssn)), c("title", "zip")])            # Index: NA SSNs
mat_na <- left_join(ssn_na, danfo)                                             # Mutating join
fix_na <- unique(mat_na[which(!is.na(mat_na$ssn)), ]$ssn)                      # Recover NA value
danfo[is.na(danfo$ssn) & danfo$title == "General Foreman", ]$ssn <- fix_na     # Impute NA value
rm(mat_na, ssn_na, fix_na)                                                     # Remove obsolete variables

danfo <- danfo %>%
  select(ssn:title, wage, ending, zip:longitude, pdf_pg:occur)                 # Rearrange

write_csv(danfo, "danforth_table_1.0.csv")                                     # Write to .csv

for(i in 1:nrow(danfo)){for (j in 1:col(danfo)){
  if (is.na(danfo[i, j])){danfo[i, j] <- "" }}}                                # NAs to empty cells

write_csv(danfo, "danforth_table_narm_1.0.csv"); rm(danfo, i, j)               # Write to .csv, narm; remove

# EDITS: ENVIRONMENTAL SERVICES

envir <- envir %>%
  mutate(zip = as.character(zip)) %>%                                          # Coerce class: zip
  left_join(y = zipcode, by = "zip") %>%                                       # Merge location data
  filter(class != "Fringe") %>%                                                # Filter: "Fringe"
  select(ssn:class, gross, ending, zip:longitude, pdf_pg:occur)                # Rearrange variables

for (i in 1:nrow(envir)){
  if (envir[i, 1:9] == envir[i + 1, 1:9]){envir[i, ] <- NA}}                   # Remove duplicates; keep pdf_pg
envir <- envir[which(complete.cases(envir)), ]                                 # Keep complete cases

write_csv(envir, "environmental_table_1.0.csv")                                # Write to .csv

for(i in 1:nrow(envir)){for (j in 1:col(envir)){
  if (is.na(envir[i, j])){envir[i, j] <- "" }}}                                # NAs to empty cells

write_csv(envir, "environmental_table_narm_1.0.csv"); rm(envir, i, j)          # Write to .csv, narm; remove

# EDITS: LONGHOUSE

longh <- longh %>%
  mutate(zip = as.character(zip)) %>%                                          # Coerce class: zip
  left_join(y = zipcode, by = "zip") %>%                                       # Merge location data
  select(ssn:exempt, week_wg, ending, zip, city:longitude, pdf_pg:occur)       # Rearrange variables

fix <- unique(longh$sex[which(!is.na(longh$sex))])
longh[which(is.na(longh$sex)), "sex"] <- fix; rm(fix)                          # Impute sex

for (i in 1:nrow(longh)){if (is.na(longh$race[i])){                            # Impute race
  longh$race[i] <- longh$race[which(longh$ssn == longh$ssn[i] & !is.na(longh$race))][1]
}}

longh$class <- str_replace_all(longh$class, " IW|\\+", "")                     # Clean variable: class

write_csv(longh, "longhouse_1.0.csv")                                          # Write to .csv

for(i in 1:nrow(longh)){for (j in 1:col(longh)){
  if (is.na(longh[i, j])){longh[i, j] <- "" }}}                                # NAs to empty cells

write_csv(longh, "longhouse_narm_1.0.csv"); rm(longh, i, j)                    # Write to .csv, narm; remove

# EDITS: NIAGARA ERECTING

niagr <- niagr %>% 
  spread(key = time, value = gross) %>%                                        # Spread: time, gross
  rowwise() %>%
  mutate(zip = as.character(zip),                                              # Coerce class: zip
         wage = sum(ot, st, na.rm = TRUE)) %>%                                 # Add ot, st: wage
  left_join(y = zipcode, by = "zip") %>%                                       # Merge location data
  select(ssn, wage, ending, zip, city:longitude, pdf_pg:occur)                 # Rearrange variables

j <- niagr$ssn
k <- niagr$wage

for (i in 1:nrow(niagr)){
  if (j[i] == j[i + 1] & j[i] == j[i + 2] & j[i] == j[i + 3] & j[i] == j[i + 4]){
    k[i] <- sum(k[i], k[i + 1], k[i + 2], k[i + 3], k[i + 4], na.rm = TRUE);
    niagr[i + 1:4, ] <- NA
  } else if (j[i] == j[i + 1] & j[i] == j[i + 2] & j[i] == j[i + 3]){
    k[i] <- sum(k[i], k[i + 1], k[i + 2], k[i + 3], na.rm = TRUE);
    niagr[i + 1:3, ] <- NA
  } else if (j[i] == j[i + 1] & j[i] == j[i + 2]){
    k[i] <- sum(k[i], k[i + 1], k[i + 2], na.rm = TRUE);
    niagr[i + 1:2, ] <- NA
  } else if (j[i] == j[i + 1]){
    k[i] <- sum(k[i], k[i + 1], na.rm = TRUE);
    niagr[i + 1, ] <- NA
  }
}                                                                              # Combine gross wages

niagr <- niagr[which(complete.cases(niagr)), ]                                 # Preserve complete cases
niagr <- niagr[-(which(niagr$ending == "2018-02-24")[7:12]), ]                 # Remove duplicates
niagr <- niagr[-30, ]                                                          # Remove negative wage

write_csv(niagr, "niagara_1.0.csv")                                            # Write to .csv
write_csv(niagr, "niagara_narm_1.0.csv"); rm(niagr, i, j, k)                   # Write to .csv, narm; remove

# EDITS: PATRICIA ELECTRIC

patri <- patri %>%
  rowwise() %>%
  mutate(zip = as.character(zip),                                              # Coerce class: zip
         gross = sum(deduct, net_wg, ra.rm = TRUE)) %>%                        # New variable: gross
  left_join(y = zipcode, by = "zip") %>%                                       # Merge location data
  select(ssn:class, gross, ending, zip:longitude, pdf_pg:occur)                # Rearrange variables

write_csv(patri, "patricia_1.0.csv")                                           # Write to .csv
write_csv(patri, "patricia_narm_1.0.csv"); rm(patri)                           # Write to .csv, narm; remove

# EDITS: STONE BRIDGE

stone <- stone %>%
  mutate(zip = as.character(zip)) %>%                                          # Coerce class: zip
  left_join(y = zipcode, by = "zip") %>%                                       # Merge location data
  select(ssn:title, hourly, week_wg, ending, zip:longitude, pdf_pg:occur)      # Rearrange variables

write_csv(stone, "stone_bridge_1.0.csv")                                       # Write to .csv
write_csv(stone, "stone_bridge_narm_1.0.csv"); rm(stone, zipcode)              # Write to .csv, narm; remove