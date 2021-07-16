library("data.table")
library("ggplot2")

SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
SUMM <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehiclesSCC <- SCC[condition, SCC]
vehiclesSUMM <- SUMM[SUMM[, SCC] %in% vehiclesSCC,]

vehiclesBaltimoreSUMM <- vehiclesSUMM[fips == "24510",]
vehiclesBaltimoreSUMM[, city := c("Baltimore City")]

vehiclesLASUMM <- vehiclesSUMM[fips == "06037",]
vehiclesLASUMM[, city := c("Los Angeles")]

bothSUMM <- rbind(vehiclesBaltimoreSUMM,vehiclesLASUMM)

png("plot6.png")

ggplot(bothSUMM, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()
