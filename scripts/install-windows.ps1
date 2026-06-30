param([Parameter(Mandatory=$true)][string]$RepoUrl)
$Target = Join-Path $HOME "texmf\tex\latex\school-latex-template"
New-Item -ItemType Directory -Force -Path (Split-Path $Target) | Out-Null
if (Test-Path (Join-Path $Target ".git")) {
  Write-Host "Repo existiert bereits: $Target"
} else {
  git clone $RepoUrl $Target
}
Write-Host "Fertig. In LaTeX: \documentclass{schoolworksheet}"
