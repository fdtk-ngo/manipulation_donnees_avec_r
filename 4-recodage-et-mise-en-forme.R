
# RECODAGE ET MISE EN FORME

library(dplyr)
counties <- readRDS("data/counties.rds")
## RECODAGE DES VARIABLES ------------------------------

### ifelse

counties %>% 
  mutate(population_group = ifelse(population > 25000, ">25000", "<=25000")) %>% 
  select(population, population_group)


### case_when

counties %>% 
  select(income) %>% 
  mutate(income_cat = case_when(
    income >= 17000 & income <= 40000 ~ "17000-40000",
    income > 40000 & income <= 46000 ~ "40001-46000",
    income > 46000 & income <= 50000 ~ "46001-50000",
    TRUE ~ ">50000"
  )) 

# même résultat avec between
counties %>% 
  select(income) %>% 
  mutate(income_cat = case_when(
    between(income, 17000, 40000) ~ "17000-40000",
    between(income, 40000, 46000) ~ "40001-46000",
    between(income, 46000, 50000) ~ "46001-50000",
    TRUE ~ ">50000"
  )) 



### cut
counties %>% 
  select(income) %>% 
  mutate(
    income_cat = cut(
      income,
      breaks = c(17000, 40000, 46000, 50000, 150000),
      labels = c("17000-40000", "40001-46000", "46001-50000", ">50000")
    ))


### recode
table(counties$metro)

counties %>% 
  mutate(metro_new = recode(metro, 
                            "Metro" = "Avec Metro", 
                            "Nonmetro" = "Sans metro")) %>% 
  count(metro_new)







## MISE EN FORME DE DONNÉES ------------------------------

library(tidyr)
library(readxl)

df <- read_excel("data/pop.xlsx")

### pivot_longer : transformer des colonnes en lignes
df_long <- df %>%
  pivot_longer(cols = names(df)[-1], names_to = "annee", values_to = "population")

df_long


### pivot_wider : transformer des lignes en colonnes
df_wide <- df_long %>% 
  pivot_wider(names_from = "annee", values_from = "population")

df_wide























