# Janela do resumo dos dados

data_ini <- as.Date('2020-01-01')

tabItem(tabName = "resumo_notas",
        
        
        fluidRow(
          
                column(width = 12,
                       
                       box(width = 12, 
                           
                           column(width = 6,
                                  dateInput(inputId = 'resumo_selecionar_ano_inicio', 
                                            label = 'Selecione a data inicial', 
                                            value = data_ini)),
                           
                           column(width = 6,
                                  dateInput(inputId = 'resumo_selecionar_ano_fim', 
                                            label = 'Selecione a data final')),
                           
                           dataTableOutput("tabela_resumo", width = '100%'),
                           
                           
                           )
                       
                       )
        )
        
)