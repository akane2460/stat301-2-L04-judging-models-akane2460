# L04 Judging Models ----
# Define and fit penalized regression (lasso)

## load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data
load(here("exercise_1/data_split/abalone_train.rda"))

# load pre-porcessing/feature engineering/recipe
load(here("exercise_1/data_split/aba_recipe.rda"))

# model specifications ----
# set penalty = 0.03
# mixture = 1 specifies lasso; mixture = 0 for ridge
ridge_spec <- 
  linear_reg(penalty = 0.03, mixture = 0) %>% 
  set_engine("glmnet") %>% 
  set_mode("regression")

# define workflows ----
ridge_wflow <-
  workflow() |> 
  add_model(ridge_spec) |> 
  add_recipe(aba_recipe)

# fit workflows/models ----
fit_ridge <- fit(ridge_wflow, abalone_train)

# write out results (fitted/trained workflows) ----

save(fit_ridge, file = here("exercise_1/data_split/fit_ridge.rda"))

