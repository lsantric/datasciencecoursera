NEI <- data.table(NEI)
setkey(NEI, fips)

Aggregated_pollutant <- NEI[fips == "24510"]

setkey(Aggregated_pollutant, year)
Aggregated_pollutant <- Aggregated_pollutant[,sum(Emissions), by = year]

barplot(Aggregated_pollutant[[2]], Aggregated_pollutant[["year"]], 
        names = list("1999", "2002", "2005", "2008"),
        main = "Aggregated pollutant levels",
        ylab="Pollutant emissions",
        xlab="Year"
)

dev.copy(png,'plot2.png')
dev.off()

