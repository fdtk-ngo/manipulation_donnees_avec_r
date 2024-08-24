

# MANIPULATION DE DONNÉES AVEC DPLY

library(tidyverse)
counties <- readRDS("data/counties.rds")

### Données à utiliser
View(counties)

## LES VERBES DE DPLYR -----------------------------------

### select
counties %>%
  # Selectionner 4 colonnes
  select(state, county, population, poverty)


counties %>% 
  select(metro : black)


counties %>% 
  select(starts_with("in"))


counties %>% 
  select(-c(1 : 6))


counties_small <- counties %>%
  select(region, state, county, public_work, population, 
         private_work, women, citizens, work_at_home, walk, land_area)

### arrange


counties_small %>%
  arrange(public_work)

counties_small %>%
  # trier par ordre décroissant de 'public_work'
  arrange(desc(public_work))


### filter

counties_small %>%
  # filtrer les comtés avec une population sup à 1000000
  filter(population > 1000000)


counties_small %>%
  # filtrer les comtés avec une population sup à 1000000 à California
  filter(population > 1000000, state == "California")

counties_small %>%
  filter(state == "Texas", population > 1000000) %>%
  arrange(desc(private_work))

### mutate
# nombre de travailleurs du secteur public
counties_small %>%
  mutate(public_workers = population * public_work / 100)


counties_small %>%
  mutate(public_workers = population * public_work / 100) %>%
  arrange(desc(public_workers)) %>% 
  select(state, county, public_workers)


# 👉 Quelles sont les 5 comtés ayant la plus grande proportion des femmes ?

counties_small %>% 
  mutate(proportion_femme = women / population) %>% 
  arrange(desc(proportion_femme)) %>% 
  select(state, county, proportion_femme) %>% 
  head(5)


### count

counties_small %>% 
  count(region, sort = T)

# total des citadins par region
counties_small %>% 
  count(region, wt = citizens, sort = T)

 
# personnes travaillant à la maison
counties_small %>% 
  mutate(pop_work_at_home = population * work_at_home / 100) %>% 
  count(state, wt = pop_work_at_home, sort = T)


# 👉 Calculer le nombre de personnes qui font la marche 
     #pour se rendre au travail pour chaque état.

counties_small %>%
  mutate(population_walk = population * walk / 100) %>%
  count(state, wt = population_walk, sort = T)


### summarize

counties_small %>% 
  summarise(n = n())


counties_small %>% 
  summarise(
    # calculer le minimum
    min_population = min(population),
    # calculer la moyenne
    mean_population = mean(population),
    # calculer le maximum
    max_population = max(population)
  )


### group_by() / ungroup()

# min, mean, et max de la population
counties_small %>% 
  group_by(region) %>% 
  summarise(
    # calculer le minimum
    min_population = min(population),
    # calculer la moyenne
    mean_population = mean(population),
    # calculer le maximum
    max_population = max(population)
  )

# Calculer pour chaque Etat, la superficie et la population totale.
counties_small %>%
  # Grouper par state 
  group_by(state) %>%
  # surface total et population totale
  summarise(
    total_area = sum(land_area),
    total_population = sum(population)
  )


# calculer la densité par état et la trier par ordre décroissant.
counties_small %>%
  group_by(state) %>%
  summarize(total_area = sum(land_area),
            total_population = sum(population)) %>%
  mutate(density = total_population / total_area) %>%
  arrange(desc(density))

# L’Etat avec le plus faible revenu dans chaque region

counties_small <- counties %>%
  select(region, state, county, population, income)

counties_small %>%
  group_by(region, state) %>%
  # Calculer le revenu moyen
  summarise(average_income = mean(income)) %>%
  # Etat avec le plus faible revenu dans chaque region
  slice_min(average_income, n = 1)

# EX :pour chaque province, quelles sont les villes le taux de malnutrition le plus e..


# Deux Etats avec le taux de pauvreté le plus élevé dans chaque region

counties %>% 
  group_by(region, state) %>% 
  summarise(average_poverty = mean(poverty)) %>% 
  slice_max(average_poverty, n = 2)


### rename

counties_small <- counties %>%
  select(census_id, region, state, county, population, income)

counties_small %>% 
  rename(id = census_id, us_state = state)


### transmute

counties %>% 
  mutate(density = population / land_area) %>% 
  select(state, county, population, density) %>% 
  arrange(density)

counties %>%
  transmute(state, county, population, density = population / land_area) %>%
  arrange(density)

