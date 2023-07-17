
# HMM counter example

.libPaths("~/Rlib/")
library(ggplot2)
library(latex2exp)

set.seed(1954)

N = 100

generate_x <- function(N) {
  z = rep(NA, N)
  x = rep(NA, N)
  
  z[1] = rnorm(1)
  x[1] = rnorm(1, z[1])
  
  for (n in 2:N) {
    z[n] = rnorm(1, z[n - 1])
    x[n] = rnorm(1, z[n])
  }
}

alpha = 1
beta = 3
gamma = -2

Psi = matrix(0, nrow = N, ncol = N)
diag(Psi) = beta
Psi[1, 1] = alpha
for (i in 1:(N - 1)) {
  Psi[i, i + 1] = gamma
  Psi[i + 1, i] = gamma
}

mu = solve(Psi, x)

# Set x's equal, but show they still have a different mean
x[49] = x[50]
mu = - 2 * solve(Psi, x)

mu[49]   # 0.8485943
mu[50]   # -0.2128043


# Set all x's equal except the first and last x.
# x = rep(rnorm(1), N)
x = rep(1, N)
mu = - 2 * solve(Psi, x)

p <- ggplot(data = data.frame(n = 1:N, mu = mu), aes(x = n, y = mu)) +
  geom_line() + geom_point() + theme_bw() + ylab(TeX("$\\nu^*$")) +
  theme(text = element_text(size = 15))
p
