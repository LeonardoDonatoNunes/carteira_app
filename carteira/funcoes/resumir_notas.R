

resumir_dados <- function(ano_base = Sys.Date()){

    require(stringr)
    require(dplyr)
    require(lubridate)
    
    if(is.Date(ano_base)){
      ano_base <- year(ano_base)
    }
  
    dados <- read.csv(paste0("./dados/", list.files('./dados/')))
    
    dados$data <- as.Date(dados$data)
    dados$ano <- year(dados$data)
    
    dados <- subset(dados, ano <= ano_base)
    
    dados$Titulo <- sub("F$", "", dados$Titulo)
    dados$Valor <- as.numeric(sub(",", ".", dados$Valor))
    
    dados$Valor_Ajuste <- str_remove(dados$Valor_Ajuste, "\\s+[A-z]*")
    dados$Valor_Ajuste <- str_remove(dados$Valor_Ajuste, "\\.")
    dados$Valor_Ajuste <- as.numeric(sub(",", ".", dados$Valor_Ajuste))
    
    dados <- dados[order(dados$Titulo, dados$data),]
    
    dados <- dados %>% 
              group_by(Titulo, C_V) %>%
                      summarise(N = sum(N),
                                Valor = sum(Valor),
                                Valor_Ajuste = sum(Valor_Ajuste),
                                Data_ini = min(data),
                                Data_fim = max(data),
                                Tipo = paste(unique(Tipo), collapse = ";"))
    
    
    titulos <- unique(dados$Titulo)
    
    resumo <- data.frame()
    
    for(i in 1:length(titulos)){
      titulo_i <- subset(dados, Titulo == titulos[i])
      Valor <- sum(titulo_i[titulo_i$C_V == 'C',]$Valor_Ajuste) - sum(titulo_i[titulo_i$C_V == 'V',]$Valor_Ajuste)
      Numero <- sum(titulo_i[titulo_i$C_V == 'C',]$N) - sum(titulo_i[titulo_i$C_V == 'V',]$N)
      
      resumo_i <- data.frame("Título" = titulos[i],
                             "Tipo" = titulo_i$Tipo,
                             "C_V" = paste(unique(titulo_i$C_V), collapse = ";"),
                             "Primeiro negócio" = min(titulo_i$Data_ini),
                             "Último negócio" = max(titulo_i$Data_fim), 
                             "Preço total" = Valor,
                             "Número de papeis" = Numero,
                             "Preço médio" = Valor/Numero)
      
      resumo <- rbind(resumo, resumo_i)
      
    }

return(resumo)

}

