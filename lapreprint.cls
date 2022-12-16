%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% LaPreprint: A TEMPLATE FOR PREPRINT SUBMISSION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Full disclosure: The vast majority of this template comes from the 
% eLife submissions template, created by Overleaf (writeLaTeX).
% I've tidied it up to make it easier to maintain and added 
% a few things here and there.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lapreprint}[2022/10/28, v1.1]

% List of packages used throughout the document class:
% babel, calc, etoolbox, regexpatch, ifxetex, ifluatex, marginfix,
% amsmath, mdframed, lineno, endfloat
% FONT: unicode-math, opensans
%

\RequirePackage[english]{babel}
\RequirePackage{calc}
\RequirePackage{etoolbox}
\RequirePackage{regexpatch}
\RequirePackage{ifxetex,ifluatex}
\RequirePackage{marginfix}  % Solves the issue of long notes running over the bottom of the page

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DOCUMENT CLASS OPTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Preprint server
\newif\if@biorxiv
\newif\if@medrxiv
\newif\if@arxiv 
\newif\if@chemrxiv
\DeclareOption{biorxiv}{\@biorxivtrue}
\DeclareOption{medrxiv}{\@medrxivtrue}
\DeclareOption{arxiv}{\@arxivtrue}
\DeclareOption{chemrxiv}{\@chemrxivtrue}
\newcommand{\ppserver}{Preprint} % Make command for the preprint logo
\renewcommand{\ppserver}{
  \if@biorxiv
    bio\textcolor{red}{R}$\chi$iv
  \fi
  \if@medrxiv
    med\textcolor{blue}{R}$\chi$iv
  \fi
  \if@arxiv
    ar\textcolor{red}{X}iv
  \fi
  \if@chemrxiv
    \textbf{Chem}\textcolor{lightgray}{Rxiv}
  \fi
}

%% Colour scheme
\newif\if@blue
\newif\if@red
\DeclareOption{blue}\@bluetrue
\DeclareOption{red}\@redtrue

%% Line numbers
\newif\if@reqslineno
\DeclareOption{lineno}{\@reqslinenotrue}

%% Endfloats
\newif\if@endfloat
\DeclareOption{endfloat}{\@endfloattrue}

%% Linespacing
\newif\if@onehalfspacing
\newif\if@doublespacing
\DeclareOption{onehalfspacing}{\@onehalfspacingtrue}
\DeclareOption{doublespacing}{\@doublespacingtrue}

%% Section numbers
\newif\if@secnum
\DeclareOption{secnum}{\@secnumtrue}

%%% Provides extra font sizes (? - look up extsizes, https://www.ctan.org/pkg/extsizes) 
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ExecuteOptions{}
\ProcessOptions\relax
\LoadClass{extarticle}

\RequirePackage{amsmath}
\RequirePackage{mdframed}
\RequirePackage{lineno}
\if@reqslineno\linenumbers\fi
\if@endfloat\RequirePackage[nolists,nomarkers]{endfloat}\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FONT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifxetexorluatex
  \RequirePackage{unicode-math}
  \RequirePackage[default]{opensans}
  % \setmonofont[Scale=MatchUppercase]{Latin Modern Mono}
  % XITSMath is really STIX. Really.
  % https://tex.stackexchange.com/questions/227216/stix-versus-xits
  \setmathfont[Extension = .otf,BoldFont = XITSMath-Bold,]{XITSMath-Regular}
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{stix}
  \RequirePackage[default]{opensans}
  \renewcommand{\ttdefault}{lmtt}
\fi

\RequirePackage{microtype}

% Trueno/Open Sans requires a bigger "single" linespread.
\linespread{1.2}
\if@onehalfspacing\linespread{1.5}\fi
\if@doublespacing\linespread{2.0}\fi
\if@endfloat\AtBeginDelayedFloats{% Also changes for endfloat captions
      \renewcommand{\baselinestretch}{1.2}
      \if@onehalfspacing\renewcommand{\baselinestretch}{1.5}\fi%
      \if@doublespacing\renewcommand{\baselinestretch}{2.0}\fi}\fi

% Colour scheme
\RequirePackage{graphicx}
\RequirePackage[table]{xcolor}
\if@red
  \definecolor{darkColour}{HTML}{8F3840}
  \definecolor{lightColour}{HTML}{CC505C}
  \definecolor{MediumGrey}{HTML}{6D6E70}
  \definecolor{LightGrey}{HTML}{929497}
\else
  \definecolor{darkColour}{HTML}{0E4B92}
  \definecolor{lightColour}{HTML}{357ABF}
  \definecolor{MediumGrey}{HTML}{6D6E70}
  \definecolor{LightGrey}{HTML}{929497}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PAGE LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{authblk} % redefines \author command - needs to go before {silence}
\RequirePackage[left=6cm,%
                marginparwidth=4cm,%
                marginparsep=0.5cm,%
                right=1.3cm,%
                top=2cm,%
                bottom=2.5cm,%
                headheight=21pt,%
                headsep=2\baselineskip,%
                columnsep=2em,%
                letterpaper]{geometry}%
\if@reqslineno\linenumbers\newgeometry{left=6cm,%
                marginparwidth=3.5cm,%
                marginparsep=1cm,%
                right=1.3cm,%
                top=2cm,%
                bottom=2.5cm,%
                headheight=21pt,%
                headsep=2\baselineskip,%
                columnsep=2em}\fi
\RequirePackage[strict]{changepage} % strict for use with sidenotes
\RequirePackage{silence}
\WarningFilter{caption}{The option `hypcap=true' will be ignored}
\RequirePackage[labelfont={bf},%
                labelsep=period,%
                justification=raggedright,%
                singlelinecheck=false,%
                tableposition=top,font=small]
                {caption}

% \captionsetup*[table]{skip=\medskipamount}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% HEADERS AND FOOTERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{fancyhdr}  % custom headers/footers
\RequirePackage{lastpage}  % Number of pages in the document
\pagestyle{fancy}          % Enables the custom headers/footers
\addtolength{\headwidth}{\marginparsep}
\addtolength{\headwidth}{\marginparwidth}
\fancyhf{}

% Footers
% From Henriques' Lab bioRxiv template
\newcommand{\shorttitle}[1]{\def\@shorttitle{#1}}
\newcommand{\leadauthor}[1]{\def\@leadauthor{#1}}
\def\ppfooterA{{\footnotesize
    \@leadauthor\ifnum \value{authors} > 1\hspace{2pt}\textit{et al.}\fi\hspace{7pt}|\hspace{7pt}\ppserver\hspace{7pt}|\hspace{7pt}\today\hspace{7pt}|\hspace{7pt}\thepage\textendash\pageref{LastPage}
  }}
  
\def\ppfooterB{{\footnotesize
    \ppserver\hspace{7pt}|\hspace{7pt}\thepage\space of\space\pageref{LastPage}
  }}
   
\def\ppfooterC{{\footnotesize
    \@leadauthor\ifnum \value{authors} > 1\hspace{2pt}\textit{et al.} \the\year{}\fi\hspace{7pt}|\hspace{7pt}\@shorttitle
  }}

\def\ppfooterSupp{{\footnotesize
  \ppserver\hspace{7pt}
}}

\lfoot{\ppfooterC}
\rfoot{\ppfooterB}
\preto{\footrule}{\color{MediumGrey}}

\fancypagestyle{plain}{
\fancyhf{}
\fancyfoot[R]{\ppfooterA}}

\renewcommand{\headrulewidth}{0pt}% % No header rule
\renewcommand{\footrulewidth}{0.4pt}% % No footer rule

% Format title
\if@secnum\else\setcounter{secnumdepth}{0}\fi
\RequirePackage[explicit]{titlesec}
\titleformat{\section}
  {\color{MediumGrey}\Large\bfseries}
  {\thesection}{10pt}{#1}[]
\titleformat{\subsection}
  {\large\bfseries}
  {\thesubsection}{10pt}{#1}[]
\titleformat{\subsubsection}
  {\large}
  {\thesubsubsection}{10pt}{#1}[]    
\titleformat{\paragraph}
  {\color{MediumGrey}\large}
  {\theparagraph}{10pt}{#1}[]

% Title spacing
\titlespacing*{\section}{0pc}{3ex \@plus4pt \@minus3pt}{2pt}
\titlespacing*{\subsection}{0pc}{2.5ex \@plus3pt \@minus2pt}{1pt}
\titlespacing*{\subsubsection}{0pc}{2ex \@plus2.5pt \@minus1.5pt}{0pt}
\titlespacing*{\paragraph}{0pc}{1.5ex \@plus2pt \@minus1pt}{0pt}
  
\RequirePackage{enumitem}
\setlist{noitemsep}

\RequirePackage{alphalph}
\newalphalph{\fnsymbolmult}[mult]{\@fnsymbol}{5}

\newcounter{authorfn}
\setcounter{authorfn}{1}
\newcommand{\authfn}[1]{%
  \fnsymbolmult{\numexpr\value{authorfn}+#1}%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ADDITIONAL FRONT PAGE META DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@metadata{}

\newcommand{\metadata}[3][]{%
  \ifx\empty\@metadata\else\appto{\@metadata}{}{}{}\fi
  \appto{\@metadata}{%
    \ifx\empty#2\else\textbf{#2: }\fi
    \ifx\empty#1\else\textsuperscript{#1}\fi
    #3%
    \par\bigskip
  }
}

\reversemarginpar


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CREATE TITLE PAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\Authfont}{\bfseries\large\raggedright}
\renewcommand{\Affilfont}{\mdseries\large\raggedright}
\renewcommand{\Authands}{, }
\setlength{\affilsep}{16pt}
\renewcommand{\AB@affilsepx}{; \protect\Affilfont}

\newcommand{\themetadata}{%
    \ifx\empty\@metadata\else
    \@metadata\fi
}

% Insert authors and affiliations
\patchcmd{\@author}{\AB@authlist\\[\affilsep]\AB@affillist}{\AB@authlist\\[\affilsep] 
  \AB@affillist}{}{}

% Insert title
\renewcommand{\maketitle}{%
  \vskip36pt%
  {\color{darkColour}\raggedright\bfseries\fontsize{22}{27}\selectfont \@title\par}%
  \vskip16pt
  {\@author\par}
  \vskip8pt
  \thispagestyle{plain}
}

% Insert abstract
\renewenvironment{abstract}{%
   \setlength{\parindent}{0pt}\raggedright
   \textcolor{MediumGrey}{\rule{\textwidth}{2pt}}
   \vskip16pt
   \textcolor{lightColour}{\large\bfseries\abstractname\space}

   % Here we squeeze in the margin metadata
   \marginpar{\raggedright\footnotesize\themetadata\par}
}{%
   \vskip8pt
   \textcolor{MediumGrey}{\rule{\textwidth}{2pt}}
   \vskip16pt
}

%% Insert a grey line to separate floats from main text
\newcommand{\topfigrule}{\vskip8pt\noindent{\rule{\linewidth}{1pt}}}
\newcommand{\botfigrule}{\noindent{\rule{\linewidth}{1pt}}\vskip8pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FLOATS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{booktabs} % Better tables
\RequirePackage{newfloat}
\RequirePackage{wrapfig}
\AtEndEnvironment{wrapfigure}{\vskip8pt\noindent{\rule{\hsize}{1pt}}}
% \RequirePackage[lflt]{floatflt}
% \AtEndEnvironment{floatingfigure}{\vskip8pt\noindent\textcolor{MediumGrey}{\rule{\hsize}{2pt}}}

\DeclareFloatingEnvironment[placement=btp,name=Box]{featurebox}
\captionsetup[featurebox]{font={Large,bf,color=darkColour}}

% v1.11 2022-06 Updated many caption casing and dashes
\newcounter{featurefigure}
\newcounter{featuretable}
\AtBeginEnvironment{featurebox}{%
  \setcounter{featurefigure}{0}%
  \setcounter{featuretable}{0}%
  \newcommand{\featurefig}[1]{%
    \refstepcounter{featurefigure}%
    \vskip\smallskipamount%
    {\small\textbf{\color{darkColour}Box \arabic{featurebox}---figure \arabic{featurefigure}.}\space #1\par}\medskip}
  \newcommand{\featuretable}[1]{%
    \refstepcounter{featuretable}%
    \vskip\smallskipamount%
    {\small\textbf{\color{darkColour}Box \arabic{featurebox}---table \arabic{featuretable}.}\space #1\par}\medskip}

}
\apptocmd{\featurebox}{%
  \begin{mdframed}[linewidth=0pt,backgroundcolor=lightColour!10,fontcolor=darkColour]
  \if@reqslineno\addtolength{\linenumbersep}{1em}\internallinenumbers\fi%
}{}{}
\pretocmd{\endfeaturebox}{\end{mdframed}}{}{}


\newenvironment{fullwidth}{%
  \begin{adjustwidth}{-4.5cm}{}%
  \hsize=\linewidth%
}{\end{adjustwidth}}

\appto{\appendix}{%
  \captionsetup*[figure]{name={Appendix \arabic{appendix}---figure },font={color=darkColour,small},skip=\smallskipamount}%
  \captionsetup*[table]{name={Appendix \arabic{appendix}---table },font={color=darkColour,small}}%
}

\newcounter{figsupp}
\setcounter{figsupp}{0}
\newcounter{data}
\setcounter{data}{0}
%% Added videos 2021/03/07
\newcounter{srccode}
\setcounter{srccode}{0}
%% Added fig supp data and source code 2022/06
\newcounter{fsdata}
\setcounter{fsdata}{0}
\newcounter{fssrccode}
\setcounter{fssrccode}{0}
%% Added videos 2018/06/03
\newcounter{video}
\setcounter{video}{0}
\newcounter{videosupp}
\setcounter{videosupp}{0}
\def\supplist{}

\RequirePackage{newfile}
\newoutputstream{suppinfo}
\openoutputfile{\jobname.suppinfo}{suppinfo}
\addtostream{suppinfo}{\protect\setcounter{figure}{0}}

% Added video source data and code 2022/06
\DeclareRobustCommand{\video}[1]{%
  \refstepcounter{video}%
  \setcounter{data}{0}%
  \setcounter{srccode}{0}%
  \bigskip%
  \noindent{\small\textbf{Video \arabic{video}.} #1\par}%
  \bigskip
}
\DeclareRobustCommand{\videodata}[1]{%
  \refstepcounter{data}%
  \par\noindent{\small\textbf{Video~\thevideo---source data \arabic{data}.} #1}\par
}
\DeclareRobustCommand{\videosrccode}[1]{%
  \refstepcounter{srccode}%
  \par\noindent{\small\textbf{Video~\thevideo---source code \arabic{srccode}.} #1}\par
}

% Added fig supp source data and code 2022/06
\DeclareRobustCommand{\figsuppsrccode}[1]{%
  \protect\refstepcounter{fssrccode}%
  \par\small\textbf{\figurename~\thefigure---figure supplement \arabic{figsupp}---source code~\arabic{fssrccode}. } #1\par
}
\DeclareRobustCommand{\figsuppdata}[1]{%
  \protect\refstepcounter{fsdata}%
  \par\small\textbf{\figurename~\thefigure---figure supplement \arabic{figsupp}---source data~\arabic{fsdata}. } #1\par
}


\AtBeginEnvironment{figure}{%
  \setcounter{figsupp}{0}
  \setcounter{data}{0}
  \setcounter{videosupp}{0}
  \setcounter{srccode}{0}
  \addtostream{suppinfo}{
    \protect\setcounter{figsupp}{0}
    \protect\refstepcounter{figure}
  }
}

\AtBeginEnvironment{wrapfigure}{%
  \setcounter{figsupp}{0}
  \setcounter{data}{0}
  \setcounter{videosupp}{0}
  \setcounter{srccode}{0}
  \addtostream{suppinfo}{
    \protect\setcounter{figsupp}{0}
    \protect\refstepcounter{figure}
  }
}

%% Updated 2017/06/30 to allow optional argument
\DeclareRobustCommand{\figsupp}[3][]{%
  \refstepcounter{figsupp}%
  \addtostream{suppinfo}{%
  \protect\refstepcounter{figsupp}
  \protect\setcounter{fsdata}{0}
  \protect\setcounter{fssrccode}{0}
  }%
  {%
  \ifstrequal{#1}{none}{}{%
    \small\textbf{\figurename~\thefigure---figure supplement \arabic{figsupp}.} 
    \ifstrempty{#1}{%
      \renewcommand\figsuppdata[1]{}%
      \renewcommand\figsuppsrccode[1]{}%
      #2}{%
      \renewcommand\figsuppdata[1]{}%
      \renewcommand\figsuppsrccode[1]{}%
      #1}}}\raggedright\par
  \addtostream{suppinfo}{%
    \noindent\protect\begin{minipage}{\linewidth}
    \protect #3\noexpand\par
    \textbf{\figurename~\thefigure---figure supplement \arabic{figsupp}.} #2\noexpand\par
    \vskip8pt
    \protect\end{minipage}
    \vskip16pt
  }
}
\DeclareRobustCommand{\figdata}[1]{%
  \refstepcounter{data}
  {\small\textbf{\figurename~\thefigure---source data \arabic{data}.} #1}\par
}
%% Added 2021/03/07  
\DeclareRobustCommand{\figsrccode}[1]{%
  \refstepcounter{srccode}
  {\small\textbf{\figurename~\thefigure---source code \arabic{srccode}.} #1}\par
}
%% Added 2018/06/03
\DeclareRobustCommand{\videosupp}[1]{%
  \refstepcounter{videosupp}
  {\small\textbf{\figurename~\thefigure---video \arabic{videosupp}.} #1}\par
}

% Added table source data and code 2022/06
\AtBeginEnvironment{table}{%
  \setcounter{data}{0}
  \setcounter{srccode}{0}
  \setcounter{videosupp}{0}
}

\AtBeginEnvironment{wraptable}{%
  \setcounter{data}{0}
  \setcounter{srccode}{0}
  \setcounter{videosupp}{0}
}

\DeclareRobustCommand{\tabledata}[1]{%
  \refstepcounter{data}
  {\small\textbf{\tablename~\thetable---source data \arabic{data}.} #1}\par
}
\DeclareRobustCommand{\tablesrccode}[1]{%
  \refstepcounter{srccode}
  {\small\textbf{\tablename~\thetable---source code \arabic{srccode}.} #1}\par
}

\AtEndDocument{%
  \closeoutputstream{suppinfo}
%   \pagestyle{empty}
  \renewcommand{\footrule}{}
  \rfoot{\ppfooterSupp}
  \input{\jobname.suppinfo}
}

\newcounter{appendix}
\setcounter{appendix}{0}
\newenvironment{appendixbox}{%
  \setcounter{figure}{0}
  \setcounter{table}{0}
  \refstepcounter{appendix}%
  \clearpage%
  \patchcmd{\ttlf@section}{MediumGrey}{darkColour}{}{}
  \noindent{\bfseries\Large\color{MediumGrey}Appendix \arabic{appendix}\par}
  \nolinenumbers%
  \begin{mdframed}[hidealllines=true,backgroundcolor=lightColour!10,leftline=true,linecolor=lightColour,linewidth=1em]
  \if@reqslineno\addtolength{\linenumbersep}{2em}\internallinenumbers\fi
}{%
  \vspace{1em}%
  \end{mdframed}
}

% Hyperlinks
\RequirePackage{hyperref}
\hypersetup{%
  colorlinks=true,
  allcolors=black,
  citecolor=MediumGrey,
  linkcolor=MediumGrey,
  urlcolor=lightColour,
  hypertexnames=false}
\urlstyle{sf}

% Other desired commands
\renewcommand{\equationautorefname}{Eq.}
%% Added autoref support for \figsupp, \figdata, \video, \videosupp, (2021-03-04) \figsrccode
% Added support for figsupp, video source data and code 2022/06
\newcommand{\figsuppautorefname}{figure Supplement}
\newcommand{\dataautorefname}{source data}
\newcommand{\videoautorefname}{Video}
\newcommand{\videosuppautorefname}{video}
\newcommand{\srccodeautorefname}{source code}
\newcommand{\FIGSUPP}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{fig:#1}---}\autoref{figsupp:#2}%
}
\newcommand{\FIGDATA}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{fig:#1}---}\autoref{figdata:#2}%
}
\newcommand{\TABLEDATA}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{tab:#1}---}\autoref{tabdata:#2}%
}
\newcommand{\VIDEODATA}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{video:#1}---}\autoref{viddata:#2}%
}

\newcommand{\FIGSRCCODE}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{fig:#1}---}\autoref{figsrccode:#2}%
}
\newcommand{\TABLESRCCODE}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{tab:#1}---}\autoref{tabsrccode:#2}%
}
\newcommand{\VIDEOSRCCODE}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{video:#1}---}\autoref{vidsrccode:#2}%
}

\newcommand{\VIDEOSUPP}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{fig:#1}---}\autoref{videosupp:#2}%
}
\newcommand{\FIG}[1]{\autoref{fig:#1}}
\newcommand{\TABLE}[1]{\autoref{tab:#1}}
\newcommand{\VIDEO}[1]{\autoref{video:#1}}
\newcommand{\EQ}[1]{\autoref{eq:#1}}
\newcommand{\BOX}[1]{\autoref{box:#1}}
\let\oldautoref\autoref
\renewcommand{\autoref}[1]{\emph{\textbf{\oldautoref{#1}}}}

\RequirePackage{lipsum}     % Required to insert dummy text

\endinput