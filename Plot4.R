library("data.table")
library("ggplot2")

SCC <- as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
SUMM <- as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

combustionRelated <- grepl("comb", SCC[, SCC.Level.One], ignore.case=TRUE)
coalRelated <- grepl("coal", SCC[, SCC.Level.Four], ignore.case=TRUE) 
combustionSCC <- SCC[combustionRelated & coalRelated, SCC]
combustionSUMM <- SUMM[SUMM[,SCC] %in% combustionSCC]

png("plot4.png")

ggplot(combustionSUMM,aes(x = factor(year),y = Emissions/10^5)) +
  geom_bar(stat="identity", fill ="#FF9999", width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

dev.off()
