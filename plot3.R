#load libraries required
library(dplyr)
library(ggplot2)

#read the data
data<-readRDS("summarySCC_PM25.rds") 

#Total Emission Data by year and type - ted
ted = data %>% group_by(year,type) %>% summarise(sum(Emissions))
colnames(ted)[3] = "emissions"


#open png file
png(filename = "plot3.png",width = 1200,height = 800) 

#Plot the data using bar plot using ggplot2
g = ggplot(ted,aes(x=year,y=emissions))

g + 
geom_bar(stat = "identity", fill = "darkslateblue") + 
facet_grid(rows=.~type) + 
scale_x_continuous(breaks = c(1999,2002,2005,2008)) + 
labs(x="\n\nYEAR",y="EMISSIONS (Tons) \n\n",cex=2.5) + 
theme(axis.text.x = element_text(size = 18) , axis.text.y = element_text(size=18) , axis.title = element_text(size=18) , strip.text = element_text(size=18) , plot.title = element_text(size = 20,hjust = 0.5)) +
ggtitle("Types of Pm2.5 emissions for Baltimore City from 1999-2008\n\n")

dev.off()
