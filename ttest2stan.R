ttest2stan <- function(x,y,c=1,paired=FALSE,iter=2000,chains=4,warmup=1000){
  nx <- length(x)
  ny <- length(y)
  if(paired==FALSE){
    datastan <- list(N1=nx,N2=ny,x1=x,x2=y,c=c)
    stancode <- '
      data{
      int<lower=0> N1;
      int<lower=0> N2;
      real x1[N1];
      real x2[N2];
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
      real cohen_d;
      delta = mu2 - mu1;
      d_over = (delta>0? 1:0 );
      d_overC = (delta>c? 1:0);
      cohen_d = delta /((sigma1^2*(N1-1)+sigma2^2*(N2-1)) /((N1-1)+(N2-1)))^0.5;
    }
    '    
  }else{
    datastan <- list(N=nx,x1=cbind(x,y))
    stancode <- '
    data{
      int<lower=0> N;
      vector[2] x1[N];
    }
    parameters{
      vector[2] mu;
      vector<lower=0>[2] sigma;
      real<lower=-1,upper=1> rho;
    }
    transformed parameters{
      matrix[2,2] Sigma;
      vector<lower=0>[2] sigmasq;
      sigmasq[1] = pow(sigma[1],2);
      sigmasq[2] = pow(sigma[2],2);
      Sigma[1,1] = sigmasq[1];
      Sigma[2,2] = sigmasq[2];
      Sigma[1,2] = sigma[1] * sigma[2] * rho;
      Sigma[2,1] = sigma[2] * sigma[1] * rho;
    }
    model{
      for(i in 1:N)
        x1[i] ~ multi_normal(mu,Sigma);
    }
    generated quantities{
      real delta;
      real d_over;
      delta = mu[2] - mu[1];
      d_over =(delta>0 ? 1 : 0);
    }
    '      
    }

  model <- stan_model(model_code=stancode)
  fit <- sampling(model,data=datastan,iter=iter,chain = chains, warmup = warmup)
  return(fit)
}