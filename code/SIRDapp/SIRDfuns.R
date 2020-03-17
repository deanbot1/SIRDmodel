require(ggplot2)
require(deSolve)

SIRDsim <- function(popsize=10000,phixsi=0.25,txsi=30,hsc=0.1,I0=0.01,kr=1,xsi=2,d=0.08,phid=2,autoscale=TRUE){

parameters<-c(kr=kr,xsi=xsi,phixsi=phixsi,txsi=txsi,d=d,phid=phid,h=hsc)
# kr = recovery rate (1/day)
# xsi = efficiency of transmission from infected to susceptible (1/day)
# phixsi = safeness multiplier on xsi (fraction)
# txsi = days of delay before people start acting safely (days)
# d = death rate of infected people who don't exceed hsc (1/day)
# phid = multiplier on death rate d for people exceeding hsc (1)
# hsc = health care system capacity as fraction of total population (fraction)

state<-c(S=1-I0,I=I0,R=0,D=0)
# S = Susceptible population fraction (dimensionless)
# I = Infected population fraction (dimensionless)
# R = Recovered population fraction (dimensionless)
# D = Deceased population fraction (dimensionless)

#popsize <- 10000 # hypothetical population size (doesn't change anything)

SIRDode <- function(t,state,parameters){
  with(as.list(c(state,parameters)),{
       
       xxx <- xsi
       if(t>txsi){xxx<-xsi*phixsi}
       delt <- d*(min(I,h)+phid*max(0,I-h)) # only the infected in excess of hsc experience elevated death rate
       dSdt <- -xxx*I*S
       dIdt <-  xxx*I*S - kr*I - delt
       dRdt <- kr*I
       dDdt <- delt
       
       list(c(dSdt,dIdt,dRdt,dDdt))
  })
}

times<-seq(0,200,by=0.1)

out<-ode(y=state,times=times,func=SIRDode,parms=parameters)
outf <-as.data.frame(out)
#outf$R <- 1-outf$S-outf$I-outf$D # conservation law
T <- c(times,times,times,times)
Y <- popsize*c(outf$S,outf$I,outf$R,outf$D)
G <- c(rep('Susceptible',times=length(times)),rep('Infected',times=length(times)),rep('Recovered',times=length(times)),rep('Deceased',times=length(times)))
outff <- data.frame(T,Y,G)
outff$G <- factor(outff$G,levels=c('Susceptible','Recovered','Deceased','Infected'))

ylim <- c(0.5,popsize)
if(autoscale==TRUE){ylim<-c(0.5,1.1*max(max(popsize*(outf$I + outf$D)),popsize*hsc))}

require(scales)
options(scipen=999)

ggplot(outff,aes(x=T,y=Y,color=G)) + geom_line(size=2) + geom_hline(yintercept=popsize*hsc,linetype='dashed',color='black') + 
  ggtitle(paste("Hypothetical scenario results in ", round(outf$D[length(times)]*popsize,digits=0),' of ', popsize, ' Deceased after ',max(times),' days')) + 
  xlab('days') + ylab('number of cases') + theme(plot.title=element_text(face='bold',color='red',hjust=0.5)) +
  #scale_fill_manual(values=c('green','yellow','red','purple')) + 
  coord_cartesian(xlim=c(min(times),max(times)),ylim=ylim) +
  geom_vline(xintercept=txsi,linetype='dashed',color='black') + scale_y_log10(labels=comma,breaks=10.^(0:ceiling(log10(popsize)))) 

# ggplot(outff,aes(x=T,y=Y,fill=G)) + geom_area() + geom_hline(yintercept=popsize*hsc,linetype='dashed',color='black') + 
#   ggtitle(paste("Hypothetical scenario results in ", round(outf$D[length(times)]*popsize,digits=0),' of ', popsize, ' Deceased after ',max(times),' days')) + 
#   xlab('days') + ylab('number of cases') + theme(plot.title=element_text(face='bold',color='red',hjust=0.5)) +
#   scale_fill_manual(values=c('green','yellow','red','purple')) + 
#   coord_cartesian(xlim=c(min(times),max(times)),ylim=ylim) +
#   geom_vline(xintercept=txsi,linetype='dashed',color='black')


}

