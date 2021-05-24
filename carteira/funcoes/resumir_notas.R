

resumir_notas <- function(data_ini = data_ini, data_fim = data_fim, encoding = "UTF-8"){

    require(stringr)
    require(dplyr)
    require(lubridate)
  
    dados <- read.csv(paste0("./dados/", list.files('./dados/')))
    dados <- subset(dados, data >= data_ini &
                           data <= data_fim)
    
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
      
      resumo_i <- data.frame("Titulo" = titulos[i],
                             "Tipo" = titulo_i$Tipo,
                             "C_V" = paste(unique(titulo_i$C_V), collapse = ";"),
                             "Primeiro negocio" = min(titulo_i$Data_ini),
                             "Ultimo negocio" = max(titulo_i$Data_fim), 
                             "Preco total" = Valor,
                             "Numero de papeis" = Numero,
                             "Preco medio" = Valor/Numero)

      resumo <- rbind(resumo, resumo_i)
      resumo <- unique(resumo)
    }

return(resumo)

}

