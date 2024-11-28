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
load(here("exercise_2/data_split/titanic_tree_based_recipe.rda"))

# model specifications task 6----
random_forest_spec_task6 <-
  rand_forest() |>
  set_engine("ranger") |>
  set_mode("classification")

# define workflow
random_forest_wflow <-
  workflow() |>
  add_model(random_forest_spec_task6) |>
  add_recipe(titanic_tree_based_recipe)

# fit workflows/models
fit_rf_task6 <- fit(random_forest_wflow, data = titanic_train)

# write out results (fitted/trained workflows)
save(fit_rf_task6, file = here("exercise_2/data_split/fit_rf_task6.rda"))

# model specifications task 7----
random_forest_spec_task7 <-
  rand_forest(mtry = 2, trees = 1000, min_n = 2) |>
  set_engine("ranger") |>
  set_mode("classification")

# define workflows
random_forest_wflow_task7 <-
  workflow() |>
  add_model(random_forest_spec_task7) |>
  add_recipe(titanic_tree_based_recipe)

# fit workflows/models
fit_rf_task7 <- fit(random_forest_wflow_task7, data = titanic_train)

# write out results (fitted/trained workflows)
save(fit_rf_task7, file = here("exercise_2/data_split/fit_rf_task7.rda"))

