NEI <- data.table(NEI)
setkey(NEI, fips, type)

Aggregated_pollutant1 <- NEI[list("24510","POINT")]


Aggregated_pollutant1 <- Aggregated_pollutant1[,sum(Emissions), by = year]




Aggregated_pollutant2 <- NEI[list("24510","NONPOINT")]


Aggregated_pollutant2 <- Aggregated_pollutant2[,sum(Emissions), by = year]


Aggregated_pollutant3 <- NEI[list("24510","ON-ROAD")]


Aggregated_pollutant3 <- Aggregated_pollutant3[,sum(Emissions), by = year]



Aggregated_pollutant4 <- NEI[list("24510","NON-ROAD")]


Aggregated_pollutant4 <- Aggregated_pollutant4[,sum(Emissions), by = year]



Aggregated_pollutantUK <- Aggregated_pollutant1
Aggregated_pollutantUK$V2 <- Aggregated_pollutant2$V1
Aggregated_pollutantUK$V3 <- Aggregated_pollutant3$V1
Aggregated_pollutantUK$V4 <- Aggregated_pollutant4$V1


Aggregated_pollutantUK <- data.table(Aggregated_pollutantUK)
setNames(Aggregated_pollutantUK, c("YEAR","POINT", "NONPOINT", "ONROAD", "NONROAD"))
rownames(Aggregated_pollutantUK) <- c("1999","2002","2005","2008")
Aggregated_pollutantUK$YEAR <- NULL
Aggregated_pollutantUK <- melt(as.matrix(Aggregated_pollutantUK))

plotter <- ggplot(Aggregated_pollutantUK, aes(x=Var1, y=value)) + 
          geom_bar(stat="identity") + 
          guides(fill=FALSE) +
          facet_wrap( ~ Var2, ncol=2, scales="free_y") +
          xlab("Year") + 
          ylab("Emissions") + 
          ggtitle("Aggregate pollutant emissions by source")

print(plotter)
  
dev.copy(png,'plot3.png')
dev.off()

