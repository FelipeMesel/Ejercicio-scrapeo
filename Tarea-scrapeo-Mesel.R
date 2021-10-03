#Para el trabajo de scrapeo elegimos traernos a los países ordenados según su PBI per cápita de acuerdo a datos del Banco Mundial.

library(rvest)
library(tidyverse)

#Despúes de cargar las librerías, nos traemos la página y las columnas de países y PBI per cápita en dólares, las que luego unimos en una tabla con tibble.

url <- "https://es.wikipedia.org/wiki/Anexo:Pa%C3%ADses_por_PIB_(PPA)_per_c%C3%A1pita"
PBI <- read_html(url)


paises <- PBI %>% 
  html_nodes(xpath= '//td[(((count(preceding-sibling::*) + 1) = 2) and parent::*)]//td[(((count(preceding-sibling::*) + 1) = 2) and parent::*)]') %>% 
  html_text()


paises


PBI_percapita <- PBI %>% 
  html_nodes(xpath= '//td[(((count(preceding-sibling::*) + 1) = 2) and parent::*)]//td[(((count(preceding-sibling::*) + 1) = 3) and parent::*)]') %>% 
  html_text()


tabla <- tibble(paises= paises, PBI_percapita=PBI_percapita)

#Ahora veremos los 50 países con mayor PBI per cápita de acuerdo a los datos del Banco Mundial.

tabla1 <- tabla %>% slice(1:50)

#Ahora tomaremos los 50 países de menor PBI per cápita, comenzando por el más pobre

tabla2 <- tabla %>% slice(196:147) 


