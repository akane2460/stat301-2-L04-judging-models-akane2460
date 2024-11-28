# L04 Judging Models ----
# Analysis of trained models 

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load test data----
load(here("exercise_2/data_split/titanic_test.rda"))

# load trained models ----
load(here("exercise_2/data_split/fit_log_reg.rda"))
load(here("exercise_2/data_split/fit_rf_task6.rda"))
load(here("exercise_2/data_split/fit_rf_task7.rda"))

# predicted vs. test value tibble
predicted_log_reg <- bind_cols(titanic_test, predict(fit_log_reg, titanic_test)) |> 
  select(.pred_class, survived)

predicted_rf_task6 <- bind_cols(titanic_test, predict(fit_rf_task6, titanic_test)) |> 
  select(.pred_class, survived)

predicted_rf_task7 <- bind_cols(titanic_test, predict(fit_rf_task7, titanic_test)) |> 
  select(.pred_class, survived)

# accuracy
accuracy_log_reg <- accuracy(predicted_log_reg, truth = survived, estimate = .pred_class)
accuracy_rf_task6 <- accuracy(predicted_rf_task6, truth = survived, estimate = .pred_class)
accuracy_rf_task7 <- accuracy(predicted_rf_task7, truth = survived, estimate = .pred_class)

# combined output
titanic_accuracy_combined <- bind_rows(
  mutate(accuracy_log_reg, Model = "Log Reg"),
  mutate(accuracy_rf_task6, Model = "RF 6"),
  mutate(accuracy_rf_task7, Model = "RF 7")
)

write_rds(titanic_accuracy_combined, here("results/titanic_accuracy_combined.rds"))

# confusion matrix----
confusion_matrix_rf_task7 <- conf_mat(predicted_rf_task7, truth = survived, estimate = .pred_class)

write_rds(confusion_matrix_rf_task7, here("results/titanic_conf_matrix.rds"))

# class probabilities predictions----
class_probabilities <- bind_cols(titanic_test, predict(fit_rf_task7, titanic_test, type = "prob")) |> 
  select(.pred_Yes, .pred_No, survived)

write_rds(class_probabilities, here("results/class_probabilities.rds"))

# roc_curve()` and `autoplot()` -----

roc_curve_rf_model <- roc_curve(class_probabilities, truth = survived, .pred_Yes)

roc_curve_rf_plot <- autoplot(roc_curve_rf_model)

ggsave(here("results/roc_curve_rf_plot.png"), plot = roc_curve_rf_plot)

roc_auc_curve_rf <- roc_auc(class_probabilities, truth = survived, .pred_Yes)

write_rds(roc_auc_curve_rf, here("results/roc_auc_curve_rf.rds"))



