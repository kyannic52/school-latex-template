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

## Kopfübungen auf einer A4-Seite

Die Klasse `schoolmental` bietet einen kompakten Kopf, nummerierte Aufgaben mit
Bearbeitungsfeldern und eine rechte Korrekturspalte mit je zwei Ankreuzfeldern
(`richtig` / `falsch`). Ein vollständiges Beispiel mit zehn Aufgaben, davon zwei
mit Koordinatensystem, steht in `examples/mental-a4.tex`.

```latex
\documentclass[subject=Mathematik,grade=8b,number=01]{schoolmental}
\worksheetsetup{title={Kopfübungen},subtitle={Gemischte Wiederholung}}
\begin{document}
\quicktask{Berechne: $48+37-19$.}
\quicktask[field=grid]{Vereinfache: $3x+2x-7$.}
\quicktask[field=coordinates,height=34mm]{Zeichne $A(-3\mid 1)$ ein.}
\end{document}
```

Eine normale Zeile ist mindestens 18 mm hoch und enthält ein 9 mm hohes leeres
Bearbeitungsfeld. Damit passen bis zu zwölf kurze Aufgaben auf eine A4-Seite.
Bei acht Aufgaben kann beispielsweise `height=27mm,workheight=17mm` mehr Platz
zum Schreiben geben. `height` ist eine Mindesthöhe; längere Inhalte vergrößern
die Zeile automatisch. Bei mehr Text oder größeren Grafiken den Seitenumfang
prüfen. Für Geometrie sind acht bis zehn Aufgaben meist zweckmäßiger.

Optionen je `\quicktask[...]{Aufgabentext}`:

- `field=blank` (Standard): umrandetes, leeres Bearbeitungsfeld.
- `field=grid`: Bearbeitungsfeld mit 4-mm-Karos.
- `field=coordinates`: Koordinatensystem unter der Aufgabe, mit $x$ von -4 bis 4
  und $y$ von -2 bis 2; eine Einheit entspricht 4 mm.
- `field=none`: eigene Bearbeitungsfläche oder Grafik direkt im Aufgabentext.
- `height=...` und `workheight=...`: Mindesthöhe der Zeile und Höhe des leeren
  bzw. karierten Feldes.

Eigene GeoGebra-Exporte (PDF oder PNG) und ergänzte TikZ-Koordinatensysteme:

```latex
\quicktask[field=none]{Ergänze die Zeichnung.\par\smallskip
  \includegraphics[width=65mm,height=27mm,keepaspectratio]{assets/geometrie.pdf}}
\quicktask[field=none]{Spiegle den Punkt an der $y$-Achse.\par
  \mentalcoordinates{}{\fill (-2,1) circle (1.5pt);}}
```

`assets/geometrie.pdf` ist hierbei durch den eigenen GeoGebra-Export zu ersetzen.
Die Klassenoptionen `sidebar` und `showmeta` werden in dieser kompakten Vorlage
nicht verwendet. Name und Datum bleiben zum handschriftlichen Ausfüllen frei.

Aus dem Projektverzeichnis kompilieren:

```powershell
lualatex examples/mental-a4.tex
```

## Installation lokal als Git-Clone

```powershell
mkdir $HOME\texmf\tex\latex
cd $HOME\texmf\tex\latex
git clone https://github.com/kyannic52/school-latex-template.git
mktexlsr $HOME\texmf
kpsewhich schoolworksheet.cls
```
