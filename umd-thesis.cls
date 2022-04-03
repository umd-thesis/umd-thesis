% -*- mode: latex; coding: utf-8; fill-column: 72; -*-
% UMD Thesis Class
%
% Copyright 2022 by Adam Liter <io@adamliter.org>
%
% This is a class file for producing dissertations and theses according
% to The University of Maryland Electronic Thesis and Dissertation (ETD)
% Style Guide (2021).
%
% This class may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This package has the LPPL maintenance status `unmaintained'.
%
%
% This package consists of the following source file:
%     - umd-thesis.cls
%
\def\umd@version{0.1}
\def\umd@date{2022/01/15}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{umd-thesis}[\umd@date\space University of Maryland Thesis Class version \umd@version]

\DeclareOption{12pt}{\def\umd@sizeoption{12pt}}
\DeclareOption{11pt}{\def\umd@sizeoption{11pt}}
\DeclareOption{10pt}{\def\umd@sizeoption{10pt}}

\ExecuteOptions{12pt}
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions\relax
\LoadClass[\umd@sizeoption,oneside,letterpaper]{memoir}[2008/05/27]

% One inch margins and ensure titles/chapters start around 2–2.5
% inches down on the page

\settypeblocksize{9in}{6.5in}{*}
\setlrmargins{1in}{*}{*}
\setulmargins{1in}{*}{*}
\setheadfoot{0.5in}{0.5in}
\setlength{\droptitle}{0.75in}

% Names of parts required or allowed by UMD guidelines

\newcommand*{\umd@abstractname}{Abstract}
\newcommand*{\umd@contentsname}{Table of Contents}
\newcommand*{\umd@lotname}{List of Tables}
\newcommand*{\umd@lofname}{List of Figures}
\newcommand*{\umd@prefacename}{Preface}
\newcommand*{\umd@forewordname}{Foreword}
\newcommand*{\umd@dedicationname}{Dedication}
\newcommand*{\umd@acknowledgmentsname}{Acknowledgments}
\newcommand*{\umd@abbreviationsname}{List of Abbreviations}
\newcommand*{\umd@bibliographyname}{Bibliography}

% TOC

\maxtocdepth{subsubsection}
\setsecnumdepth{subsubsection}
\renewcommand*{\printtoctitle}[1]{%
  \vspace*{\droptitle}\centering\large#1}
\renewcommand*{\cftchaptername}{Chapter\space}
\renewcommand*{\cftappendixname}{Appendix\space}
\renewcommand*{\cftchapterdotsep}{\cftdotsep}

% List of tables

\renewcommand*{\printlottitle}[1]{%
  \vspace*{\droptitle}\centering\large\umd@lotname}

% List of figures

\renewcommand*{\printloftitle}[1]{%
  \vspace*{\droptitle}\centering\large\umd@lofname}

% Macros for committee members and chair and co-chair

\RequirePackage{expkv-def}

\ekvdefinekeys{umd-thesis/committee}{%
  long store title = \umd@committee@title,
  long store role  = \umd@committee@role,
  long store name  = \umd@committee@name}
\ekvsetdef\umd@committee@options{umd-thesis/committee}

\ekvdefinekeys{umd-thesis/advisors}{%
  long store department = \umd@committee@department,
  unknown redirect = umd-thesis/committee}
\ekvsetdef\umd@advisors@options{umd-thesis/advisors}

% Initialize macros
\newcommand*\umd@committee{}
\newcommand\committee[1]{\edef\umd@committee{\unexpanded{#1}}}

\newcommand\chair{\umd@advisors@aux{chair}}
\newcommand\cochair{\umd@advisors@aux{cochair}}
\newcommand\umd@advisors@aux[2]{%
  % group to keep the assignments to \umd@committee@role etc. local
  \begingroup
    \umd@advisors@options{#2}%
    % smuggle out the settings inside of \umd@advisors@tmp (with
    % \umd@copyadvisors)
    \def\umd@advisors@tmp{}%
    \ekvcsvloop{\umd@copyadvisors{#1}}{title,role,name,department}%
    % close the group after expanding the temporary macro once
    \expandafter
  \endgroup
  \umd@advisors@tmp}
\newcommand\umd@copyadvisors[2]{%
  \edef\umd@advisors@tmp{%
    \unexpanded\expandafter{\umd@advisors@tmp}% keep old contents
    \def
    \unexpanded\expandafter{\csname umd@advisors@#1@#2\endcsname}{%
      \unexpanded\expandafter\expandafter\expandafter
      {\csname umd@committee@#2\endcsname}}}}

\newcommand*\umd@advisors@chair@name{}
\newcommand*\umd@advisors@cochair@name{}

% Macros for empty value handling
\newcommand\umd@unlessempty[3]{%
  % #1: macro
  % #2: pre
  % #3: post
  \unless\ifx\@empty#1%
    \expandafter\@secondoftwo
  \fi
  \@gobble{#2#1#3}}
\newcommand\umd@unlessempty@advisors[1]
  {\expandafter\umd@unlessempty\csname umd@advisors@#1\endcsname}

% Abstract page(s)

\RequirePackage{array}
\RequirePackage{booktabs}

\renewenvironment{abstract}{%
  \pagestyle{empty}
  \thispagestyle{empty}
  \begin{titlingpage}
    \vspace*{\droptitle}
    \begin{center}
    \large\MakeUppercase{\umd@abstractname}
    \end{center}
    \plainbreak{3}
    \begin{tabular}{p{1.8in}p{4.4in}@{}}
      Title of Dissertation: & \large\MakeUppercase{\thetitle}\\
      ~ & ~\\
      ~ & ~\\
      ~ & \large\theauthor\\
      ~ & \large Doctor of Philosophy, \thedate\\
      ~ & ~\\
      ~ & ~\\
      Directed by: %
        \umd@unlessempty@advisors{chair@name}{%
          & \large\umd@unlessempty@advisors{chair@title}{}{ }}{%
          \\
          \umd@unlessempty@advisors{chair@department}{%
            & \large Department of }{\\}%
          \addlinespace\addlinespace}%
        \umd@unlessempty@advisors{cochair@name}{%
          & \large\umd@unlessempty@advisors{cochair@title}{}{ }}{%
          \\
          \umd@unlessempty@advisors{cochair@department}{& \large Department of }{\\}}%
    \end{tabular}
    \plainbreak{3}\DoubleSpacing%
}{\end{titlingpage}}

% Title page

\newcommand\umd@chair@output{%
  \umd@unlessempty@advisors{chair@name}{%
    \item
    \umd@unlessempty@advisors{chair@title}{}{ }}
    , Chair}
\newcommand\umd@cochair@output{%
  \umd@unlessempty@advisors{cochair@name}{%
    \item
    \umd@unlessempty@advisors{cochair@title}{}{ }}
    , Co-chair}

\RequirePackage{enumitem}

\newcommand*\umd@committeelist[1]{%
  \begin{itemize}[label={}, nosep]
    \umd@chair@output%
    \umd@cochair@output%
    \ekvcsvloop\umd@committee@aux{#1}%
  \end{itemize}}

\newcommand\umd@committee@aux[1]{%
  \item
  \begingroup
    \umd@committee@options{#1}%
    \umd@unlessempty\umd@committee@title{}{ }%
    \umd@committee@name
    \umd@unlessempty\umd@committee@role{, }{}%
  \endgroup}

\newcommand{\maketitlepage}{%
  \pagestyle{empty}
  \thispagestyle{empty}
  \begin{titlingpage}
    \vspace*{\droptitle}
    \begin{center}
      {\large\MakeUppercase{\thetitle}
      \plainbreak{3}
      by
      \plainbreak{2}
      \theauthor
      \plainbreak{4}}
      {\normalsize
       Dissertation submitted to the Faculty of the Graduate School of the\\
       University of Maryland, College Park in partial fulfillment\\
       of the requirements for the degree of\\
       Doctor of Philosophy\\
       \thedate}
    \end{center}
    \plainbreak{6}
    Advisory Committee:
    \expandafter\umd@committeelist\expandafter{\umd@committee}
  \end{titlingpage}}

% Copyright page

\newcommand{\makecopyrightpage}{%
  \pagestyle{empty}
  \thispagestyle{empty}
  \begin{titlingpage}
    \vspace*{\fill}
    \begin{center}
      \large
      \copyright~Copyright by\\
      \theauthor\\
      \thedate
    \end{center}
    \vspace*{\fill}
  \end{titlingpage}
  \addtocounter{page}{1}}

% Preface page(s)

\newcommand{\umd@frontmattername}{\umd@prefacename}

\newenvironment{preface}{%
  \pagestyle{plain}
  \phantomsection % ensure link in toc goes to intended page
  \addcontentsline{toc}{chapter}{\umd@frontmattername}
  \vspace*{\droptitle}
  \begin{center}
  \large\umd@frontmattername
  \end{center}
  \DoubleSpacing%
}{\clearpage}

% Foreword page(s)

\newenvironment{foreword}{%
  \renewcommand{\umd@frontmattername}{\umd@forewordname}
  \preface%
}{\endpreface}

% Dedication page

\newenvironment{dedication}{%
  \renewcommand{\umd@frontmattername}{\umd@dedicationname}
  \preface%
}{\endpreface}

% Acknowledgments page(s)

\newenvironment{acknowledgments}{%
  \renewcommand{\umd@frontmattername}{\umd@acknowledgmentsname}
  \preface%
}{\endpreface}

% List of abbreviations page(s)

\newenvironment{abbreviations}{%
  \renewcommand{\umd@frontmattername}{\umd@abbreviationsname}
  \preface\SingleSpacing%
}{\endpreface}

% Main matter

\renewcommand{\mainmatter}{%
  \DoubleSpacing\pagestyle{plain}\@ifstar{\@smemmain}{\@memmain}}

\chapterstyle{article}
\renewcommand{\printchapternum}{%
  \vspace*{\droptitle}\chapnumfont Chapter \thechapter:\quad}

% Appendices

\newcommand*{\umd@appendixconfig}{%
  \renewcommand{\printchapternum}{%
    \vspace*{\droptitle}\chapnumfont Appendix \thechapter:\quad}}

\AtBeginEnvironment{appendix}{\umd@appendixconfig}
\AtBeginEnvironment{appendices}{\umd@appendixconfig}

% Set up some stuff at document begin

\AtBeginDocument{%
  % Table of contents name
  \@ifpackageloaded{babel}
    {\setlocalecaption{\bbl@loaded}{contents}{\umd@contentsname}}
    {\renewcommand{\contentsname}{\umd@contentsname}}
  % Bibliography configuration
  \@ifpackageloaded{biblatex}
    % biblatex
    {\renewcommand{\bibsetup}{%
      \SingleSpacing\setlength{\bibitemsep}{\baselineskip}}
    \defbibheading{bibliography}[\umd@bibliographyname]{%
      \vspace*{\droptitle}\begin{center}\large#1\end{center}
      \phantomsection % ensure link in toc goes to intended page
      \addcontentsline{toc}{chapter}{\umd@bibliographyname}}}
    {\@ifpackageloaded{natbib}
      % natbib
      {\AtBeginEnvironment{thebibliography}{%
        \SingleSpacing\setlength{\bibsep}{\baselineskip}}
        \renewcommand{\bibsection}{%
          \vspace*{\droptitle}
          \begin{center}\large\umd@bibliographyname\end{center}
        \phantomsection % ensure link in toc goes to intended page
        \addcontentsline{toc}{chapter}{\umd@bibliographyname}}}}
      % any other bib package
      % NOTE: I've only tested with biblatex and natbib
      {\AtBeginEnvironment{thebibliography}{\SingleSpacing}}
  % Ensure margins are set up correctly via memoir
  \checkandfixthelayout
  % hyperref
  \@ifpackageloaded{hyperref}
    {\hypersetup{pdfborder={0 0 0}}}
    {\relax}}

\endinput
