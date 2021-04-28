### Leitor de notas da Easnvest ####

# Função para ler cada nota
ler_notas <- function(diretorio){
  
  # Carrega os pacotes
  
  library(tabulizer)
  library(dplyr)
  library(stringr)
  
  # Arquivos no diretorio
  arquivos <- list.files(diretorio)
  
  
  # Para identificar as áreas das tabelas no PDF usar a função abaixo.
  
  # locate_areas(nota)
  
  # Vai abrir uma visualização com o PDF para selecioanr uma área. Quando clicar 
  # em Done, um vetor com as extremidades da tabela sera impresso no console.
  
  negociacoes <- data.frame()

  for(i in 1:length(arquivos)){
    
    nota <- paste0(diretorio, "/", arquivos[i])
  
    # Seleciona a tabela com o cabeçalho dos dados
    tabela_1 <- extract_tables(
      nota,
      guess = FALSE,
      area = list(c(2.334997,14.341271,150.840821,586.265833)),
      output = "data.frame",
      encoding = "UTF-8"
    )[[1]]
    
    # Seleciona a tabela com os dados das negociações
    tabela_2 <- extract_tables(
      nota,
      guess = FALSE,
      area = list(c(153.69841,11.82141,835.31746,601.55558)),
      columns = list(c(65,68,105,173,279,371,444,511,584)),
      output = "data.frame",
      encoding = "UTF-8"
    )[[1]]
    
    # Padroniza os nomes das colunas
    nomes <- c("Mercado","x","C_V","Tipo","Titulo","Obs","N","Valor","Valor_Ajuste")  
  
    names(tabela_2) <- nomes
    
    negocios_nota <- tabela_2
    negocios_nota <- negocios_nota[negocios_nota$Mercado == 'BOVESPA',]
    
    data <- str_extract(as.character(tabela_1),pattern = "[0-9]{2}\\/[0-9]{2}\\/[0-9]{4}") 
    data <- data[!is.na(data)]
    negocios_nota$data <- as.Date(data, format = "%d/%m/%Y")
    
    negociacoes <- rbind(negociacoes, negocios_nota)
  }    
  return(negociacoes)
}

