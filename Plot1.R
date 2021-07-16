library("data.table")

SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
SUMM <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

SUMM[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]

totalSUMM <- SUMM[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

png("plot1.png", width=480, height=480)

barplot(totalSUMM[, Emissions]
        , names = totalSUMM[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")

dev.off()
