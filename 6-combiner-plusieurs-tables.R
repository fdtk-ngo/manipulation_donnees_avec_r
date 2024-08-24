
# COMBINER PLUSIEURS TABLEAUX DE DONNÉES

personnes <- tibble(
  nom = c("Sylvie", "Sylvie", "Monique", "Gunter", "Rayan", "Rayan"),
  voiture = c("Twingo", "Ferrari", "Scenic", "Lada", "Twingo", "Clio")
)

voitures <- tibble(
  voiture = c("Twingo", "Ferrari", "Clio", "Lada", "208"),
  vitesse = c("140", "280", "160", "85", "160")
)


## inner_join per : monique supprimé, voit : 208 supprimé
personnes %>% inner_join(voitures)

personnes %>% inner_join(voitures, by = "voiture")

## left_join pers : monique NA, voit : 208 supprimé
personnes %>% left_join(voitures)

## right_join voit : 208 NA, monique supprimé
personnes %>% right_join(voitures)

## full_join
personnes %>% full_join(voitures)

## semi_join : même que inner sans les colonnes de voiture
personnes %>% semi_join(voitures)

## anti_join
personnes %>% anti_join(voitures)




