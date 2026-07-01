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

## Klassenarbeiten

```latex
% !TeX program = lualatex
\documentclass[theme=modern,subject=Mathematik,grade=8. Klasse,number=2]{schoolexam}
\examsetup{
  title={Klassenarbeit},
  class={8. Klasse},
  duration={90 Minuten},
  aids={Geodreieck, Lineal, Taschenrechner},
  totalpoints={60 Punkte}
}
\begin{document}
\begin{examtask}[title={Terme und Gleichungen},points=6]
\examsubtask[4]{$3(x+2)-2(x-5)$ \hfill \answerline[7cm]}
\examsubtask[2]{$4(2x-1)+3(x+4)$ \hfill \answerline[7cm]}
\end{examtask}
\examnewpage
\begin{examtask}[title={Textaufgabe},points=6]
...
\end{examtask}
\end{document}
```

Die Klassenarbeitsklasse erzeugt standardmaessig ein Deckblatt und danach normale
A4-Inhaltsseiten. Fuer den Druck als gefaltetes A3-Heft die PDF im Druckdialog
als Broschuere bzw. zwei A4-Seiten auf A3 ausgeben.

Kompilieren mit LuaLaTeX:

```powershell
lualatex examples/worksheet-a4.tex
```

## Installation lokal als Git-Clone

```powershell
mkdir $HOME\texmf\tex\latex
cd $HOME\texmf\tex\latex
git clone https://github.com/kyannic52/school-latex-template.git
mktexlsr $HOME\texmf
kpsewhich schoolworksheet.cls
```
