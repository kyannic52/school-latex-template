% schoolmental.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{schoolmental}[2026/09/08 Compact mental maths worksheets]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{schoolworksheet}}
\ProcessOptions\relax
\LoadClass{schoolworksheet}
\RequirePackage{graphicx}
\geometry{a4paper,left=15mm,right=15mm,top=12mm,bottom=12mm}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\pagestyle{empty}
\renewcommand\worksheetTitle{Kopfübungen}

% Keep the worksheet setup API, but use a compact header and no sidebar.
\renewcommand{\worksheetheader}{%
  \thispagestyle{empty}%
  {\Large\bfseries\color{schoolPrimaryDark}\worksheetTitle}\hfill
  {\small\school@subject\ifx\school@number\empty\else\enspace Nr.\,\school@number\fi}\par
  \ifx\worksheetSubtitle\empty\else
    \vspace{1mm}{\small\worksheetSubtitle}\par
  \fi
  \vspace{3mm}{\small Name: \rule{64mm}{.35pt}\hfill
    Klasse: \ifx\worksheetClass\empty\rule{17mm}{.35pt}\else\worksheetClass\fi
    \hfill Datum: \rule{26mm}{.35pt}}\par
  \vspace{3mm}{\footnotesize Löse die Aufgaben auf diesem Blatt. Kreuze bei der Korrektur rechts an.}\par
  \vspace{2mm}%
  \noindent\begin{tikzpicture}
    \fill[schoolSoft] (0,0) rectangle (\linewidth,6mm);
    \node[anchor=west,font=\footnotesize\bfseries,text=schoolInk] at (2mm,3mm) {Aufgabe und Bearbeitung};
    \node[font=\scriptsize,text=schoolInk] at (\dimexpr\linewidth-21mm\relax,3mm) {richtig};
    \node[font=\scriptsize,text=schoolInk] at (\dimexpr\linewidth-7mm\relax,3mm) {falsch};
  \end{tikzpicture}\par\nointerlineskip
}
\renewenvironment{worksheetbody}{\worksheetheader}{}

\newcounter{mental task}
\newsavebox{\mental@content}
\newlength{\mental@width}
\newlength{\mental@rowheight}
\pgfkeys{
  /school/mental/.is family, /school/mental,
  height/.store in=\mental@height,
  workheight/.store in=\mental@workheight,
  field/.is choice,
  field/blank/.code={\def\mental@field{0}},
  field/grid/.code={\def\mental@field{1}},
  field/coordinates/.code={\def\mental@field{2}},
  field/none/.code={\def\mental@field{3}}
}

% Four quadrants, with the same scale on both axes; optional TikZ additions.
\NewDocumentCommand{\mentalcoordinates}{O{} +m}{%
  \begin{tikzpicture}[x=4mm,y=4mm,baseline,#1]
    \draw[step=1,schoolLine,very thin] (-4,-2) grid (4,2);
    \draw[->,schoolInk] (-4,0) -- (4.5,0) node[right,font=\scriptsize] {$x$};
    \draw[->,schoolInk] (0,-2) -- (0,2.5) node[above,font=\scriptsize] {$y$};
    \foreach \x in {-4,-3,-2,-1,1,2,3,4}
      \draw[schoolInk] (\x,.08) -- (\x,-.08) node[below,font=\tiny,inner sep=1pt] {\x};
    \foreach \y in {-2,-1,1,2}
      \draw[schoolInk] (.08,\y) -- (-.08,\y) node[left,font=\tiny,inner sep=1pt] {\y};
    \node[below left,font=\tiny,inner sep=1pt] at (0,0) {0};
    #2
  \end{tikzpicture}%
}

% Heights are minima: long prompts grow instead of overlapping the next row.
\NewDocumentCommand{\quicktask}{O{} +m}{%
  \begingroup
  \pgfkeys{/school/mental,height=18mm,workheight=9mm,field=blank,#1}%
  \refstepcounter{mental task}%
  \setlength{\mental@width}{\dimexpr\linewidth-42mm\relax}%
  \sbox{\mental@content}{%
    \begin{minipage}{\mental@width}
      \small\raggedright #2\par
      \ifnum\mental@field<2
        \vspace{1mm}
        \begin{tikzpicture}
          \ifnum\mental@field=1
            \draw[step=4mm,schoolLine,very thin] (0,0) grid (\mental@width,\mental@workheight);
          \fi
          \draw[schoolLine,thin] (0,0) rectangle (\mental@width,\mental@workheight);
        \end{tikzpicture}\par
      \else\ifnum\mental@field=2
        \vspace{1mm}\mentalcoordinates{}\par
      \fi\fi
    \end{minipage}%
  }%
  \setlength{\mental@rowheight}{\dimexpr\ht\mental@content+\dp\mental@content+4mm\relax}%
  \ifdim\mental@rowheight<\mental@height\setlength{\mental@rowheight}{\mental@height}\fi
  \noindent\begin{tikzpicture}[baseline=(current bounding box.south)]
    \path[use as bounding box] (0,0) rectangle (\linewidth,-\mental@rowheight);
    \draw[schoolLine,thin] (0,-\mental@rowheight) -- (\linewidth,-\mental@rowheight);
    \draw[schoolLine,thin] (\dimexpr\linewidth-28mm\relax,0) -- (\dimexpr\linewidth-28mm\relax,-\mental@rowheight);
    \node[anchor=north west,inner sep=0pt,font=\small\bfseries,text=schoolPrimaryDark] at (2mm,-2mm) {\arabic{mental task}.};
    \node[anchor=north west,inner sep=0pt] at (10mm,-2mm) {\usebox{\mental@content}};
    \foreach \offset in {21,7}{
      \draw[schoolInk,thin] (\dimexpr\linewidth-\offset mm-2mm\relax,-\mental@rowheight/2-2mm)
        rectangle ++(4mm,4mm);
    }
  \end{tikzpicture}\par\nointerlineskip
  \endgroup
}
\AtEndDocument{%
  \ifnum\value{mental task}>12
    \ClassWarningNoLine{schoolmental}{Mehr als 12 Aufgaben: Seitenumfang pruefen}%
  \fi
}
\endinput
