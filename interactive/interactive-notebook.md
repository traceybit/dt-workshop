---
title: "Eco-data-science data.table workshop"
output: 
  html_document:
    keep_md: true
---

### shortcuts

Run Chunk : *Cmd+Shift+Enter*

Insert Chunk : *Cmd+Option+I*

Preview HTML : *Cmd+Shift+K*

# packages

## install packages

```r
# install.packages("tidyverse")
# install.packages("data.table")
```

## load package(s)

```r
library(data.table)
```

# read in data

## file locations

```r
data_path   = '/Volumes/GoogleDrive/.shortcut-targets-by-id/1PUbZLiJ00nRGtnKGqYulNtUT25f_O2cv/alaska-data'
data_file   = 'epa_ampd_hourly_2019_selected.csv'
```

## read in csv file


```r
dt = fread(file.path(data_path, data_file))
```

# operations

## setkey?

## filter row

## select columns

## add columns

### add columns by groups

## replace values

## reshape between long and wide forms

## summarize/aggregate

### summarize by group(s)

### summarize several columns

### summarize several columns by group(s)

### summarize multiple functions on several columns by group(s)

# joining data

## merge

## bind
