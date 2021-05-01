# @@@@@@@@@@@@ Carteira @@@@@@@@@@@@

# Autor: Leonardo Donato Nunes
# Data de criação: 28 de abril de 2021

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Carregar pacotes ----
library(shiny)
library(shinydashboard)
library(dplyr)
library(shinycssloaders)

source("./ler_notas.R")

ui <- dashboardPage(
    
    
    dashboardHeader(disable = T),
    
    dashboardSidebar(
        
        HTML(paste0(
            "<p style = 'text-align: center; font-size: 28px; '<a target='_blank'>Monitor de Carteira</a> </p>",
            "<p style = 'text-align: center; color: #33b812; font-size: 32px; '<a target='_blank'>Investimento$</a> </p>",
            "<br>",
            "<br>"
        )),
        
        
        sidebarMenu(
            
            menuItem("Home", tabName = "home", icon = icon("home")),
            menuItem("Painel", tabName = "painel", icon = icon("tachometer-alt")),
            menuItem("Notas", tabName = "notas", icon = icon("file-pdf")),
            menuItem("Extratos", tabName = "extratos", icon = icon("table")),
            

            HTML(paste0(
                "<br><br><br><br><br><br><br>",
                "<table style='margin-left:auto; margin-right:auto;'>",
                "<tr>",
                "<td style='padding: 5px;'><a href='https://github.com/LeonardoDonatoNunes' target='_blank'><i class='fab fa-github-square fa-lg'></i></a></td>",
                "<td style='padding: 5px;'><a href='https://www.linkedin.com/in/leonardo-donato-nunes-754aa5b8/' target='_blank'><i class='fab fa-linkedin fa-lg'></i></a></td>",
                "<td style='padding: 5px;'><a href='https://www.instagram.com/leonardodonatonunes/?hl=pt-br' target='_blank'><i class='fab fa-instagram fa-lg'></i></a></td>",
                "</tr>",
                "</table>",
                "<br>")),            
            
            
            HTML(paste0(
                "<a href='https://leonardodonatonunes.github.io/ds/' target='_blank'><img style = 'display: block; margin-left: auto; margin-right: auto;' src='Logo_Cinza.png' width = '80'></a>",
                "<br>"
            )),
            
            HTML(paste0(
                "<script>",
                "var today = new Date();",
                "var yyyy = today.getFullYear();",
                "</script>",
                "<p style = 'text-align: center;'><small>&copy; - <a href='https://leonardodonatonunes.github.io/ds/' target='_blank'>LDN Data Science</a> - <script>document.write(yyyy);</script></small></p>")
                )
        )
        
    ),
    
    dashboardBody(
        
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
        ),
        
        tabItems(
          
            # First tab content
            tabItem(tabName = "home",
                    
                    box(width = 12,
                        
                        HTML(paste0(
                          "<br><br><br><br><br><br><br><br><br><br>",
                          "<p style = 'text-align: center; font-size: 38px;'<a target='_blank'>  <i class='fas fa-wallet'></i>  Monitor de Carteira <i class='fas fa-wallet'></i> </a>  </p>",
                          "<p style = 'text-align: center; color: #33b812; font-size: 38px; '<a target='_blank'> <i class='fas fa-coins'></i> Investimento$ <i class='far fa-money-bill-alt'> </i> </a> </p>",
                          "<br>",
                          "<p style = 'text-align: center; color: #33b812; font-size: 52px; '<a target='_blank'> <i class='fas fa-hand-holding-usd'></i> </a> </p>",
                          "<br><br><br><br><br><br><br><br><br><br><br><br><br>"
                        ))
                        
                        
                    )
                    
                    ),
              
            
            # First tab content
            tabItem(tabName = "notas",
                    
                    fluidRow(
                        box(width = 12,
                            HTML(paste0(
                                "<p style = 'text-align: justify; color: #1d1f1d; font-size: 22px; '<a target='_blank'>Ler notas de corretagem</a> </p>",
                                "<p style = 'text-align: justify; color: #1d1f1d; font-size: 20px; '<a target='_blank'>As funções abaixo servem para obeter os dados de negociações que estão nas notas de corretagem.</a> </p>",
                                "<br>",
                                "<br>"
                            )),
                        ) 
                    ),
                    
                    fluidRow(
                        
                        box(width = 12,
                        
                        column(width = 3,
                            fluidRow(
                                box(width = 12,
                                    textInput("diretorio_notas_input", label = "Copie e cole o caminho do diretorio", value = "C:/Arquivos/Financeiro/Notas"),
                                    textOutput("diretorio_notas_output")
                                )
                            ),
                            
                            
                            fluidRow(
                                box(width = 12,
                                    selectInput("corretora", label = "Selecione a Corretora", choices = c("Easynvest"), selected = "Easynvest"),
                                    actionButton("ler_notas", "Ler notas", icon = icon("arrow-circle-down"))
                                ) 
                            ),
                            
                            fluidRow(
                                box(width = 12,
                                    downloadButton("download_dados", "Baixar Dados")
                                ) 
                            )
                        ),
                        
                        column(width = 9,
                            box(width = 12,
                                
                                withSpinner(tableOutput('table') ,color="#0dc5c1")
                            )
                        )
                    )
            )),
            
            
            # Second tab content
            tabItem(tabName = "notas",
                    h2("Leitor de notas"),
                    
            ),
            
            
            
            # Third tab content
            tabItem(tabName = "extratos",
                    h2("Leitor de extratos")
            )
        )
    )
)

server <- function(input, output, session) {
    
    
    
    # close the R session when Chrome closes
     # session$onSessionEnded(function() {
     #   stopApp()
     #   q("no")
     # })
    
    v<-reactiveValues(data=NULL)
    
    diretorio_notas <- reactive({
        input$diretorio_notas_input
    })
    
    output$diretorio_notas_output <- renderText({ 
        head(list.files(diretorio_notas()))
    })
    
    observeEvent(input$ler_notas, {
      Sys.sleep(1)
      horario <- Sys.time()    
      v$data <- ler_notas(diretorio = paste0(diretorio_notas(), "/"))
      Sys.sleep(1)
      tempo <- difftime(Sys.time(), horario)
      Sys.sleep(tempo)
    })
    
    output$table <- renderTable({
        v$data
    })

    output$download_dados <- downloadHandler(
       filename = function() {
         paste('data-', Sys.Date(), '.csv', sep='')
       },
       content = function(con) {
         write.csv(v$data, con)
       }
     )
}

shinyApp(ui, server)