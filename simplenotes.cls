% ================================================
% Clase: simplenotes.cls
%
% by: Jeremías Martinez
% Inspirado por las notas de Isaac Bruno Quiroga
% Codeblocks based on github.com/alexmingzhang/amznotes/
% ================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{simplenotes}[2025/08/28 v2.0 Clase para apuntes simples]

% --------------------------------
% CLASE BASE
% --------------------------------
% Si se desea usar capítulos, cambiar article por report
\LoadClass[a4paper]{article}

% --------------------------------
% PAQUETES
% --------------------------------
% --- Paquetes fundamentales
\RequirePackage[spanish]{babel}                   % Formato en español
\RequirePackage{amsmath,amssymb,amsfonts,amsthm}  % Utilidades y símbolos matemáticos
\RequirePackage{graphicx}                         % Insertar imágenes
\RequirePackage{xcolor}                           % Permite definir colores
\RequirePackage{geometry}                         % Configura los márgenes
\RequirePackage{microtype}                        % Mejora el typesetting del documento
\RequirePackage[colorlinks=true,
                linkcolor=blue,
                urlcolor=blue,
                citecolor=blue]{hyperref}         % Inserta enlaces en el PDF

\RequirePackage[most]{tcolorbox}                  % Para las cajas personalizadas
\RequirePackage{fontawesome5}                     % Fuente con iconos
\RequirePackage{minted}                           % Soporte para resaltado de sintaxis

% --------------------------------
% CONFIGURACIÓN DE PÁGINA
% --------------------------------
\geometry{
  a4paper, 
  left=25mm, 
  right=25mm, 
  top=30mm, 
  bottom=30mm
}

% --------------------------------
% ENTORNOS PERSONALIZADOS
% --------------------------------

% --- Teoremas y matemáticas
\newtheorem*{property}{Propiedad}
\newtheorem*{proposition}{Proposición}
\newtheorem*{note}{Nota}
\newtheorem*{convention}{Convención}

\newtcbtheorem[auto counter]{definition}{Definición}{
    separator sign=\ \raisebox{2.3pt}{\scalebox{0.5}{ $\blacktriangleright$}},
    sharp corners=downhill,
    left=2mm,right=1mm}{definition}

\newtcbtheorem[auto counter]{theorem}{Teorema}{
    separator sign=\ \raisebox{2.3pt}{\scalebox{0.5}{ $\blacktriangleright$}},
    sharp corners=downhill,
    left=2mm,right=1mm}{theorem}

\newtcbtheorem[auto counter]{lemma}{Lema}{
    separator sign=\ \raisebox{2.3pt}{\scalebox{0.5}{ $\blacktriangleright$}},
    sharp corners=downhill,
    left=2mm,right=1mm}{lemma}

% --- Comandos rápidos con íconos
\newcommand{\iquestion}{{\large\faIcon{question-circle}}\hspace{1mm}}
\newcommand{\iexclamation}{{\large\faIcon{exclamation-triangle}}\hspace{1mm}}
\newcommand{\ieye}{{\large\faIcon{eye}}\hspace{1mm}}

% --- Estilos generales para cajas
\tcbsetforeverylayer{
    fonttitle=\bfseries\upshape
}

\tcbset{
  basebox/.style={
    enhanced,
    before skip=2mm, after skip=3mm,
    boxrule=0.4pt, left=5mm, right=2mm, top=1mm, bottom=1mm,
    sharp corners, rounded corners=southeast, arc is angular, arc=3mm,
    drop fuzzy shadow
  }
}

% --- Cajas con íconos
\newtcolorbox{iconbox}[2][]{basebox,
  underlay={
    \path[fill=black] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
    \path[draw=black,shorten <=-0.05mm,shorten >=-0.05mm] 
      ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
    \path[fill=black,draw=none] (interior.south west) rectangle node[white]{#2} 
      ([xshift=4mm]interior.north west);
  },#1}

\newenvironment{observation}{\begin{iconbox}{\faIcon{eye}}}{\end{iconbox}}
\newenvironment{remark}{\begin{iconbox}{\faIcon{comment}}}{\end{iconbox}}
\newenvironment{question}{\begin{iconbox}{\Large\bfseries ?}}{\end{iconbox}}
\newenvironment{exercise}{\begin{iconbox}{\faIcon{pencil-alt}}}{\end{iconbox}}
\newenvironment{important}{\begin{iconbox}{\Large\bfseries !}}{\end{iconbox}}

% --- Cajas de código (minted)
\definecolor{codeboxcolor}{HTML}{2d3436}

\tcbset{
    codeboxstyle/.style={
        overlay={\begin{tcbclipinterior}
            \fill[darkgray!20!white] 
            (frame.south west) rectangle ([xshift=6mm]frame.north west);
        \end{tcbclipinterior}},
        skin=bicolor,
        collower=white,
        colbacklower=darkgray
    },
}

\newtcbtheorem[auto counter]{codebox}{Fragmento de Código}{
    enhanced,
    drop fuzzy shadow,
    fonttitle=\strut\bfseries,
    boxrule=0pt,
    frame hidden,
    separator sign=\ \raisebox{2.3pt}{\scalebox{0.5}{ $\blacktriangleright$}},
    breakable,
    frame style={fill=codeboxcolor!85!black},
    interior style={fill=codeboxcolor!5!white},
    segmentation style={solid,draw=codeboxcolor!50!black,opacity=0.25,line width=1pt},
    sharp corners=downhill,
    codeboxstyle
}{codebox}


\renewcommand{\theFancyVerbLine}{\ttfamily\scriptsize{\arabic{FancyVerbLine}}} % Cambia el estilo de los números del código

\newenvironment{snippet}[2][]{
    \VerbatimEnvironment
    \begin{minted}[
        linenos,            
        breaklines,         
        autogobble,         
        xleftmargin=3.75mm,
    ]{#2}}
{\end{minted}}

\newcommand{\inputsnippet}[2]{\inputminted[
    linenos,
    breaklines,
    autogobble,
    xleftmargin=3.75mm,
]{#1}{#2}}
