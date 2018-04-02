library(httr)
library(jsonlite)
library(data.table)
library(dplyr)

output_control <- function(data, type="data.table"){
  if(type == "data.table"){
    setDT(data)
    return(data)
  }
  if(type == "tibble"){
    print("Passou aqui")
    return(as_tibble(data))
  }
}

get_fontes <- function(type="data.table"){
  get_return <- GET("http://ipeadata2-homologa.ipea.gov.br/api/v1/Fontes")
  return_json <- httr::content(get_return, as = "text")
  fromJSON(return_json)$value %>% output_control(type = type) %>% return
}
