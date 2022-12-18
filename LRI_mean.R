#Atribui um Índice de retenção médio para os resultados


library(readxl)
library(tidyverse)

ARQ = "C:\\Users\\vitor\\OneDrive\\Área de Trabalho\\Tabela qualitativa - Tratamento de dados\\Nova versão\\OUT17.xlsx"

sheets = excel_sheets(ARQ)

total_lri = data.frame(matrix(nrow = 0, ncol = 3))
names(total_lri) = c("compound", "LRI", "MF")

for(aba in sheets){
  xlss = read_xlsx(ARQ, sheet = aba)
  for (line in c(1:dim(xlss)[1])) {
    total_lri[nrow(total_lri) + 1, ] = c(xlss[line, "Compound"], xlss[line, "LRI"], xlss[line, "Match Factor"])
  }
}


filtrd_lri = total_lri %>% 
  filter(!is.na(compound) & !is.na(LRI)) %>%
  filter(! compound %in% c("msm", "mesmo", "Mesmo", "MESMO", "Msm", "MSM", "Mszm", "mszm")) %>%
  filter( MF >= 800 )


ref = read.csv("C:\\Users\\vitor\\OneDrive\\Área de Trabalho\\Tabela qualitativa - Tratamento de dados\\Nova versão\\ReferenciaLRI.CSV", sep = ";")
head(ref)

unique(ref$CAS)
refU = unique(ref$CAS)

for (cmp in c(1:dim(filtrd_lri)[1])) {
  if( filtrd_lri[cmp, "compound"] %in% ref$Composto ){
    filtrd_lri[cmp, "compound"] = ref$CAS[ref$Composto == filtrd_lri[cmp, "compound"]]
  }else{
    print("out")
    print(filtrd_lri[cmp, "compound"])
    filtrd_lri[cmp, "compound"] = "remove"
  }
}



mean_cas = filtrd_lri %>%
  filter(compound != "remove") %>%
  group_by(compound) %>%
  summarise(mean_LRI = mean(LRI))

mean_cas

ru = read.csv("C:\\Users\\vitor\\OneDrive\\Área de Trabalho\\ReferenciaLRI_UNIQUE.CSV", sep = ";")
ru$CAS
for (i in c(1:dim(mean_cas)[1])) {
  mean_cas$compound[i] = ru$Composto[ru$CAS == mean_cas$compound[i]]
}

mean_cas

write.csv(mean_cas, )

write_csv(mean_cas, file =  "C:\\Users\\vitor\\OneDrive\\Área de Trabalho\\Mean_LRI.csv")

