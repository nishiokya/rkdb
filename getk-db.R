#codeの指定
code <- c(8316)
stocks <- function(){
  url = "http://k-db.com/stocks/?download=csv"
  s =  read.table(file(url,encoding='cp932'),sep=",", header=T)
}
g <- function(x) {
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
      
      stock_tmp　<- read.table(file(url,encoding='cp932'),sep=",", header=T)
      #http://k-db.com/stocks/8306-T/1d/?year=2008&download=csv
      #http://k-db.com/stocks/8316-T/1d/2016?download=csv
      if (!is.data.frame(stock ) ) {  
        #print(url)
        stock  <- stock_tmp
      }else{
        #データを結合ただし、stock_tmpにあるひづけは上書き
        #http://stackoverflow.com/questions/28282484/
      　stock  <- rbind (stock[!stock$日付 %in% stock_tmp$日付,], stock_tmp ) #
      }
      Sys.sleep(3)
   
  }
  stock <- stock[order(stock$日付),]
  write.table(stock, file=filename)
}
#s8361
#s8361 <- read.csv(file("~/Downloads/stocks_8361-T.csv",encoding='cp932'), header=T) 
#stock
#s[code[1]]$diff<-diff(log(s[code[1]]$終値))*100
#plot(s8361$diff,type = "l" )

#out <- cbind(s8361)

#plot(diff(log(s[code[1]]$終値))*100,type = "l" )

#s[code[1]]<-s[code[1]][sort(s[code[1]]$日付),]

#head(s[code[1]]$日付)
#head(s[code[1]][order(s[code[1]]$日付),])
#head(order(s[code[1]]$日付))

#code <- c(8316)
#g(8306)
#
#a<-data.frame(c("Foo", "Moo", "Boo"), c(1, 2, 3), stringsAsFactors=F)
#colnames(a)<-c("Name", "Value")
#b<-data.frame(c("Boo", "Bar", "Bat"), c(11, 12, 13), stringsAsFactors=F)
#colnames(b)<-c("Name", "Value")
#rbind(a, b[!b$Name %in% a$Name,])
#d <- diff(log(stock$終値))*100
library(ggplot2)
ggplot(stock, aes(x=stock$日付, y=stock$終値))
