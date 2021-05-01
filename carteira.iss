#define MyAppName "MONITOR CARTEIRA"  ; NOME DO APLICATIVO
#define MyAppVersion "1.0"  ; VERS�O
#define MyAppPublisher "LDN DATA SCIENCE"   ; COMPANHIA
#define MyAppURL "https://leonardodonatonunes.github.io/ds/"  ; SITE


[Setup]
; NOTA: O valor de AppId identifica exclusivamente este aplicativo. N�o use o mesmo valor AppId em instaladores para outros aplicativos.
; (Para gerar um novo GUID, clique em Ferramentas | Gerar GUID dentro do IDE.)
AppId={{B319B9CA-C026-4DB3-B3FA-11FC28E82577}


AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=C:\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes


; Remova o coment�rio da linha a seguir para executar no modo de instala��o n�o administrativa (instalar apenas para o usu�rio atual).
;PrivilegesRequired=lowest


; Endere�o da pasta que ser� salvo o instalador
OutputDir=C:\Users\leona\Documents\CarteiraApp


; Nome do instalador
OutputBaseFilename=MC_INSTALADOR


; Endere�o do ICO
SetupIconFile=C:\Projetos\R\carteira_app\Icone.ico


Compression=lzma
SolidCompression=yes
PrivilegesRequired=none


; Criptografar Instalador
; Encryption=yes


; Senha, se quiser
; Password=12345678    


[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"


[Files]
; Endere�o da pasta que ser� compactada com \* no final
Source: "C:\Projetos\R\carteira_app\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
;  NOTA: N�o use "Flags: ignoreversion" em nenhum arquivo de sistema compartilhado


; Criar programa de desinstala��o
[Icons]
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"


; Substituir com o nome do aplicativo, o nome do arquivo VBS e do arquivo ICO
[Icons]
Name: "{commondesktop}\CARTEIRA"; Filename: "{app}\run.vbs"; IconFilename: {app}\Icone.ico
