# L04 Judging Models ----
# Define and fit penalized regression (lasso)

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load training data
load(here("exercise_1/data_split/abalone_train.rda"))

# load pre-processing/feature engineering/recipe
load(here("exercise_1/data_split/aba_recipe.rda"))

# model specifications ----
# set penalty = 0.03
# mixture = 1 specifies lasso; mixture = 0 for ridge
lasso_spec <- 
  linear_reg(penalty = 0.03, mixture = 1) %>% 
  set_engine("glmnet") %>% 
  set_mode("regression")

# define workflows ----
lasso_wflow <-
  workflow() |> 
  add_model(lasso_spec) |> 
  add_recipe(aba_recipe)

# fit workflows/models ----
fit_lasso <- fit(lasso_wflow, abalone_train)

# write out results (fitted/trained workflows) ----

save(fit_lasso, file = here("exercise_1/data_split/fit_lasso.rda"))