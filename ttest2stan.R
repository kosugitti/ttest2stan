ttest2stan <- function(x,y,c=1,iter=2000,chains=4,warmup=1000){
  nx <- length(x)
  ny <- length(y)
  datastan <- list(N1=nx,N2=ny,x1=x,x2=y,c=c)
  stancode <- '
  data{
    int<lower=0> N1;
    int<lower=0> N2;
    real<lower=0> x1[N1];
    real<lower=0> x2[N2];
    real c;
  }
  parameters{
    real mu1;
    real mu2;
    real<lower=0> sigma1;
    real<lower=0> sigma2;
  }
  model{
    x1 ~ normal(mu1,sigma1);
    x2 ~ normal(mu2,sigma2);
  }
  generated quantities{
    real delta;
    real d_over;
    real d_overC;
    delta <- mu2 - mu1;
    d_over <- if_else(delta>0,1,0);
    d_overC <- if_else(delta>c,1,0);
  }
  '
  model <- stan_model(model_code=stancode)
  fit <- sampling(model,data=datastan,iter=iter,chain = chains, warmup = warmup)
  return(fit)
}