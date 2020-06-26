#load libraries required
library(dplyr) 

#read the data
data<-readRDS("summarySCC_PM25.rds") 


#Total Emission Data by year for Baltimore city - ted
ted = subset(data,fips=="24510") %>% group_by(year) %>% summarise(sum(Emissions))
colnames(ted) = c("year","emissions") 

#open png file
png(filename = "plot2.png",width = 600,height = 480) 

#Plot the data using plot in BaseR
plot(ted$year,ted$emissions , lwd=3, type="l",col = "coral1",xlab = "Year",ylab = "Emissions (Tons)" , main = "Total Pm2.5 Emissions for Baltimore City from 1999-2008")

points(ted$year,ted$emissions , pch=20,cex=2.5 , col = "darkslateblue")

#Change the X axis a bit

x = c("1999","2001","","2003","","2005","","2007")
axis(side = 1 , at = x)

dev.off()

