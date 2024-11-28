# L04 Judging Models ----
# Initial data checks & data splitting

# load packages ----
library(tidyverse)
library(tidymodels)
library(here)
library(patchwork)

# handle common conflicts
tidymodels_prefer()

# load data----
abalone <- read_csv(here("data/abalone.csv")) |> 
  janitor::clean_names()

# briefly explore data----

abalone |> skimr::skim_without_charts()
  # type is the only character variable
  # the rest are all numeric
  # no missingness issues

## task 1----

# create age variable
abalone <- abalone |> 
  mutate(
    age = rings + 1.5,
    type = factor(type)
  )

# inspect age variable
abalone |> 
skimr::skim_without_charts(age)

p1 <- abalone |> 
  ggplot(aes(x = age)) +
  geom_density() +
  theme_minimal() +
  theme(
    axis.text.y = element_blank(),
    axis.title.y = element_blank(),
    axis.ticks.y = element_blank()
  ) 

p2 <- abalone |> 
  ggplot(aes(x = age)) +
  geom_boxplot() +
  theme_void() +
  labs(title = "Abalone Age in Years (Distribution)")

age_distribution <- p2/p1

ggsave("results/age_distribution.png", plot = age_distribution)

## splitting data----

# set seed
set.seed(3012)

# split the data
abalone_split <- abalone |> 
  initial_split(prop = .8, strata = age)

abalone_train <- abalone_split |> training()
abalone_test <- abalone_split |>  testing()

# write out datasets
save(abalone_split, file = here("exercise_1/data_split/abalone_split.rda"))
save(abalone_train, file = here("exercise_1/data_split/abalone_train.rda"))
save(abalone_test, file = here("exercise_1/data_split/abalone_test.rda"))

