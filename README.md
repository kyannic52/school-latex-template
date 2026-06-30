# school-latex-template

Modernes LaTeX-Template für schulische Arbeitsblätter und später Klassenarbeiten.

## Nutzung

Nach lokaler Installation im persönlichen TeX-Baum kannst du überall schreiben:

```latex
\documentclass[theme=modern,subject=Mathematik,grade=8]{schoolworksheet}
```

Metadaten für das Blatt:

```latex
\worksheetsetup{
  title={Lineare Funktionen},
  subtitle={Steigung und Graphen},
  number={07},
  class={8b},
  date={\today}
}
```

Aufgaben mit Metadaten:

```latex
\begin{task}[difficulty=2,type=xoo,points=6,tag=modellieren,title=Training]
Text der Aufgabe.
\end{task}
```

`type` ist absichtlich nur ein freier dreistelliger String aus `x` und `o`, z. B. `xoo`, `xxo`, `oxo`.

## Kompilieren

Empfohlen ist LuaLaTeX:

```bash
lualatex examples/arbeitsblatt-a4.tex
```

## Lokale Installation als Git-Clone

```bash
mkdir -p ~/texmf/tex/latex
cd ~/texmf/tex/latex
git clone https://github.com/DEINNAME/school-latex-template.git
```

Updates:

```bash
cd ~/texmf/tex/latex/school-latex-template
git pull
```
