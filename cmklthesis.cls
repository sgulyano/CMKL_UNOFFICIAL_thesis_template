\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cmklthesis}[2025/12/29 CMKL/CMU Thesis Class]

% Load base class
\LoadClass[12pt]{report}

% Required packages
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{tocloft}
\RequirePackage{etoolbox}
\RequirePackage{mathptmx} % Times New Roman font
\RequirePackage{graphicx}


% Page Layout
% Standard 1 inch margins usually.
\geometry{
    top=1in,
    bottom=1in,
    left=1in,
    right=1in,
    footskip=0.25in, % Page numbers at least 0.75" from edge (1in - 0.25in)
    letterpaper
}

% Double spacing for body text
\doublespacing

% Variables for Title Page
\def\@degree{Doctor of Philosophy}
\newcommand{\degree}[1]{\def\@degree{#1}}

\def\@department{Artificial Intelligence and Computer Engineering}
\newcommand{\department}[1]{\def\@department{#1}}

\def\@degreemonth{May}
\def\@degreeyear{2026}
\newcommand{\degreedate}[2]{%
  \def\@degreemonth{#1}%
  \def\@degreeyear{#2}%
}
\def\@degreedate{\@degreemonth\ \@degreeyear}

\def\@previousdegrees{}
\newcommand{\previousdegrees}[1]{\def\@previousdegrees{#1}}

% Title Page
\renewcommand{\maketitle}{
    \begin{titlepage}
        \thispagestyle{empty}
        \begin{center}
            \vspace*{0.5in}
            {\bfseries \MakeUppercase{\@title} \par}
            \vspace{1em}
            % (single-spaced, bold, capitalize) - handled above
            
            \vspace{1in}
            
            Submitted in partial fulfillment of the requirements for\\
            the degree of\\
            \vspace{1em}
            \@degree\\
            \vspace{1em}
            in\\
            \vspace{1em}
            \@department
            
            \vspace{1.5in}
            
            \@author
            
            \vspace{1em}
            \begin{singlespace}
            \@previousdegrees
            \end{singlespace}
            
            \vfill
            
            CMKL University\\
            Bangkok, Thailand\\
            \vspace{1em}
            \@degreedate
        \end{center}
    \end{titlepage}
    \setcounter{page}{2} % Title page is page i, but unnumbered. Next is ii.
}

% Copyright Page
\newcommand{\makecopyright}{
    \clearpage
    \thispagestyle{empty}
    \vspace*{\fill}
    \begin{center}
        \begin{singlespace}
        \copyright\ \@author, \@degreeyear\\
        All Rights Reserved
        \end{singlespace}
        \vspace{1.5in}
    \end{center}
    \clearpage
}

% Dedication
\newenvironment{dedication}{
    \clearpage
    \vspace*{\fill}
    \begin{center}
    \doublespacing
}{
    \end{center}
    \vspace*{\fill}
    \clearpage
}

% Acknowledgments
\newenvironment{acknowledgments}{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{\normalfont ACKNOWLEDGEMENTS}
    \chapter*{Acknowledgements}
    \doublespacing
}{
    \clearpage
}

% Abstract
\renewenvironment{abstract}{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{\normalfont ABSTRACT}
    \chapter*{Abstract}
    \doublespacing
}{
    \clearpage
}

% List of Abbreviations
\newenvironment{abbreviations}{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{\normalfont LIST OF ABBREVIATIONS}
    \chapter*{List of Abbreviations}
}{
    \clearpage
}

% Table of Contents Formatting
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}} % Dots for chapters
\renewcommand{\cftfigleader}{\cftdotfill{\cftdotsep}} % Dots for figures
\renewcommand{\cfttableader}{\cftdotfill{\cftdotsep}} % Dots for tables
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\listfigurename}{List of Figures}
\renewcommand{\listtablename}{List of Tables}

% Center TOC/LOT/LOF headings
\renewcommand{\cfttoctitlefont}{\hfil\bfseries\large\MakeUppercase}
\renewcommand{\cftaftertoctitle}{\hfil}
\renewcommand{\cftlottitlefont}{\hfill\bfseries\MakeUppercase}
\renewcommand{\cftafterlottitle}{\hfill}
\renewcommand{\cftloftitlefont}{\hfill\bfseries\MakeUppercase}
\renewcommand{\cftafterloftitle}{\hfill}

% Add "Figure" and "Table" prefixes with enumeration
\newcounter{lofcount}
\newcounter{lotcount}
\renewcommand{\cftfigpresnum}{\stepcounter{lofcount}\thelofcount.~Figure }
\renewcommand{\cfttabpresnum}{\stepcounter{lotcount}\thelotcount.~Table }
\setlength{\cftfignumwidth}{6.5em}
\setlength{\cfttabnumwidth}{6.5em}

% Spacing between items in LOF and LOT
\setlength{\cftbeforefigskip}{10pt}
\setlength{\cftbeforetabskip}{10pt}

% Add LOT and LOF to TOC
% Add LOT and LOF to TOC (Redefine to ensure they appear)
% We use AtBeginDocument to ensure we wrap the version defined by tocloft
\AtBeginDocument{
    \let\oldtableofcontents\tableofcontents
    \renewcommand{\tableofcontents}{%
        \clearpage
        \begin{singlespace}
        \oldtableofcontents
        \end{singlespace}
    }

    \let\oldlistoftables\listoftables
    \renewcommand{\listoftables}{%
      \setcounter{lotcount}{0}%
      \clearpage
      \phantomsection
      \addcontentsline{toc}{chapter}{\normalfont\MakeUppercase\listtablename}%
      \begin{singlespace}
      \oldlistoftables
      \end{singlespace}
    }

    \let\oldlistoffigures\listoffigures
    \renewcommand{\listoffigures}{%
      \setcounter{lofcount}{0}%
      \clearpage
      \phantomsection
      \addcontentsline{toc}{chapter}{\normalfont\MakeUppercase\listfigurename}%
      \begin{singlespace}
      \oldlistoffigures
      \end{singlespace}
    }
    
    % Rename Bibliography to References
    \renewcommand{\bibname}{References}

    % Add spacing between bibliography items
    \AtBeginEnvironment{thebibliography}{\setlength{\itemsep}{10pt}}

    % Single space references
    \let\oldbibliography\bibliography
    \renewcommand{\bibliography}[1]{%
        \clearpage
        \phantomsection
        \addcontentsline{toc}{chapter}{\bibname}
        \begin{singlespace}
        \oldbibliography{#1}
        \end{singlespace}
    }
}


% Section Headings
\titleformat{\chapter}[block]
    {\large\bfseries\centering}
    {\thechapter.}
    {1em}
    {\MakeUppercase}
\titlespacing*{\chapter}{0pt}{50pt}{20pt}

\titleformat{\section}
    {\normalfont\bfseries}
    {\thesection}
    {1em}
    {}
    [\global\@afterindenttrue]
\titlespacing*{\section}{0pt}{12pt}{6pt}

\titleformat{\subsection}
    {\normalfont\bfseries}
    {\thesubsection}
    {1em}
    {}
    [\global\@afterindenttrue]
\titlespacing*{\subsection}{0pt}{12pt}{6pt}

% Footnotes
% "placed at the bottom of the page below a 1.5-inch underscore"
\renewcommand{\footnoterule}{%
  \kern -3pt
  \hrule width 1.5in height 0.4pt
  \kern 2.6pt
}

% "The first line of each footnote should be indented 0.5 inches"
% "Footnotes should be numbered consecutively throughout each chapter"
\usepackage{footmisc}
\renewcommand{\@makefntext}[1]{%
  \parindent 0.5in%
  \noindent
  \hb@xt@0.5in{\hss\@makefnmark}#1}

% Reset footnote counter per chapter
\makeatletter
\@addtoreset{footnote}{chapter}
\makeatother

% Pagination
\pagenumbering{roman} % Start with roman

% Helper to switch to arabic
\newcommand{\startmainbody}{
    \clearpage
    \pagenumbering{arabic}
}

\endinput
