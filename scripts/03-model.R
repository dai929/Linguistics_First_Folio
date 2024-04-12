#### Preamble ####
# Purpose: Build a generalized linear model and estimate the model.
# Author: Daisy Huo
# Date: 7 April 2024
# Contact: daisy.huo@mail.utoronto.ca
# License: MIT
# Pre-requisites: N/A

#### Workspace setup ####
library(tidyverse)
library(dataverse)
library(arrow)
library(modelsummary)
library(rstanarm)
library(marginaleffects)

#### Build model ####
# Refer to code from: https://tellingstorieswithdata.com/13-ijaglm.html#letters-used-in-jane-eyre
first_folio_vowel_counts <-
  stan_glm(
    count_vowel ~ word_count,
    data = first_folio_reduced,
    family = poisson(link = "log"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 312
  )

saveRDS(
  first_folio_vowel_counts,
  file = "first_folio_vowel_counts.rds"
)

first_folio_vowel_counts <-
  readRDS(file = "outputs/data/first_folio_vowel_counts.rds")