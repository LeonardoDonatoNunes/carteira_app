# @@@@@@@@@@@@ Carteira @@@@@@@@@@@@

# Autor: Leonardo Donato Nunes
# Data de criação: 28 de abril de 2021

# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Carregar pacotes ----
library(shiny)
library(shinydashboard)

source("./ler_notas.R")

ui <- dashboardPage(
    
    
    dashboardHeader(disable = T),
    
    dashboardSidebar(
        
        HTML(paste0(
            "<p style = 'text-align: center; font-size: 28px; '<a target='_blank'>Carteira de</a> </p>",
            "<p style = 'text-align: center; color: #33b812; font-size: 30px; '<a target='_blank'>Investimento$</a> </p>",
            "<br>",
            "<br>"
        )),
        
        
        sidebarMenu(
            
            menuItem("Painel", tabName = "painel", icon = icon("tachometer-alt")),
            menuItem("Notas", tabName = "notas", icon = icon("file-pdf")),
            menuItem("Extratos", tabName = "extratos", icon = icon("table")),
            

            HTML(paste0(
                "<br><br><br><br><br><br><br><br><br><br><br><br><br>",
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
            tabItem(tabName = "notas",
                    
                    box(width = 12,
                    HTML(paste0(
                        "<p style = 'text-align: justify; color: #1d1f1d; font-size: 22px; '<a target='_blank'>Ler notas de corretagem</a> </p>",
                        "<p style = 'text-align: justify; color: #1d1f1d; font-size: 20px; '<a target='_blank'>As funções abaixo servem para obeter os dados de negociações que estão nas notas de corretagem.</a> </p>",
                        "<br>",
                        "<br>"
                    )),
                    ),
                    
                    box(width = 3, title = "Selecione o diretório dos arquivos .TXT", footer = "Somente execute se os nomes dos arquivos aparecerem no quadro acima",
                        textInput("diretorio_limpeza_input", label = "Copie e cole o caminho do diretorio", value = "C:/ArquivosTXT"),
                        textOutput("diretorio_limpeza_output")
                    ),
                    
                    box(width = 3,
                        selectInput("tipo_telemetria", label = "Selecione o tipo da telemetria", choices = c("Rádio Fixo", "Rádio Móvel", "Acústica"), selected = "Rádio Fixo"),
                        actionButton("limpar_dados", "Limpar dados", icon = icon("arrow-circle-down"))
                    )
                    
                    
            ),
            
            
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

server <- function(input, output) { }

shinyApp(ui, server)