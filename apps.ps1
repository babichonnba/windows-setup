# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);
 
    exit
}
 
### Update Help for Modules
Write-Host "Updating Help..." -ForegroundColor "Yellow"
Update-Help -Force

### Package Providers
Write-Host "Installing Package Providers..." -ForegroundColor "Yellow"
Get-PackageProvider NuGet -Force | Out-Null
# Chocolatey Provider is not ready yet. Use normal Chocolatey
#Get-PackageProvider Chocolatey -Force
#Set-PackageSource -Name chocolatey -Trusted
 
 
### Install PowerShell Modules
Write-Host "Installing PowerShell Modules..." -ForegroundColor "Yellow"
Install-Module Posh-Git -Scope CurrentUser -Force
Install-Module PSWindowsUpdate -Scope CurrentUser -Force
 
 
### Chocolatey
Write-Host "Installing Desktop Utilities..." -ForegroundColor "Yellow"
if ((which cinst) -eq $null) {
    iex (new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}
 
# system and cli
clis = @{
    "curl"
    "git"
    "nuget.commandline"
    "nvm.portable"
    "python"
    "ruby"
    "webpi"
}

foreach ($cli in $clis) {
    choco install $cli --limit-output
}
 
#fonts
$fonts = @{
    "lato"
    "merriweather"
    "opensans"
    "robotofonts"
    "sourcecodepro"
    "ubuntu.font"
}

foreach ($font in $fonts) {
    choco install $font --limit-output
}
 
#apps 
$apps = @{
    "authy-desktop"
    "etcher"
    "brackets"
    "chocolateygui"
    "docker"
    "docker-cli"
    "docker-compose"
    "etcher"
    "eartrumpet"
    "everything"
    "fileoptimizer"
    "firefox"
    "google-backup-and-sync"
    "grammarly"
    "imageglass"
    "itunes"
    "krita"
    "logitech-options"
    "microsoft-windows-terminal"
    "notepadplusplus"
    "notion"
    "office365proplus"
    "peazip"
    "postman"
    "powertoys"
    "protonmailbridge"
    "protonvpn"
    "pycharm"
    "qbittorrent"
    "quicklook"
    "sharex"
    "sumatrapdf"
    "teamviewer"
    "telegram"
    "telegram"
    "teracopy"
    "ueli"
    "vlc"
    "vnc-viewer"
    "vscode"
    "whatsapp"
    "youtube-dl"
}

foreach ($app in $apps) {
    choco install $app --limit-output
}

# Download Windows Package Manager winget 
Write-Host = 'Opening Windows Package Manager Releases Download Page... '
start "https://github.com/microsoft/winget-cli/releases"
 
Refresh-Environment