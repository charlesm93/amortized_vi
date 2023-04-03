
data {
  int n;
  vector[n] y;
  real tau;
  real sigma;
}

parameters {
  real theta;
  vector[n] mu;
}

model {
  mu ~ normal(theta, tau);
  y ~ normal(mu, sigma);
}
