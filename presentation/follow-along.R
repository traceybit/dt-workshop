# follow along script during presentation?

# load packages -------

  library(tidyverse)
  library(data.table)
  library(here)

# data inputs ------

  hourly_data = 'epa_ampd_hourly_2019_selected.csv'
  flight_data = 'flights14.csv'

## ways to create a data object (tibble or data.table)
## --------------------------------------------------------------
  
# read in flight data using tidyverse -------
  
  flight_tbl = read_csv(here::here("data", flight_data))
  head(flight_tbl)
  str(flight_tbl)
  
# read in flight data using data.table -------
  
  flight_dt = fread(here::here("data", flight_data))
  head(flight_dt)
  str(flight_dt)
  
# create a new object
  
  # dplyr
  tibble(x = 1:10, y = 10:1)
  
  # data.table
  data.table(x = 1:10, y = 10:1)
  
# coerce an existing object
  
  # create data frame
  temp1 <- data.frame(x = 1:10, y = 10:1)
  
  # coerce to tibble
  as_tibble(temp1)
  
  # coerce to data.table
  as.data.table(temp1)
  
# coerce an existing data object by reference (no need to reassign)
  
  setDT(temp1)
    
  ## notice that nothing prints... check the structure to see the class of the object
  str(temp1) ## temp1 is now a data.table!
  
## data manipulation (use flight data)
## ---------------------------------------------
  
  # filter rows --------
  ## -------------------
  
  # filter origin for EWR, dplyr
  flight_tbl %>%
    filter(origin == "EWR")
  
  # filter origin for EWR, data.table
  flight_dt[origin == "EWR"]
  
  # helper %like% (filter for pattern)
  like_dt <- flight_dt[dest %like% "HO"]
  unique(like_dt[, dest])
  
  # helper %like% with $ at the end (look for pattern at the end)
  like_dt2 <- flight_dt[dest %like% "HO$"]
  unique(like_dt2[, dest])
  
  # helper %between% 
  # filter air time between 0 and 180 minutes
  between_dt <- flight_dt[dep_delay %between% c(0, 180)]
  min(between_dt[, dep_delay])
  max(between_dt[, dep_delay])
  
  # helper %chin
  # filter dest for LAX, SEA, and PHX using %chin%
  chin_dt <- flight_dt[dest %chin% c("LAX", "SEA", "PHX")]
  unique(chin_dt[, dest])
  
  # working with columns in j --------
  ## ---------------------------------

  ## select columns month, day, and carrier -----
    ## dplyr
    flight_tbl %>%
      select(month, day, carrier)
    
    ## data.table (the following options do the same thing)
    flight_dt[, list(month, day, carrier)]
    flight_dt[, .(month, day, carrier)]
    
  ## drop columns month, day, and carrier -----
    ## dplyr (these two do the same)
    flight_tbl %>%
      select(-month, -day, -carrier)
    
    flight_tbl %>%
      select(!c(month, day, carrier))
    
    ## data.table
    flight_dt[, !c("month", "day", "carrier")]
  
  ## rename dest to destination
    ## dplyr
    flight_tbl %>%
      rename(destination = dest)
    
    ## data.table
    setnames(flight_dt, "dest", "destination")
    ## notice -- this modifies the original data table
    colnames(flight_dt)
    
  ## create a new coumn with :=
    ## dplyr
    flight_tbl %>%
      mutate(month_day = paste(month, day, sep = "-"))
    
    ## data.table -- this will modify in place
    flight_dt[, month_day := paste(month, day, sep = "-")]
    head(flight_dt)
  
  ## drop a column with := NULL
    flight_dt[, month_day := NULL]
    head(flight_dt)
    
  # group by --------
  ## ---------------------------------  
    
  ## summarise: calculate mean dep_delay for for carrier, origin, and dest 
    ## dplyr
    flight_tbl %>%
      group_by(carrier, origin, dest) %>%
      summarise(mean_dep_delay = mean(dep_delay)) %>%
      ungroup()
    
    ## data.table -- this DOES NOT modify in place
    flight_dt[, .(mean_dep_delay = mean(dep_delay)), by = .(carrier, origin, dest)]

  ## mutate: calculate the mean dep_delay for carrier, origin, and dest
    ## dplyr
    flight_tbl %>%
      group_by(carrier, origin, dest) %>%
      mutate(mean_dep_delay = mean(dep_delay)) %>%
      ungroup()
    
    ## data.table -- this will modify in place
    flight_dt[, mean_dep_delay := mean(dep_delay), by = .(carrier, origin, dest)]

  ##  LHS := RHS form 
    flight_dt[, c("mean_dep_delay", "mean_arr_delay") := .(mean(dep_delay), mean(arr_delay)), 
              by = .(carrier, origin, dest)]
    
  ## Functional form
    # drop mean_dep_delay and mean_arr_delay
    ## data.table -- this will modify in place
    flight_dt[, `:=`(mean_dep_delay = NULL,
                     mean_arr_delay = NULL)]
      
  # Helpful operators --------
  ## ---------------------------------  
     
    ## .N
    ## how many entries for each carrier?
    ## dplyr
    flight_tbl %>%
      group_by(carrier) %>%
      summarise(n = n()) %>%
      ungroup()
    
    ## data.table -- this will not modify in place
    flight_dt[, .N, by = carrier]
    
    ## compare with the following, which modifies in place and creates a new column
    flight_dt[, n := .N, by = carrier] 
    
    ## uniqueN and .SD
    ## how many unique origin and dest locations by carrier?
    flight_dt[, lapply(.SD, uniqueN), by = carrier, .SDcols = c("origin", "dest")]
  
  ## creating and modifying copies
    temp1_copy <- temp1
    temp1_copy[, y := NULL]
    
    ## check copy
    head(temp1_copy)
    
    ## check original -- y column is gone
    head(temp1)
    
    ## remake data.table
    temp1 <- data.table(x = 1:10, y = 10:1)
    
    ## create a copy with copy function
    temp1_copy2 <- copy(temp1)
    
    ## remove column
    temp1_copy2[, y := NULL]
    
    ## check temp1_copy2
    head(temp1_copy2)
    
    ## check original -- y column is still there
    head(temp1)
  
  ## Chaining
    ## dplyr
    flight_dt %>%
      mutate(delay_diff = dep_delay - arr_delay,
             diff_over_at = delay_diff / air_time)
    
    ## data.table
    flight_dt[, delay_diff := dep_delay - arr_delay][, diff_over_at := delay_diff / air_time]
    
# setkey ------
  
  setkey(dt, ORISPL_CODE, UNITID, OP_DATE, OP_HOUR)
  
# summarize again -----
  
  dt[, .(total_gload = sum(gload_mw, na.rm = T)), by = .(ORISPL_CODE, UNITID)]
    
## add exmples for merging?    

  