NEI <- data.table(NEI)
SCC <- data.table(SCC)
setkey(SCC, EI.Sector)
setkey(NEI, SCC)

SCCList <-as.character(SCC[like(EI.Sector,"Coal")][,SCC])
Aggregated_pollutant <- NEI[SCCList]

setkey(Aggregated_pollutant, year)
Aggregated_pollutant <- Aggregated_pollutant[,sum(Emissions), by = year][2:5,]

plotter <- ggplot(Aggregated_pollutant, aes(x=year, y=V1) ) + 
  geom_bar(stat="identity") + 
  guides(fill=FALSE) +
   xlab("Year") + 
  ylab("Emissions") + 
  ggtitle("Aggregate pollutant emissions from Coal sources")

print(plotter)

dev.copy(png,'plot4.png')
dev.off()

