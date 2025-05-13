#' readKubios
#' This function read the analysis' results from Kubios (.csv) to extract
#'   the RMSSD or the HF data.
#' RMSSD: root mean square of successive differences between normal heartbeats.
#' HF: High Frequency - frequency activity in the 0.15 - 0.40Hz range.
#'
#' @param hrvfile A dataframe of 1 or more Kubios csv files.
#' @param target A string indicating which parameter to extract. Either "HF" or "RMSSD".
#' @return Return a dataframe of the corresponding values (HF, RMSSD) according to each sample analyzed.
#' @export
#' @examples
#' readKubios(list.files(path = "dataHRV/",
#'                       recursive = F,       # do not search within folders
#'                       pattern = "\\.csv$", # read only csv files
#'                       full.names = T),     # keep the path in the names
#'            target="HF")
require(tidyverse)
readKubios = function(hrvFiles, target="HF"){
  # Extract HF related values
  if( target == "HF"){
    # Read the csv files by skipping a specific amount of non-relevant lines
    dt = readr::read_csv(hrvFiles, id = "FileName", skip = 91, n_max = 21, trim_ws = T, skip_empty_rows = T)
    # Keep only the data related to HF
    hrv = dt %>% filter(`Frequency-Domain Results` %in% c("HF (ms^2):", "HF (log):", "HF (n.u.):"))
  }
  # Extract RMSSD related values
  if( target=="RMSSD"){
    # Read the csv files by skipping a specific amount of non-relevant lines
    dt = readr::read_csv(hrvFiles, id = "FileName", skip = 71, n_max = 7, trim_ws = T, skip_empty_rows = T)
    # Keep only the data related to RMSSD
    hrv = dt %>% filter(`Statistical parameters` == "RMSSD (ms):")
    rmssdVal = str_split(hrv$...2, ",")
    # Convert data into numeric values and keep only not empty columns
    rmssdVal = as.data.frame(do.call(rbind, rmssdVal))
    rmssdVal = sapply(rmssdVal, as.numeric)
    rmssdVal = remove_empty(as.data.frame(rmssdVal), which = "cols")
    # Rename the columns
    names(rmssdVal) = paste0("T", 1:ncol(rmssdVal))
    rmssdVal$FileName = hrv$FileName
    hrv =select(rmssdVal, FileName, starts_with("T"))
  }
  # Keep only the filenames as id
  hrv$FileName = basename(hrv$FileName)
  return(hrv)
}
