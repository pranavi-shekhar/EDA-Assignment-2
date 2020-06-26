#load libraries required
library(dplyr)


#set options for sessions
options(scipen = 999)

#read the data
data<-readRDS("summarySCC_PM25.rds") 

#Total Emission Data by year - ted
ted = data %>% group_by(year) %>% summarise(sum(Emissions))
colnames(ted) = c("year","emissions") 

#open png file
png(filename = "plot1.png",width = 600,height = 600) 

#Plot the data using bar plot in BaseR
b = barplot(ted[["emissions"]],names.arg = ted[["year"]] , ylim=range(pretty(c(0,ted[[2]]))) , xlab = "Year" , ylab = "Emissions (Tons)" , col = "darkslateblue", main = "Total Pm2.5 Emissions in USA from 1999-2008") 

#Give labels for the bars
text(x=b , y=ted[["emissions"]] , labels = round(ted[["emissions"]]),pos = 3 , col = "coral1",font = 2) 

dev.off()

