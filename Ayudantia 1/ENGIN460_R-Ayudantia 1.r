######################################BUSINESS INTELLIGENCE ENGIN460 20181######################################
################################################################################################################

################################################################################################################
#Para escribir comentarios en el codigo, utilizar al principio de la linea de codigo el signo gato '#'
################################################################################################################


# https://cran.r-project.org/
# https://www.rstudio.com/
# https://www.rdocumentation.org/

######################################INSTALACION DE LIBRERIAS######################################

#install.packages("nombre de la libreria")

install.packages("readxl")
install.packages("ggplot2")
install.packages("mice")
install.packages("clusterSim")
install.packages("corrplot")
install.packages("MASS")
install.packages("caret")
install.packages("pROC")
install.packages("devtools")
install.packages("lattice")
install.packages("scales")
install.packages("lazyeval")
install.packages("stringi")
install.packages("rpart.plot")

#library(nombre de la libreria)

library(readxl)
library(ggplot2)
library(mice)
library(clusterSim)
library(corrplot)
library(MASS)
library(caret)
library(pROC)
library(devtools)
library(lattice)
library(scales)
library(lazyeval)
library(stringi)
library(rpart.plot)



######################################SUMA######################################
2+1
3+6
20+10
######################################RESTA######################################
2-1
5-6
######################################MULTIPLICACION######################################
6*8
2*4
######################################DIVISION######################################
10/2
15/3
######################################POTENCIAS######################################
2^3
######################################################################################
######################################################################################



######################################VARIABLES######################################
#La asignacion de variables se realiza con la letra de la variable, una flecha
#y el dato que se quiere asignar a la variable. Para observar en la consola
#cual se el dato de la variable que se est谩 asignando, solo basta con escribir
#la variable asignada y ejecutar la consola.

#Asignacion de variable numeric
my_numeric <- 24

#Impresion de variable
my_numeric

#Asignaci贸n de variable character
my_character <- '24'
my_character

#Asignacion de variable logical
my_logical <- TRUE
my_logical

#Para saber el tipo de variable:

class(my_numeric)
class(my_character)
class(logical)

######################################OPERATORIA DE VARIABLES######################################

Nota_Uno <- 4.5
Nota_Dos <- 5.7
Nota_Tres <- 2.0

mis_notas <- Nota_Uno + Nota_Dos + Nota_Tres

mi_promedio <- mis_notas/3

mi_promedio

######################################VECTORES######################################
# Arreglos de una dimensi贸n que pueden contener datos numericos, de caracteres o l贸gicos. Son una herramienta para almacenar datos.


vector_numeric <- c(1,2,3,4,5,6,7,8,9)

vector_character <- c("a","b","c")

vector_logical <- c(TRUE,TRUE,FALSE,FALSE,FALSE)

#Asignacion de nombres a los elementos del vector

vector_notas <- c(4.5,5.7,2.0)
names(vector_notas) <- c("Prueba1","Prueba2","Prueba3")
?names

#Seleccion de elementos en vector, seleccionemos nuestra nota mas alta 5.7

Nota_Max <- vector_notas[2]
Nota_Max <- max(vector_notas)
Nota_Max <- vector_notas[which.max(vector_notas)]

######################################MATRICES######################################
#Coleccion de elementos de UN MISMO TIPO DE DATOS (NUMERICO, CARACTER O LOGICO)

#https://www.rdocumentation.org/packages/base/versions/3.4.3/topics/matrix

matrix(data = , nrow = 1, ncol = 1, byrow = FALSE,
       dimnames = NULL)

m1<-matrix(1:9, byrow = TRUE, nrow = 3)
m2<-matrix(10:21, byrow = TRUE, nrow = 3)
m3<-matrix(20:25,byrow = TRUE, nrow = 2)

#union de matrices

cbind(m1,m2)
rbind(m1,m3)


######################################FACTOR######################################
#Tipo de dato usado para guardar variables categoricas, que representan una magnitud o caracter铆stica en particular.
#Las variables categ贸ricas pueden ser nominales u ordinales.
#Ejemplo: 
#1) Masculino, Femenino. /nominal
#2) Alto, Medio, Bajo. /ordinales
#3) Mono, Jirafa, Caballo /nominal

factor("Masculino","Femenino")
factor("Alto","Medio","Bajo")




######################################DATAFRAME######################################
#data.frame son conjuntos de vectores/matrices con distintos tipos de valor.

id<-c(1,2,3)
nombre<-c("Josue","Pedro","Jonathan")
apellido<-c("Salinas","Espinosa","Vasquez")
ayudante<-c(TRUE,TRUE,FALSE)
df<-data.frame(id,nombre,apellido,ayudante)

#para nombrar los elementos por filas se debe usar el siguiente c骴igo
rownames(df)<-nombre

#Pregunta: nombrar los elements de df


######################################Accediendo a Datos######################################
#con $ accedo a alguna columna del data.frame. Ejemplo:
df$id #estoy accediendo al vector id del data.frame df

#con [,] accedo a una coordenada en particular del data frame. Ejemplo:
df[2,3] #se accede a la coordenada (2,1), es decir, fila 2 y columna 1

#se pueden usar condiciones. En el caso del igual se debe usar ==. Ejemplo
df[df$ayudante==TRUE,] #entrega todos los registros donde ayudante sea igual a TRUE
df[which(ayudante==TRUE),]

#se puede filtrar tambi茅n qu茅 columnas mostrar
df[df$ayudante==TRUE,c(2,3)] #solamente se estar铆a mostrando los ayudantes con las columnas nombre y apellido.

######################################CARGANDO BASES DE DATOS######################################
library(readxl) #asegurarse cargar esta libreria

setwd("C:/Users/Xasco/Documents/Trabajo/Universidad-FEN/2018/Oto駉/Business Intelligence/Ayudant韆s/Ayudant韆 1")
titanic<-read_excel("Titanic_Train.xlsx",col_names = TRUE) #con esto cargamos el dataframe.
summary(titanic)
str(titanic)

#en el caso que alguna variable no sea bien cargada podemos volver a asignarla:
titanic$X__1<-as.factor(titanic$X__1)
str(titanic$X__1)


################################################################################################################
by: jovasque & jsalinasc
################################################################################################################