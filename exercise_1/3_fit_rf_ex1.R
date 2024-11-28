# L04 Judging Models ----
# Define and fit random forest model

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

# set seed
set.seed(3012)

# don't worry about hyperparameters (mtry and trees) -- we will cover later
rf_spec <- 
  rand_forest(mtry = 4, trees = 1000) %>%
  set_engine("ranger") %>% 
  set_mode("regression")

# define workflows ----
rf_wflow <-
  workflow() |> 
  add_model(rf_spec) |> 
  add_recipe(aba_recipe)

# fit workflows/models ----
fit_rf <- fit(rf_wflow, abalone_train)

# write out results (fitted/trained workflows) ----

save(fit_rf, file = here("exercise_1/data_split/fit_rf.rda"))

