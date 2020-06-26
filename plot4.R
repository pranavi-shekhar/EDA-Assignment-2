#load libraries required
library(dplyr)

#read the data
data<-readRDS("summarySCC_PM25.rds") 
scc=readRDS("Source_Classification_Code.rds")

# identify SCCs for coal based sources
scc.for.coal = scc[grep("Coal",scc$EI.Sector),1]

#Total Emission Data by year from coal sources - ted
ted = subset(data , data$SCC %in% scc.for.coal) %>%  group_by(year) %>% summarise(sum(Emissions))
colnames(ted) = c("year","emissions") 

#open png file
png(filename = "plot4.png",width = 600,height = 480)

#Plot the data using plot in BaseR
plot(ted$year,ted$emissions , lwd=3, type="l",col = "coral1",xlab = "Year",ylab = "Emissions (Tons)",main = "Total Pm2.5 Emissions from coal based sources")

points(ted$year,ted$emissions , pch=20,cex=2.5 , col = "darkslateblue")

#Change the X axis a bit

x = c("1999","2001","","2003","","2005","","2007")
axis(side = 1 , at = x)

dev.off()
