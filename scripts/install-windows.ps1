param([string]$RepoUrl = "https://github.com/kyannic52/school-latex-template.git")
$target = Join-Path $HOME "texmf\tex\latex"
New-Item -ItemType Directory -Force -Path $target | Out-Null
Set-Location $target
git clone $RepoUrl
mktexlsr (Join-Path $HOME "texmf")
