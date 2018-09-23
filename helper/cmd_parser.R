##
# Parase all tabs
##
ParseCmds <- function(fp, shts){
  res <- lapply(1:length(shts), function(i){
    res1 <- ParseOneTab(fp, shts[i])
  })
  names(res) <- shts
  return(res)
}

##
# Parse one tab
##
ParseOneTab <- function(fp, sht){
  
  ##
  # content_df
  content_df <- as.data.frame(readxl::read_excel(fp, sheet = sht, col_names = TRUE))
  content_df[is.na(content_df)] <- ""
  
  curr_cat <- ""
  content_list <- lapply(1:nrow(content_df), function(i){
    
    id <- content_df[i, "ID"]
    nm <- content_df[i, "Name"]
    cmd <- content_df[i, "Command"]
    cmt <- content_df[i, "Comments"]
    ref <- content_df[i, "Reference"]
  
    if(nm != ""){
      ##
      # Only process non-empty row
      if(substr(nm, 1, 2) == "##"){
        curr_cat <<- substr(nm, 4, nchar(nm))
        cmds <- NULL
      } else {
        cmds <- list(
          #id = id,
          Category = curr_cat,
          Name = nm,
          Command = cmd,
          Comment = cmt,
          Reference = ref
        )
      }
      
    } else {
      cmds <- NULL
    }
    
  })
  
  # remove empty list element
  fnl_res <- content_list[!sapply(content_list, is.null)]
  
  return(fnl_res)
}

##
# Get all active files from directory
##
ParseDocs <- function(path){
  
  all_dirs <- list.dirs(path = path, full.names = TRUE, recursive = FALSE)
  
  res <- lapply(1:length(all_dirs), function(i){
    
    ##
    # Get all file paths
    files <- list.files(path=all_dirs[i], pattern="*", full.names=TRUE, recursive=FALSE)
  })
  names(res) <- basename(all_dirs)
  
  return(res)
}
