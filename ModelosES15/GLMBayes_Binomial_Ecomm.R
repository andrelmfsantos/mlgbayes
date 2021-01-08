#====================================================
# Title:  BAYESIAN GENERALIZED LINEAR MODELS
# Method: Binomial(Logistic)
# Case:   Ecommerce
# Date:   2021/Jan/08
# Author: Andr� Luis M.F. dos Santos
# e-mail: andre@metodosexatos.com.br
# Source: www.metodosexatos.com
#====================================================
# Pacotes necess�rios:

# rstanarm
# readr
# dplyr
#------------------------
# Diret�rios e Arquivos:

# getwd() # Qual o diret�rio que o script est� apontando
# list.files() # Quais arquivos est�o contidos no diret�rio
# setwd("C:/Users/andre/Downloads") # muda a pasta de destino
#-------------------------------------------------------------
# Leitura de dataset:

# A. op��o para ler arquivo salvo no computador
# mydata <- read.csv(file = "wells.csv") 

# B. op��o para ler arquivo na web (github)
library (readr)
urlfile="https://raw.githubusercontent.com/metodosexatos/mlgbayes/main/DatasetsES15/ecomm.csv"
mydata<-read_csv2(url(urlfile)) # para csv no formato brasileiro use read_csv2
head(mydata)
#------------
# Subset:
library(dplyr)
amostra <- mydata %>% filter(amostras == "Treino")
#------------
# Modelo:

library(rstanarm)
model_binomial <- stan_glm(status ~ genero+compras+regiao+pagto+qtde+pedido,
                           data = amostra, family = binomial())
summary(model_binomial)
#------------------------
# Interpreta��o dos coeficientes:

coef <- exp(model_binomial$coefficients)
coef