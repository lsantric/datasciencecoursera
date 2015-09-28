

NEI <- data.table(NEI)
setkey(NEI, year)

Aggregated_pollutant = NEI[,sum(Emissions), by = year]

barplot(Aggregated_pollutant[[2]], Aggregated_pollutant[["year"]], 
            names = list("1999", "2002", "2005", "2008"), 
            ylim=c(0,7500000),
            main = "Aggregated pollutant levels",
            ylab="Pollutant emissions",
            xlab="Year"
        )

dev.copy(png,'plot1.png')
dev.off()

