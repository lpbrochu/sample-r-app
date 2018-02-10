#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)


library(readr)
library(tidyr)
library(dplyr)

#flights <- read.csv("~/data/flights.csv", stringsAsFactors = F, na.strings = c("NA", ""))
#flights <- read.csv("/pfs/flights/flights.csv", stringsAsFactors = F, na.strings = c("NA", ""))
flights <- read.csv(paste0(args[1],"/","flights.csv"), stringsAsFactors = F, na.strings = c("NA", ""))

flights <- flights %>%
  mutate(speed = dist / (time / 60))

delays <- flights %>%
    group_by(dest) %>%
    summarise(mean = mean(dep_delay))

hourly <- flights %>%
  filter(cancelled == 0) %>%
  mutate(time = hour + minute / 60) %>%
  group_by(time) %>%
  summarise(
    arr_delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )

full <- flights %>%
  group_by(dest) %>%
  filter(!is.na(arr_delay)) %>%
  summarise(delay = mean(arr_delay)) %>%
  arrange(desc(delay)) 

#saveRDS(full, file="/home/lpbrochu/data-out/full.Rda")
#saveRDS(full, file="/pfs/out/full.Rda")
saveRDS(full, file=paste0(args[2],"/","full.Rda"))
