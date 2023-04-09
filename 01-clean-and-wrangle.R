# load packages
pacman::p_load(tidyverse)

# load ports and clean
ports <- read_csv("data/Port_Data.csv") |>
  janitor::clean_names()

ports$port_name <- str_to_title(ports$port_name)

# load shipping and clean
shipping <- read_csv("data/shipping_data.csv") |>
  janitor::clean_names()

shipping$destination_port <- gsub("\\s*\\((\\w+(?:\\s+\\w+)*)\\)", "", shipping$destination_port)

shipping$destination_port <- gsub("Port of ", "", shipping$destination_port)

shipping$shipment_date <- as.Date(shipping$shipment_date)

# explore data

shipping |>
  drop_na(destination_port) |>
  group_by(destination_port) |>
  count()

# calculate volume