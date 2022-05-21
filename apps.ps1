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
    "docker-cli"
    "docker-compose"
    "youtube-dl"
}

foreach ($app in $apps) {
    choco install $app --limit-output
}

# Download Windows Package Manager winget 
Write-Host = 'Opening Windows Package Manager Releases Download Page... '
start "https://github.com/microsoft/winget-cli/releases"

Refresh-Environment

# WinGet Apps 
$win_apps = @{
    "Apple.Itunes"
    "Docker.DockerDesktop"
    "EarTrumpet"
    "FileOptimizer"
    "Giorgiotani.Peazip"
    "Google.BackupAndSync"
    "Grammarly.ForOffice"
    "Grammarly.ForWindows"
    "KDE.krita"
    "Logitech.options"
    "Microsoft.PowerToys"
    "Microsoft.VisualStudioCode"
    "Microsoft.WindowsTerminal"
    "Mozilla.Firefox"
    "Notepadplusplus"
    "Notion.Notion"
    "ProtonTechnologies.ProtonMailBridge"
    "ProtonTechnologies.ProtonVPN"
    "Q-Win.QuickLook"
    "RealVNC.VNCViewer"
    "ShareX"
    "SumatraPDF"
    "TeamViewer.TeamViewer"
    "Telegram.TelegramDesktop"
    "VideoLAN.VLC"
    "Whatsapp.Whatsapp"
    "authy-desktop"
    "balenaetcher"
    "brackets-cont.brackets"
    "choco"
    "imageglass"
    "postman.postman"
    "qbittorrent.qbittorrent"
    "ueli"
    "voidtools.everything"

}

foreach ($win_apps in $win_app) {
    winget install $win_app
}