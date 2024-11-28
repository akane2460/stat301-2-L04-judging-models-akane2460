# L04 Judging Models ----
# Define and fit ordinary linear regression

# load packages ----
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
lm_spec <- 
  linear_reg() |> 
  set_engine("lm") |> 
  set_mode("regression") 

# define workflows ----
lm_wflow <-
  workflow() |> 
  add_model(lm_spec) |> 
  add_recipe(aba_recipe)

# fit workflows/models ----
fit_lm <- fit(lm_wflow, abalone_train)

# write out results (fitted/trained workflows) ----
save(fit_lm, file = here("exercise_1/data_split/fit_lm.rda"))
