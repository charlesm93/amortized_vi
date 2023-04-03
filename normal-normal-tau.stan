
data {
  int n;
  vector[n] y;
  real sigma;
}

parameters {
  real theta;
  real log_tau;
  vector[n] z;
}

transformed parameters {
  vector[n] mu = theta + z * exp(log_tau);
}

model {
  log_tau ~ normal(0, 1);
  z ~ normal(0, 1);
  y ~ normal(mu, sigma);
}


