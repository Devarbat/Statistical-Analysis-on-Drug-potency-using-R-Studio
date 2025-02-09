#Project Deliverable File

#Data

sample_1 <- c(10.2,10.5,10.3,10.8,9.8,10.6,10.7,10.2,10.0,10.6) #Directly tested

sample_2 <- c(9.8,9.6,10.1,10.2,10.1,9.7,9.5,9.6,9.8,9.9) #Tested after 1 year

#Checking Normality

library(car)
qqPlot(sample_1)
qqPlot(sample_2)

#1. (10 points) At the 5% level, does the company have sufficient evidence to 
#conclude that the product that has been stored for one year has average potency less than advertised?

t.test(sample_2, mu = 10, alternative = 'less')

#ANSWER - Yes, with p = 0.026 < 0.05 we can conclude that true mean for sample_2 was less than 10

#
#
#2. (10 points) Create a 95% confidence interval for the median potency using one of the procedures from class. 
#Does this interval suggest that the true median potency is less than advertised?
library(boot)
boot_out <- boot(sample_1,function(dat,inds){median(dat[inds])},R=10000)
boot.ci(boot_out)

#ANSWER - Yes, based on the interval it can be seen that true median potency is less than advertised. 



#
#
#3. (10 points) At the 5% level, does the company have sufficient evidence to conclude that the product 
#that has been stored for one year has average potency less than the product that has not been stored at all?

var.test(sample_1,sample_2) #F test as p-value > 0.05 hence fail to reject null hypothesis - (Pooled test)

t.test(sample_1, sample_2, alt = 'greater',var.equal=TRUE)

# ANSWER - Yes, with p=0.0002 < 0.05 we reject the hypothesis. Hence, true mean for sample_1 > sample_2.


#
#
#4. (10 points) At the 5% level, does the company have sufficient evidence to conclude that the product 
#that has been stored for one year has median potency less than the product that has not been stored at all?


comb_samp <- c(sample_1,sample_2)

set.seed(1)
obs.median.diff <- median(sample_2) - median(sample_1)

nsim <- 100000

sim.median.diff <- rep(NA,length=nsim)

for (i in 1:nsim){
  med_grps <- sample(c(rep(1,10),rep(2,10)),replace=FALSE)
  sim.median.diff[i] <- median(comb_samp[med_grps==1]) - median(comb_samp[med_grps==2])
}

hist(sim.median.diff);abline(v=obs.median.diff,col="blue",lty=2)
length(sim.median.diff[sim.median.diff<=obs.median.diff])/nsim

