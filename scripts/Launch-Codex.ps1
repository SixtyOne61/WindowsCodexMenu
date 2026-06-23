param(
    [Parameter(Position = 0)]
    [string]$TargetPath = ""
)

$ErrorActionPreference = "Stop"

function Resolve-WorkingDirectory {
    param([string]$Path)

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return (Get-Location).Path
    }

    if (-not (Test-Path -LiteralPath $Path)) {
        return (Get-Location).Path
    }

    $item = Get-Item -LiteralPath $Path
    if ($item.PSIsContainer) {
        return $item.FullName
    }

    return $item.DirectoryName
}

$workingDirectory = Resolve-WorkingDirectory -Path $TargetPath
$codexCommand = Get-Command "codex.cmd" -ErrorAction SilentlyContinue

if ($null -eq $codexCommand) {
    $codexCommand = Get-Command "codex" -ErrorAction SilentlyContinue
}

if ($null -eq $codexCommand) {
    Write-Host "Codex introuvable dans le PATH de cette session PowerShell." -ForegroundColor Red
    Write-Host "Installe Codex, puis verifie que la commande 'codex' fonctionne dans PowerShell." -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Appuie sur Entree pour fermer"
    exit 1
}

Set-Location -LiteralPath $workingDirectory
Write-Host "Lancement de Codex dans :" -ForegroundColor Cyan
Write-Host $workingDirectory
Write-Host ""

& $codexCommand.Source --cd $workingDirectory --sandbox workspace-write --ask-for-approval on-request
