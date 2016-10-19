data{
  int<lower=0> N;
  vector[2] x1[N];
  real c;
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
  real d_overC;
  delta = mu[2] - mu[1];
  d_overC = (delta>c? 1:0);
}
