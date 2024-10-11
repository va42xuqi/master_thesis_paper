%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I2 Thesis Class for LaTeX
% 
% There is usually no need to change anything here. Just set the appropriate
% configuration options in your TeX document.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}

%%%%%%%%%% SETUP THE CLASS %%%%%%%%%%

\LoadClass[
	a4paper,
	12pt,
	BCOR=0mm,
	headsepline,
	twoside,
	numbers=noendperiod,
]{scrbook}

\usepackage{pdfpages}
\usepackage{tcolorbox}
\usepackage{adjustbox}
\usepackage{fancyvrb}
\usepackage{caption}
\usepackage[abbreviations,symbols,nogroupskip,nonumberlist,shortcuts=true,style=super,automake, acronym]{glossaries-extra}
\makeglossaries

\captionsetup[algorithm]{name=Algorithm}
\usepackage{tikz}
\usetikzlibrary{shapes.geometric, arrows}

% Define block styles
\tikzstyle{startstop} = [rectangle, rounded corners, minimum width=3cm, minimum height=1cm,text centered, draw=black, fill=red!30]
\tikzstyle{process} = [rectangle, minimum width=3cm, minimum height=1cm, text centered, draw=black, fill=orange!30]
\tikzstyle{arrow} = [thick,->,>=stealth]

% Control whether the thesis will be written in german or english
\newif\ifGerman

\RequirePackage[T1]{fontenc}
\RequirePackage[ngerman,english]{babel}
\RequirePackage{setspace}                % Used to control the line space
\RequirePackage{etoolbox}                % Used for more powerful control macros
\RequirePackage{xinttools} % Used for looping control macros
\RequirePackage[german=quotes,autostyle=true]{csquotes}
\RequirePackage[backend=biber,natbib]{biblatex}


\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}

%%%%%%%%%% COMMON DEFINITIONS %%%%%%%%%%

\newcommand{\SetLangString}[3]{\newcommand{#1}{\ifGerman #2 \else #3 \fi}}

\newcommand{\PSGHead}{Prof. Dr. M. Philippsen}

\SetLangString{\Bachelor}{Bachelorarbeit}{Bachelor's Thesis}
\SetLangString{\Master}{Masterarbeit}{Master's Thesis}
\SetLangString{\FAUIPSG}{Department Informatik \\
	Lehrstuhl f\"{u}r Informatik 2 \\
	Programmiersysteme \\
	Friedrich-Alexander-Universit\"{a}t Erlangen-N\"{u}rnberg \\
	(\PSGHead)}{Computer Science Department \\
	Chair of Computer Science 2 \\
	Programming Systems \\
	Friedrich-Alexander University Erlangen-N\"{u}rnberg \\
	(\PSGHead)}



%%%%%%%%%% BIBLIOGRAPHY %%%%%%%%%%

\DefineBibliographyStrings{ngerman}{%
	andothers = {et al.}, % Use "et al." also in German texts
}

\ExecuteBibliographyOptions{%
	maxbibnames = 9,
	minbibnames = 3,
	maxcitenames = 3,
}



%%%%%%%%%% CONFIGURATION COMMANDS %%%%%%%%%%

\newcommand{\DefineVarSetter}[2]%
	{\newcommand{#1}{}\newcommand{#2}[1]{\renewcommand{#1}{##1}}}

\DefineVarSetter{\thethesis}{\thesistype}
\DefineVarSetter{\theauthorgender}{\authorgender}
\DefineVarSetter{\thebirthdate}{\birthdate}
\DefineVarSetter{\thebirthloc}{\birthloc}
\DefineVarSetter{\thethesisstart}{\thesisstart}
\DefineVarSetter{\thethesisend}{\thesisend}
\DefineVarSetter{\theinstitute}{\institute}
\DefineVarSetter{\theinstituteloc}{\instituteloc}

\newtoks\Supervisors % Used to build supervisor items
\newcommand{\thesissupervisor}[1]{%
\Supervisors=\expandafter{\the\Supervisors {#1}}}


%%%%%%%%%% INTERNAL HELPERS %%%%%%%%%%

%% These two commands are based on https://tex.stackexchange.com/a/150839
%\makeatletter
%\newcommand{\RememberText}[2]{%
%	\immediate\write\@auxout{\unexpanded{\global\long\@namedef{savedtext@#1}{#2}}}%
%	#2}
%\newcommand{\RecallText}[1]{%
%	\ifcsname savedtext@#1\endcsname
%		\@nameuse{savedtext@#1}%
%	\else
%		Undefined
%	\fi}
%\makeatother



%%%%%%%%%% LAYOUT %%%%%%%%%%

\setkomafont{chapter}{\normalfont\huge\bfseries}
\setkomafont{section}{\normalfont\Large\bfseries}
\setkomafont{subsection}{\normalfont\large\bfseries}
\setkomafont{subsubsection}{\normalfont\bfseries}


%%%%%%%%%% DESIGN-RELATED COMMANDS %%%%%%%%%%

%% TITLE PAGE
\newcommand{\MakeTitlePage}{%
	\ifGerman\selectlanguage{ngerman}\else\selectlanguage{english}\fi
	\begin{titlepage}\begin{center}
		\vspace*{1cm}

		\hrulefill

		\vspace*{0.5cm}

		{\fontsize{24pt}{32pt}\selectfont\textbf{
			\@title
		}\par}

		\vspace*{1cm}

		\ifGerman
			\thethesis im Fach Informatik
		\else
			\thethesis in Computer Science
		\fi

		\vfill

		\begin{minipage}{.45\linewidth}
			\begin{flushright}
				\large\ifGerman vorgelegt von \else by \fi
			\end{flushright}
		\end{minipage}\hfill%
		\begin{minipage}{.45\linewidth}
			\textbf{\Large\@author} \\[0.5ex]
			{\large \ifGerman geb. \else born \fi\thebirthdate\ in \thebirthloc}
		\end{minipage}

		\vspace*{0.5cm}

		\hrulefill

		\vfill

		\ifGerman angefertigt am \else prepared at \fi \\[0.75cm]
		\theinstitute

		\vfill

		\ifGerman Betreuung: \else Supervisors: \fi \\
		\xintFor* ##1 in {\the\Supervisors} \do {%
			##1 \\
		}

		\vspace*{1cm}

		\begin{tabular}{ll}
			\ifGerman
				Beginn der Arbeit: & \thethesisstart \\
				Abgabe der Arbeit: & \thethesisend \\
			\else
				Started on:   & \thethesisstart \\
				Submitted on: & \thethesisend \\
			\fi
		\end{tabular}
	\end{center}\end{titlepage}
}


%% PLEDGE PAGE
\newcommand{\MakePledgePage}[1][grant]{%
	\clearpage{\pagestyle{empty}\cleardoublepage}
	\thispagestyle{empty}

	\selectlanguage{ngerman}
	Ich versichere, dass ich die Arbeit ohne fremde Hilfe und ohne Benutzung
	anderer als der angegebenen Quellen angefertigt habe und dass die Arbeit in
	gleicher oder \"{a}hnlicher Form noch keiner anderen Pr\"{u}fungsbeh\"{o}rde
	vorgelegen hat und von dieser als Teil einer Pr\"{u}fungsleistung angenommen
	wurde. Alle Ausf\"{u}hrungen, die w\"{o}rtlich oder sinngem\"{a}\ss{}
	\"{u}bernommen wurden, sind als solche gekennzeichnet.
	
	\ifstrequal{#1}{nogrant}{}{%
		\vspace*{2cm}
		
		Der Universit\"{a}t Erlangen-N\"{u}rnberg, vertreten durch die Informatik 2
		(Programmiersysteme), wird f\"{u}r Zwecke der Forschung und Lehre ein
		einfaches, kostenloses, zeitlich und \"{o}rtlich unbeschr\"{a}nktes
		Nutzungsrecht an den Arbeitsergebnissen der \thethesis\ einschlie\ss{}lich
		etwaiger Schutzrechte und Urheberrechte einger\"{a}umt.
	}
	
	\vspace*{2cm}
	\theinstituteloc, den \thethesisend
	
	\vspace*{2cm}
	\@author
}


%% TASK PAGE
\newsavebox{\TaskPageBackgroundBox} % Save background text
\newenvironment{thesisbackground}{\global\setbox\TaskPageBackgroundBox\hbox\bgroup}{\egroup}

\newsavebox{\TaskPageTaskBox} % Save task text
\newenvironment{thesistask}{\global\setbox\TaskPageTaskBox\hbox\bgroup}{\egroup}
\newtoks\TaskPageMilestones % Used to build milestone items
\newtoggle{TaskPageMilestoneAdded} % Track whether milestone has been added

\newcommand{\thesismilestone}[1]{\toggletrue{TaskPageMilestoneAdded}%
\TaskPageMilestones=\expandafter{\the\TaskPageMilestones {#1}}}

\newtoks\TaskPageLiterature % Used to build literature items
\newtoggle{TaskPageLiteratureAdded} % Track whether literature has been added

\newcommand{\thesisliterature}[1]{\toggletrue{TaskPageLiteratureAdded}%
\TaskPageLiterature=\expandafter{\the\TaskPageLiterature {#1}}}

\newcommand{\MakeTaskPage}{%
	\clearpage{\pagestyle{empty}\cleardoublepage}
	\pagenumbering{roman}
	\pagestyle{empty}

	\begin{center}\textbf{\Huge \thethesis}\end{center}

	\paragraph{\ifGerman Thema: \else Topic:\fi}
	\@title

	\paragraph{\ifGerman Hintergrund: \else Background:\fi}
	\unhbox\TaskPageBackgroundBox

	\paragraph{\ifGerman Aufgabenstellung: \else Task:\fi}
	\unhbox\TaskPageTaskBox

	\iftoggle{TaskPageMilestoneAdded}{%
		\paragraph{\ifGerman Meilensteine: \else Milestones:\fi}
		\begin{itemize}
			\xintFor* ##1 in {\the\TaskPageMilestones} \do {%
				\item ##1
			}
		\end{itemize}
	}{}

	\iftoggle{TaskPageLiteratureAdded}{%
		\paragraph{\ifGerman Literatur: \else Literature:\fi}
		\begin{itemize}
			\xintFor* ##1 in {\the\TaskPageLiterature} \do {%
				\item ##1
			}
		\end{itemize}
	}{}

	\paragraph{\ifGerman Betreuung: \else Supervisors:\fi}
	\newtoggle{FirstSupervisorPrinted}
	\xintFor* ##1 in {\the\Supervisors} \do {%
		\iftoggle{FirstSupervisorPrinted}{, }{\toggletrue{FirstSupervisorPrinted}}##1%
	}

	\paragraph{\ifGerman \ifdefstring{\theauthorgender}{f}{Bearbeiterin:}{Bearbeiter:} \else Author:\fi}
	\@author
}


%% ABSTRACTS

\newenvironment{abstract}[1]{%
	\ifstrequal{#1}{german}{%
		\selectlanguage{ngerman}
		\chapter*{Kurzzusammenfassung}
	}{%
	\ifstrequal{#1}{english}{%
		\selectlanguage{english}
		\chapter*{Abstract}
	}{%
		\ClassError{thesis}%
			{Abstract type "#1" not supported}%
			{Only german or english abstracts are supported}
	}%
	}

}{}

% The conditional code has to be written outside the environment definition.
% Hence we use BeforeBeginEnvironment.
\newtoggle{InFrontMatter}
\BeforeBeginEnvironment{abstract}{%
	\cleardoubleoddpage
	\nottoggle{InFrontMatter}{%
		\pagestyle{headings}
		\pagenumbering{roman}
	}{}
	\toggletrue{InFrontMatter}
}
\AfterEndEnvironment{abstract}{%
	\ifGerman\selectlanguage{ngerman}\else\selectlanguage{english}\fi%
}

% vim: ft=tex
