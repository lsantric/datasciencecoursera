NEI <- data.table(NEI)
SCC <- data.table(SCC)
setkey(SCC, EI.Sector)
setkey(NEI, fips,SCC)

SCCList <-as.character(SCC[like(EI.Sector,"On-Road")][,SCC])
Aggregated_pollutant <- NEI[list("24510",SCCList)]
Aggregated_pollutantLA <- NEI[list("06037",SCCList)]

setkey(Aggregated_pollutant, year)
Aggregated_pollutant <- Aggregated_pollutant[,sum(Emissions), by = year][2:5,]
setkey(Aggregated_pollutantLA, year)
Aggregated_pollutantLA <- Aggregated_pollutantLA[,sum(Emissions), by = year][2:5,]

Aggregated_pollutant[,"Area" := "Baltimore City"]
Aggregated_pollutantLA[,"Area" := "Los Angeles"]

Aggregated_pollutantAll <- rbind(Aggregated_pollutantLA, Aggregated_pollutant)




plotter <- ggplot(Aggregated_pollutantAll, aes(x=year, y=V1) ) + 
  facet_grid(  Area ~ .,  scales="free_y") +
  geom_bar(stat="identity") + 
  guides(fill=FALSE) +
  xlab("Year") + 
  ylab("Emissions") + 
  ggtitle("Aggregate pollutant emissions from On-road vehicles")

print(plotter)

dev.copy(png,'plot6.png')
dev.off()

