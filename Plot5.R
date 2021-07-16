library("data.table")
library("ggplot2")

SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
SUMM <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

vehiclesSCC <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
                   , SCC]
vehiclesSUMM <- SUMM[SUMM[, SCC] %in% vehiclesSCC,]

baltimoreVehiclesSUMM <- vehiclesSUMM[fips=="24510",]

png("plot5.png")

ggplot(baltimoreVehiclesSUMM,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill ="#FF9999" ,width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.off()
