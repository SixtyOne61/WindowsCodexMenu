# Windows Codex Menu

Petit utilitaire Windows qui ajoute une entree **Ouvrir Codex ici** au menu contextuel de l'Explorateur.

## Ce que ca ajoute

- Clic droit sur un dossier : ouvre PowerShell dans ce dossier et lance `codex`.
- Clic droit dans le fond d'un dossier : ouvre PowerShell dans le dossier affiche et lance `codex`.
- Clic droit sur un disque : ouvre PowerShell a la racine du disque et lance `codex`.
- Clic droit sur un fichier : ouvre PowerShell dans le dossier du fichier et lance `codex`.

Les cles sont installees dans `HKCU`, donc l'installation ne demande pas de droits administrateur.

## Installation

Depuis ce dossier :

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\scripts\Install-CodexContextMenu.ps1
```

Ensuite, dans l'Explorateur Windows, fais un clic droit et choisis **Ouvrir Codex ici**.

Sur Windows 11, les entrees de menu contextuel classiques peuvent apparaitre dans **Afficher plus d'options**.

## Desinstallation

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\scripts\Uninstall-CodexContextMenu.ps1
```

## Prerequis

La commande `codex` doit etre disponible dans le `PATH` de PowerShell. Tu peux verifier avec :

```powershell
codex --version
```
