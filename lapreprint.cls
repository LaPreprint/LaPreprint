% A template for preprint submissions.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lapreprint}[2022/10/28, v1.0]
% The vast majority of this template comes from the eLife submissions template, created by Overleaf (writeLaTeX). 

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

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ExecuteOptions{}
\ProcessOptions\relax
\LoadClass{extarticle}

\RequirePackage{amsmath}
\RequirePackage{mdframed}
\RequirePackage{lineno}
\if@reqslineno\linenumbers\fi
\if@endfloat\RequirePackage[nolists,nomarkers]{endfloat}\fi

% Note v1.0 of elife.cls used Trueno font; this was 
% changed to use Open Sans in v1.1
\ifxetexorluatex
  \RequirePackage{unicode-math}
  % v1.7: xits-math font name changed to XITSMath in TL2019
  \RequirePackage[default]{opensans}
  \setmonofont[Scale=MatchUppercase]{Latin Modern Mono}
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


\RequirePackage{graphicx}
\RequirePackage[table]{xcolor}

% Colour scheme
\if@red
  \definecolor{darkColour}{HTML}{8F3840}
  \definecolor{lightColour}{HTML}{CC505C}
  \definecolor{eLifeMediumGrey}{HTML}{6D6E70}
  \definecolor{eLifeLightGrey}{HTML}{929497}
\else
  \definecolor{darkColour}{HTML}{0E4B92}
  \definecolor{lightColour}{HTML}{357ABF}
  \definecolor{eLifeMediumGrey}{HTML}{6D6E70}
  \definecolor{eLifeLightGrey}{HTML}{929497}
\fi


\RequirePackage{booktabs}
\RequirePackage{authblk}

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
\RequirePackage[strict]{changepage} %strict for use with sidenotes

\RequirePackage{silence}
\WarningFilter{caption}{The option `hypcap=true' will be ignored}

\RequirePackage[labelfont={bf},%
                labelsep=period,%
                justification=raggedright,%
                singlelinecheck=false,%
                tableposition=top,font=small]
                {caption}

% \captionsetup*[table]{skip=\medskipamount}


\RequirePackage{natbib}
\renewcommand{\bibfont}{\small}
% modifed from https://github.com/gbhutani/vancouver_authoryear_bibstyle/
\IfFileExists{vancouver-elife.bst}
  {\bibliographystyle{vancouver-elife}}
  {\PackageWarning{elife}{vancouver-elife.bst not found; falling back to apalike bibliography style.}\bibliographystyle{apalike}}

  % Make author in citation italic
\renewcommand{\NAT@nmfmt}[1]{{\bfseries\itshape\color{eLifeMediumGrey} #1}}

% ...as well as the year
\xpatchcmd{\NAT@citex}
{\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}\NAT@date}}
{\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}\NAT@nmfmt{\NAT@date}}}
{}{\PackageWarning{eLife}{Failed to patch year format in citation}}

\xpatchcmd{\NAT@citex}
{\else\unskip\NAT@spacechar\NAT@hyper@{\NAT@date}}
{\else\unskip\NAT@spacechar\NAT@hyper@{\NAT@nmfmt{\NAT@date}}}
{}{\PackageWarning{eLife}{Failed to patch year format in citation}}

\xpatchcmd{\NAT@citex}
{\hyper@natlinkbreak{\NAT@aysep\NAT@spacechar}{\@citeb\@extra@b@citeb}\NAT@date}
{\hyper@natlinkbreak{\NAT@nmfmt{\NAT@aysep\NAT@spacechar}}{\@citeb\@extra@b@citeb}\NAT@nmfmt{\NAT@date}}
{}{\PackageWarning{eLife}{Failed to patch year format in citation}}

\xpatchcmd{\NAT@citex}
{\@citea\NAT@hyper@{\NAT@date}}
{\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@date}}}
{}{\PackageWarning{eLife}{Failed to patch year format in citation}}

\xpatchcmd{\NAT@citex}
{{\@citeb\@extra@b@citeb}\NAT@date}
{{\@citeb\@extra@b@citeb}\NAT@nmfmt{\NAT@date}}
{}{\PackageWarning{eLife}{Failed to patch year format in citation}}
%% There, we're finally done with patching the year in citations.


% headers and footers
%
\RequirePackage{fancyhdr}  % custom headers/footers
\RequirePackage{lastpage}  % Number of pages in the document
\pagestyle{fancy}          % Enables the custom headers/footers
\addtolength{\headwidth}{\marginparsep}
\addtolength{\headwidth}{\marginparwidth}
\fancyhf{}
% Removing header in v1.9
% \chead{%
% \setlength{\fboxsep}{3pt}
% \colorbox{eLifeMediumGrey}{\begin{minipage}{\headwidth}\centering\color{white} Manuscript submitted to eLife\end{minipage}}%
% }

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

\lfoot{\ppfooterC}
\rfoot{\ppfooterB}
\preto{\footrule}{\color{eLifeMediumGrey}}

\fancypagestyle{plain}{
\fancyhf{}
\fancyfoot[R]{\ppfooterA}}


%\rfoot{\small\color{eLifeMediumGrey}\thepage\space of\space\pageref{LastPage}}%

\renewcommand{\headrulewidth}{0pt}% % No header rule
\renewcommand{\footrulewidth}{0.4pt}% % No footer rule

%
% section/subsection/paragraph set-up
%
\setcounter{secnumdepth}{0}
\RequirePackage[explicit]{titlesec}
\titleformat{\section}
  {\color{eLifeMediumGrey}\Large\bfseries}
  {\thesection}{}{#1}[]
\titleformat{\subsection}
  {\large\bfseries}
  {\thesubsection}{}{#1}[]
\titleformat{\subsubsection}
  {\large}
  {\thesubsubsection}{}{#1}[]    
\titleformat{\paragraph}
  {\color{eLifeMediumGrey}\large}
  {\theparagraph}{}{#1}[] 
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

\def\@correspondence{}
\def\@contribution{}
\def\@presentaddress{}
\def\@deceased{}
\def\@data{}
\def\@funding{}
\def\@compint{}

\newcommand{\correspondence}[2]{%
  \ifx\empty\@correspondence\else\appto{\@correspondence}{; }{}{}\fi
  \appto{\@correspondence}{%
    \url{#1}%
    \ifx\empty#2\else\space(#2)\fi
  }{}{}%
}

\newcommand{\contribution}[2][]{
  \appto{\@contribution}{%
  \ifx\empty#1\else\textsuperscript{#1}\fi
  #2\\
  }{}{}
}

\newcommand{\presentaddress}[2][]{
  \ifx\empty\@presentaddress\else\appto{\@presentaddress}{; }{}{}\fi
  \appto{\@presentaddress}{%
  \ifx\empty#1\else\textsuperscript{#1}\fi
  #2%
  }{}{}
}

\newcommand{\deceased}[1]{\def\@deceased{\textsuperscript{#1}Deceased}}

\newcommand{\data}[2][]{
  \ifx\empty\@data\else\appto{\@data}{; }{}{}\fi
  \appto{\@data}{%
  \ifx\empty#1\else\textsuperscript{#1}\fi
  #2%
  }{}{}
}

\newcommand{\funding}[2][]{
  \ifx\empty\@funding\else\appto{\@funding}{; }{}{}\fi
  \appto{\@funding}{%
  \ifx\empty#1\else\textsuperscript{#1}\fi
  #2%
  }{}{}
}

\newcommand{\compint}[2][]{
  \ifx\empty\@compint\else\appto{\@compint}{; }{}{}\fi
  \appto{\@compint}{%
  \ifx\empty#1\else\textsuperscript{#1}\fi
  #2%
  }{}{}
}

\reversemarginpar

% custom title page 
%
\renewcommand{\Authfont}{\bfseries\large\raggedright}
\renewcommand{\Affilfont}{\mdseries\large\raggedright}
\renewcommand{\Authands}{, }
\setlength{\affilsep}{16pt}
\renewcommand{\AB@affilsepx}{; \protect\Affilfont}

\newcommand{\themetadata}{%
    \textbf{\Letter \hspace{.5ex} For correspondence:\\}  \@correspondence\par
    \ifx\empty\@contribution\else
    \bigskip\@contribution\par\fi
    \ifx\empty\@presentaddress\else
    \bigskip\textbf{Present address: }\@presentaddress\par\fi
    \ifx\empty\@deceased\else\@deceased\par\fi
    \ifx\empty\@data\else
    \bigskip\textbf{Data availability: }\@data\par\fi
    \ifx\empty\@funding\else
    \bigskip\textbf{Funding: }\@funding\par\fi
    \ifx\empty\@compint\else
    \bigskip\textbf{Competing interests: }\@compint\par\fi
    \bigskip
}

\patchcmd{\@author}{\AB@authlist\\[\affilsep]\AB@affillist}{\AB@authlist\\[\affilsep] 
  \AB@affillist}{}{}

\renewcommand{\maketitle}{%
  \vskip36pt%
  {\color{darkColour}\raggedright\bfseries\fontsize{22}{27}\selectfont \@title\par}%
  \vskip16pt
  {\@author\par}
  \vskip8pt
  \thispagestyle{plain}
}

\renewenvironment{abstract}{%
   \setlength{\parindent}{0pt}\raggedright
   \textcolor{eLifeMediumGrey}{\rule{\textwidth}{2pt}}
   \vskip16pt
   \textcolor{lightColour}{\large\bfseries\abstractname\space}

   % Here we squeeze in the margin metadata
   \marginpar{\raggedright\footnotesize\themetadata\par}
}{%
   \vskip8pt
   \textcolor{eLifeMediumGrey}{\rule{\textwidth}{2pt}}
   \vskip16pt
}

%% Insert a grey line to separate floats from main text
\newcommand{\topfigrule}{\vskip8pt\noindent{\rule{\linewidth}{1pt}}}
\newcommand{\botfigrule}{\noindent{\rule{\linewidth}{1pt}}\vskip8pt}

\RequirePackage{newfloat}
\RequirePackage{wrapfig}
\AtEndEnvironment{wrapfigure}{\vskip8pt\noindent{\rule{\hsize}{1pt}}}
% \RequirePackage[lflt]{floatflt}
% \AtEndEnvironment{floatingfigure}{\vskip8pt\noindent\textcolor{eLifeMediumGrey}{\rule{\hsize}{2pt}}}

\DeclareFloatingEnvironment[placement=btp,name=Box]{featurebox}
\captionsetup[featurebox]{font={Large,bf,color=darkColour}}

\newcounter{featurefigure}
\newcounter{featuretable}
\AtBeginEnvironment{featurebox}{%
  \setcounter{featurefigure}{0}%
  \setcounter{featuretable}{0}%
  \newcommand{\featurefig}[1]{%
    \refstepcounter{featurefigure}%
    \vskip\smallskipamount%
    {\small\textbf{\color{darkColour}Box \arabic{featurebox} Figure \arabic{featurefigure}.}\space #1\par}\medskip}
  \newcommand{\featuretable}[1]{%
    \refstepcounter{featuretable}%
    \vskip\smallskipamount%
    {\small\textbf{\color{darkColour}Box \arabic{featurebox} Table \arabic{featuretable}.}\space #1\par}\medskip}
}
\apptocmd{\featurebox}{%
  \begin{mdframed}[linewidth=0pt,backgroundcolor=lightColour!10,fontcolor=darkColour]
  \if@reqslineno\addtolength{\linenumbersep}{1em}\internallinenumbers\fi%
}{}{}
\pretocmd{\endfeaturebox}{\end{mdframed}}{}{}


\newenvironment{fullwidth}{%
  \begin{adjustwidth}{-4.5cm}{}
}{\end{adjustwidth}}

\appto{\appendix}{%
  \captionsetup*[figure]{name={Appendix \arabic{appendix} Figure },font={color=darkColour,small},skip=\smallskipamount}%
  \captionsetup*[table]{name={Appendix \arabic{appendix} Table },font={color=darkColour,small}}%
}

\newcounter{figsupp}
\setcounter{figsupp}{0}
\newcounter{data}
\setcounter{data}{0}
%% Added videos 2021/03/07
\newcounter{srccode}
\setcounter{srccode}{0}
%% Added videos 2018/06/03
\newcounter{video}
\setcounter{video}{0}
\newcounter{videosupp}
\setcounter{videosupp}{0}
\def\supplist{}

\RequirePackage{newfile}
\newoutputstream{suppinfo}
\openoutputfile{\jobname.suppinfo}{suppinfo}

\newcommand{\video}[1]{%
  \refstepcounter{video}%
  \bigskip%
  \noindent{\small\textbf{Video \arabic{video}.} #1\par}%
  \bigskip
}

\AtBeginEnvironment{figure}{%
  \setcounter{figsupp}{0}
  \setcounter{data}{0}
  \setcounter{videosupp}{0}
  \setcounter{srccode}{0}
  %% Updated 2017/06/30 to allow optional argument
  \newcommand{\figsupp}[3][]{%
    \refstepcounter{figsupp}%
    {%
    \ifstrequal{#1}{none}{}{%
      \small\textbf{Figure~\thefigure--Figure supplement \arabic{figsupp}.} \ifstrempty{#1}{#2}{#1}}}\par
    \addtostream{suppinfo}{%
      \noindent\protect\begin{minipage}{\linewidth}
      \protect #3\noexpand\par
      \textbf{Figure \thefigure--Figure supplement \arabic{figsupp}.} #2\noexpand\par
      \vskip8pt
      \protect\end{minipage}
      \vskip16pt
    }
  }
  \newcommand{\figdata}[1]{%
    \refstepcounter{data}
    {\small\textbf{Figure~\thefigure--source data \arabic{data}.} #1}\par
  }
  %% Added 2021/03/07  
  \newcommand{\figsrccode}[1]{%
    \refstepcounter{srccode}
    {\small\textbf{Figure~\thefigure--source code \arabic{srccode}.} #1}\par
  }
  %% Added 2018/06/03
  \newcommand{\videosupp}[1]{%
    \refstepcounter{videosupp}
    {\small\textbf{Figure~\thefigure--video \arabic{videosupp}.} #1}\par
  }
}

\AtBeginEnvironment{table}{%
  \setcounter{data}{0}
  \setcounter{srccode}{0}
  \setcounter{videosupp}{0}
  \newcommand{\tabledata}[1]{%
    \refstepcounter{data}
    {\small\textbf{Table~\thetable--source data \arabic{data}.} #1}\par
  }
  \newcommand{\tablesrccode}[1]{%
    \refstepcounter{srccode}
    {\small\textbf{Table~\thetable--source code \arabic{srccode}.} #1}\par
  }
}

\AtEndDocument{%
  \closeoutputstream{suppinfo}
%   \pagestyle{empty}
  \renewcommand{\footrule}{}
  \rfoot{}
  \input{\jobname.suppinfo}
}

\newcounter{appendix}
\setcounter{appendix}{0}
\newenvironment{appendixbox}{%
  \setcounter{figure}{0}
  \setcounter{table}{0}
  \refstepcounter{appendix}%
  \clearpage%
  \patchcmd{\ttlf@section}{eLifeMediumGrey}{darkColour}{}{}
  \noindent{\bfseries\Large\color{eLifeMediumGrey}Appendix \arabic{appendix}\par}
  \nolinenumbers%
  \begin{mdframed}[hidealllines=true,backgroundcolor=lightColour!10,leftline=true,linecolor=lightColour,linewidth=1em]
  \if@reqslineno\addtolength{\linenumbersep}{2em}\internallinenumbers\fi
}{%
  \vspace{1em}%
  \end{mdframed}
}

\RequirePackage{hyperref}
\hypersetup{colorlinks=true,allcolors=black,citecolor=eLifeMediumGrey,linkcolor=eLifeMediumGrey,urlcolor=lightColour,hypertexnames=false}
\urlstyle{sf}

% Other desired commands
\renewcommand{\equationautorefname}{Eq.}
%% Added autoref support for \figsupp, \figdata, \video, \videosupp, (2021-03-04) \figsrccode
\newcommand{\figsuppautorefname}{Figure Supplement}
\newcommand{\dataautorefname}{source data}
\newcommand{\videoautorefname}{Video}
\newcommand{\videosuppautorefname}{video}
\newcommand{\srccodeautorefname}{source code}
\newcommand{\FIGSUPP}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{fig:#1}--}\autoref{figsupp:#2}%
}
\newcommand{\FIGDATA}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{fig:#1}--}\autoref{figdata:#2}%
}
\newcommand{\TABLEDATA}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{tab:#1}--}\autoref{tabdata:#2}%
}
\newcommand{\FIGSRCCODE}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{fig:#1}--}\autoref{figsrccode:#2}%
}
\newcommand{\TABLESRCCODE}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{tab:#1}--}\autoref{tabsrccode:#2}%
}
\newcommand{\VIDEOSUPP}[2][]{%
  \ifstrequal{#1}{}{}{\autoref{fig:#1}--}\autoref{videosupp:#2}%
}
\newcommand{\FIG}[1]{\autoref{fig:#1}}
\newcommand{\TABLE}[1]{\autoref{tab:#1}}
\newcommand{\VIDEO}[1]{\autoref{video:#1}}
\newcommand{\EQ}[1]{\autoref{eq:#1}}
\newcommand{\BOX}[1]{\autoref{box:#1}}
\let\oldautoref\autoref
\renewcommand{\autoref}[1]{\emph{\textbf{\oldautoref{#1}}}}

\endinput