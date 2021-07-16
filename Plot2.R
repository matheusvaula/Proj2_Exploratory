library("data.table")

SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
SUMM <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

SUMM[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
totalSUMM <- SUMM[fips=='24510', lapply(.SD, sum, na.rm = TRUE)
                , .SDcols = c("Emissions")
                , by = year]

png('plot2.png')

barplot(totalSUMM[, Emissions]
        , names = totalSUMM[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")

dev.off()
