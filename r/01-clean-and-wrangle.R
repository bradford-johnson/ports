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

shipping <- shipping |>
  drop_na(destination_port, shipment_date)

# explore data
shipping |>
  group_by(destination_port) |>
  count()

shipping |>
  group_by(name) |>
  count()

shipping |>
  group_by(shipment_date, destination_port) |>
  count()

# calculate volume for items
## Volume = L * W * H | in cubic meters (m3)
shipping <- shipping |>
  mutate(volume = length_m * width_m * height_m)