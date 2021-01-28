# inputs -----------------

  data_path     = '/Users/MEAS/Google Drive/data/epa/ampd'
  data_file     = 'epa_ampd_hourly_2019_all.csv'
  
# outputs -----------------
  
  save_file     = 'epa_ampd_hourly_2019_selected.csv'
  
# parameters -------
  
  # select which states' data we want
    sel_states = c('CA', 'NJ', 'TX', 'MN', 'NY', 'AK')
  
# libraries -------------
  
  library(data.table)
  
# read in data -------
  
  dt_full = fread(file.path(data_path, data_file), header = T)

# only keep selected states data -------
  
  dt_select = dt_full[STATE %in% sel_states]

# write csv ------
  
  fwrite(dt_select, file.path(data_path, save_file), row.names = F)
  