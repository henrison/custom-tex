\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{henrison-abs}[2016/01/19 Henrison Hsieh's Abstract Template Class]

%%%%%%%%%%%%%%%
%%% OPTIONS %%%
%%%%%%%%%%%%%%%
\DeclareOption{10pt}{\PassOptionsToClass{\CurrentOption}{henrison}}
\DeclareOption{11pt}{\PassOptionsToClass{\CurrentOption}{henrison}}
\DeclareOption{12pt}{\PassOptionsToClass{\CurrentOption}{henrison}}

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
% \newcommand{\abssec}[1]{\textbf{\uline{\textsc{#1:}}}}
\newcommand{\abssec}[1]{\paragraph{\textsc{#1}}}
\newcommand{\abstitle}[1]{\paragraph{\large#1}~\vspace{-3ex}}

\newlength{\shrinklength}
\setlength{\shrinklength}{-0.5em}
\newcommand{\shrink}{\vspace{\shrinklength}}

\if@times
  \RequirePackage{mathptmx}
\fi

\setlength{\parindent}{15pt}
\if@squeeze
  \setlength{\parskip}{0pt}
\else
  \setlength{\parskip}{5pt}
\fi

\endinput
