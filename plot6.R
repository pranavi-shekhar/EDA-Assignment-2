#load libraries required
library(dplyr)
library(ggplot2)

#read the data
data<-readRDS("summarySCC_PM25.rds") 
scc=readRDS("Source_Classification_Code.rds")

# identify SCCs for motor vehicles - Locomotives and On-road heavy duty vehicles
scc.for.motor = scc[grep("Locomotives|On-Road",scc$EI.Sector),1]

#Total Emission Data by year from coal sources - ted
ted = subset(data,(fips=="24510" |fips == "06037") & data$SCC %in% scc.for.motor )  %>%  group_by(year , fips) %>% summarise(sum(Emissions))
colnames(ted) = c("year","fips","emissions") 


#open png file
png(filename = "plot6.png",width = 1200,height = 800) 

#Plot the data using bar plot using ggplot2
g = ggplot(ted,aes(x=year,y=emissions))

g + 
  geom_bar(stat = "identity", fill = "cornflowerblue") + 
  facet_grid(rows=.~fips , labeller = labeller(fips = cities)) + 
  scale_x_continuous(breaks = c(1999,2002,2005,2008)) + 
  labs(x="\nYEAR",y="EMISSIONS (Tons) \n\n",cex=2.5) + 
  theme(axis.text.x = element_text(size = 18) , axis.text.y = element_text(size=18) , axis.title = element_text(size=18) , strip.text = element_text(size=18), plot.title = element_text(size = 20,hjust = 0.5)) +
  ggtitle("Total Pm2.5 Emissions from motor vehicles - LA vs Baltimore City\n\n")

dev.off()

