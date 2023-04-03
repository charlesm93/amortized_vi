
rm(list = ls())
gc()
.libPaths("~/Rlib/")
setwd("~/Code/amortized_vi")
set.seed(1954)

library(cmdstanr)

n <- 10
y <- rnorm(n, 0, 10)
# y <- c(-1.77980995, 3.31378778, 1.88207342, -0.71123601, 3.89777947)
tau = 1.155 # 1000 1.155
sigma = 2.43 # 0.001 2.43
data <- list(n = n, y = y, tau = tau, sigma = sigma)

# options: "normal-normal", "normal-normal-nc", "normal-normal-tau"
model_name <- "normal-normal-tau.stan"
mod <- cmdstan_model(model_name)

fit <- mod$sample(
  data = data,
  seed = 123,
  chains = 4,
  parallel_chains = 4,
  iter_sampling = 10000, refresh = 1000
)

# this can take a long time if the groups are large.
fit$summary()


draws <- fit$draws(c("z[1]", "z[2]", "z[3]"))
cov(draws[, , 2], draws[, , 3]) / var(draws[, , 1])


# Fit model with ADVI (which uses a form of mean-field...)

fit_vb <- mod$variational(data = data, seed = 123)
fit_vb$summary()


###############################################################################
## Analytical benchmarks

## Calculations for bivariate (n = 2) case for centered parameterization
mean(y)
sqrt(sigma^2 / n + tau^2 / n)

rho <- (1 / tau^2) / (n / sigma^2 + 1 / tau^2)
rho

xi <- sqrt(2 * tau^2 * rho / (1 - rho^2))
xi

nu_1 = (y[4] / sigma^2 + mean(y) / tau^2) / (1 / sigma^2 + 1 / tau^2)
nu_1

nu_2 = (y[2] / sigma^2 + mean(y) / tau^2) / (1 / sigma^2 + 1 / tau^2)
nu_2

## Estimates for non-centered gaussian variable
# rho_alpha = 1 / (2 * sigma^2 + 1)

rho_z = (1 / sigma^2) / (n / tau^2 + 1 / sigma^2)
rho_z

xi_z = sqrt( 2 * sigma^2 / tau^2 * rho_alpha / (1 - rho_alpha^2))
xi_z

nu_z1 = y[1] / tau - (y[1] / tau^2 + mean(y) / sigma^2) / 
         (tau * (1 / tau^2 + 1 / sigma^2))
nu_z1

nu_z1 = y[2] / tau - (y[2] / tau^2 + mean(y) / sigma^2) / 
  (tau * (1 / tau^2 + 1 / sigma^2))
nu_z1

## Correlation between theta and mu1
draws <- fit$draws(c("theta", "mu[1]"))
cov(draws[, , 1], draws[, , 2]) / sqrt(var(draws[, , 1]) * var(draws[, , 2]))

rho <- (sigma / sqrt(n)) / sqrt(sigma^2 / n + tau^2)
rho


## Correlation between theta and z1
draws <- fit$draws(c("theta", "z[1]"))
cov(draws[, , 1], draws[, , 2]) / sqrt(var(draws[, , 1]) * var(draws[, , 2]))

rho <- - (tau / sqrt(n)) / sqrt(tau^2 / n + sigma^2)
rho


