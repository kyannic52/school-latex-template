% schoolexam.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{schoolexam}[2026/07/01 Modern exam class]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=school,prefix=school@}
\DeclareStringOption[modern]{theme}
\DeclareStringOption[Mathematik]{subject}
\DeclareStringOption[]{grade}
\DeclareStringOption[]{number}
\DeclareBoolOption[true]{cover}
\ProcessKeyvalOptions*

\LoadClass[11pt,a4paper]{article}

\RequirePackage{iftex}
\ifPDFTeX
  \ClassError{schoolexam}{Dieses Template braucht LuaLaTeX oder XeLaTeX}{Kompiliere mit lualatex oder xelatex statt pdflatex.}
\fi

\RequirePackage[ngerman]{babel}
\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures=TeX}
\IfFontExistsTF{Inter}{\setmainfont{Inter}}{\setmainfont{Latin Modern Sans}}
\IfFontExistsTF{Inter}{\setsansfont{Inter}}{\setsansfont{Latin Modern Sans}}
\renewcommand\familydefault{\sfdefault}

\RequirePackage{geometry}
\geometry{a4paper,left=15mm,right=15mm,top=13mm,bottom=14mm,headheight=16pt,footskip=8mm}

\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage{pgfkeys}
\RequirePackage{tabularx}
\RequirePackage{tikz}
\RequirePackage{needspace}
\RequirePackage{schooldesign}
\RequirePackage{themes/\school@theme}

\newlength{\exampointscolwidth}
\setlength{\exampointscolwidth}{22mm}
\newlength{\exampointsgap}
\setlength{\exampointsgap}{5mm}
\newlength{\examcontentcolwidth}
\newlength{\examsubtaskleftwidth}
\newlength{\examsubtaskrowwidth}

\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyfoot[R]{\scriptsize\bfseries\color{schoolMuted}Seite \thepage\ von \pageref{LastPage}}

\newif\ifexam@contentpages
\exam@contentpagesfalse
\AddToHook{shipout/background}{%
  \ifexam@contentpages
    \begin{tikzpicture}[remember picture,overlay]
      \fill[schoolSoft,opacity=.75]
        ([xshift=-37mm,yshift=-38mm]current page.north east)
        rectangle
        ([xshift=-15mm,yshift=14mm]current page.south east);
      \draw[schoolLine,line width=.4pt]
        ([xshift=-37mm,yshift=-38mm]current page.north east) --
        ([xshift=-37mm,yshift=14mm]current page.south east);
    \end{tikzpicture}%
  \fi
}

\newcommand\examTitle{Klassenarbeit}
\newcommand\examSubtitle{}
\newcommand\examClass{\school@grade}
\newcommand\examDate{\today}
\newcommand\examDuration{}
\newcommand\examAids{}
\newcommand\examTotalPoints{}
\newcommand\examTeacher{}

\pgfkeys{
  /school/exam/.is family, /school/exam,
  title/.store in=\examTitle,
  subtitle/.store in=\examSubtitle,
  class/.store in=\examClass,
  date/.store in=\examDate,
  duration/.store in=\examDuration,
  aids/.store in=\examAids,
  totalpoints/.store in=\examTotalPoints,
  teacher/.store in=\examTeacher,
  subject/.store in=\school@subject,
  grade/.store in=\school@grade,
  number/.store in=\school@number
}
\newcommand{\examsetup}[1]{\pgfkeys{/school/exam,#1}}

\newcommand{\examFullTitle}{%
  \examTitle\ifx\school@number\empty\else~\school@number\fi
}

\newcommand{\examCoverInfoLine}[3]{%
  \noindent\hspace*{7mm}\begin{tabularx}{\dimexpr\linewidth-7mm\relax}{@{}>{\color{schoolPrimaryDark}}m{8mm}@{\hspace{2mm}}>{\color{schoolInk}}m{33mm}X@{}}
    #1 & \small #2 & {\small\bfseries #3}
  \end{tabularx}\par\vspace{4mm}%
}

\newcommand{\examcoverpage}{%
  \thispagestyle{empty}%
  \noindent{\color{schoolPrimary}\rule{.94\linewidth}{11.2mm}}\par
  \vspace{17mm}%
  \noindent
  \begin{tabularx}{\linewidth}{@{}p{25mm}@{\hspace{7mm}}X@{}}
    \vspace{0pt}\begingroup\setlength\schoolIconSize{24mm}\schoolSubjectIcon\endgroup &
    \vspace{0pt}\begin{minipage}[t][24mm][t]{\linewidth}
      \vspace{2.5mm}{\fontsize{30}{32}\selectfont\bfseries\color{schoolInk}\MakeUppercase{\school@subject}}\par
      \vfill
      {\fontsize{17}{20}\selectfont\bfseries\color{schoolPrimary}\examFullTitle}\par\vspace{3.5mm}
    \end{minipage}\par\vspace{2mm}
    {\Large\color{schoolInk}\examClass}
  \end{tabularx}
  \vspace{20mm}

  \examCoverInfoLine{\faCalendar*[regular]}{Datum:}{\rule{34mm}{0.35pt}}
  \examCoverInfoLine{\faClock[regular]}{Bearbeitungszeit:}{\examDuration}
  \examCoverInfoLine{\faPen}{Hilfsmittel:}{\examAids}
  \examCoverInfoLine{\faStar[regular]}{Gesamtpunktzahl:}{\examTotalPoints}

  \vspace{8mm}
  \begin{schoolSoftBox}[colback=schoolSoft,colframe=schoolSoft,arc=2.5mm,left=7mm,right=7mm,top=6mm,bottom=6mm]{}
    \begin{tabularx}{\linewidth}{@{}>{\color{schoolPrimaryDark}}m{8mm}@{\hspace{2mm}}>{\color{schoolInk}}m{25mm}X@{}}
      \faUser[regular] & Name: & \rule{\linewidth}{0.35pt}\\[5mm]
      \faUsers & Klasse: & \rule{\linewidth}{0.35pt}\\[5mm]
      \faChalkboardTeacher & Lehrkraft: & \rule{\linewidth}{0.35pt}\\[5mm]
      \faFileSignature & Unterschrift: & \rule{\linewidth}{0.35pt}
    \end{tabularx}
  \end{schoolSoftBox}

  \vfill
  \noindent
  \begin{minipage}[c]{10mm}
    \tikz[baseline=(s.base)]\node[circle, minimum size=9mm, inner sep=0pt, shade,
      left color=schoolPrimaryDark, right color=schoolAccent, text=white,
      font=\bfseries] (s) {\faStar};
  \end{minipage}\hspace{3mm}%
  \begin{minipage}[c]{65mm}
    {\bfseries\color{schoolPrimary}Viel Erfolg!}\par
    {\small Zeige, was du kannst.}
  \end{minipage}\hfill
  \begin{tikzpicture}[baseline=-2mm]
    \foreach \x in {0,...,5}{\foreach \y in {0,...,3}{\fill[schoolPrimary] (\x*2.4mm,\y*2.4mm) circle (.45mm);}}
  \end{tikzpicture}
  \clearpage
  \setcounter{page}{1}%
}

\newif\ifexam@firsttaskonpage

\newcommand{\examcontentheader}{%
  \exam@firsttaskonpagetrue
  \noindent
  \begin{tabularx}{\linewidth}{@{}p{13mm}@{\hspace{3mm}}X>{\raggedleft\arraybackslash}p{58mm}@{}}
    \begingroup\setlength\schoolIconSize{11mm}\schoolSubjectIcon\endgroup &
    \vspace{0pt}{\fontsize{20}{22}\selectfont\bfseries\color{schoolInk}\MakeUppercase{\school@subject}}\par
    {\fontsize{10}{12}\selectfont\bfseries\color{schoolPrimary}\examFullTitle}
    &
    \vspace{0pt}\scriptsize
    \begin{tabular}{@{}>{\color{schoolInk}}l@{\hspace{2mm}}l@{}}
      Name: & \rule{32mm}{0.35pt}\\[2.2mm]
      Klasse: & \rule{32mm}{0.35pt}
    \end{tabular}
  \end{tabularx}
  \par\vspace{4mm}\noindent{\color{schoolPrimary}\rule{\linewidth}{1pt}}\par\vspace{1mm}
  \noindent
  \begin{tabularx}{\linewidth}{@{}>{\bfseries\scriptsize\color{schoolInk}}X>{\centering\arraybackslash\bfseries\scriptsize\color{schoolInk}}p{\exampointscolwidth}@{}}
    Aufgabe & Punkte
  \end{tabularx}
  \par\vspace{1mm}\noindent{\color{schoolLine}\rule{\linewidth}{0.5pt}}\par\vspace{3mm}
}

\newcommand{\examnewpage}{%
  \clearpage
  \examcontentheader
}

\newcounter{examtask}
\newcounter{examsubtask}[examtask]
\newcommand\examtasktitle{}
\newcommand\examtaskpoints{}
\newcommand\examsubtaskpoints{}
\newcommand{\exampointsfield}[1]{%
  \ifx#1\empty\else\strut\rule{10mm}{0.35pt}\,/\,#1P\fi
}
\newcommand{\examtaskpointsfield}{%
  \exampointsfield{\examtaskpoints}%
}

\pgfkeys{
  /school/examtask/.is family, /school/examtask,
  title/.store in=\examtasktitle,
  points/.store in=\examtaskpoints,
  title=,
  points=
}

\NewDocumentCommand{\examsubtask}{O{} +m}{%
  \refstepcounter{examsubtask}%
  \def\examsubtaskpoints{#1}%
  \setlength{\examsubtaskleftwidth}{\linewidth}%
  \setlength{\examsubtaskrowwidth}{\dimexpr\linewidth+\exampointscolwidth+\exampointsgap\relax}%
  \par\medskip\noindent
  \makebox[0pt][l]{%
    \begin{minipage}[t]{\examsubtaskrowwidth}
      \begin{minipage}[t]{\examsubtaskleftwidth}
        \vspace{0pt}%
        \textbf{\alph{examsubtask})}\quad #2%
      \end{minipage}\hfill
      \begin{minipage}[t]{\exampointscolwidth}
        \vspace{0pt}\centering\scriptsize\bfseries\color{schoolInk}\exampointsfield{\examsubtaskpoints}%
      \end{minipage}%
    \end{minipage}%
  }%
  \par\smallskip
}

\newcommand{\examtaskseparator}{%
  \noindent
  \begin{tikzpicture}
    \draw[schoolPrimary, dotted, line width=.45pt] (0,0) -- ({\linewidth-1pt},0);
  \end{tikzpicture}\par\vspace{3mm}%
}

\NewDocumentEnvironment{examtask}{O{}}{%
  \refstepcounter{examtask}%
  \pgfkeys{/school/examtask,title=,points=,#1}%
  \Needspace{4cm}%
  \ifexam@firsttaskonpage
    \exam@firsttaskonpagefalse
  \else
    \par\vspace{2mm}\examtaskseparator
  \fi
  \setlength{\examcontentcolwidth}{\dimexpr\linewidth-\exampointscolwidth-\exampointsgap\relax}%
  \noindent\begin{minipage}[t]{\examcontentcolwidth}
    \vspace{0pt}%
    \schoolNumberBadge{\arabic{examtask}}\hspace{2mm}%
    {\bfseries\color{schoolInk}\examtasktitle}\par\vspace{1.5mm}%
}{%
  \end{minipage}\hfill
  \begin{minipage}[t]{\exampointscolwidth}
    \vspace{0pt}\centering\small\bfseries\color{schoolInk}\examtaskpointsfield\par\vspace{1.5mm}%
  \end{minipage}\par\vspace{2mm}%
}

\AtBeginDocument{%
  \ifschool@cover\examcoverpage\fi
  \exam@contentpagestrue
  \examcontentheader
}

\endinput
