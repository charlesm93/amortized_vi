Deprecated: please go to https://github.com/charlesm93/AVI-when-and-why.

# Supplemental to the paper "Amortized Variational Inference: when and why?"

This repository contains code to reproduce the figures and tables of the paper "Amortized Variational Inference: when and why?" by Charles Margossian and David Blei. The jupyter notebooks can be used to run the experiments in section 4, respectively for the linear, nonlinear, VAE, and timeseries examples. Some of these experiments take a long time to run, so the results of the experiments are saved in the `deliv` directory and can be loaded in the `analyze results` section of the notebooks. Note that we used a GPU to run this code.

In addition, the script `hmm_counter_example.R` provides the code to build a counter-example in the hidden Markov model (HMM) case, demonstrating a learnable function may not exist for HMMs.
