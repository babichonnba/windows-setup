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
choco install curl                 --limit-output
choco install git.install          --limit-output -params '"/GitAndUnixToolsOnPath /NoShellIntegration"'
choco install nuget.commandline    --limit-output
choco install nvm.portable         --limit-output
choco install python               --limit-output
choco install ruby                 --limit-output
choco install vim                  --limit-output
choco install webpi                --limit-output
 
#fonts
choco install lato                 --limit-output
choco install merriweather         --limit-output
choco install opensans             --limit-output
choco install robotofonts          --limit-output
choco install sourcecodepro        --limit-output
choco install ubuntu.font          --limit-output
 
#apps 
choco install brackets             --limit-output
choco install chocolateygui        --limit-output
choco install everything           --limit-output
choco install firefox              --limit-output
choco install grammarly            --limit-output
choco install itunes               --limit-output
choco install logitech-options     --limit-output
choco install notepadplusplus      --limit-output
choco install peazip               --limit-output
choco install quicklook            --limit-output
choco install sharex               --limit-output
choco install sumatrapdf           --limit-output
choco install ueli                 --limit-output
choco install vlc                  --limit-output
choco install vscode               --limit-output
 
Refresh-Environment