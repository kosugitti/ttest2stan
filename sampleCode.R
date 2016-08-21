x <- rnorm(100,5,4)
y <- rnorm(100,7,3)
t.test(x,y)
require(rstan)
source("ttest2stan.R")
fit <- ttest2stan(x,y,c=0,iter=10000,chains=2,warmup=500)

require(shinyStan)
launch_shinystan(fit)

### Paired comparison
x <- rnorm(10,0,3)
e1 <- rnorm(10,0,3)
e2 <- rnorm(10,0,3)
rho <- 0.8

y1 <- sqrt(rho) * x + sqrt(1-rho)* e1
y2 <- sqrt(rho) * x + sqrt(1-rho)* e2

x1 <- y1 + 2.5
x2 <- y2 + 5.5

t.test(x1,x2,paierd=T)
fit <- ttest2stan(x1,x2,paired=TRUE,iter=2000,chains=2,warmup=500)

