
# IMPORT ET EXPORT DE DONNÉES 

# installer les packages
library(readr) # csv,...
library(readxl) # excel
library(xlsx) # excel
library(haven) # stata, sas, spss
library(foreign) # stata, sas, spss
library(DBI) # db
library(RSQLite) #db
library(rvest) # web


## IMPORTER --------------------------------

### Importer un fichier texte 

# sep = "\t"
potatoes <- read.table("data/potatoes.txt", header = T)
head(potatoes)

# plus générale sep = "\t", ",", ";", " "
potatoes <- read.delim("data/potatoes.txt")
head(potatoes)


### Importer un fichier CSV 

df <- read.csv("data/swim.csv", sep = ",")
str(df)
head(df)

# avec readr

df <- read_csv("data/potatoes.csv", show_col_types = F)

df <- read_delim("data/potatoes.csv", show_col_types = F)


### Importer un fichier Excel : readxl


df <- read_excel("data/pop.xls", sheet = 1)
df

excel_sheets("data/pop.xls")



### Importer des fichier SPSS, SAS et Stata : haven & foreign

# fichier SAS

sales <- read_sas("data/sales.sas7bdat")
str(sales)
head(sales)


# fichier Stata

ed <- foreign::read.dta("data/edequality.dta")
head(ed)
str(ed)
colSums(is.na(ed))

ed <- haven::read_dta("data/edequality.dta")
head(ed)


# spss

demo <- foreign::read.spss("data/demo.sav", to.data.frame = T)
head(demo)

demo <- haven::read_spss("data/demo.sav") # read_sav()


###  Importer les données d’une base de données : DBI & RSQLite

# connexion / création de la base de données
connexion <- DBI::dbConnect(RSQLite::SQLite(), dbname = "data/db.sqlite")


# Afficher les tables de la base de données
dbListTables(connexion)

# Afficher les champs (variables) de la table iris_info
dbListFields(conn = connexion, "iris_info")

# Lire le contenu d’une table
iris_info <- dbReadTable(conn = connexion, "iris_info")
head(iris_info)


# requête SQL
query1 = "
  SELECT *
  FROM iris_info
  WHERE Species = 'versicolor'
"

query2 = "
  SELECT *
  FROM iris_info
  WHERE 'Sepal.Length' >= 4
"
res1 <- dbGetQuery(conn = connexion, query1)
head(res1)

res2 <- dbGetQuery(conn = connexion, query2)
head(res2)

dbDisconnect(connexion)



### Importer les données du web

# Importer un fichier CSV : readr
# spécifier l'URL du fichier CSV à importer
url <- "https://raw.githubusercontent.com/mwaskom/seaborn-data/master/diamonds.csv"

# importer le fichier CSV en tant que dataframe 
df <- read_csv(url)

# afficher les premières lignes du dataframe
head(df)


# Importer une table HTML avec rvest : rvest

url <- "https://fr.wikipedia.org/wiki/Liste_des_pays_par_population"

page <- read_html(url)

library(magrittr)

# obtenir la première table
tabs <- html_elements(page, "table")

#length(tabs)

tab1 <- tabs[[1]]


# transformer la première table en data.frame/tibble
df_table1 <- html_table(tab1)

head(df_table1)


library(tidyverse)
library(stringi)

df_table1 <- janitor::clean_names(df_table1)

df_table1 %>% 
  mutate(
    population_au_1er_juillet_2021 = as.numeric(
      stri_replace_all_charclass(population_au_1er_juillet_2021, "\\p{WHITE_SPACE}", "")
    ),
    projection_projetee_au_1er_janvier_2023 = as.numeric(
      stri_replace_all_charclass(projection_projetee_au_1er_janvier_2023, "\\p{WHITE_SPACE}", "")
    )
  )


# récupérer du paragraphe
texts <- html_elements(page, "p")

# troisième paragraphe
texts_3 <- texts[[3]]

# transformer en vecteur
text2 <- html_text2(texts_3)

text2  



## EXPORTER --------------------------------



library(xlsx) # excel
library(haven) # stata, sas, spss

df <- read.table("data/potatoes.txt", header = T)
head(df)

# vers csv
write.csv(df, file = "data/df1.csv")

# vers Excel
xlsx::write.xlsx(df, file = "data/df2.xlsx")

# vers spss
haven::write_sav(res, path = "data/df3.sav")


# Export interne

save(df, file = "data/df4.RData")

load("data/df4.RData") # risque d'écraser les objets en mémoire

# solution
saveRDS(df, file = "data/df5.rds")
data1 <- readRDS("data/df5.rds")




























