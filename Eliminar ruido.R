#Carregar o arquivo bruto
data = read.csv(file = file.choose(), header = T, sep = ";")
head(data)

View(data)



#Selecionando as colunas de interesse
Sel = data[,c(2,5)]

View(Sel)

#Instalar pacote dplyr
install.packages("dplyr")
library("dplyr")

#Remove o ruído com base em um limiar definido pelo pesquisador
datafix = filter(Sel, data$Area > 71749.5)
View(datafix)

#Cria arquio .xml no desktop com o dado tratado
install.packages("writexl")
library("writexl")
write_xlsx(datafix,"C:\\Users\\vitor\\OneDrive\\?rea de Trabalho\\An?lise qualitativa\\LRI\\204137A9SR.xlsx")
