# kdbjp
# install.packages("devtools"); install.packages("roxygen2"); install.packages("testthat");
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

#' @return stock list
stocks <- function(){
  url <- "http://k-db.com/stocks/?download=csv"
  s <-  read.table(file(url,encoding='cp932'),sep=",", header=T)
  return (s)
}

#' @return stock time
stock <- function(x) {
  filename = paste("s",x,".csv", sep = "")
  start <- 2007
  tryCatch({
    stock　<- read.table(file(filename),sep=",", header=T)
  },
  error = function(e) {
    print("file not found")
    start <- 2007
  }
  )

  today <- Sys.Date()
  year <- format(today, "%Y")  #2016
  for(y in start:year){#2007:2016

    url <- paste("http://k-db.com/stocks/",x,"-T/1d/",y,"?download=csv",sep="")

    tmp.stock　<- read.table(file(url,encoding='cp932'),sep=",", header=T)
    #http://k-db.com/stocks/8306-T/1d/?year=2008&download=csv
    #http://k-db.com/stocks/8316-T/1d/2016?download=csv
    if (!is.data.frame(stock ) ) {
      #print(url)
      stock  <- tmp.stock
    }else{
      #データを結合ただし、stock_tmpにあるひづけは上書き
      #http://stackoverflow.com/questions/28282484/
      stock  <- rbind (stock[!stock$日付 %in% tmp.stock$日付,], tmp.stock ) #
    }
    Sys.sleep(3)

  }
  stock <- stock[order(stock$日付),]
  write.table(stock, file=filename)
  return(r)
}
