#https://www.statmethods.net/stats/frequencies.html



library(readxl)
setwd("C:\\Users\\Adal\\Dropbox\\Magister Control de Gesti?n\\20181\\BI 20181\\Ayudantia 2")
titanic_train<-read_excel("Titanic_Train.xlsx",col_names = TRUE)

##########################################EXPLORACION DE LOS DATOS##########################################
str(titanic_train)
head(titanic_train, n = 20)
tail(titanic_train, n = 20)

summary(titanic_train)

sum(titanic_train$Age)

mean(titanic_train$Age)

sd(titanic_train$Age)

# #puede consultar funciones usando los siguientes comandos
# ?sum
# help(sum)

#para no considerar los NA se debe hacer:
sum(titanic_train$Age, na.rm=TRUE)
mean(titanic_train$Age,na.rm=TRUE)
sd(titanic_train$Age, na.rm = TRUE)



unique(titanic_train$Pclass)
unique(titanic_train$Sex)
unique(titanic_train$Ticket)
unique(titanic_train$Fare)
unique(titanic_train$Cabin)
unique(titanic_train$Embarked)

aggregate(titanic_train,by=list(titanic_train$Sex,titanic_train$Survived), FUN = mean)
aggregate(titanic_train,by=list(titanic_train$Sex,titanic_train$Survived), FUN = sd)

str(titanic_train)
titanic_train <- subset(titanic_train, select = c("PassengerId","Survived","Pclass","Sex","Age","SibSp","Parch","Fare","Embarked"))
titanic_train


##########################################TRATAMIENTO DE MISSING VALUES##########################################
#?Hay missing values?
anyNA(titanic_train)

#?Donde?
str(titanic_train)

#Cuantos missing values hay?
is.na(titanic_train)
sum(is.na(titanic_train))


####DEFINICION DE FUNCIONES####
function(x){
  sum(is.na(x))
}
#es importante guardar la función
pMiss<-function(x){
  sum(is.na(x))
}


#Vemos por columna el porcentaje de missing values
apply(titanic_train,2,pMiss)

#DEJAR COMO TAREA EL MISMO CALCULO, PERO QUE LO ENTREGUE COMO PORCENTAJE
#DEJAR COMO TAREA QUE AVERIGÜEN LAS DERIVADAS DE APPLY: SAPPLY Y LAPPLY


####TRATAMIENTO DE MISSING VALUES####
library(lattice)
library(mice)

#IMPUTAR VALORES VACIOS#
# recordar imputar los valores vacios. Por ejemplo, en la tarea el 999 es un missing value.
# Hagamos el ejemplo en el caso que existan 999 en Age. Debemos imputar los valores vacíos:
attach(titanic_train)
titanic_train$Age[Age==999]<-NA
#Para comparaciones usamos: <,<=,>,>=,== y is.na() para valores vacios

##Opciones para tratar missing values
#############################Opci?n 1: Eliminar todos los datos omitidos
na.omit(titanic_train)

#############################Opci?n 2: Eliminar la variable
subset(titanic_train, select = c("PassengerId","Pclass"))

#############################Opci?n 3: Rellenar missing values
##Opcion 3.1: Reemplazar por la media o moda:##
# generaremos un vector para probar
titanic_train.Age<-titanic_train$Age
titanic_train.Embarked<-titanic_train$Embarked

#Reemplazando por media
titanic_train.Age[is.na(titanic_train.Age)]<-mean(titanic_train.Age, na.rm=TRUE)

#Reemplazar por moda
# no existe esta funcion, por tanto debemos crearla
getmode<-function(v) {
  uniqv<-unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

titanic_train.Embarked[is.na(titanic_train.Embarked)]<-getmode(titanic_train.Embarked)

# # FUNCION MATCH #
# # Esta funcion retorna un vector con las posiciones en que existe igualdad del primer argumento con el segundo
# uniqv<-unique(titanic_train.Embarked)
# uniqv
# match(titanic_train.Embarked, uniqv)
# 
# # FUNCION TABULATE
# # toma el valor entero de un vector con valores y cuenta el número de veces que cada entero occure en él
# tabulate(match(titanic_train.Embarked, uniqv))
# 
# # ###FUNCION WHICH###
# # # arroja un vector indicando los elementos que cumplen la condición lógica en el vector de comparación
# # # which(<comparacion logica>)
# # #Ejemplo, el siguiente comando arrojará un vector con la posición de aquellos elementos que son NA en el vector titanic_train$Age
# # which(is.na(titanic_train$Age))
# # En el which.max determina la localización/index del elemento numérico que es el maximo de un vector.
# which.max(tabulate(match(titanic_train.Embarked, uniqv)))
# uniqv[which.max(tabulate(match(titanic_train.Embarked, uniqv)))]


##Opcion 3.2: Reemplazar por modelos:##
#Para ver los m?todos del MICE:
#https://cran.r-project.org/web/packages/mice/mice.pdf

#mice funciona en dos etapas, primero produce multiples copias del dataframe
#cada una con diferentes datos inputados. 
#La segunda etapa es con complete(), que entrega el set de datos inputados.

mod_mice<-mice(data = titanic_train, m = 5,meth='midastouch')

titanic_train_smv <- complete(mod_mice)
titanic_train_smv
anyNA(titanic_train_smv$Age)

# data = dataframe trabajado
# m = Numero de inputaciones multiples
# meth = Que metodo utilizaremos para rellenar los missing values

#pmm any Predictive mean matching
#midastouch any Weighted predictive mean matching
#sample any Random sample from observed values
#cart any Classification and regression trees
#rf any Random forest imputations
#mean numeric Unconditional mean imputation
#norm numeric Bayesian linear regression
#norm.nob numeric Linear regression ignoring model error
#norm.boot numeric Linear regression using bootstrap
#norm.predict numeric Linear regression, predicted values
#quadratic numeric Imputation of quadratic terms
#ri numeric Random indicator for nonignorable data
#logreg binary Logistic regression
#logreg.boot binary Logistic regression with bootstrap
#polr ordered Proportional odds model
#polyreg unordered Polytomous logistic regression
#lda unordered Linear discriminant analysis
#2l.norm numeric Level-1 normal heteroskedastic
#2l.lmer numeric Level-1 normal homoscedastic, lmer
#2l.pan numeric Level-1 normal homoscedastic, pan
#2lonly.mean numeric Level-2 class mean
#2lonly.norm numeric Level-2 class normal
#2lonly.pmm any Level-2 class predictive mean matching

##########################################VARIABLES DUMMY##########################################
library(caret)
#Elimina una variable para evitar colinealidad
dummy_01<-model.matrix(Survived ~ ., data = titanic_train_smv)
#Entrega todas las variables binarias
modelo_dummy <- dummyVars(Survived ~ ., data = titanic_train_smv)
dummy_02<-as.data.frame(predict(modelo_dummy, newdata = titanic_train_smv))

Survived<-titanic_train$Survived

titanic_train_dummy<- cbind.data.frame(Survived,dummy_02)

#########################################NORMALIZACION DE DATOS#########################################
#1) 
scale(titanic_train_dummy$Age)

#2)
library(clusterSim)
data.Normalization(titanic_train_dummy$Age,type = "n3",normalization = "column")
  #n0 - without normalization
  #n1 - standardization ((x-mean)/sd)
  #n2 - positional standardization ((x-median)/mad)
  #n3 - unitization ((x-mean)/range)
  #n3a - positional unitization ((x-median)/range)
  #n4 - unitization with zero minimum ((x-min)/range)
  #n5 - normalization in range <-1,1> ((x-mean)/max(abs(x-mean)))
  #n5a - positional normalization in range <-1,1> ((x-median)/max(abs(x-median)))
  #n6 - quotient transformation (x/sd)
  #n6a - positional quotient transformation (x/mad)
  #n7 - quotient transformation (x/range)
  #n8 - quotient transformation (x/max)
  #n9 - quotient transformation (x/mean)
  #n9a - positional quotient transformation (x/median)
  #n10 - quotient transformation (x/sum)
  #n11 - quotient transformation (x/sqrt(SSQ))
  #n12 - normalization ((x-mean)/sqrt(sum((x-mean)^2)))
  #n12a - positional normalization ((x-median)/sqrt(sum((x-median)^2)))
  #n13 - normalization with zero being the central point ((x-midrange)/(range/2))


#3)
scalling <- function(x){(x-min(x))/(max(x)-min(x))}

scalling(titanic_train_dummy$Age)


########################CORRELACION##########################
#CORRELACIONES ESPURIAS
#http://tylervigen.com/spurious-correlations

library(caret)
library(corrplot)

matriz_correlacion <- cor(titanic_train_dummy)
summary(matriz_correlacion[upper.tri(matriz_correlacion)])

corrplot(matriz_correlacion)

#######################VARIABLES SINTETICAS#################

titanic_train_dummy$Sintetica1<-ifelse(titanic_train_dummy$Pclass == 1 & titanic_train_dummy$Sexmale==1,1,0)

titanic_train_dummy

matriz_correlacion <- cor(titanic_train_dummy)
summary(matriz_correlacion[upper.tri(matriz_correlacion)])

corrplot(matriz_correlacion)

##########################################GRAFICOS##########################################
#Grafico de barras

library(ggplot2)
ggplot(data = titanic_train,aes(x=Age, y=Survived))+
  geom_point()+
  ggtitle("TITULOS")

ggplot(data = titanic_train, aes(x= , y= ))


#########################################dplyr##############################################
install.packages("dplyr")
library(dplyr)

tbl_01 <- titanic_train%>%
  group_by(Sex,Pclass)%>%
  summarise(n =n(),AVG_NR = mean(Survived), Std = sd(Survived))

tbl_01