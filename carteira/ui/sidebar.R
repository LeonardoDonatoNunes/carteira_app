




  sidebarMenu(
    

    
    
    menuItem("Home", tabName = "home", icon = icon("home")),
    menuItem("Painel", tabName = "painel", icon = icon("tachometer-alt")),
    menuItem("Notas", tabName = "ler_notas", icon = icon("file-pdf"),
             menuSubItem("Resumo", tabName = "resumo_notas"),
             menuSubItem("Dados", tabName = "dados_notas"),
             menuSubItem("Leitor", tabName = "leitor_notas")),
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