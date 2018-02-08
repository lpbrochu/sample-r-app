#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)


data = read.csv(paste0(args[1], "/", "cereals.csv"), header=T)

# Random sampling
samplesize = 0.60 * nrow(data)
set.seed(80)
index = sample( seq_len ( nrow ( data ) ), size = samplesize )

# Create training and test set
datatrain = data[ index, ]
datatest = data[ -index, ]


max = apply(data , 2 , max)
min = apply(data, 2 , min)
scaled = as.data.frame(scale(data, center = min, scale = max - min))

saveRDS(scaled, file=paste0(args[2], "/", "data.Rda"))
