#Instalar pacote GCalignR 
install.packages("GCalignR")
library("GCalignR")

#Alinhamento dos picos
dados <- align_chromatograms(data = "C:\\Users\\vitor\\OneDrive\\Área de Trabalho\\ParaAlinhar.txt",
                             rt_col_name = "RT",
                             max_diff_peak2mean = 0.02,
                             min_diff_peak2peak = 0.08,
                             max_linear_shift = 0.05)

#Visualização dos dados
print(dados)
View(dados)

# Para acessar os tR
dados$aligned$RT
# Para acessar as áreas
dados$aligned$Area


#peak_interspace(data = "C:/Users/Vitor/Documents/R/PIA.txt", rt_col_name = "RT",
                #quantile_range = c(0, 0.8), quantiles = 0.05)


#Gerar arquivo no Desktop (.xml) com o alinhamento 
install.packages("writexl")
library("writexl")
write_xlsx(dados$aligned$Area,"C:\\Users\\vitor\\OneDrive\\Área de Trabalho\\Alinhamento1.xlsx")


draw_chromatogram(
  data = dados,
  rt_col_name = "RT",
  width = 0.05,
  step = NULL,
  sep = "\t",
  breaks = NULL,
  rt_limits = NULL,
  samples = NULL,
  show_num = FALSE,
  show_rt = TRUE,
  plot = TRUE,
  shape = c("gaussian", "stick"),
  legend.position = "bottom"
)

View(dados)
peak = dados[,]
choose_optimal_reference(data = dados, rt_col_name = "RT", sep = "\t")

install.packages("reshape2")
library("reshape2")
require(reshape2)
dados$id <- rownames(dados) 
melt(dados)
choose_optimal_reference(data = dados, rt_col_name = "RT", sep = "\t")


