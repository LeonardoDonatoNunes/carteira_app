# Janela do resumo dos dados

tabItem(tabName = "resumo_notas",
        
        
        fluidRow(
                  
                  box(width = 12,
                      
                      column(width = 12,
                          dataTableOutput("tabela_resumo")
                            )
                      )
                ) 
        )