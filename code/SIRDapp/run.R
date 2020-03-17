source('SIRDfuns.R')
SIRDsim(popsize=100000,phixsi=.12,txsi=0,xsi=6,hsc=0.05/100,I0=0.01/100,d=0.01,kr=2,phid=2,autoscale=FALSE)
