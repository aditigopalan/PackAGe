reading_in_alt <- function(file, test="Per base sequence quality", s_name) {
  ## open connection
  con <- base::file(file, 'r')

  ## locate module
  repeat { !grepl(test, readLines(con, n=1)) || break }

  ## read in module
  input <- character(0)
  repeat {
    line <- readLines(con, n=1)
    if (grepl(">>END_MODULE", line)) { break }
    else { input <- c(input, line) }
  }

  ## close connection
  close(con)

  ## parse
  dat <- as.data.frame(data.table::fread(paste(input, collapse="\n")))
  dat$Sample_Name <- s_name
  return(dat)
}
