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

## file names

```r
hourly_data     = 'epa_ampd_hourly_2019_selected.csv'
facility_data   = 'facility_01-27-2021_224024745.csv'
```

## read in csv file

read in hourly data:

```r
dt = fread(here::here("data", hourly_data))
```

# operations


```r
setkey(dt, ORISPL_CODE, UNITID, OP_DATE, OP_HOUR)
```

## filter rows

### select rows for generators in California (CA)

```r
head(dt[STATE=="CA"])
```

```
##    STATE FACILITY_NAME ORISPL_CODE UNITID    OP_DATE OP_HOUR OP_TIME GLOAD (MW)
## 1:    CA  Moss Landing         260     1A 01-01-2019       0       1        262
## 2:    CA  Moss Landing         260     1A 01-01-2019       1       1        262
## 3:    CA  Moss Landing         260     1A 01-01-2019       2       1        262
## 4:    CA  Moss Landing         260     1A 01-01-2019       3       1        262
## 5:    CA  Moss Landing         260     1A 01-01-2019       4       1        262
## 6:    CA  Moss Landing         260     1A 01-01-2019       5       1        262
##    SLOAD (1000lb/hr) SO2_MASS (lbs) SO2_MASS_MEASURE_FLG SO2_RATE (lbs/mmBtu)
## 1:                NA          1.108             Measured                0.001
## 2:                NA          1.109             Measured                0.001
## 3:                NA          1.111             Measured                0.001
## 4:                NA          1.110             Measured                0.001
## 5:                NA          1.107             Measured                0.001
## 6:                NA          1.107             Measured                0.001
##    SO2_RATE_MEASURE_FLG NOX_RATE (lbs/mmBtu) NOX_RATE_MEASURE_FLG
## 1:           Calculated                0.011             Measured
## 2:           Calculated                0.033             Measured
## 3:           Calculated                0.035             Measured
## 4:           Calculated                0.036             Measured
## 5:           Calculated                0.036             Measured
## 6:           Calculated                0.036             Measured
##    NOX_MASS (lbs) NOX_MASS_MEASURE_FLG CO2_MASS (tons) CO2_MASS_MEASURE_FLG
## 1:         20.304           Calculated         100.273                Other
## 2:         61.004           Calculated         100.273                Other
## 3:         64.810           Calculated         100.273                Other
## 4:         66.618           Calculated         100.273                Other
## 5:         66.431           Calculated         100.273                Other
## 6:         66.424           Calculated         100.273                Other
##    CO2_RATE (tons/mmBtu) CO2_RATE_MEASURE_FLG HEAT_INPUT (mmBtu) FAC_ID UNIT_ID
## 1:                 0.054           Calculated             1845.8     47     149
## 2:                 0.054           Calculated             1848.6     47     149
## 3:                 0.054           Calculated             1851.7     47     149
## 4:                 0.054           Calculated             1850.5     47     149
## 5:                 0.054           Calculated             1845.3     47     149
## 6:                 0.054           Calculated             1845.1     47     149
```
### select rows that occurred after july 1, 2019

```r
head(dt[OP_DATE > "07-01-2019"])
```

```
##    STATE  FACILITY_NAME ORISPL_CODE UNITID    OP_DATE OP_HOUR OP_TIME
## 1:    TX Copper Station           9  CTG-1 07-02-2019       0       0
## 2:    TX Copper Station           9  CTG-1 07-02-2019       1       0
## 3:    TX Copper Station           9  CTG-1 07-02-2019       2       0
## 4:    TX Copper Station           9  CTG-1 07-02-2019       3       0
## 5:    TX Copper Station           9  CTG-1 07-02-2019       4       0
## 6:    TX Copper Station           9  CTG-1 07-02-2019       5       0
##    GLOAD (MW) SLOAD (1000lb/hr) SO2_MASS (lbs) SO2_MASS_MEASURE_FLG
## 1:         NA                NA             NA                     
## 2:         NA                NA             NA                     
## 3:         NA                NA             NA                     
## 4:         NA                NA             NA                     
## 5:         NA                NA             NA                     
## 6:         NA                NA             NA                     
##    SO2_RATE (lbs/mmBtu) SO2_RATE_MEASURE_FLG NOX_RATE (lbs/mmBtu)
## 1:                   NA                                        NA
## 2:                   NA                                        NA
## 3:                   NA                                        NA
## 4:                   NA                                        NA
## 5:                   NA                                        NA
## 6:                   NA                                        NA
##    NOX_RATE_MEASURE_FLG NOX_MASS (lbs) NOX_MASS_MEASURE_FLG CO2_MASS (tons)
## 1:                                  NA                                   NA
## 2:                                  NA                                   NA
## 3:                                  NA                                   NA
## 4:                                  NA                                   NA
## 5:                                  NA                                   NA
## 6:                                  NA                                   NA
##    CO2_MASS_MEASURE_FLG CO2_RATE (tons/mmBtu) CO2_RATE_MEASURE_FLG
## 1:                                         NA                     
## 2:                                         NA                     
## 3:                                         NA                     
## 4:                                         NA                     
## 5:                                         NA                     
## 6:                                         NA                     
##    HEAT_INPUT (mmBtu) FAC_ID UNIT_ID
## 1:                 NA   8237   90211
## 2:                 NA   8237   90211
## 3:                 NA   8237   90211
## 4:                 NA   8237   90211
## 5:                 NA   8237   90211
## 6:                 NA   8237   90211
```

## select columns

### select columns by name:

```r
head(dt[, .(ORISPL_CODE, UNITID, OP_DATE, OP_HOUR, OP_TIME, `GLOAD (MW)`, `SLOAD (1000lb/hr)`, `SO2_MASS (lbs)`)])
```

```
##    ORISPL_CODE UNITID    OP_DATE OP_HOUR OP_TIME GLOAD (MW) SLOAD (1000lb/hr)
## 1:           9  CTG-1 01-01-2019       0       0         NA                NA
## 2:           9  CTG-1 01-01-2019       1       0         NA                NA
## 3:           9  CTG-1 01-01-2019       2       0         NA                NA
## 4:           9  CTG-1 01-01-2019       3       0         NA                NA
## 5:           9  CTG-1 01-01-2019       4       0         NA                NA
## 6:           9  CTG-1 01-01-2019       5       0         NA                NA
##    SO2_MASS (lbs)
## 1:             NA
## 2:             NA
## 3:             NA
## 4:             NA
## 5:             NA
## 6:             NA
```
### select columns by column number/index

```r
head(dt[, c(3:10)])
```

```
##    ORISPL_CODE UNITID    OP_DATE OP_HOUR OP_TIME GLOAD (MW) SLOAD (1000lb/hr)
## 1:           9  CTG-1 01-01-2019       0       0         NA                NA
## 2:           9  CTG-1 01-01-2019       1       0         NA                NA
## 3:           9  CTG-1 01-01-2019       2       0         NA                NA
## 4:           9  CTG-1 01-01-2019       3       0         NA                NA
## 5:           9  CTG-1 01-01-2019       4       0         NA                NA
## 6:           9  CTG-1 01-01-2019       5       0         NA                NA
##    SO2_MASS (lbs)
## 1:             NA
## 2:             NA
## 3:             NA
## 4:             NA
## 5:             NA
## 6:             NA
```

## reshape between long and wide forms

## summarize/aggregate

### summarize by group(s)

### summarize several columns

### summarize several columns by group(s)

### summarize multiple functions on several columns by group(s)

## setkey?

# modify data table

## rename columns

## reorder rows

## add columns

### add columns by groups

## replace values

# joining data

## merge

## bind
