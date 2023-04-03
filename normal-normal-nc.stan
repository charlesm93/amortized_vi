
data {
  int n;
  vector[n] y;
  real tau;
  real sigma;
}

parameters {
  real theta;
  vector[n] z;
}

transformed parameters {
  vector[n] mu = theta + z * tau;
}

model {
  z ~ normal(0, 1);
  y ~ normal(mu, sigma);
}
