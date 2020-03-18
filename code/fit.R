source("./SIRDapp/SIRDfuns.R")
require(minpack.lm)
library(reshape2)


data.confirmed  <- read.csv('../data/time_series_19-covid-Confirmed.csv',header=TRUE) 
data.deceased  <- read.csv('../data/time_series_19-covid-Deaths.csv',header=TRUE)
data.recovered <- read.csv('../data/time_series_19-covid-Recovered.csv',header=TRUE)

# how to isolate say italy

countries = c('Italy') # which countries to fit
pops = 60317546; # corresponding populations of countries

for (j in 1:length(countries)){
con <-as.numeric(data.confirmed[data.confirmed$Country.Region==countries[j],])
con <- con[5:length(con)]
dec <-as.numeric(data.deceased[data.deceased$Country.Region==countries[j],])
dec <- dec[5:length(dec)]
rec <-as.numeric(data.recovered[data.recovered$Country.Region==countries[j],])
rec <- rec[5:length(rec)]
time <- 0:(length(rec)-1)
inf <- con-(dec+rec) # infected
sus <- pops[j] - (inf+dec+rec) # susceptible

df = data.frame(time,sus,inf,rec,dec,con)

}