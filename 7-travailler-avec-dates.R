
# TRAVAILLER AVEC DES DATES

library(lubridate)
library(nycflights13)

today()

now()

## CRÉER UNE VARIABLE DE DATE ---------------------------------

### A partir d’une chaîne de caractère
dmy("21-08-2023")

ymd("2020-Feb-12")

mdy("July 1, 2017")

dmy_hms("21-08-2023 10-10-25")

mdy_hm("July 1, 2017 16-10")


### A partir de composants individuels de date
flights %>%
  select(year, month, day, hour, minute)

flights %>% 
  select(year, month, day, hour, minute) %>% 
  mutate(
    depart = make_datetime(year, month, day, hour, minute)
  )


### A partir d’une autre variable date
as_datetime(today())

as_date(now())


## EXTRAIRE DES COMPOSANTS DE DATE ---------------------------------
datetime <- dmy_hms("15-02-2023 14:25:02")


year(datetime)

month(datetime)

# le jour de l'année
yday(datetime)

# le jour du mois
mday(datetime)

# jour de la semaine
wday(datetime) # premier jour : dimache

hour(datetime)

month(datetime, label = T, abbr = F)

wday(datetime, label = T, abbr = F)


## CALCULER LA DURÉE ENTRE DEUX DATES ---------------------------------

date_etude <- as_date("2023-01-01")
age <- date_etude - dmy("25-05-1999")
age

class(age)

# transformer le résultat en secondes
as.duration(age)
# tranbsformer le résultat en numérique
as.numeric(as.duration(age))

# transformation en année
as.numeric(as.duration(age)) / (60*60*24*365)

