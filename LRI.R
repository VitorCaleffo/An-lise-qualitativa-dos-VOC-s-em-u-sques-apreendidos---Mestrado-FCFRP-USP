alcanos = read.csv(file = file.choose(), header = T, sep = ";")
alcanos$tr = as.numeric(sub(",", ".", alcanos$tr))
alcanos$nC = c(8:30)
View(alcanos)
LRI = function(RT_x = 0) {
  z = sum(RT_x > alcanos$tr)
  #                  z                RT(x)        RT(z)         RT(Z+1)            RT(Z)
  return(100 * alcanos$nC[z] + 100 *((RT_x - alcanos$tr[z])/(alcanos$tr[z+1] - alcanos$tr[z])))
}

amostra = read.csv(file = file.choose(), header = T, sep = ";")
head(amostra)
View(amostra)
amostra$tr = as.numeric(sub(",", ".", amostra$tr))

#Lógica
#amostra$TR_analito[1] > alcanos$tr
#sum(amostra$TR_analito[1] > alcanos$tr)
#z = sum(amostra$TR_analito[1] > alcanos$tr)
#z_1 = z + 1
#LRI_x = 100 * alcanos$nC[z] + 100 *((amostra$TR_analito[1] - alcanos$tr[z])/(alcanos$tr[z_1] - alcanos$tr[z]))
#LRI_x


#LRI(amostra$tr[1])

#unlist(lapply(amostra$JD1,LRI))

amostra$LRI = unlist(lapply(amostra$tr, LRI))

View(amostra)


install.packages("writexl")
library("writexl")


write_xlsx(amostra,"C:\\Users\\vitor\\OneDrive\\Área de Trabalho\\LRIExp\\Black Label.xlsx")

