% schoolexam.cls
% Platzhalter / Startpunkt fuer die spaetere Klassenarbeits-Klasse.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{schoolexam}[2026/06/30 Modern exam class]

\LoadClass[11pt,a4paper]{article}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=schoolexam,prefix=schoolexam@}
\DeclareStringOption[modern]{theme}
\DeclareStringOption[Mathematik]{subject}
\DeclareStringOption[]{grade}
\ProcessKeyvalOptions*

\RequirePackage{schooldesign}
\RequirePackage{schooltasks}
\RequirePackage{tabularx}

\InputIfFileExists{themes/\schoolexam@theme.sty}{}{\ClassWarning{schoolexam}{Theme \schoolexam@theme.sty nicht gefunden. Nutze Standarddesign.}}
\renewcommand{\schoolSubject}{\schoolexam@subject}
\renewcommand{\schoolGrade}{\schoolexam@grade}
\newcommand{\examsetup}[1]{\worksheetsetup{#1}}

\newcommand{\examcover}{%
\thispagestyle{empty}
\begin{tikzpicture}[remember picture,overlay]
  \fill[schoolSoftBlue] (current page.north west) rectangle (current page.south east);
  \fill[schoolPrimary] (current page.north west) rectangle ([xshift=10mm]current page.south west);
  \fill[schoolAccent,opacity=.18] ([xshift=-24mm,yshift=-18mm]current page.north east) circle (34mm);
\end{tikzpicture}
\vspace*{18mm}
{\sffamily\Huge\bfseries\color{schoolInk}\schoolTitle\par}
\vspace{3mm}
{\sffamily\Large\color{schoolMuted}\schoolSubtitle\par}
\vspace{12mm}
\begin{tcolorbox}[enhanced,arc=4mm,boxrule=.6pt,colback=white,colframe=schoolLine,left=6mm,right=6mm,top=5mm,bottom=5mm]
\begin{tabularx}{\textwidth}{@{}>{\sffamily\color{schoolMuted}}l X@{}}
Name: & \rule{100mm}{0.4pt}\\[5mm]
Klasse: & \schoolClass\\[3mm]
Datum: & \schoolDate\\[3mm]
Punkte: & \rule{25mm}{0.4pt} / \rule{25mm}{0.4pt}\\
\end{tabularx}
\end{tcolorbox}
\vfill
\begin{infobox}[Hinweise]
Bearbeite die Aufgaben sauber und nachvollziehbar. Schreibe Rechenwege auf.
\end{infobox}
\newpage
\schoolHeader
}
\newenvironment{examtask}[1][]{\begin{task}[#1]}{\end{task}}
