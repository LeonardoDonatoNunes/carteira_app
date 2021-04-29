chrome.sys = "C:/Program Files/Google/Chrome/Application/chrome.exe"


if (file.exists(chrome.sys))
  options(browser = chrome.sys)
shiny::runApp('./carteira/app.R', launch.browser=T)
