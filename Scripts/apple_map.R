library(here)
library(tidyverse)
library(sf)
library(dplyr)
library(ggplot2)

# read in shape file (note, all files from the unzipped folder
# must be present; .shx, etc)

fsa <- st_read(here("data/shape","lfsa000b21a_e.shp"))

# filter BC only
bc_fsa <- fsa %>%
  filter(PRUID == "59")

# filter for the V5 and V6 postal codes and check

vancouver_fsa <- bc_fsa %>%
  filter(substr(CFSAUID, 1, 2) %in% c("V5","V6"))

ggplot(vancouver_fsa) +
  geom_sf(fill = "grey90", colour = "white")

# colour in FSA where Prof Vercammen's house is located

v6l <- fsa %>%
  dplyr::filter(CFSAUID == "V6L")

ggplot() +
  geom_sf(data = vancouver_fsa, fill = "grey90", colour = "white") +
  geom_sf(data = v6l, fill = "red", colour = "black")

# identify the specific location of Prof Vercammen's house

house <- st_as_sf(
  data.frame(
    lon = -123.17605,
    lat = 49.25238
  ),
  coords = c("lon", "lat"),
  crs = 4326
)

house_3347 <- st_transform(house, st_crs(vancouver_fsa))

ggplot() +
  geom_sf(data = vancouver_fsa, fill = "grey90", colour = "white") +
  geom_sf(data = v6l, fill = "red", colour = "black") +
  geom_sf(data = house_3347, colour = "blue", size = 3)



