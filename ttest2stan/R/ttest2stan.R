ttest2stan <- function(x,y,c=0,paired=FALSE,iter=2000,chains=4,warmup=1000){
  nx <- length(x)
  ny <- length(y)
  if(paired==FALSE){
    datastan <- list(N1=nx,N2=ny,x1=x,x2=y,c=c)
    model <- stan_model("pairedF.stan",model_name="pairedF")
  }else{
    datastan <- list(N=nx,x1=cbind(x,y),c=c)
    model <- stan_model("pairedT.stan",model_name="pairedT")
  }
  fit <- sampling(model,data=datastan,iter=iter,chain = chains, warmup = warmup)
  return(fit)
}