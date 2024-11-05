library(here)
library(plm)
library(texreg)
library(mice)
library(tidyverse)

finaldata <- read.csv(here("original","analytical","finaldata.csv"),header = TRUE)

finaldata$loggdp1000 <- log(finaldata$gdp1000)
finaldata$pctpopdens <- finaldata$popdens/100

finaldata |>
  arrange(year,ISO) |>
  dplyr::select(-country_name,-ISO,-region) |>
  vis_miss()

midata <- finaldata |>
  mutate(ISOnum = as.numeric(as.factor(finaldata$ISO))) |>
  select(-country_name,-ISO)

mice0 <- mice(midata,seed=100,m=5,maxit=0,print=F)

meth <- mice0$method
meth[c("urban","male_edu","temp","rainfall1000","matmor","infmor","neomor","un5mor","loggdp1000","pctpopdens")] <- "2l.lmer"

pred <- mice0$predictorMatrix
pred[c("urban","male_edu","temp","rainfall1000","matmor","infmor","neomor","un5mor","loggdp1000","pctpopdens"),"ISOnum"] <- -2

mice.multi.out <- mice(midata,seed=100,m=10,matix=20,method=meth,predictorMatrix=pred)

plot(mice.multi.out)

preds <- as.formula(" ~ conflict + loggdp1000 + OECD + popdens + urban + 
                  agedep + male_edu + temp + rainfall1000 + earthquake + 
                  drought + as.factor(ISO) + as.factor(year)")

matmor_cc <- lm(update.formula(preds, matmor ~ .), data = finaldata)
un5mor_cc <- lm(update.formula(preds, un5mor ~ .), data = finaldata)
infmor_cc <- lm(update.formula(preds, infmor ~ .), data = finaldata)
neomor_cc <- lm(update.formula(preds, neomor ~ .), data = finaldata)

matmor_mi <- pool(with(mice.multi.out,lm(matmor ~ conflict + loggdp1000 + OECD + pctpopdens + urban + 
                                           agedep + male_edu + temp + rainfall1000 + earthquake + drought +
                                           as.factor(ISOnum) + as.factor(year))))

un5mor_mi <- pool(with(mice.multi.out,lm(un5mor ~ conflict + loggdp1000 + OECD + pctpopdens + urban + 
                                           agedep + male_edu + temp + rainfall1000 + earthquake + drought +
                                           as.factor(ISOnum) + as.factor(year))))

infmor_mi <- pool(with(mice.multi.out,lm(infmor ~ conflict + loggdp1000 + OECD + pctpopdens + urban + 
                                           agedep + male_edu + temp + rainfall1000 + earthquake + drought +
                                           as.factor(ISOnum) + as.factor(year))))

neomor_mi <- pool(with(mice.multi.out,lm(neomor ~ conflict + loggdp1000 + OECD + pctpopdens + urban + 
                                           agedep + male_edu + temp + rainfall1000 + earthquake + drought +
                                           as.factor(ISOnum) + as.factor(year))))


vars <- list ("conflict" = "Armed Conflict",
              "loggdp1000" = "log(GDP)",
              "OECD" = "OECD",
              "pctpopdens" = "Population Density",
              "urban" = "Urban",
              "agedep" = "Age Dependency",
              "male_edu" = "Male Education",
              "temp" = "Average Temperature",
              "rainfall1000" = "Average Rainfall",
              "earthquake" = "Earthquake",
              "drought" = "Drought")

tosave <- list(matmor_cc,un5mor_cc,infmor_cc,neomor_cc,matmor_mi,un5mor_mi,infmor_mi,neomor_mi)

screenreg(tosave, ci.force = TRUE, custom.coef.map = vars,
          custom.model.names = c("Mat CC","Und5 CC","Inf CC","Neo CC","Mat MI","Und5 MI","Inf MI","Neo MI"))

save(tosave, file = here("figures","mi_output.Rdata"))


htmlreg(tosave, file = "Week9Table.html", custom.model.names = c("Mat CC","Und5 CC","Inf CC","Neo CC","Mat MI","Und5 MI","Inf MI","Neo MI"), custom.coef.map = vars)



