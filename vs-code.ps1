$extensions = @(
    "abusaidm.html-snippets"
    "christian-kohler.path-intellisense"
    "DavidAnson.vscode-markdownlint"
    "dbaeumer.vscode-eslint"
    "DotJoshJohnson.xml"
    "eamodio.gitlens"
    "Equinusocio.vsc-community-material-theme"
    "Equinusocio.vsc-material-theme"
    "equinusocio.vsc-material-theme-icons"
    "esbenp.prettier-vscode"
    "felixfbecker.php-intellisense"
    "GrapeCity.gc-excelviewer"
    "HookyQR.beautify"
    "jmrog.vscode-nuget-package-manager"
    "mechatroner.rainbow-csv"
    "ms-mssql.mssql"
    "ms-python.python"
    "ms-vscode.powershell"
    "PKief.material-icon-theme"
    "ritwickdey.LiveServer"
    "skyapps.fish-vscode"
    "Tyriar.sort-lines"
    "vscodevim.vim"
    "yzhang.markdown-all-in-one"
)

foreach ($extension in $extensions) {
    code --install-extension $extension
}