# First tab content

tabItem(tabName = "leitor_notas",
        
                
        fluidRow(
          
          box(width = 12,
              
              column(width = 10,
                     HTML(paste0(
                       "<p style = 'text-align: justify; color: #0c1b3e; font-size: 26px; '<a target='_blank'>Ler notas de corretagem</a> </p>",
                       "<p style = 'text-align: justify; color: #0c1b3e; font-size: 20px; '<a target='_blank'>As funções abaixo servem para obeter os dados de negociações que estão nas notas de corretagem.</a> </p>",
                       "<p style = 'text-align: justify; color: #0c1b3e; font-size: 20px; '<a target='_blank'>Para refazer todo o banco de dados, clicar no botão vermelho   'Apagar Dados' no botão a direita.</a> </p>"
                     ))
              ),
              
              column(width = 2,
                     actionButton("limpar_dados", "Limpar Dados", icon = icon("snowplow")),
                     conditionalPanel(condition = "input.limpar_dados", 
                                      withSpinner(textOutput("dados_apagados"), 
                                                  proxy.height = '60px',color="#0c1b3e", 
                                                  type = 1, size = 0.8))
              )
          ) 
        ),
        
        fluidRow(
          
          box(width = 12,
              
              column(width = 3,
                     fluidRow(
                       box(width = 12,
                           textInput("diretorio_notas_input", label = "Copie e cole o caminho do diretorio", value = "C:/Arquivos/Financeiro/Notas"),
                           textOutput("numero_notas_output"),
                           textOutput("diferencas_notas"),
                           textOutput("diretorio_notas_output", container = pre)
                       )
                     ),
                     
                     
                     fluidRow(
                       box(width = 12,
                           selectInput("corretora", label = "Selecione a Corretora", choices = c("Easynvest"), selected = "Easynvest"),
                           actionButton("ler_notas", "Ler notas", icon = icon("arrow-circle-down")),
                           conditionalPanel(condition = "input.ler_notas", 
                                            withSpinner(textOutput("notas_lidas"), 
                                                        proxy.height = '60px',color="#0c1b3e", 
                                                        type = 1, size = 0.8))
                       ) 
                     ),
                     
                     fluidRow(
                       box(width = 12,
                           actionButton("atualizar_dados", "Atualizar Dados", icon = icon("sync-alt")),
                           conditionalPanel(condition = "input.atualizar_dados", 
                                            withSpinner(textOutput("dados_atualizados"), 
                                                        proxy.height = '60px',color="#0c1b3e", 
                                                        type = 1, size = 0.8))
                       ) 
                     )
              ),
              
              column(width = 9,
                     box(width = 12,
                         conditionalPanel(condition = "input.ler_notas",
                                          withSpinner(dataTableOutput('table'), 
                                                      color="#0c1b3e", type = 7))
                     )
              )
          )
        ))