\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{henrison}[2016/05/24 Henrison Hsieh's Personal Template Class]

%%%%%%%%%%%%%%%
%%% OPTIONS %%%
%%%%%%%%%%%%%%%
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}

\newif\if@pdfa \@pdfafalse
\DeclareOption{pdfa}{\@pdfatrue}

% Line Spacing Options
\DeclareOption{single}{
  \PassOptionsToPackage{singlespacing}{setspace}
  \PassOptionsToPackage{\CurrentOption}{syn-gloss}
}
\DeclareOption{double}{
  \PassOptionsToPackage{doublespacing}{setspace}
  \PassOptionsToPackage{\CurrentOption}{syn-gloss}
}

% Page Style Options
\newif\if@fancy \@fancyfalse
\DeclareOption{fancy}{
  \PassOptionsToPackage{bottom=1.25in}{geometry}
  \@fancytrue
}
\DeclareOption{plain}{\@fancyfalse}

\newif\if@abstract \@abstractfalse
\DeclareOption{abstract}{
  \@fancyfalse
  \@abstracttrue
}

\newif\if@twocol \@twocolfalse
\DeclareOption{twocol}{
  \@twocoltrue
  \PassOptionsToPackage{twocolumn,landscape}{geometry}
}

\newif\if@nobib \@nobibfalse
\DeclareOption{nobib}{
  \@nobibtrue
}

\DeclareOption{draft}{
  \PassOptionsToPackage{showframe}{geometry}
}

\newif\if@bookclass \@bookclassfalse
\DeclareOption{book}{
  \@bookclasstrue
}
\DeclareOption{openany}{\PassOptionsToClass{openany}{book}}

% Font Option
\newif\if@regfont \@regfontfalse
\DeclareOption{regfont}{\@regfonttrue}
\newif\if@times \@timesfalse
\DeclareOption{times}{\@timestrue}

\DeclareOption*{\ClassWarning{henrison}{Unknown option `\CurrentOption'. Use the geometry command to change paper size.}}

\ExecuteOptions{single,fancy}
\ProcessOptions\relax
\if@bookclass
  \LoadClass{book}
  \setcounter{secnumdepth}{3}
\else
  \LoadClass{article}
\fi

%%%%%%%%%%%%%%%
%% PACKAGES %%%
%%%%%%%%%%%%%%%
% PAGE LAYOUT
\if@pdfa
  \RequirePackage[a-1b]{pdfx}
\fi

\RequirePackage[margin=1in,letterpaper]{geometry}
\RequirePackage{fancyhdr}

\if@fancy
  %\setlength{\headheight}{0.5in}
  \geometry{top=1.25in,bottom=1in,headheight=0.5in}
  \if@twocol
    \geometry{margin=0.5in,top=0.85in,bottom=0.85in,headheight=0.35in,columnsep=0.3in}
  \fi
  \pagestyle{fancy}
\fi

% TYPOGRAPHY and PARAGRAPH FORMATTING
\if@times
  \RequirePackage{mathptmx}
\else
  \if@regfont
    \RequirePackage{mathpazo}
  \else
    \RequirePackage[sc,osf]{mathpazo}
  \fi
\fi
\RequirePackage[T1]{fontenc}
\RequirePackage{setspace}

\newlength{\myparskip}
\if@abstract
  \setlength{\parindent}{15pt}
  \setlength{\myparskip}{0pt}
\else
  \setlength{\parindent}{30pt}
  \setlength{\myparskip}{5pt}
\fi
\setlength{\parskip}{\myparskip}

% MISCELLANEOUS THINGS
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage[table]{xcolor}
\RequirePackage[normalem]{ulem}
\RequirePackage{fancybox}
\RequirePackage{hyperref}

% booktabs toprule spacing (for captions)
\setlength{\abovetopsep}{5pt}
\pdfstringdefDisableCommands{% Not the best fix for getting rid of the annoying warnings...
  \def\citealt{}%
  \def\citealp{}%
  \def\citep{}%
  \def\citet{}%
  \def\citeauthor{}%
  \def\citeyear{}%
}

% BIBLIOGRAPHY
\if@nobib
\else
  \RequirePackage[authoryear]{natbib}
  \setcitestyle{aysep={}}   % Bibliography citation formatting
  \bibliographystyle{linquiry2}
\fi

%%%%%%%%%%%%%%%%
%%% COMMANDS %%%
%%%%%%%%%%%%%%%%
\newcommand{\citeposs}[1]{\citeauthor{#1}'s (\citeyear{#1})}
\newcommand{\todo}[2][red]{\textcolor{#1}{#2}}
\newcommand{\quickfig}[2][0.85]{%
  \begin{figure}[ht]
    \centering
    \includegraphics[width=#1\textwidth]{#2}
  \end{figure}%
}
\newenvironment{standout}{
  \begin{Sbox}\begin{minipage}
}{
  \end{minipage}\end{Sbox}\begin{center}\Ovalbox{\TheSbox}\end{center}
}
\newenvironment{miniblock}[1][\textwidth]%
  {\noindent\begin{minipage}{#1}\setlength{\parskip}{\myparskip}}%
  {\end{minipage}}
% Non-breaking multicols environment for side-by-side examples
\newenvironment{multiblock}[1][\textwidth]%
  {\begin{miniblock}[#1]\begin{multicols}}%
  {\end{multicols}\end{miniblock}}

% Custom IPA command for typesetting IPA from unicode
\if@times
  \newcommand{\textipa}[1]{{\fontfamily{qtm}\selectfont#1}}
\else
  \newcommand{\textipa}[1]{{\fontfamily{qpl}\selectfont#1}}
\fi
% \newcommand{\textipa}[1]{{\fontfamily{qzc}\selectfont#1}}

\endinput
