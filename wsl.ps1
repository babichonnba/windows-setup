### Update Help for Modules 

Write-Host "Enabling Windows Subsystem for Linux" -ForegroundColor "Yellow"
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

Write-Host "Enable Virtual Machien Feature"
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Write-Host "Setting WSL2 as the default version"
wsl --set-default-version 2