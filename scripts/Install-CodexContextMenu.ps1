$ErrorActionPreference = "Stop"

$launcherPath = Join-Path $PSScriptRoot "Launch-Codex.ps1"

if (-not (Test-Path -LiteralPath $launcherPath)) {
    throw "Lanceur introuvable : $launcherPath"
}

$powerShellExe = Join-Path $env:SystemRoot "System32\WindowsPowerShell\v1.0\powershell.exe"
$icon = $powerShellExe

function Set-CodexMenuEntry {
    param(
        [string]$SubKeyPath,
        [string]$TargetArgument
    )

    $command = "`"$powerShellExe`" -NoExit -ExecutionPolicy Bypass -File `"$launcherPath`" `"$TargetArgument`""
    $key = [Microsoft.Win32.Registry]::CurrentUser.CreateSubKey($SubKeyPath)
    $commandKey = $key.CreateSubKey("command")

    try {
        $key.SetValue("MUIVerb", "Ouvrir Codex ici", [Microsoft.Win32.RegistryValueKind]::String)
        $key.SetValue("Icon", $icon, [Microsoft.Win32.RegistryValueKind]::String)
        $key.SetValue("Position", "Top", [Microsoft.Win32.RegistryValueKind]::String)
        $commandKey.SetValue("", $command, [Microsoft.Win32.RegistryValueKind]::String)
    }
    finally {
        if ($null -ne $commandKey) {
            $commandKey.Dispose()
        }

        if ($null -ne $key) {
            $key.Dispose()
        }
    }
}

$entries = @(
    @{ Path = "Software\Classes\Directory\shell\OpenCodexHere"; Argument = "%1" },
    @{ Path = "Software\Classes\Directory\Background\shell\OpenCodexHere"; Argument = "%V" },
    @{ Path = "Software\Classes\Drive\shell\OpenCodexHere"; Argument = "%1" },
    @{ Path = "Software\Classes\*\shell\OpenCodexHere"; Argument = "%1" }
)

foreach ($entry in $entries) {
    Set-CodexMenuEntry -SubKeyPath $entry.Path -TargetArgument $entry.Argument
}

Write-Host "Menu contextuel installe pour l'utilisateur courant." -ForegroundColor Green
Write-Host "Dans l'Explorateur Windows : clic droit sur un dossier, le fond d'un dossier, un disque ou un fichier, puis 'Ouvrir Codex ici'."
Write-Host "Sur Windows 11, l'entree peut etre dans 'Afficher plus d'options'."
