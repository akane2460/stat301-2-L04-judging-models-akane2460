# L04 Judging Models ----
# Initial data checks & data splitting

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)

# handle common conflicts
tidymodels_prefer()

# load data----
titanic <- read_csv(here("data/titanic.csv")) |> 
  janitor::clean_names()

titanic <- titanic |> 
  mutate(
    survived = factor(survived, levels = c("Yes", "No"), ordered = TRUE),
    pclass = factor(pclass)
  )

# inspect age variable
titanic |> 
  skimr::skim_without_charts(survived)

p1 <- titanic |> 
  ggplot(aes(x = survived)) +
  geom_bar() +
  theme_minimal() +
  theme(
    axis.text.y = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks.y = element_blank()
  ) 

table_1 <- titanic |> 
  summarize(
    count = n(),
    yes = sum(survived == "Yes"),
    no = sum(survived == "No"),
    pct_yes = yes/count,
    pct_no = no/ count
  ) |> 
  select(pct_yes, pct_no)

ggsave("results/survived_distribution.png", plot = p1)

write_rds(table_1, "results/proportions_survived.rds")

# splitting data----
set.seed(3012)

# split the data
titanic_split <- titanic |> 
  initial_split(prop = .8, strata = age)

titanic_train <- titanic_split |> training()
titanic_test <- titanic_split |>  testing()

# write out datasets
save(titanic_split, file = here("exercise_2/data_split/titanic_split.rda"))
save(titanic_train, file = here("exercise_2/data_split/titanic_train.rda"))
save(titanic_test, file = here("exercise_2/data_split/titanic_test.rda"))

# skim of training
train_data_skim <- titanic_train |> 
skimr::skim_without_charts() |> 
  filter(complete_rate < 1)

write_rds(train_data_skim, file = here("results/titanic_train_data_skim.rds"))
