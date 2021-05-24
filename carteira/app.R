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

source("./funcoes/ler_notas.R")
source("./funcoes/resumir_notas.R")

# UI ----

ui <- dashboardPage(
    
    
    dashboardHeader(disable = T),
    
    dashboardSidebar(
                source("./ui/sidebar_head.R", encoding = 'UTF-8')$value,
                source("./ui/sidebar.R", encoding = 'UTF-8')$value
                    ),
    
    dashboardBody(
        
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
            
            # Script JS para dimensionar de acordo com o tamanho da janela.
            tags$script('
                                var dimension = [0, 0];
                                $(document).on("shiny:connected", function(e) {
                                    dimension[0] = window.innerWidth;
                                    dimension[1] = window.innerHeight;
                                    Shiny.onInputChange("dimension", dimension);
                                });
                                $(window).resize(function(e) {
                                    dimension[0] = window.innerWidth;
                                    dimension[1] = window.innerHeight;
                                    Shiny.onInputChange("dimension", dimension);
                                });
                            ')
        ),
        
        tabItems(
          
            # First tab content
            source("./ui/body_home.R", encoding = 'UTF-8')$value,
            
            # diciona o código da UI da página dos dados das notas.
            source("./ui/body_notas_resumo.R", encoding = 'UTF-8')$value,
            
            
            # diciona o código da UI da página dos dados das notas.
            source("./ui/body_notas_dados.R", encoding = 'UTF-8')$value,
            
            # Adiciona o código da UI da página de leitura de notas.
            source("./ui/body_notas_leitor.R", encoding = 'UTF-8')$value,
            
            
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

# Servidor ----

server <- function(input, output, session) {
  
    
    # close the R session when Chrome closes
     # session$onSessionEnded(function() {
     #   stopApp()
     #   q("no")
     # })
  
  # Carrega os dados armazenados
  
  dados_notas <- read.csv(paste0('./dados/', list.files('./dados/')))
  dados_notas$data <- as.Date(dados_notas$data)
  
  output$tabela_dados <- renderDataTable({
    datatable(dados_notas,
    options = list(scrollY='600px'))
  })
  
  updateDateInput(session, inputId = 'resumo_selecionar_ano_inicio', 
                  value = min(dados_notas$data))
  
  dados_notas_sub <- reactive({
    
    data_ini <- input$resumo_selecionar_ano_inicio
    data_fim <- input$resumo_selecionar_ano_fim
    
    resumir_notas(data_ini = data_ini, data_fim = data_fim)
    
  })

  
  output$tabela_resumo <- renderDataTable({
    datatable(dados_notas_sub(), 
              options = list(searchHighlight = TRUE))
  })
  
  
  
  v <- reactiveValues(data=NULL)
  
  diretorio_notas <- reactive({
    input$diretorio_notas_input
  })
  
  nomes_notas <- reactive({
    notas_diretorio <- list.files(diretorio_notas())
    notas_diretorio[!notas_diretorio %in% dados_notas$nome_nota]
  })
  
  
  output$numero_notas_output <- renderText({ 
    paste0("A pasta contém ", 
           length(nomes_notas()), 
           " nota(s) direfente(s).")
  })
  
  
  output$diretorio_notas_output <- renderText({
    paste0(nomes_notas(), collapse = "\n")
  })
  
  
  observeEvent(input$ler_notas, {
    lista <- paste0(diretorio_notas(), "/", nomes_notas())
    v$data <- ler_notas(lista = lista)
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
    dados <- dados_notas[0,] 
    write.csv(dados, file = paste0(dir_dados, arquivo), row.names = F)
    file.rename(from = paste0(dir_dados, arquivo), to = paste0(dir_dados, paste0('data-', Sys.Date(), '.csv')))
    session$reload()
  })
  
  output$dados_apagados <- renderText({
    "Dados apagados!"
  })
  
  observeEvent(input$atualizar_dados, {
    dir_dados <- './dados/'
    arquivo <- list.files(dir_dados)
    dados <- read.csv(paste0(dir_dados, arquivo))
    dados <- rbind(dados, v$data)
    write.csv(dados, file = paste0(dir_dados, arquivo), row.names = F)
    file.rename(from = paste0(dir_dados, arquivo), to = paste0(dir_dados, paste0('data-', Sys.Date(), '.csv')))
    
    output$dados_atualizados <- renderText({
      "Os dados foram incorporados ao banco de dados!"
    })
    
    session$reload()

  })
  
  
  }

shinyApp(ui, server)