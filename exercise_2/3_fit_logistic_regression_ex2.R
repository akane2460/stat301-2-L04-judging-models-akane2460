# L04 Judging Models ----
# Define and fit ...

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data
load(here("exercise_2/data_split/titanic_train.rda"))

# load pre-porcessing/feature engineering/recipe
load(here("exercise_2/data_split/titanic_logistic_regression_recipe.rda"))

# model specifications ----
log_reg_spec <- 
  logistic_reg() |> 
  set_engine("glm") |> 
  set_mode("classification") 

# define workflows ----
log_reg_wflow <-
  workflow() |> 
  add_model(log_reg_spec) |> 
  add_recipe(titanic_logistic_regression_recipe)

# fit workflows/models ----
fit_log_reg <- fit(log_reg_wflow, titanic_train)

# write out results (fitted/trained workflows) ----
save(fit_log_reg, file = here("exercise_2/data_split/fit_log_reg.rda"))
