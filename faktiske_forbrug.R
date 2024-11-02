setwd("/Users/YunusEmreYesildal/Documents/RStudio/Forventning - Faktiske forbrug")
library(readr)
Xfaktiske_forbrug <- read_delim("Documents/RStudio/faktiske_forbrug.csv", 
                                 delim = ";", escape_double = FALSE, trim_ws = TRUE, 
                                 skip = 2)
View(faktiske_forbrug)

faktiske_forbrug <- data.frame(X2023912105322431108860FORV139210826423)



rownames(faktiske_forbrug)<- faktiske_forbrug[ , 1]
Forbruger_forventninger<-Forbruger_forventninger[,-1]


ff_df <- as.data.frame(t(Forbruger_forventninger))

ff_df <-ff_df[-320,]

ff_df <- ff_df[-319,]

ForbtKvat <- data.frame()

for (i in seq(3, nrow(ff_df), by = 3)) {
  mymean <- colMeans(ff_df[(i-2):i, 1:13], na.rm = TRUE)
  new_row <- ff_df[i, 1:13]
  new_row[1, 1:13] <- mymean
  ForbtKvat <- rbind(ForbtKvat, new_row)
  new_row_names <- c()
  
  for (year in 1997:2023) {
    for (quarter in 1:4) {
      new_row_names <- c(new_row_names, paste0(year, " Q", quarter))
    }
  }
  
  row.names(ForbtKvat) <- new_row_names[1:nrow(ForbtKvat)]
  
}


ForbtKvat_afrundet <- round(ForbtKvat, digits = 2)