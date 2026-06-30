% schoolworksheet.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{schoolworksheet}[2026/06/30 Modern worksheet class]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=school,prefix=school@}
\DeclareStringOption[modern]{theme}
\DeclareStringOption[Mathematik]{subject}
\DeclareStringOption[]{grade}
\DeclareStringOption[]{number}
\DeclareBoolOption[false]{sidebar}
\DeclareBoolOption[false]{showmeta}
\ProcessKeyvalOptions*

\LoadClass[11pt,a4paper]{article}

\RequirePackage{iftex}
\ifPDFTeX
  \ClassError{schoolworksheet}{Dieses Template braucht LuaLaTeX oder XeLaTeX}{Kompiliere mit lualatex oder xelatex statt pdflatex.}
\fi

\RequirePackage[ngerman]{babel}
\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures=TeX}
\IfFontExistsTF{Inter}{\setmainfont{Inter}}{\setmainfont{Latin Modern Sans}}
\IfFontExistsTF{Inter}{\setsansfont{Inter}}{\setsansfont{Latin Modern Sans}}
\renewcommand\familydefault{\sfdefault}

\RequirePackage{geometry}
\ifschool@sidebar
  \geometry{a4paper,left=15mm,right=14mm,top=14mm,bottom=15mm,headheight=16pt,footskip=9mm}
\else
  \geometry{a4paper,left=18mm,right=18mm,top=15mm,bottom=16mm,headheight=16pt,footskip=9mm}
\fi

\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage{pgfkeys}
\RequirePackage{tabularx}
\RequirePackage{tikz}
\RequirePackage{schooldesign}
\RequirePackage{schooltasks}
\RequirePackage{themes/\school@theme}

\ifschool@showmeta\schoolshowtaskmetatrue\fi

\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyfoot[C]{\scriptsize\color{schoolMuted}Seite \thepage\ von \pageref{LastPage}}

\newcommand\worksheetTitle{Arbeitsblatt}
\newcommand\worksheetSubtitle{}
\newcommand\worksheetName{}
\newcommand\worksheetClass{\school@grade}
\newcommand\worksheetDate{\today}

\pgfkeys{
  /school/worksheet/.is family, /school/worksheet,
  title/.store in=\worksheetTitle,
  subtitle/.store in=\worksheetSubtitle,
  name/.store in=\worksheetName,
  class/.store in=\worksheetClass,
  date/.store in=\worksheetDate,
  subject/.store in=\school@subject,
  grade/.store in=\school@grade,
  number/.store in=\school@number
}
\newcommand{\worksheetsetup}[1]{\pgfkeys{/school/worksheet,#1}}

\newcommand{\worksheetheader}{%
  \thispagestyle{fancy}%
  \noindent
  \begin{minipage}[c]{15mm}\schoolSubjectIcon\end{minipage}\hspace{4mm}%
  \begin{minipage}[c]{0.49\linewidth}
    {\fontsize{29}{31}\selectfont\bfseries\color{schoolInk}\MakeUppercase{\school@subject}}\par\vspace{-1mm}
    {\Large\bfseries\color{schoolPrimary}\worksheetTitle}\par
    \ifx\worksheetSubtitle\empty\else{\large\color{schoolMuted}\worksheetSubtitle}\fi
  \end{minipage}\hfill
  \begin{minipage}[c]{0.31\linewidth}
    \raggedleft
    \ifx\school@number\empty\else\schoolSmallPill{Nr.\,\school@number}\par\vspace{1mm}\fi
    \begin{tabular}{@{}>{\color{schoolInk}}l@{\hspace{2mm}}l@{}}
      \faUser[regular] & Name:\quad\rule{38mm}{0.35pt}\\[2mm]
      \faCalendar*[regular] & Datum:\quad\rule{38mm}{0.35pt}\\[2mm]
      \faUsers & Klasse:\quad\rule{38mm}{0.35pt}
    \end{tabular}
  \end{minipage}
  \par\vspace{5mm}\noindent{\color{schoolPrimary}\rule{\linewidth}{1pt}}\par\vspace{5mm}
}

\newenvironment{worksheetbody}{%
  \worksheetheader
  \ifschool@sidebar
    \noindent\begin{minipage}[t]{0.72\linewidth}
  \fi
}{%
  \ifschool@sidebar
    \end{minipage}\hfill
    \begin{minipage}[t]{0.24\linewidth}
      \begin{rememberbox}\small Regeln, Formeln oder Merksätze.\end{rememberbox}
      \vspace{5mm}
      \begin{notebox}\writinglines[5mm]{10}\end{notebox}
      \vspace{5mm}
      \begin{schoolSoftBox}[colback=schoolSoftGreen,colframe=schoolSoftGreen]{\faCheck\hspace{2mm}Selbstcheck}
      \small Wie sicher fühlst du dich?\par\vspace{2mm}
      $\square$ sicher\quad $\square$ geht so\quad $\square$ unsicher
      \end{schoolSoftBox}
    \end{minipage}
  \fi
}

\AtBeginDocument{\worksheetbody}
\AtEndDocument{\endworksheetbody}

\endinput
