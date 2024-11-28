# L04 Judging Models ----
# Setup pre-processing/recipes

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# read data
load(here("exercise_2/data_split/titanic_train.rda"))

skimr::skim(titanic_train)

# recipe defining

# logistic regression
titanic_logistic_regression_recipe <- recipe(
  survived ~ pclass + age + sex + sib_sp + parch + fare,
  data = titanic_train) |> 
  step_impute_linear(age) |> 
  step_dummy(all_nominal_predictors()) |> 
  step_interact(~ fare:starts_with("sex")) |> 
  step_interact(~ fare:starts_with("age")) 

# check recipe
# titanic_logistic_regression_recipe |>
#   prep() |>
#   bake(new_data = NULL)

# save recipe
save(titanic_logistic_regression_recipe, file = here("exercise_2/data_split/titanic_logistic_regression_recipe.rda"))

# tree based regression
titanic_tree_based_recipe <- recipe(
  survived ~ pclass + age + sex + sib_sp + parch + fare,
  data = titanic_train) |> 
  step_impute_linear(age) |> 
  step_dummy(all_nominal_predictors())

# check recipe
# titanic_tree_based_recipe |>
#   prep() |>
#   bake(new_data = NULL)

# save recipe
save(titanic_tree_based_recipe, file = here("exercise_2/data_split/titanic_tree_based_recipe.rda"))


