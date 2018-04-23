library(httr)
library(jsonlite)
library(data.table)
library(dplyr)

format_data <- function(date_value){
  return(ifelse(length(date) <1, '', format(as.Date(date_value), '%m/%Y')))

}

make_citation <- function(data){
  name_serie <- ifelse('FNTNOME' %in% names(data), data$FNTNOME, '')
  dat_ini <- ifelse('SERMINDATA' %in% names(data), data$SERMINDATA, '')
  dat_end <- ifelse('SERMAXDATA' %in% names(data), data$SERMAXDATA, '')
  acess_date <- paste("Acesso em:", format(Sys.Date(), "%d/%m/%Y"), sep = " ")
  range <- paste(format_data(dat_ini), 'a', format_data(dat_end))
  cite <- paste(name_serie, range, acess_date, sep = '. ' )
  cat(cite)
  return(cite)
}

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

basic_call <- function(api, type="data.table"){
  get_return <- GET(api)
  return_json <- httr::content(get_return, as = "text")
  fromJSON(return_json)$value %>% output_control(type = type) %>% return
}

#' Return fonts from ipeaData .
#'
#' \code{get_fonts} return fonts from ipeaData
#'
#'
#' @param type They type of return, it could be data.table or tibble.
#'
#' @import data.table
#' @import dplyr
#' @return a data.table with all fonts on ipeaData
#'
#' @examples
#'    fontes <- get_fonts()
#' @export
#'
get_fonts <- function(type="data.table"){
  api_call <- "http://ipeadata2-homologa.ipea.gov.br/api/v1/Fontes"
  return(basic_call(api_call, type))
}


#' Return metadadata from a serie on Ipeadata .
#'
#' \code{get_metadata} Return metadadata from a serie on Ipeadata.
#'
#' @param serie The serie number.
#' @param type The type of return, it could be data.table or tibble.
#'
#' @return a data.table with all fonts on ipeaData
#'
#' @examples
#'    fontes <- get_metadata(420)
#' @export
#'
get_metadata <- function(serie = NULL, type='data.table'){
  serie <- ifelse(is.null(serie) | length(serie) < 1, '', paste("('", serie, "')", sep = ""))
  api_call <- paste("http://ipeadata2-homologa.ipea.gov.br/api/v1/Metadados", serie, sep = "" )
  cat(api_call)
  data <- basic_call(api_call, type)
  if (length(serie) > 1){
    make_citation(data)
  }
  return(data)

}

#' Return values from a serie.
#'
#' \code{get_values} return values from a serie.
#'
#' @param serie The serie number.
#' @param type They type of return, it could be data.table or tibble.
#'
#' @return a data.table with all fonts on ipeaData
#'
#' @examples
#'    fontes <- get_values()
#' @export
#'
get_values<- function(serie, type='data.table'){
  api_call <- paste("http://ipeadata2-homologa.ipea.gov.br/api/v1/ValoresSerie(SERCODIGO='", serie, "')", sep = "" )
  return(basic_call(api_call, type))
}

