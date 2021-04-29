#define MyAppName "MONITOR CARTEIRA"  ; NOME DO APLICATIVO
#define MyAppVersion "1.0"  ; VERSÃO
#define MyAppPublisher "LDN DATA SCIENCE"   ; COMPANHIA
#define MyAppURL "https://leonardodonatonunes.github.io/ds/"  ; SITE


[Setup]
; NOTA: O valor de AppId identifica exclusivamente este aplicativo. Não use o mesmo valor AppId em instaladores para outros aplicativos.
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


; Remova o comentário da linha a seguir para executar no modo de instalação não administrativa (instalar apenas para o usuário atual).
;PrivilegesRequired=lowest


; Endereço da pasta que será salvo o instalador
OutputDir=C:\Users\leona\Documents\CarteiraApp


; Nome do instalador
OutputBaseFilename=MC_INSTALADOR


; Endereço do ICO
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
; Endereço da pasta que será compactada com \* no final
Source: "C:\Projetos\R\carteira_app\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
;  NOTA: Não use "Flags: ignoreversion" em nenhum arquivo de sistema compartilhado


; Criar programa de desinstalação
[Icons]
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"


; Substituir com o nome do aplicativo, o nome do arquivo VBS e do arquivo ICO
[Icons]
Name: "{commondesktop}\CARTEIRA"; Filename: "{app}\run.vbs"; IconFilename: {app}\Icone.ico
