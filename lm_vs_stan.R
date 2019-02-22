

# Declaring Libraries ------------------------------------------------------------

library("datasets")
library("data.table")

airquality <- setDT(copy(airquality))
airquality <- airquality[complete.cases(airquality[,.(Ozone,Solar.R)])]

# Simple lin reg with 1 variable ------------------------------------------



fit_lm <- lm(formula = 'Ozone ~ Solar.R', data = airquality)


# Stan model --------------------------------------------------------------

mydata <- list(N = nrow(airquality), y = airquality$Ozone , x = airquality$Solar.R)

fit_stan <- stan(file = 'linreg.stan', data = mydata, 
            iter = 1000, chains = 4)

result <- extract(fit_stan)

hist(result$beta)
hist(result$alpha)


