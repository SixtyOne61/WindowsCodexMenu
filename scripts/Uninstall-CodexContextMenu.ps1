$ErrorActionPreference = "Stop"

$entries = @(
    "Software\Classes\Directory\shell\OpenCodexHere",
    "Software\Classes\Directory\Background\shell\OpenCodexHere",
    "Software\Classes\Drive\shell\OpenCodexHere",
    "Software\Classes\*\shell\OpenCodexHere"
)

foreach ($entry in $entries) {
    [Microsoft.Win32.Registry]::CurrentUser.DeleteSubKeyTree($entry, $false)
}

Write-Host "Menu contextuel Codex supprime." -ForegroundColor Green
