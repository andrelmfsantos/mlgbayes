#====================================================
# Title:  BAYESIAN GENERALIZED LINEAR MODELS
# Method: Poisson and Negative Binomial
# Case:   Ecommerce
# Date:   2021/Jan/10
# Author: Andr� Luis M.F. dos Santos
# e-mail: andre@metodosexatos.com.br
# Source: www.metodosexatos.com
#====================================================
# Pacotes necess�rios:

# rstanarm
# readr
#------------------------
# Diret�rios e Arquivos:

# getwd() # Qual o diret�rio que o script est� apontando
# list.files() # Quais arquivos est�o contidos no diret�rio
# setwd("C:/Users/andre/Downloads") # muda a pasta de destino
#-------------------------------------------------------------
# Leitura de dataset:

# A. op��o para ler arquivo salvo no computador
# mydata <- read.csv(file = "ecomm.csv") 

# B. op��o para ler arquivo na web (github)
library (readr)
urlfile="https://raw.githubusercontent.com/metodosexatos/mlgbayes/main/DatasetsES15/hurricanes.csv"
mydata<-read_csv2(url(urlfile)) # para csv no formato brasileiro use read_csv2#head(mydata)
str(mydata)

#--------------------

# Pacotes necess�rios
library(ggplot2)
library(bayesplot)
theme_set(bayesplot::theme_default())
library(rstanarm)

#-------------------
# Modelos:

# I.Poisson:
#stan_glm1 <- stan_glm(folhas ~ dist, data = mydata, family = poisson())
stan_glm1 <- stan_glm(loss ~ hurr, data = mydata, family = poisson,
                      prior = normal(0, 2.5), seed = 12345)

# Propor��o de zeros:
prop_zero <- function(loss) mean(loss == 0)
(prop_zero_test1 <- pp_check(stan_glm1, plotfun = "stat", stat = "prop_zero",
                             binwidth = .005))

# II.Binomial Negativa:
stan_glm2 <- update(stan_glm1, family = neg_binomial_2)

# Propor��o de zeros:
prop_zero_test2 <- pp_check(stan_glm2, plotfun = "stat", stat = "prop_zero",
                            binwidth = 0.01)
# Show graphs for Poisson and negative binomial side by side
bayesplot_grid(prop_zero_test1 + ggtitle("Poisson"),
               prop_zero_test2 + ggtitle("Negative Binomial"),
               grid_args = list(ncol = 2))

# Coeficientes:
round(rbind(poisson = coef(stan_glm1), binomial_negativa = coef(stan_glm2)), digits = 2)

# Erro Padr�o:

round(rbind(se_glm1=se(stan_glm1), se_glm2=se(stan_glm2)),3)
