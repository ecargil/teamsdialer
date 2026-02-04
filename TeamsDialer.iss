[Setup]
AppName=TeamsDialer
AppVersion=1.0.0
AppPublisher=ecargil
AppPublisherURL=https://github.com/ecargil/teamsdialer
DefaultDirName={autopf}\TeamsDialer
DefaultGroupName=TeamsDialer
OutputDir=.
OutputBaseFilename=TeamsDialerSetup
Compression=lzma2
SolidCompression=yes
PrivilegesRequired=admin
UninstallDisplayIcon={app}\TeamsDialer.exe
SetupIconFile=phone.ico
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "TeamsDialer.exe"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\TeamsDialer Settings"; Filename: "{app}\TeamsDialer.exe"
Name: "{group}\Uninstall TeamsDialer"; Filename: "{uninstallexe}"

[Registry]
Root: HKLM; Subkey: "SOFTWARE\Classes\tel"; ValueType: string; ValueName: ""; ValueData: "URL:tel Protocol"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Classes\tel"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Classes\tel\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\TeamsDialer.exe"" ""%1"""; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\TeamsDialer\Capabilities"; ValueType: string; ValueName: "ApplicationName"; ValueData: "Teams Dialer"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\TeamsDialer\Capabilities"; ValueType: string; ValueName: "ApplicationDescription"; ValueData: "Dial phone numbers with Microsoft Teams"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\TeamsDialer\Capabilities\URLAssociations"; ValueType: string; ValueName: "tel"; ValueData: "tel"; Flags: uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\RegisteredApplications"; ValueType: string; ValueName: "TeamsDialer"; ValueData: "SOFTWARE\TeamsDialer\Capabilities"; Flags: uninsdeletevalue

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
begin
  if CurStep = ssPostInstall then
  begin
    // Delete user choice to allow re-selection
    RegDeleteKeyIncludingSubkeys(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\Shell\Associations\UrlAssociations\tel\UserChoice');
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then
  begin
    // Remove user choice on uninstall
    RegDeleteKeyIncludingSubkeys(HKEY_CURRENT_USER, 'Software\Microsoft\Windows\Shell\Associations\UrlAssociations\tel\UserChoice');
    // Remove user-level registrations if they exist
    RegDeleteKeyIncludingSubkeys(HKEY_CURRENT_USER, 'Software\Classes\tel');
    RegDeleteKeyIncludingSubkeys(HKEY_CURRENT_USER, 'Software\TeamsDialer');
  end;
end;

[Run]
Filename: "{app}\TeamsDialer.exe"; Description: "Launch TeamsDialer Settings"; Flags: postinstall nowait skipifsilent
