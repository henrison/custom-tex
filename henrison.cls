\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{henrison}[2016/05/24 Henrison Hsieh's Personal Template Class]

%%%%%%%%%%%%%%%
%%% OPTIONS %%%
%%%%%%%%%%%%%%%
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{article}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{article}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}

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

\DeclareOption*{\ClassWarning{henrison}{Unknown option `\CurrentOption'. Use the geometry command to change paper size.}}

\ExecuteOptions{single,fancy}
\ProcessOptions\relax
\if@bookclass
  \LoadClass{book}
\else
  \LoadClass{article}
\fi

%%%%%%%%%%%%%%%
%% PACKAGES %%%
%%%%%%%%%%%%%%%
% PAGE LAYOUT
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
\if@regfont
  \RequirePackage{mathpazo}
\else
  \RequirePackage[sc,osf]{mathpazo}
\fi
\RequirePackage[T1]{fontenc}
\RequirePackage{setspace}

\if@abstract
  \setlength{\parindent}{15pt}
  \setlength{\parskip}{0pt}
\else
  \setlength{\parindent}{30pt}
  \setlength{\parskip}{5pt}
\fi

% MISCELLANEOUS THINGS
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{booktabs}
\RequirePackage{xcolor}
\RequirePackage[normalem]{ulem}
\RequirePackage{fancybox}

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
  \RequirePackage[authoryear,comma]{natbib}
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


\endinput
