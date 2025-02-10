# Statistical-Analysis-on-Drug-potency-using-R-Studio

## Project Overview

The project uses statistical method for analysis of potency of a particular drug over a period of one year. Using the R-studio software two sample are analyzed. Sample_1 is taken directly out of its factor and tested for potency, while Sample_2 is stored for one year and then analyzed for potency.  

## Objectives

Company is advertising that the drug have a potency of 10. To analyze which drug satify the company statement. 

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

