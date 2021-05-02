# @@@@@@@@@@@@ Carteira @@@@@@@@@@@@

# Autor: Leonardo Donato Nunes
# Data de criação: 28 de abril de 2021

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Carregar pacotes ----
library(shiny)
library(shinydashboard)
library(dplyr)
library(shinycssloaders)
library(DT)

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
            menuItem("Leitor de Notas", tabName = "ler_notas", icon = icon("file-pdf")),
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
              
            # Adiciona o código da UI da página de leitura de notas.
            source("./body/body_notas.R")$value,
            
            
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
    
    
    output$numero_notas_output <- renderText({ 
      paste0("A pasta contém ", length(list.files(diretorio_notas())), " nota(s) direfente(s).")
    })
    
    
    output$diretorio_notas_output <- renderText({
      dir_dados <- './dados/'
      arquivo <- list.files(dir_dados)
      dados <- read.csv(paste0(dir_dados, arquivo))
      notas_arquivadas <- dados$nome_nota
      notas_novas <- list.files(diretorio_notas())
      
      arquivos <- notas_novas[!(notas_novas %in% notas_arquivadas)] 
      
      paste0(arquivos, collapse = "\n")
    })
    
    
    observeEvent(input$ler_notas, {
      dir_dados <- './dados/'
      arquivo <- list.files(dir_dados)
      dados <- read.csv(paste0(dir_dados, arquivo))
      notas_arquivadas <- dados$nome_nota
      notas_novas <- list.files(diretorio_notas())
      
      arquivos <- notas_novas[!(notas_novas %in% notas_arquivadas)] 
      
      lista <- paste0(diretorio_notas(), "/", arquivos)
      v$data <- ler_notas(lista = lista)
    })
    
    output$dados_apagados <- renderText({
      "Dados apagados!"
    })
    
    output$table <- renderDataTable({
      datatable(v$data,
                options = list(scrollY='600px')
                )
    })
    
    output$notas_lidas <- renderText({
      paste0(nrow(v$data), " negócios obtidos!")
    })
    
    observeEvent(input$limpar_dados, {
      dir_dados <- './dados/'
      arquivo <- list.files(dir_dados)
      dados <- read.csv(paste0(dir_dados, arquivo))
      dados <- dados[0,] 
      write.csv(dados, file = paste0(dir_dados, arquivo), row.names = F)
      file.rename(from = paste0(dir_dados, arquivo), to = paste0(dir_dados, paste0('data-', Sys.Date(), '.csv')))
    })
    
    observeEvent(input$download_dados, {
      dir_dados <- './dados/'
      arquivo <- list.files(dir_dados)
      dados <- read.csv(paste0(dir_dados, arquivo))
      dados <- rbind(dados, v$data)
      write.csv(dados, file = paste0(dir_dados, arquivo), row.names = F)
      file.rename(from = paste0(dir_dados, arquivo), to = paste0(dir_dados, paste0('data-', Sys.Date(), '.csv')))
      
      output$download_concluido <- renderText({
        "Os dados foram incorporados ao banco de dados!"
      })
      
    })
}

shinyApp(ui, server)