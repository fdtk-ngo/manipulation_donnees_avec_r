
# GESTION DES DOUBLONS ET DONNÉES MANQUANTES

library(dplyr)

## GESTION DES DOUBLONS ---------------------------------------

(df <- data.frame(
  Prenom   = c(rep('Jean',3), rep("Alain", 2)), 
  Activite = c(rep('Foot',3), rep("Danse", 2)), 
  Lieu     = c(rep('Kinshasa',3), rep("Goma", 2)), 
  Date     = as.Date(c("2023-05-12", "2023-05-16", "2023-05-14", "2023-05-17", "2023-05-13"))
))

### Détection des doublons
duplicated(df[, -4])

# les lignes contenant des doublons
which(duplicated(df[, - 4]))

# afficher les doublons
dup <- which(duplicated(df[, - 4]))

df[dup, ]


### Suppression des doublons

# duplicated
dup <- which(duplicated(df[, - 4]))
df[-dup, ]

# distinct
df %>% 
  distinct(Prenom, Activite, Lieu, .keep_all = T)

### Retenir les observations par rapport à une date

# retenir les observations dont la date est la plus ancienne

# Grouper et Trier par ordre croissant 
df_cr <- df %>% 
  group_by(Prenom, Activite, Lieu) %>% 
  arrange(Date) 

df_cr %>% 
  distinct(Prenom, Activite, Lieu, .keep_all = T)


# retenir les observations avec la date la plus récente

# Grouper et Trier par ordre décroissant
df_dec <- df %>% 
  group_by(Prenom, Activite, Lieu) %>% 
  arrange(desc(Date)) 

df_dec %>% 
  distinct(Prenom, Activite, Lieu, .keep_all = T)

# même résultat avec slice
df_dec %>% 
  slice(1)



## DONNÉES MANQUANTES ---------------------------------------

library(haven)
library(dplyr)

telco <-  haven::read_sav("data/telco_missing.sav")
dim(telco)

### Détection des données maquantes

# pour un vecteur
is.na(telco$age)
which(is.na(telco$age))
sum(is.na(telco$age))

# pour le dataframe
colSums(is.na(telco))
colSums(is.na(telco)) / nrow(telco)


### Supprimer les données manquantes

# pour un vecteur
telco$age[!is.na(telco$age)]
telco$age[complete.cases(telco$age)]

mean(telco$age)
mean(telco$age, na.rm = T)
mean(telco$income, na.rm = T)

# pour le dataframe
telco2 <- na.omit(telco)
dim(telco2)


### Remplacer les valeurs manquantes

# par la moyenne
telco$age_new <- telco$age
telco$age_new[is.na(telco$age_new)] <- mean(telco$age_new, na.rm = T)

sum(is.na(telco$age_new))
mean(telco$age_new)


# par la médiane
telco3 <- telco %>% 
  mutate(new_income = ifelse(is.na(income), 
                             median(income, na.rm = T),
                             income)) 
telco3

telco3 %>% 
  select(income, new_income) %>% 
  filter(is.na(income))



