% schoolworksheet.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{schoolworksheet}[2026/06/30 Modern worksheet class]

\LoadClass[11pt,a4paper]{article}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=schoolworksheet,prefix=schoolworksheet@}
\DeclareStringOption[modern]{theme}
\DeclareStringOption[Mathematik]{subject}
\DeclareStringOption[]{grade}
\DeclareStringOption[standard]{layout}
\ProcessKeyvalOptions*

\RequirePackage{schooldesign}
\RequirePackage{schooltasks}

\InputIfFileExists{themes/\schoolworksheet@theme.sty}{}{\ClassWarning{schoolworksheet}{Theme \schoolworksheet@theme.sty nicht gefunden. Nutze Standarddesign.}}

\renewcommand{\schoolSubject}{\schoolworksheet@subject}
\renewcommand{\schoolGrade}{\schoolworksheet@grade}

\AtBeginDocument{\schoolHeader\schoolInfoBar\vspace{2mm}}

% Zweispaltiges Inhaltslayout mit rechter Notiz-/Hinweisspalte.
% Nutzung:
% \begin{worksheetwithnotes}
%   \maincontent{...}
%   \notescontent{...}
% \end{worksheetwithnotes}
\newcommand{\maincontent}[1]{\def\schoolMainContent{#1}}
\newcommand{\notescontent}[1]{\def\schoolNotesContent{#1}}
\newenvironment{worksheetwithnotes}{%
  \def\schoolMainContent{}%
  \def\schoolNotesContent{}%
}{%
  \par\begin{minipage}[t]{0.67\textwidth}\schoolMainContent\end{minipage}\hfill%
  \begin{minipage}[t]{0.28\textwidth}\schoolNotesContent\end{minipage}\par
}

% Einfacher Schnellmodus: Inhalt links, rechts leere Notizbox.
\newenvironment{worksheetnotes}{%
  \par\begin{minipage}[t]{0.67\textwidth}
}{%
  \end{minipage}\hfill\begin{minipage}[t]{0.28\textwidth}
  \begin{notebox}[Notizen]\vspace{.68\textheight}\end{notebox}
  \end{minipage}\par
}
