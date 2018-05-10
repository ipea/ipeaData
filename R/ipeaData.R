#' Return data formated for citation .
#'
#' \code{format_data} return data formated for citation
#'
#'
#' @param date_value data as Date object
#'
#'
format_data <- function(date_value){
  return(ifelse(length(date) <1, '', format(as.Date(date_value), '%m/%Y')))

}

#' Return citation for a given serie.
#'
#' \code{make_citation} Return citation for a given serie.
#'
#'
#' @param data They type of return, it could be data.table or tibble.
#'
#' @return return a string
#'
make_citation <- function(data){
  name_serie <- ifelse('FNTNOME' %in% names(data), data$FNTNOME, '')
  dat_ini <- ifelse('SERMINDATA' %in% names(data), data$SERMINDATA, '')
  dat_end <- ifelse('SERMAXDATA' %in% names(data), data$SERMAXDATA, '')
  acess_date <- paste("Acesso em:", format(Sys.Date(), "%d/%m/%Y"), sep = " ")
  range <- paste(format_data(dat_ini), 'a', format_data(dat_end))
  cite <- paste(name_serie, range, acess_date, sep = '. ' )
  return(cite)
}

#' Return data from api in data.table or tibble.
#'
#' \code{output_control} Return data from api in data.table or tibble
#'
#' @param data Data.frame to be converted
#' @param type They type of return, it could be data.table or tibble.
#'
#' @return a data.table or tibble
#'
output_control <- function(data, type="data.table"){
  if(type == "data.table"){
    setDT(data)
    return(data)
  }
  if(type == "tibble"){
    return(as_tibble(data))
  }
}
#' Make a call on IpeaData api.
#'
#' \code{basic_call} return data from ipeaData
#'
#' @param api Url to be called
#' @param type The type of return, it could be data.table or tibble.
#'
#' @return a data.table or tibble
#'
basic_call <- function(api, type="data.table"){
  get_return <- GET(api)
  if(status_code(get_return) == '200'){
    return_json <- httr::content(get_return, as = "text", encoding = 'utf-8')
    fromJSON(return_json)$value %>% output_control(type = type) %>% return
  }else{
    warning_msg <- paste('Call to api not return a 200 code status', api, 'It returns:', status_code(get_return))
    warning(warning_msg)
    return(NULL)
  }
}

#' Return series sources from ipeaData. This functions
#' can be used fot search for SERCODIGO of series. SERCODIGO
#'
#' must be used for get series values.
#' \code{get_sources} return series sources from ipeaData
#'
#'
#' @param type The type of return, it could be data.table or tibble.
#'
#' @importFrom data.table setDT
#' @importFrom dplyr %>%
#' @importFrom dplyr as_tibble
#' @import httr
#' @import jsonlite
#' @return a data.table with all fonts on ipeaData
#'
#'
#' @export
#'
get_sources <- function(type="data.table"){
  api_call <- "http://ipeadata2-homologa.ipea.gov.br/api/v1/Fontes"
  return(basic_call(api_call, type))
}


#' Return metadadata from a serie on Ipeadata .
#'
#' \code{get_metadata} Return metadata from a serie on Ipeadata.
#'
#' @param serie The serie number.
#' @param type The type of return, it could be data.table or tibble.
#'
#' @return a data.table with all fonts on ipeaData
#'
#' @export
#'
get_metadata <- function(serie = NULL, type='data.table'){
  serie <- ifelse(is.null(serie) | length(serie) < 1, '', paste("('", serie, "')", sep = ""))
  api_call <- paste("http://ipeadata2-homologa.ipea.gov.br/api/v1/Metadados", serie, sep = "" )
  data <- basic_call(api_call, type)
  if (!is.null(data) && nrow(data) == 1){
    print(make_citation(data))
  }
  return(data)

}

get_values<- function(serie, type='data.table'){
  api_call <- paste("http://ipeadata2-homologa.ipea.gov.br/api/v1/ValoresSerie(SERCODIGO='", serie, "')", sep = "" )
  return(basic_call(api_call, type))
}

#' Return values from a serie, its metadados and citation.
#'
#' \code{ipeadata} return values from a serie.
#'
#' @param serie The serie number.
#' @param type They type of return, it could be data.table or tibble.
#'
#' @return a data.table or tibble with all fonts on ipeaData
#'
#' @examples
#'     data <- ipeadata('ADMIS')
#'
#' @export
#'
ipeadata <-function(serie,  type='data.table'){
  get_metadata(serie)
  return(get_values(serie))
}

