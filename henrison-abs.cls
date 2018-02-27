\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{henrison-abs}[2016/01/19 Henrison Hsieh's Abstract Template Class]

%%%%%%%%%%%%%%%
%%% OPTIONS %%%
%%%%%%%%%%%%%%%
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{henrison}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{henrison}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{henrison}}

\newif\if@nobib \@nobibfalse
\DeclareOption{nobib}{%
  \PassOptionsToClass{\CurrentOption}{henrison}%
  \@nobibtrue%
}

\newif\if@times \@timesfalse
\DeclareOption{times}{\@timestrue}

\newif\if@squeeze \@squeezefalse
\DeclareOption{squeeze}{\@squeezetrue}

\DeclareOption*{\ClassWarning{henrison}{Unknown option `\CurrentOption'. Use the geometry command to change paper size.}}

\ProcessOptions\relax
\LoadClass[plain]{henrison}

%%%%%%%%%%%%%%%%
%%% COMMANDS %%%
%%%%%%%%%%%%%%%%
\newcommand{\abssec}[1]{\vspace{-3ex}\paragraph{\textsc{#1}}}
\newcommand{\abstitle}[1]{\paragraph{\large#1}~}

\newlength{\shrinklength}
\setlength{\shrinklength}{-0.5em}
\newcommand{\shrink}{\vspace{\shrinklength}}

% Bib formatting
\if@nobib
\else
  \renewcommand{\bibsection}{\abssec{Selected References}~\vspace{-3ex}}
  \renewcommand{\bibfont}{\small}
  \setlength{\bibsep}{0pt}
\fi

\if@times
  \RequirePackage{mathptmx}
\fi

\setlength{\parindent}{15pt}
\if@squeeze
  \setlength{\parskip}{0pt}
  \if@nobib
  \else
    \renewcommand{\bibsection}{\abssec{Selected References}~\vspace{-2ex}}
  \fi
\else
  \setlength{\parskip}{5pt}
\fi

\endinput
