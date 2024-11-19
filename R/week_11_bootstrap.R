library(here)
library(boot)

finaldata <- read.csv(here("original","analytical","finaldata.csv"), header=TRUE)


data2017inf <- finaldata |> 
  dplyr::filter(year == 2017) |>
  dplyr::filter(!is.na(infmor))


data2017neo <- finaldata |> 
  dplyr::filter(year == 2017) |>
  dplyr::filter(!is.na(neomor))


data2017un5 <- finaldata |> 
  dplyr::filter(year == 2017) |>
  dplyr::filter(!is.na(un5mor))


getmeddiffinf <- function(data,indices){
  sample_data <- data[indices,]
  group_meds <- tapply(sample_data$infmor, sample_data$conflict, FUN=function(x) median(x,na.rm=TRUE))
  meddiff <- group_meds[2] - group_meds[1]
  return(meddiff)
}

getmeddiffneo <- function(data,indices){
  sample_data <- data[indices,]
  group_meds <- tapply(sample_data$neomor, sample_data$conflict, FUN=function(x) median(x,na.rm=TRUE))
  meddiff <- group_meds[2] - group_meds[1]
  return(meddiff)
}

getmeddiffun5 <- function(data,indices){
  sample_data <- data[indices,]
  group_meds <- tapply(sample_data$un5mor, sample_data$conflict, FUN=function(x) median(x,na.rm=TRUE))
  meddiff <- group_meds[2] - group_meds[1]
  return(meddiff)
}

bootoutinf <- boot(data2017inf, statistic = getmeddiffinf, strata=data2017inf$conflict, R = 1000)
bootoutinf

bootoutneo <- boot(data2017neo, statistic = getmeddiffinf, strata=data2017neo$conflict, R = 1000)
bootoutneo

bootoutun5 <- boot(data2017un5, statistic = getmeddiffinf, strata=data2017un5$conflict, R = 1000)
bootoutun5

boot.ci(boot.out = bootoutinf, conf=0.95, type =c("basic","perc","BCa"))
boot.ci(boot.out = bootoutneo, conf=0.95, type =c("basic","perc","BCa"))
boot.ci(boot.out = bootoutun5, conf=0.95, type =c("basic","perc","BCa"))


