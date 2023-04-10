# reefer container
#
# A refrigerated container or reefer is a shipping container used in intermodal freight transport
# that is capable of refrigeration for the transportation of temperature-sensitive, perishable
# cargo such as fruits, vegetables, meat, and other similar items.
#
# web scrape list of items that should be kept in reefers

# load packages
pacman::p_load(tidyverse,
               rvest)

# site info
url <- "{{secret_link}}"
webpage <- read_html(url)

# scrape data
items <- webpage %>%
  html_nodes(".name-box") %>%
  html_text()

min_temp <- webpage %>%
  html_nodes(".cel .name+ span") %>%
  html_text()

max_temp <- webpage %>%
  html_nodes(".cel .name~ span+ span") %>%
  html_text()

# create data frame
reefer <- data.frame(items, min_temp, max_temp)

# clean data frame
reefer$min_temp <- gsub("[^0-9.-]", "", reefer$min_temp)
reefer$min_temp <- as.numeric(reefer$min_temp)

reefer$max_temp <- gsub("[^0-9.-]", "", reefer$max_temp)
reefer$max_temp <- as.numeric(reefer$max_temp)

# save reefer as .csv
write.csv(reefer, "data/reefer.csv")
