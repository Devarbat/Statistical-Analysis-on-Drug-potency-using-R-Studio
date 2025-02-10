# Statistical-Analysis-on-Drug-potency-using-R-Studio

## Project Overview

The project uses statistical method for analysis of potency of a particular drug over a period of one year. Using the R-studio software two sample are analyzed. Sample_1 is taken directly out of its factor and tested for potency, while Sample_2 is stored for one year and then analyzed for potency.  

## Objectives

Company is advertising that the drug have a potency of 10. To analyze which drug satisfy the company statement. 

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by entering a database named `Sample_1` and `Sample_2`.

```R
sample_1 <- c(10.2,10.5,10.3,10.8,9.8,10.6,10.7,10.2,10.0,10.6) #Directly tested

sample_2 <- c(9.8,9.6,10.1,10.2,10.1,9.7,9.5,9.6,9.8,9.9) #Tested after 1 year
```
- **Checking the normality of data**:

```R
library(car)
qqPlot(sample_1)
qqPlot(sample_2)
```
Output:

![image](https://github.com/Devarbat/Statistical-Analysis-on-Drug-potency-using-R-Studio/blob/29240eea75b1f5d28223ebdf39c1228c37aa36b8/Sample_1.png)
Sample_1

![image_2](https://github.com/Devarbat/Statistical-Analysis-on-Drug-potency-using-R-Studio/blob/29240eea75b1f5d28223ebdf39c1228c37aa36b8/sample_2.png)
Sample_2

### 2. Data Analysis

- 1] **At the 5% level, does the company have sufficient evidence to conclude that the product that has been stored for one year has average potency less than advertised?**

```R
t.test(sample_2, mu = 10, alternative = 'less')
```

Output:

One Sample t-test
data: sample_2
t = -2.2344, df = 9, p-value = 0.02616
alternative hypothesis: true mean is less than 10
95 percent confidence interval:
-Inf 9.969472
sample estimates:
mean of x
9.83

Analysis:
As p-value = 0.026 < 0.05, thus, we reject the null hypothesis. So, the true mean for sample_2 is less than 10. Hence, we can conclude the company has sufficient evidence to conclude that the product that has been stored for one year has an average potency less than advertised.

- 2] **Create a 95% confidence interval for the median potency using one of the procedures from class. Does this interval suggest that the true median potency is less than advertised?**

```R
library(boot)
boot_out <- boot(sample_1,function(dat,inds){median(dat[inds])},R=10000)
boot.ci(boot_out)
```

Output:

BOOTSTRAP CONFIDENCE INTERVAL CALCULATIONS
Based on 10000 bootstrap replicates
CALL :
boot.ci(boot.out = boot_out)
Intervals :
Level Normal Basic
95% ( 9.570, 10.011 ) ( 9.500, 10.000 )
Level Percentile BCa
95% ( 9.60, 10.10 ) ( 9.60, 9.95 )
Calculations and Intervals on Original Scale

Analysis:
The confidence interval for the median potency is (9.60,9.95). Based on the interval, it can be concluded that the true median potency is less than advertised.

- 3] **At the 5% level, does the company have sufficient evidence to conclude that the product that has been stored for one year has an average potency less than the product that has not been stored at all?**

```R
var.test(sample_1,sample_2) #F test to check for Pooled or Non-Pooled test

t.test(sample_1, sample_2, alt = 'greater',var.equal=TRUE)
```

Output:

F test to compare two variances
data: sample_1 and sample_2
F = 1.8061, num df = 9, denom df = 9, p-value = 0.3917
alternative hypothesis: true ratio of variances is not
equal to 1
95 percent confidence interval:
0.4486201 7.2715173
sample estimates:
ratio of variances
1.806142

Two Sample t-test
data: sample_1 and sample_2
t = 4.2368, df = 18, p-value = 0.000248
alternative hypothesis: true difference in means is
greater than 0
95 percent confidence interval:
0.3189872 Inf
sample estimates:
mean of x mean of y
10.37 9.83

Analysis:

F Test -
As p-value 0.3917 > 0.05. Hence, we fail to reject the null hypothesis. So, we will conduct the
Pooled test. 

Two-sample T-Test
As p-value = 0.0002< 0.05, thus, we reject the null hypothesis. So, the true mean for sample_1 is greater than sample_2. Hence, we can conclude that the company has sufficient evidence to conclude that the product that has been stored for one year has an average potency less than the product that has not been stored at all.

- 4] **At the 5% level, does the company have sufficient evidence to conclude that the product that has been stored for one year has median potency less than the product that has not been stored at all?**

```R
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
```

Output:

![image_3](https://github.com/Devarbat/Statistical-Analysis-on-Drug-potency-using-R-Studio/blob/29240eea75b1f5d28223ebdf39c1228c37aa36b8/Histogram.png)
[1] 0.00143

### 3. Findings

From the above analysis, it can be concluded that the company has sufficient evidence to conclude that the **average potency** and **true median potency** for `sample_2` is **less** than that of `sample_1` and also what is advertised. Hence, they **cannot sell** the **bottles** that have been **stored for one year**.




