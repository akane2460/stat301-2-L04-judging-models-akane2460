# L04 Judging Models ----
# Setup pre-processing/recipes

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# read data
load(here("exercise_1/data_split/abalone_train.rda"))

abalone_train <- abalone_train |> select(-rings)

# ex 1

## task 3 ----

# recipe defining
aba_recipe <- recipe(
  age ~ type + shucked_weight + longest_shell + diameter + shell_weight,
  data = abalone_train) |> 
  step_dummy(type) |> 
  step_interact(~ starts_with("type_"):shucked_weight) |> 
  step_interact(~ longest_shell:diameter) |> 
  step_interact(~ shucked_weight:shell_weight) |> 
  step_center(all_predictors()) |> 
  step_scale(all_predictors())

# check recipe
# aba_recipe |>
#   prep() |>
#   bake(new_data = NULL)

# save recipe
save(aba_recipe, file = here("exercise_1/data_split/aba_recipe.rda"))