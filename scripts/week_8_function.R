f_to_k <- function(tempF){
  k <- ((tempF - 32) * (5/9)) + 273.15 
  return(k)
}