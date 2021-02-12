# follow along script during presentation?

# load packages -------

  library(tidyverse)
  library(data.table)

# data inputs ------

  data_path   = '/Volumes/GoogleDrive/.shortcut-targets-by-id/1PUbZLiJ00nRGtnKGqYulNtUT25f_O2cv/alaska-data'
  data_file   = 'epa_ampd_hourly_2019_selected.csv'

# read in data using tidyverse -------
  
  tbl = read_csv(file.path(data_path, data_file))
  head(tbl)
  
# read in data using data.table -------
  
  dt = fread(file.path(data_path, data_file))
  head(dt)
  
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
  