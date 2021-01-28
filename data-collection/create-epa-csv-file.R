# inputs -----------------

  data_path     = '/Users/MEAS/Google Drive/data/epa/ampd'

# libraries -------------
  
  library(data.table)
  
# read in monthly 2019 data ------
  
  # get list of monthly files 
    files_monthly = list.files(path = file.path(data_path, 'monthly', '2019'), pattern = '.csv', recursive = TRUE)
  
  # read in csv files
    raw_monthly = lapply(file.path(data_path, 'monthly', '2019', files_monthly), fread, colClasses = c(rep('character', 7), 
                                                                                                       rep('numeric', 2),
                                                                                                       rep(c('numeric', 'character'), 6),
                                                                                                       rep('numeric', 1),
                                                                                                       rep('character', 2)))
  
  # combine all data
    dt_monthly = rbindlist(raw_monthly)

# write csv ------
    
  fwrite(dt_monthly, file.path(data_path, 'epa_ampd_hourly_2019_all.csv'), row.names = F)
    