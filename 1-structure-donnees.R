
# STRUCTURE DE DONNÉES 
getwd()

#setwd()


## VECTEURS -------------------------------------

### Vecteur réel

vect1 <- c(10, 75, 36)

(rep1 <- rep(5, 10))
(rep2 <- rep(c(1, 3), 5))

seq(from = 100, to = 1000, by = 25)
seq(from = 1000, to = 100, by = -25)

is.double(vect1)
is.numeric(vect1)

class(vect1)

as.double("25")

vect1 * 2

vect1^0.5

log10(vect1)

exp(vect1)


### Vecteur entier

vect2 <- c(10L, 75L, 36L)

is.integer(vect2)
is.numeric(vect2)
is.double(vect2)

class(vect1)
class(vect2)

typeof(vect2)

v1 <- c("12", "32", "10")
class(v1)

v1 <- as.numeric(v1)
class(v1)

### Les chaînes de caractères

x <- c("R", "python", "spss")

letters
LETTERS

class(x)
class(letters)

is.character(x)


### Vecteur logique

s <- c(TRUE, FALSE, TRUE)

class(s)
is.logical(s)

as.numeric(s)

length(letters)
length(vect1)


### valeurs maquantes

age <- c(15, 46, 40, 71, NA, 20, NA)  
age

sexe <- c("F", "H", "H", NA)
sexe

length(age)

is.na(age)

# somme des maquants
sum(is.na(age))

# logique en numeric
is.na(age) * 1

# somme des non-maquants
sum(!is.na(age))

# somme des non-maquants
sum(complete.cases(age))


## INDEXATION

### Par position

age
age[1]
age[1 : 2]
age[-4]


### Par nom

score <- c("alpha" = 10, "beta" = 17, "gamma" = 12)
score["beta"]
score["gamma"]


### Par condition

age > 25
age[age > 25]
age[age > 25 & age < 50]
age[age > 25 | age < 50]

age[age > 25 & !is.na(age)]
age[age > 25 & complete.cases(age)]


## ASSIGNATION

vect1[1] <- -10
vect1
vect1[2:3] <- 99
vect1


age[age > 50] <- 0
age

age[age == NA]
age[is.na(age)] <- 100
age


# les objets dans la mémoire
ls()

rm("age")
rm("rep1", "V1")

# vider la mémoire
rm(list = ls())


## MATRICES ------------------------------------


mat <- matrix(c(1,3,4,7,5,2), ncol = 2, byrow = TRUE) 
mat

is.matrix(mat)
class(mat)
dim(mat)

# par colonne
matrix(c(1,3,4,7,5,2), ncol = 2)

vect1 <- c(10, 75, 36)
vect2 <- c(25, 42, -3)

rbind(vect1, vect2)
cbind(vect1, vect2)

# opérations sur les matrices

t(mat)

mat * 10

mat / 100

### indexation

mat
mat[2, 1]	
mat[, 1]	
mat[1 : 2, 2]



## LISTES ------------------------------------

### Création
list(c(1, 6, 7)) 
list("R", 2023, TRUE)
list1 <- list(nom = c("a", "b", "c"), age = c(45, 75, 15)) 
list1

length(list1)

### Indexation

list1[1]
class(list1[1])

list1[[1]] 
list1$nom
class(list1[[1]])

# premier élément de la première liste
list1[[1]][1] 

# deux premières éléménts de la deuxième liste
list1[[2]][1 : 2] 


## DATAFRAME ------------------------------------

### Création

prenom <- c("Jean", "Anne", "Alice", "Bruno", "Cecile")
sexe <- c("Homme", "Femme", "Femme", "Homme", "Femme")
age <- c(23, 24, 45, 20, 60)
revenu <- c(5000, 4600, 3000, 500, 1500)

df <- data.frame(
  prenom,
  sexe,
  age,
  revenu
)


df

class(df)
is.data.frame(df)

mat <- matrix(c(1, 3, 4, 7, 5, 2), ncol = 2, byrow = TRUE) 
mat

mat2 <- as.data.frame(mat)
mat2
class(mat2)


### Indexation
df$age
df[1 : 3, ]
df[-1, ]
df[, "prenom"]
# 40 ans ou moins
df[df$age <= 40, ]

# les femmes uniquement
df[df$sexe == "Femme", ]

# les prénoms
df$prenom

# les prenoms de personnes de moins de 40 ans
df$prenom[df$age <= 40]

# la personne la plus âgée
df$prenom[df$age == max(df$age)]

# la personne la moins âgée
df$prenom[df$age == min(df$age)]

# la femme avec le plus grand revenu
df_femme <- df[df$sexe == "Femme", ]
df_femme$prenom[df_femme$revenu == max(df_femme$revenu)]

# quel est ce revenu ?
max(df_femme$revenu)
df_femme$revenu[df_femme$prenom == "Anne"]

aggregate(revenu ~ sexe, max, data = df)

aggregate(revenu ~ sexe, mean, data = df)

### Fonctions

str(df)
dim(df)
ncol(df)
nrow(df)
names(df) 

head(df, 3)
tail(df, 2)

head(iris)
tail(iris)

summary(df)
summary(df$age)
table(df$sexe)

relevel(df$sexe, ref = "Homme")

#caractère en facteur
df$sexe <- as.factor(df$sexe)
is.factor(df$sexe)

# changer le niveau
df$sexe <- relevel(df$sexe, ref = "Homme")
table(df$sexe)


### Ajout colonne
df$ville <- c("Kinshasa", "Lubumbashi", "Kikwit", "Mbujimayi", "Kisangani")
df

### Suppresion colonne
df$ville <- NULL
df


# TROUVER DE L'AIDE ------------------------------------

?max()

help("mean")

x <- c(0:10, 50)
xm <- mean(x)
c(xm, mean(x, trim = 0.10))








