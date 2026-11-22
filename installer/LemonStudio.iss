; Lemon Studio Windows installer (Inno Setup 6)
; Built by .github/workflows/build-windows.yml after `cargo build -p os-app --release`
; and `cargo run -p bundle-plugins --release`.

#define AppName    "Lemon Studio"
#define AppVersion "0.0.1"
#define AppExe     "lemonstudio.exe"

[Setup]
AppId={{8C4E2D17-5B3A-4F6E-9D21-7A0C5E3B4F92}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion} (pre-alpha)
AppPublisher=Lemon Studio contributors
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
SetupIconFile=..\crates\os-app\assets\lemonstudio.ico
UninstallDisplayIcon={app}\{#AppExe}
LicenseFile=..\LICENSE
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=admin
OutputDir=Output
OutputBaseFilename=LemonStudio-{#AppVersion}-Windows-Setup
Compression=lzma2
SolidCompression=yes
WizardStyle=modern

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"
Name: "plugins"; Description: "Install Lemon Studio's plugins (VST3 + CLAP) so other DAWs like FL Studio can use them"; GroupDescription: "Plugins:"

[Files]
Source: "..\target\release\{#AppExe}"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\LICENSE"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\THIRD-PARTY-NOTICES.txt"; DestDir: "{app}"; Flags: ignoreversion
; VST3 bundles are folders; CLAP plugins are single files on Windows
Source: "..\target\bundled\*"; Excludes: "*.clap"; DestDir: "{commoncf64}\VST3"; Flags: ignoreversion recursesubdirs createallsubdirs; Tasks: plugins
Source: "..\target\bundled\*.clap"; DestDir: "{commoncf64}\CLAP"; Flags: ignoreversion; Tasks: plugins

[Icons]
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExe}"
Name: "{group}\Uninstall {#AppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExe}"; Description: "{cm:LaunchProgram,{#AppName}}"; Flags: nowait postinstall skipifsilent
