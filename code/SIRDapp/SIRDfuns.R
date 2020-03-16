require(ggplot2)
require(deSolve)

SIRDsim <- function(phixsi=0.25,txsi=30,hsc=0.1,I0=0.01,MTT=7,xsi=2,d=0.08,phid=2){

parameters<-c(MTT=MTT,xsi=xsi,phixsi=phixsi,txsi=txsi,d=d,phid=phid,h=hsc)
# MTT = "mean transit time" of disease in infected stage (days)
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

SIRDode <- function(t,state,parameters){
  with(as.list(c(state,parameters)),{
       
       k    <-2/MTT 
       xxx <- xsi
       if(t>txsi){xxx<-xsi*phixsi}
       delt <- d*(min(I,h)+phid*max(0,I-h)) # only the infected in excess of hsc experience elevated death rate
       dSdt <- -xxx*I*S
       dIdt <-  xxx*I*S - k*I
       dRdt <- (1-delt)*k*I
       dDdt <- delt*k*I
       
       list(c(dSdt,dIdt,dRdt,dDdt))
  })
}

times<-seq(0,100,by=0.1)

out<-ode(y=state,times=times,func=SIRDode,parms=parameters)
outf <-as.data.frame(out)
T <- c(times,times,times,times)
Y <- 100*c(outf$S,outf$I,outf$R,outf$D)
G <- c(rep('Susceptible',times=length(times)),rep('Infected',times=length(times)),rep('Recovered',times=length(times)),rep('Deceased',times=length(times)))
outff <- data.frame(T,Y,G)
outff$G <- factor(outff$G,levels=c('Susceptible','Recovered','Deceased','Infected'))

ggplot(outff,aes(x=T,y=Y,fill=G)) + geom_area() + geom_hline(yintercept=100*hsc,linetype='dashed',color='black') + 
  ggtitle(paste("Simulated scenario results in ", round(outf$D[length(times)]*100,digits=2),'% of population Deceased')) + 
  xlab('days') + ylab('% of population') +
  scale_fill_manual(values=c('green','yellow','red','purple'))


}
