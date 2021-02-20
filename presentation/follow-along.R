# follow along script during presentation?

# load packages -------

  library(tidyverse)
  library(data.table)
  library(here)

# data inputs ------

  hourly_data = 'epa_ampd_hourly_2019_selected.csv'
  flight_data = 'flights14.csv'

# read in flight data using tidyverse -------
  
  flight_tbl = read_csv(here::here("data", flight_data))
  head(flight_tbl)
  str(flight_tbl)
  
# read in flight data using data.table -------
  
  flight_dt = fread(here::here("data", flight_data))
  head(flight_dt)
  str(flight_dt)
  
# filter rows --------
  
  filter(tbl, ORISPL_CODE == "6288")
  dt[ORISPL_CODE == "6288"]
  
# rename columns ------
  
  tbl <- rename(tbl, gload_mw = "GLOAD (MW)")
  setnames(dt, "GLOAD (MW)", "gload_mw")
  
# summarise: total load for each generator (ORISPL_CODE + UNITID combo) ------
  
  tbl %>%
    group_by(ORISPL_CODE, UNITID) %>%
    summarise(total_gload = sum(gload_mw, na.rm = T))
  
  dt[, .(total_gload = sum(gload_mw, na.rm = T)), by = .(ORISPL_CODE, UNITID)]
  
# setkey ------
  
  setkey(dt, ORISPL_CODE, UNITID, OP_DATE, OP_HOUR)
  
# summarize again -----
  
  dt[, .(total_gload = sum(gload_mw, na.rm = T)), by = .(ORISPL_CODE, UNITID)]
  