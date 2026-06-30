# school-latex-template

Modernes LaTeX-Template fuer schulische Arbeitsblaetter.

## Nutzung

```latex
% !TeX program = lualatex
\documentclass[theme=modern,subject=Mathematik,grade=8,number=07]{schoolworksheet}
\worksheetsetup{title={Gleichungen und Terme}, subtitle={Klammern und Gleichungen}, class={8b}}
\begin{document}
\begin{task}[title={Klammern aufloesen},difficulty=2,type=xoo,points=4,tag=Terme]
...
\end{task}
\end{document}
```

Kompilieren mit LuaLaTeX:

```powershell
lualatex arbeitsblatt-a4.tex
```

## Installation lokal als Git-Clone

```powershell
mkdir $HOME\texmf\tex\latex
cd $HOME\texmf\tex\latex
git clone https://github.com/kyannic52/school-latex-template.git
mktexlsr $HOME\texmf
kpsewhich schoolworksheet.cls
```
