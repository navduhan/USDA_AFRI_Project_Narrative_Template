%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                           %
%                   USDA AFRI Project Narrative LaTeX Class                %
%                                                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% AUTHOR:
%   Naveen Duhan and contributors
%
% VERSION:
%   v1.1 (2025/11/01)
%
% DESCRIPTION:
%   This LaTeX document class provides a complete formatting solution for
%   USDA AFRI (Agriculture and Food Research Initiative) project narrative
%   documents. It ensures compliance with USDA formatting requirements
%   including font, margins, spacing, and section numbering.
%
%   USDA AFRI Page Limits:
%   - Standard proposals: 18 pages maximum (narrative only)
%   - Bibliography/Literature Cited: Submitted as SEPARATE PDF (no page limit)
%   - The bibliography does NOT count toward the 18-page narrative limit
%
% KEY FEATURES:
%   - 12pt Times New Roman font throughout (including headings, captions, footnotes)
%   - 1-inch margins on all sides (letter paper)
%   - Single-spaced text (customizable with \onehalfspacing or \doublespacing)
%   - Section numbering with capital letters (A, B, C, ...)
%   - Centered page numbers in footer
%   - No paragraph indentation (block style with spacing between paragraphs)
%   - Compact list spacing for itemize and enumerate
%   - Numeric citations with natbib [1-3] style
%   - Utility commands: \boldline, \boldpara, \ul, \ital, \ui
%
% HOW TO USE:
%   1. Place this file (usda-afri-narrative.cls) in the same directory as
%      your main .tex file, or in your local texmf tree.
%
%   2. In your main .tex file, use:
%        \documentclass{usda-afri-narrative}
%
%   3. Begin your document:
%        \begin{document}
%        \section{Rationale}
%        Your content here...
%        \end{document}
%
% EXAMPLE USAGE:
%   \documentclass{usda-afri-narrative}
%   \begin{document}
%   
%   \section{Project Rationale}
%   This section describes the problem...
%   
%   \subsection{Background}
%   Recent studies have shown...
%   
%   \boldline{Hypothesis 1}
%   We hypothesize that...
%   
%   \section{Objectives}
%   \begin{itemize}
%       \item Objective 1: Develop...
%       \item Objective 2: Evaluate...
%   \end{itemize}
%   
%   \bibliographystyle{plainnat}
%   \bibliography{references}
%   \end{document}
%
% REQUIREMENTS:
%   - LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
%   - For best results: LuaLaTeX (for true Times New Roman font)
%   - Alternative: XeLaTeX or pdfLaTeX (uses newtxtext as fallback)
%   - Required packages: geometry, fontspec/newtxtext, hyphenat, setspace,
%     fancyhdr, titlesec, caption, etoolbox, natbib, hyperref, ulem, enumitem
%
% COMPILATION:
%   Recommended: lualatex ProjectNarrative.tex
%   Alternative: xelatex ProjectNarrative.tex or pdflatex ProjectNarrative.tex
%
% CUSTOMIZATION:
%   - Line spacing: Add \onehalfspacing or \doublespacing after \begin{document}
%   - List spacing: Adjust \USDAlisttopsep and \USDAlistitemsep lengths
%   - Paragraph spacing: Adjust \USDAparskip length
%
% LICENSE:
%   MIT License - Free to use, modify, and distribute.
%   See LICENSE file for full terms.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{usda-afri-narrative}[2025/11/01 v1.1 USDA AFRI Project Narrative class]

% Base class and size
\LoadClass[12pt]{article}

% Page geometry: 1-inch margins on letter paper
\RequirePackage[letterpaper,margin=1in]{geometry}

% Remove paragraph indentation globally
\setlength{\parindent}{0pt}
% Paragraph spacing: small gap between paragraphs
\newlength{\USDAparskip}
\setlength{\USDAparskip}{0.3em}
\setlength{\parskip}{\USDAparskip}
% Helper macro to manually insert a standard paragraph gap
\newcommand{\parspace}{\addvspace{\USDAparskip}}

% Font: Prefer exact Times New Roman with XeLaTeX/LuaLaTeX; fallback to Times-like for pdfLaTeX
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

\ifxetexorluatex
  \RequirePackage{fontspec}
  % Use system Times New Roman
  \setmainfont{Times New Roman}
\else
  % pdfLaTeX fallback (very close to Times New Roman)
  \RequirePackage{newtxtext}
\fi

% Disable automatic hyphenation globally; allow only explicit \- points
\RequirePackage[none]{hyphenat}
% Loosen line-breaking slightly to avoid overfull boxes without hyphenation
\emergencystretch=2em

% Global line spacing = 1.0 (single-spaced)
\RequirePackage{setspace}
\AtBeginDocument{\setstretch{1}}

% (Smart quotes configuration removed per user request)

% Page style: page numbers centered at bottom, no header
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
% Footer page number at 12pt
\fancyfoot[C]{\normalsize\thepage}

% Section numbering and formatting
% Number sections with capital letters A, B, C, ...
\setcounter{secnumdepth}{3}
\renewcommand{\thesection}{\Alph{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}

% Heading style: clear, compact, readable (all 12pt)
\RequirePackage{titlesec}
% Enforce 12pt for section headings
\titleformat{\section}{\normalfont\bfseries\normalsize}{\thesection.}{0.75em}{}
\titlespacing*{\section}{0pt}{0.3em}{0.3em}

\titleformat{\subsection}{\normalfont\bfseries\normalsize}{\thesubsection}{0.75em}{}
\titlespacing*{\subsection}{0pt}{0.3em}{0.3em}

\titleformat{\subsubsection}{\normalfont\itshape\normalsize}{\thesubsubsection}{0.75em}{}
\titlespacing*{\subsubsection}{0pt}{0.3em}{0.3em}

% Ensure paragraphs look standard (no extra spacing unless user changes it)
% Users can add \onehalfspacing or \doublespacing if sponsor requires.

% Ensure captions and footnotes remain 12pt
\RequirePackage{caption}
\captionsetup{font=normalsize}
\makeatletter
\let\footnotesize\normalsize
\makeatother

% Keep bibliography at 12pt even if a package tries to shrink it
\RequirePackage{etoolbox}
\AtBeginEnvironment{thebibliography}{\normalsize}
% Numeric citations in square brackets; sort and compress like [1–3]
\RequirePackage[numbers,square,sort&compress]{natbib}
% Keep bibliography list tight and consistent with 12pt
\setlength{\bibsep}{0pt}

% Clickable citations and links (no visible colors/boxes)
% \RequirePackage[hidelinks]{hyperref}
\RequirePackage[colorlinks=true, linkcolor=black, citecolor=blue, urlcolor=blue]{hyperref}
\urlstyle{same}

% Shortcut formatting commands
% Underline with good line-breaking behavior; keep \emph as italics
\RequirePackage[normalem]{ulem}
\newcommand{\ul}[1]{\uline{#1}}
% Italics shortcut
\newcommand{\ital}[1]{\textit{#1}}
% Underline + italics together (and a short alias)
\newcommand{\ulital}[1]{\uline{\textit{#1}}}
\newcommand{\ui}[1]{\ulital{#1}}

% Compact list spacing for itemize
\RequirePackage{enumitem}
\newlength{\USDAlisttopsep}
\setlength{\USDAlisttopsep}{0.2em}
\newlength{\USDAlistitemsep}
\setlength{\USDAlistitemsep}{0.15em}
\setlist[itemize]{
  leftmargin=*,
  topsep=\USDAlisttopsep,
  partopsep=0em,
  parsep=0em,
  itemsep=\USDAlistitemsep
}

% Apply the same compact spacing to enumerate
\setlist[enumerate]{
  leftmargin=*,
  topsep=\USDAlisttopsep,
  partopsep=0em,
  parsep=0em,
  itemsep=\USDAlistitemsep
}

% Utility: Bold line then unindented paragraph
% Usage 1 (separate paragraph typed after):
%   \boldline{Label}
%   Your paragraph starts here on the next line (no indent).
% Robust: works even if a blank line follows
\makeatletter
\newlength{\USDAafterboldlineskip}
\setlength{\USDAafterboldlineskip}{0.3em}
\newcommand{\boldline}[1]{%
  \par\noindent\textbf{#1}\par\addvspace{\USDAafterboldlineskip}%
  \@afterindentfalse\@afterheading
}

% Usage 2 (inline paragraph provided):
%   \boldpara{Label}{Your paragraph text...}
\newcommand{\boldpara}[2]{%
  \par\noindent\textbf{#1}\par\addvspace{\USDAafterboldlineskip}%
  \@afterindentfalse\@afterheading
  #2\par
}
\makeatother

% End of class
