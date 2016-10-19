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
  real d_overC;
  real cohen_d;
  delta = mu2 - mu1;
  d_overC = (delta>c? 1:0);
  cohen_d = delta /((sigma1^2*(N1-1)+sigma2^2*(N2-1)) /((N1-1)+(N2-1)))^0.5;
}
