# L04 Judging Models ----
# Analysis of trained models 

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(yardstick)

# handle common conflicts
tidymodels_prefer()

# load test data----
load(here("exercise_1/data_split/abalone_test.rda"))

# load trained models----
load(here("exercise_1/data_split/fit_lm.rda"))
load(here("exercise_1/data_split/fit_lasso.rda"))
load(here("exercise_1/data_split/fit_ridge.rda"))
load(here("exercise_1/data_split/fit_rf.rda"))

# create metric set
ames_metrics <- metric_set(rmse, rsq, mae)

# predicted vs. test value tibble
predicted_lm <- bind_cols(abalone_test, predict(fit_lm, abalone_test)) |> 
  select(age, .pred)

predicted_lasso <- bind_cols(abalone_test, predict(fit_lasso, abalone_test)) |> 
  select(age, .pred)

predicted_ridge <- bind_cols(abalone_test, predict(fit_ridge, abalone_test)) |> 
  select(age, .pred)

predicted_rf <- bind_cols(abalone_test, predict(fit_rf, abalone_test)) |> 
  select(age, .pred)

# apply metric sets----
# lm
ames_metrics_applied_lm <- ames_metrics(predicted_lm, truth = age, estimate = .pred)

# lasso
ames_metrics_applied_lasso <- ames_metrics(predicted_lasso, truth = age, estimate = .pred)

# ridge
ames_metrics_applied_ridge <- ames_metrics(predicted_ridge, truth = age, estimate = .pred)

# rf
ames_metrics_applied_rf <- ames_metrics(predicted_rf, truth = age, estimate = .pred)

# save metric sets----
write_rds(ames_metrics_applied_lm, here("results/aba_lm_metrics.rds"))

write_rds(ames_metrics_applied_lasso, here("results/aba_lasso_metrics.rds"))

write_rds(ames_metrics_applied_ridge, here("results/aba_ridge_metrics.rds"))

write_rds(ames_metrics_applied_rf, here("results/aba_rf_metrics.rds"))

# combined output table
metric_results <- bind_rows(
  mutate(ames_metrics_applied_lm, Model = "lm"),
  mutate(ames_metrics_applied_lasso, Model = "lasso"),
  mutate(ames_metrics_applied_ridge, Model = "ridge"),
  mutate(ames_metrics_applied_rf, Model = "rf")
)

write_rds(metric_results, here("results/aba_combined_metrics.rds"))
