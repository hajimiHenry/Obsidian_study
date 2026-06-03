import os
import subprocess
import sys

# 导入转换 PDF 的 build_svg 函数
from convert_pdf import build_svg

# 定义所有的 LaTeX 文件及其内容
TEX_FILES = {
    "chapter7_flowchart": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usetikzlibrary{arrows.meta, positioning}
\begin{document}
\begin{tikzpicture}[node distance=1.8cm and 1.2cm, auto, >=Stealth, semithick,
    block/.style={rectangle, draw, fill=blue!5, text width=6.5em, text centered, rounded corners, minimum height=3em}]
    \node [block] (time) {时域正弦量\\ $u(t), i(t)$};
    \node [block, right=of time] (phasor) {相量\\ $\dot{U}, \dot{I}$};
    \node [block, right=of phasor] (circuit) {相量电路\\ ($R, j\omega L, \frac{1}{j\omega C}$)};
    \node [block, right=of circuit] (calc) {复数代数计算\\ (KCL/KVL等)};
    \node [block, right=of calc] (result) {还原时域结果\\ $u(t), i(t)$};
    
    \draw [->] (time) -- node [above, font=\small] {$\dot{X} = X\angle\varphi$} (phasor);
    \draw [->] (phasor) -- node [above, font=\small] {$Z$} node [below, font=\scriptsize, align=center] {$Z_R=R$\\ $Z_L=j\omega L$\\ $Z_C=\frac{1}{j\omega C}$} (circuit);
    \draw [->] (circuit) -- node [above, font=\small] {复数运算} (calc);
    \draw [->] (calc) -- node [above, font=\small] {时域还原} node [below, font=\scriptsize, align=center] {$x(t)=$\\ $\sqrt{2}X\sin(\omega t+\varphi)$} (result);
\end{tikzpicture}
\end{document}
""",

    "chapter7_complex_plane": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usetikzlibrary{arrows.meta}
\begin{document}
\begin{tikzpicture}[>=Stealth, semithick]
    \draw[->] (-1,0) -- (4,0) node[right] {Re};
    \draw[->] (0,-1) -- (0,3) node[above] {Im};
    \draw[->, thick, blue] (0,0) -- (3,2) node[above right] {$F = a + jb$};
    \draw[dashed, gray] (3,0) -- (3,2) -- (0,2);
    \node[below] at (3,0) {$a = |F|\cos\varphi$};
    \node[left] at (0,2) {$b = |F|\sin\varphi$};
    \node[below left] at (0,0) {$0$};
    \draw[domain=0:33.69,->,red] plot ({0.6*cos(\x)}, {0.6*sin(\x)});
    \node[red] at (0.8,0.25) {$\varphi$};
    \node[blue, above left] at (1.5,1) {$|F| = \sqrt{a^2+b^2}$};
    \node[right, align=left] at (0.1,-0.6) {$\varphi = \arctan \frac{b}{a}$};
\end{tikzpicture}

\begin{tikzpicture}[>=Stealth, semithick]
    \draw[->] (-2.5,0) -- (2.5,0) node[right] {Re};
    \draw[->] (0,-2.5) -- (0,2.5) node[above] {Im};
    \node[red, font=\small] at (1.5,1.5) {I象限: $\varphi = \theta$};
    \node[red, font=\small] at (-1.5,1.5) {II象限: $\varphi = \theta + 180^\circ$};
    \node[red, font=\small] at (-1.5,-1.5) {III象限: $\varphi = \theta - 180^\circ$};
    \node[red, font=\small] at (1.5,-1.5) {IV象限: $\varphi = \theta$};
    \node[gray, font=\scriptsize] at (1.5,1.1) {($a>0, b>0$)};
    \node[gray, font=\scriptsize] at (-1.5,1.1) {($a<0, b>0$)};
    \node[gray, font=\scriptsize] at (-1.5,-1.1) {($a<0, b<0$)};
    \node[gray, font=\scriptsize] at (1.5,-1.1) {($a>0, b<0$)};
    \node[below right, align=left] at (-2.4,-1.8) {注: $\theta = \arctan \frac{b}{a}$ 为计算器计算值};
\end{tikzpicture}
\end{document}
""",

    "chapter7_sin_waveforms": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usetikzlibrary{arrows.meta, decorations.pathreplacing}
\begin{document}
\begin{tikzpicture}[>=Stealth, semithick, xscale=1.2]
    \draw[->] (-1.5,0) -- (7.5,0) node[right] {$\omega t$};
    \draw[->] (0,-2.5) -- (0,2.5) node[above] {$u(t), i(t)$};
    \draw[domain=-1.2:7, samples=200, blue, thick] plot (\x, {2*sin(deg(\x + 0.6))}) node[above] {$u(t)$};
    \draw[domain=-0.2:7, samples=200, red, dashed, thick] plot (\x, {1.3*sin(deg(\x - 0.4))}) node[right] {$i(t)$};
    
    \draw[dashed, gray] (-1.2, 2) -- (0.97, 2);
    \draw[<->, gray] (0.5, 0) -- (0.5, 2) node[midway, right, blue] {$U_m$};
    \draw[dashed, gray] (-0.2, 1.3) -- (1.97, 1.3);
    \draw[<->, gray] (1.5, 0) -- (1.5, 1.3) node[midway, right, red] {$I_m$};
    
    \draw[<->, black] (0.97, 2.2) -- ({0.97 + 2*pi}, 2.2) node[midway, above] {$T = 2\pi/\omega$};
    \draw[dashed, gray] ({0.97 + 2*pi}, 0) -- ({0.97 + 2*pi}, 2.2);
    \draw[dashed, gray] (0.97, 0) -- (0.97, 2.2);
    
    \filldraw[blue] (-0.6, 0) circle (1.5pt);
    \draw[<-] (-0.6, -0.4) -- (-0.3, -1) node[below, blue] {$\varphi_u$};
    \filldraw[red] (0.4, 0) circle (1.5pt);
    \draw[<-] (0.4, -0.4) -- (0.7, -1) node[below, red] {$\varphi_i$};
    
    \draw[decorate, decoration={brace, amplitude=4pt, mirror}] (-0.6, -0.1) -- (0.4, -0.1) node[midway, below=3pt] {$\varphi_{ui} = \varphi_u - \varphi_i$};
\end{tikzpicture}
\end{document}
""",

    "chapter7_phasor_diagrams": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usetikzlibrary{arrows.meta}
\begin{document}
\begin{tikzpicture}[>=Stealth, semithick]
    \draw[->] (-0.5,0) -- (4,0) node[right] {Re};
    \draw[->] (0,-1.5) -- (0,3.5) node[above] {Im};
    \draw[->, ultra thick, black] (0,0) -- (2.5,0) node[above right] {$\dot{I}$};
    \draw[->, thick, blue] (0,0) -- (1.8,0) node[below] {$\dot{U}_R$};
    \draw[->, thick, red] (0,0) -- (0,3) node[left] {$\dot{U}_L$};
    \draw[->, thick, orange] (0,0) -- (0,-1.2) node[left] {$\dot{U}_C$};
    \draw[->, thick, red!60!black, dashed] (0,0) -- (0,1.8) node[left] {$\dot{U}_L + \dot{U}_C$};
    \draw[dashed, gray] (1.8,0) -- (1.8, 1.8) -- (0,1.8);
    \draw[->, ultra thick, purple] (0,0) -- (1.8, 1.8) node[above right] {$\dot{U}_s$};
    \draw[domain=0:45, ->, purple] plot ({0.6*cos(\x)}, {0.6*sin(\x)});
    \node[purple] at (0.8, 0.3) {$\varphi$};
    \node[below, font=\small] at (2,-0.6) {(a) 串联 RLC 电路电压相量图};
\end{tikzpicture}

\begin{tikzpicture}[>=Stealth, semithick]
    \draw[->] (-0.5,0) -- (4,0) node[right] {Re};
    \draw[->] (0,-2) -- (0,3) node[above] {Im};
    \draw[->, ultra thick, black] (0,0) -- (2.5,0) node[above right] {$\dot{U}$};
    \draw[->, thick, blue] (0,0) -- (1.8,0) node[below] {$\dot{I}_R$};
    \draw[->, thick, red] (0,0) -- (0,2.2) node[left] {$\dot{I}_C$};
    \draw[->, thick, orange] (0,0) -- (0,-1.6) node[left] {$\dot{I}_L$};
    \draw[->, thick, red!60!black, dashed] (0,0) -- (0,0.6) node[left] {$\dot{I}_C + \dot{I}_L$};
    \draw[dashed, gray] (1.8,0) -- (1.8, 0.6) -- (0,0.6);
    \draw[->, ultra thick, purple] (0,0) -- (1.8, 0.6) node[above right] {$\dot{I}_s$};
    \draw[domain=0:18.4, ->, purple] plot ({0.7*cos(\x)}, {0.7*sin(\x)});
    \node[purple] at (0.9, 0.15) {$\varphi$};
    \node[below, font=\small] at (2,-1) {(b) 并联 RLC 电路电流相量图};
\end{tikzpicture}
\end{document}
""",

    "chapter7_kcl_kvl": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usetikzlibrary{arrows.meta}
\begin{document}
\begin{tikzpicture}[>=Stealth, semithick]
    \filldraw (0,0) circle (2.5pt) node[above] {节点};
    \draw[<-] (0,0) -- (-1.5, 1) node[midway, above left] {$\dot{I}_1$};
    \draw[<-] (0,0) -- (-1.5, -1) node[midway, below left] {$\dot{I}_2$};
    \draw[->] (0,0) -- (1.5, 1) node[midway, above right] {$\dot{I}_3$};
    \draw[->] (0,0) -- (1.5, -1) node[midway, below right] {$\dot{I}_4$};
    \node[right, align=left] at (2,0) {$\sum \dot{I}_{in} = \sum \dot{I}_{out}$ \\ $\dot{I}_1 + \dot{I}_2 - \dot{I}_3 - \dot{I}_4 = 0$};
\end{tikzpicture}

\begin{tikzpicture}[>=Stealth, semithick]
    \draw (0,0) rectangle (3,2);
    \node[left] at (0,1) {$\dot{U}_1$};
    \node[left, font=\scriptsize] at (0,1.7) {$+$};
    \node[left, font=\scriptsize] at (0,0.3) {$-$};
    \node[above] at (1.5,2) {$\dot{U}_2$};
    \node[above, font=\scriptsize] at (0.3,2) {$+$};
    \node[above, font=\scriptsize] at (2.7,2) {$-$};
    \node[right] at (3,1) {$\dot{U}_3$};
    \node[right, font=\scriptsize] at (3,1.7) {$-$};
    \node[right, font=\scriptsize] at (3,0.3) {$+$};
    \node[below] at (1.5,0) {$\dot{U}_4$};
    \node[below, font=\scriptsize] at (0.3,0) {$-$};
    \node[below, font=\scriptsize] at (2.7,0) {$+$};
    \draw[->, red] (1.5,1.2) arc (90:-230:0.4) node[midway, above, font=\scriptsize] {绕行方向};
    \node[right, align=left] at (3.8,1) {$\sum \dot{U} = 0$ \\ $\dot{U}_1 + \dot{U}_2 - \dot{U}_3 + \dot{U}_4 = 0$};
\end{tikzpicture}
\end{document}
""",

    "chapter7_rlc_models": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0.8) to[R, l=$R$, v=$u$, i=$i$] (2.5,0.8);
    \node[above, font=\small] at (1.25, 1.8) {电阻元件 (时域)};
    \node[below] at (1.25, 0.4) {$u(t) = R i(t)$};
    \draw[->, thick, double] (3.2, 0.8) -- (4.3, 0.8) node[midway, above, font=\scriptsize] {相量变换};
    \draw (5,0.8) to[R, l=$R$, v=$\dot{U}$, i=$\dot{I}$] (7.5,0.8);
    \node[above, font=\small] at (6.25, 1.8) {阻抗形式 (相量域)};
    \node[below] at (6.25, 0.4) {$\dot{U} = R \dot{I}$};
\end{circuitikz}

\begin{circuitikz}[semithick]
    \draw (0,0.8) to[L, l=$L$, v=$u$, i=$i$] (2.5,0.8);
    \node[above, font=\small] at (1.25, 1.8) {电感元件 (时域)};
    \node[below] at (1.25, 0.4) {$u(t) = L\frac{\mathrm{d}i(t)}{\mathrm{d}t}$};
    \draw[->, thick, double] (3.2, 0.8) -- (4.3, 0.8) node[midway, above, font=\scriptsize] {相量变换};
    \draw (5,0.8) to[L, l=$j\omega L$, v=$\dot{U}$, i=$\dot{I}$] (7.5,0.8);
    \node[above, font=\small] at (6.25, 1.8) {感抗阻抗 (相量域)};
    \node[below] at (6.25, 0.4) {$\dot{U} = j\omega L \dot{I}$};
\end{circuitikz}

\begin{circuitikz}[semithick]
    \draw (0,0.8) to[C, l=$C$, v=$u$, i=$i$] (2.5,0.8);
    \node[above, font=\small] at (1.25, 1.8) {电容元件 (时域)};
    \node[below] at (1.25, 0.4) {$i(t) = C\frac{\mathrm{d}u(t)}{\mathrm{d}t}$};
    \draw[->, thick, double] (3.2, 0.8) -- (4.3, 0.8) node[midway, above, font=\scriptsize] {相量变换};
    \draw (5,0.8) to[C, l=$\frac{1}{j\omega C}$, v=$\dot{U}$, i=$\dot{I}$] (7.5,0.8);
    \node[above, font=\small] at (6.25, 1.8) {容抗阻抗 (相量域)};
    \node[below] at (6.25, 0.4) {$\dot{U} = \frac{1}{j\omega C} \dot{I}$};
\end{circuitikz}
\end{document}
""",

    "chapter7_rlc_series": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0) to[sV, l=$\dot{U}_s$] (0,2)
          to[R, l=$R$, v=$\dot{U}_R$, i=$\dot{I}$] (2.5,2)
          to[L, l=$j\omega L$, v=$\dot{U}_L$] (5,2)
          to[C, l=$\frac{1}{j\omega C}$, v=$\dot{U}_C$] (7.5,2)
          -- (7.5,0) -- (0,0);
    \node[below, font=\small] at (3.75, -0.3) {(a) RLC 串联相量电路};
\end{circuitikz}

\begin{tikzpicture}[>=Stealth, semithick]
    \draw[->] (-0.5,0) -- (3.5,0) node[right] {Re};
    \draw[->] (0,-0.5) -- (0,3) node[above] {Im};
    \draw[thick, blue] (0,0) -- (2.5,0) node[midway, below] {$R$}
                      -- (2.5,2.2) node[midway, right] {$X = \omega L - \frac{1}{\omega C}$};
    \draw[thick, red, ->] (0,0) -- (2.5,2.2) node[above left] {$Z = R + jX$};
    \draw[domain=0:41.3, ->, purple] plot ({0.6*cos(\x)}, {0.6*sin(\x)});
    \node[purple] at (0.8,0.3) {$\varphi$};
    \node[below, font=\small] at (1.25, -0.6) {(b) 阻抗三角形};
\end{tikzpicture}

\begin{circuitikz}[semithick]
    \draw (0,0) to[sV, l=$\dot{U}_s$] (0,2)
          to[generic, l=$Z_1$, v=$\dot{U}_1$, i=$\dot{I}$] (3,2)
          to[generic, l=$Z_2$, v=$\dot{U}_2$] (6,2)
          -- (6,0) -- (0,0);
    \node[below, font=\small] at (3, -0.3) {(c) 串联阻抗分压示意图};
    \node[right, align=left] at (6.5, 1) {$\dot{I} = \frac{\dot{U}_s}{Z_1 + Z_2}$ \\ $\dot{U}_1 = \frac{Z_1}{Z_1+Z_2}\dot{U}_s$ \\ $\dot{U}_2 = \frac{Z_2}{Z_1+Z_2}\dot{U}_s$};
\end{circuitikz}
\end{document}
""",

    "chapter7_rlc_parallel": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0) to[sI, l=$\dot{I}_s$] (0,2.5) -- (6,2.5)
          (2,2.5) to[R, l=$R$, i=$\dot{I}_R$, v=$\dot{U}$] (2,0)
          (4,2.5) to[L, l=$j\omega L$, i=$\dot{I}_L$] (4,0)
          (6,2.5) to[C, l=$\frac{1}{j\omega C}$, i=$\dot{I}_C$] (6,0)
          (0,0) -- (6,0);
    \node[below, font=\small] at (3, -0.3) {(a) RLC 并联相量电路};
\end{circuitikz}

\begin{circuitikz}[semithick]
    \draw (0,0) to[sI, l=$\dot{I}_s$] (0,2.5) -- (5,2.5)
          (2.5,2.5) to[generic, l=$Y_1$, i=$\dot{I}_1$, v=$\dot{U}$] (2.5,0)
          (5,2.5) to[generic, l=$Y_2$, i=$\dot{I}_2$] (5,0)
          (0,0) -- (5,0);
    \node[below, font=\small] at (2.5, -0.3) {(b) 导纳并联分流示意图};
    \node[right, align=left] at (5.5, 1.25) {$\dot{U} = \frac{\dot{I}_s}{Y_1 + Y_2}$ \\ $\dot{I}_1 = \frac{Y_1}{Y_1+Y_2}\dot{I}_s$ \\ $\dot{I}_2 = \frac{Y_2}{Y_1+Y_2}\dot{I}_s$};
\end{circuitikz}
\end{document}
""",

    "chapter7_series_network": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0) to[sV, l=$\dot{U}_s$] (0,2)
          to[R, l=$R(3\Omega)$, i=$\dot{I}$] (2.5,2)
          to[L, l=$j\omega L(j4\Omega)$] (5,2)
          to[generic, l=$N$, v=$\dot{U}_N$] (5,0)
          -- (0,0);
    \node[above, font=\scriptsize] at (5, 1) {$Z=R_1+jX_1$};
\end{circuitikz}
\end{document}
""",

    "chapter7_mixed_circuit": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0) to[sV, l=$u_s$] (0,2.5)
          to[L, l=$L$, i=$i_L$] (3,2.5)
          to[C, l=$C$, i=$i_C$] (3,0)
          (3,2.5) -- (5,2.5)
          to[R, l=$R$, i=$i_R$, v=$u$] (5,0)
          -- (0,0);
\end{circuitikz}
\end{document}
""",

    "chapter7_example_7_4_2": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0) to[sV, l=$\dot{U}_{s1}$] (0,3)
          to[L, l=$j4\Omega$] (3,3) node[above] {a}
          to[R, l=$3\Omega$, i=$\dot{I}_1$] (3,0)
          
          (3,3) to[L, l=$j4\Omega$] (6,3) node[above] {b}
          to[sV, l=$\dot{U}_{s2}$] (6,0)
          
          (6,3) -- (8.5,3)
          to[R, l=$4\Omega$, i=$\dot{I}_2$] (8.5,1.5)
          to[sV, l=$\dot{U}_{s3}$] (8.5,0)
          (0,0) -- (8.5,0);
\end{circuitikz}
\end{document}
""",

    "chapter7_example_7_4_3": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0) to[sV, l=$\dot{U}_s$] (0,2.5)
          to[R, l=$5\Omega$, v=$\dot{U}_1$, i=$\dot{I}$] (2.5,2.5)
          to[L, l=$j10\Omega$] (5,2.5)
          to[cV, l=$0.4\dot{U}_1$] (5,0)
          to[C, l=$-j20\Omega$] (0,0);
\end{circuitikz}
\end{document}
""",

    "chapter7_example_7_4_4": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    % (a) 原电路
    \draw (0,0) to[sV, l={$u_s(10\angle 0^\circ\mathrm{V})$}] (0,3)
          to[C, l={$-j8\Omega$}] (2.5,3) node[above] {a}
          to[C, l={$-j8\Omega$}] (2.5,0)
          
          (2.5,3) to[R, l={$1\Omega+j10\Omega$}, i=$i$] (5.5,3) node[above] {b}
          to[R, l=$8\Omega$] (5.5,0)
          
          (5.5,3) -- (8,3)
          to[R, l=$2\Omega$] (8,1.5) node[right] {c}
          to[R, l=$6\Omega$] (8,0)
          
          (8,1.5) -- (9.5,1.5)
          to[sI, l={$i_s(2\angle 60^\circ\mathrm{A})$}] (9.5,0)
          (0,0) -- (9.5,0);
    \node[below, font=\small] at (4.75, -0.3) {(a) 原电路};
\end{circuitikz}

\begin{circuitikz}[semithick]
    % (b) 求 Uoc'
    \draw (0,0) to[sV, l=$\dot{U}_s$] (0,3)
          to[C, l={$-j8\Omega$}] (2.5,3) node[above] {a}
          to[C, l={$-j8\Omega$}] (2.5,0)
          
          (5.5,3) node[above] {b} to[R, l=$8\Omega$] (5.5,0)
          (5.5,3) -- (8,3)
          to[R, l=$2\Omega$] (8,1.5)
          to[R, l=$6\Omega$] (8,0)
          (0,0) -- (8,0);
    \draw (2.5,3) to[open, v={$\dot{U}_{oc}'$}, color=red] (5.5,3);
    \node[below, font=\small] at (4, -0.3) {(b) 求 $\dot{U}_{oc}'$ (电压源单独作用)};
\end{circuitikz}

\begin{circuitikz}[semithick]
    % (c) 求 Uoc''
    \draw (0,0) -- (0,3)
          to[C, l={$-j8\Omega$}] (2.5,3) node[above] {a}
          to[C, l={$-j8\Omega$}] (2.5,0)
          
          (5.5,3) node[above] {b} to[R, l=$8\Omega$] (5.5,0)
          
          (5.5,3) -- (8,3)
          to[R, l=$2\Omega$] (8,1.5)
          to[R, l=$6\Omega$] (8,0)
          
          (8,1.5) -- (9.5,1.5)
          to[sI, l=$\dot{I}_s$] (9.5,0)
          (0,0) -- (9.5,0);
    \draw (2.5,3) to[open, v={$\dot{U}_{oc}''$}, color=red] (5.5,3);
    \node[below, font=\small] at (4.75, -0.3) {(c) 求 $\dot{U}_{oc}''$ (电流源单独作用)};
\end{circuitikz}

\begin{circuitikz}[semithick]
    % (d) 求 Zo
    \draw (0,0) -- (0,3)
          to[C, l={$-j8\Omega$}] (2.5,3) node[above] {a}
          to[C, l={$-j8\Omega$}] (2.5,0)
          
          (5.5,3) node[above] {b} to[R, l=$8\Omega$] (5.5,0)
          (5.5,3) -- (8,3)
          to[R, l=$2\Omega$] (8,1.5)
          to[R, l=$6\Omega$] (8,0)
          (0,0) -- (8,0);
    \draw[red, <->] (2.5,3.3) -- (5.5,3.3) node[midway, above] {$Z_o$};
    \node[below, font=\small] at (4, -0.3) {(d) 求等效阻抗 $Z_o$};
\end{circuitikz}

\begin{circuitikz}[semithick]
    % (e) 戴维南等效电路
    \draw (0,0) to[sV, l=$\dot{U}_{oc}$] (0,2.5)
          to[generic, l=$Z_o$, i=$\dot{I}$] (3,2.5)
          to[generic, l=$Z_L$] (3,0)
          -- (0,0);
    \node[above, font=\scriptsize] at (3, 2.5) {$1+j10\ \Omega$};
    \node[below, font=\small] at (1.5, -0.3) {(e) 戴维南等效电路};
\end{circuitikz}
\end{document}
""",

    "chapter7_zero_current": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw[thick, fill=gray!10] (0,0) rectangle (2,3);
    \node at (1,1.5) {含源网络};
    \draw[thick, fill=gray!10] (5,0) rectangle (7,3);
    \node at (6,1.5) {含源网络};
    
    \draw (2,2) to[short, *-*, l=a] (5,2) node[above] {b};
    \node[above] at (2,2) {a};
    \draw (2,1) to[short, *-*] (5,1);
    
    \draw[->, red, thick] (3.2, 2.3) -- (3.8, 2.3) node[midway, above] {$\dot{I} = 0$};
    \node[blue] at (3.5, 2.7) {$\dot{U}_a = \dot{U}_b$};
\end{circuitikz}
\end{document}
""",

    "chapter7_power_triangle": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usetikzlibrary{arrows.meta}
\begin{document}
\begin{tikzpicture}[>=Stealth, semithick]
    \draw[->, gray!50] (-0.5,0) -- (4,0);
    \draw[->, gray!50] (0,-0.5) -- (0,3);
    \draw[ultra thick, blue] (0,0) -- (3,0) node[midway, below] {$P$ (有功功率/W)};
    \draw[ultra thick, red] (3,0) -- (3,2.2) node[midway, right] {$Q$ (无功功率/Var)};
    \draw[ultra thick, purple, ->] (0,0) -- (3,2.2) node[above left] {$S$ (视在功率/VA)};
    \draw[domain=0:36.25, ->, purple] plot ({0.7*cos(\x)}, {0.7*sin(\x)});
    \node[purple] at (0.9, 0.3) {$\varphi$};
    \node[right, align=left] at (4, 1.1) {
        关系公式：\\
        $S = \sqrt{P^2 + Q^2}$ \\
        $\cos\varphi = \frac{P}{S}$ \\
        $\tan\varphi = \frac{Q}{P}$
    };
\end{tikzpicture}
\end{document}
""",

    "chapter7_example_7_5_1_phasor": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usetikzlibrary{arrows.meta}
\begin{document}
\begin{tikzpicture}[>=Stealth, semithick]
    \draw[->, gray!40] (-0.5,0) -- (5,0) node[right] {Re};
    \draw[->, gray!40] (0,-0.5) -- (0,3) node[above] {Im};
    \draw[->, ultra thick, black] (0,0) -- (4,0) node[above right] {$\dot{I}$};
    \draw[->, thick, blue] (0,0) -- (3.46,0) node[below] {$\dot{U}_R$ ($86.6\mathrm{V}$)};
    \draw[->, thick, red] (0,0) -- (0,2.0) node[left] {$\dot{U}_L$ ($50\mathrm{V}$)};
    \draw[dashed, gray] (3.46,0) -- (3.46,2.0) -- (0,2.0);
    \draw[->, ultra thick, purple] (0,0) -- (3.46,2.0) node[above right] {$\dot{U}_s$ ($100\mathrm{V}$)};
    \draw[domain=0:30, ->, purple] plot ({0.9*cos(\x)}, {0.9*sin(\x)});
    \node[purple] at (1.2,0.3) {$\varphi = 30^\circ$};
\end{tikzpicture}
\end{document}
""",

    "chapter7_example_7_5_2": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0) to[sV, l={$\dot{U}_s(10\angle 45^\circ\mathrm{V})$}] (0,2)
          to[C, l={$C(X_C=2.5\Omega)$}, v={$\dot{U}_C(5\angle -135^\circ\mathrm{V})$}, i=$\dot{I}$] (3.5,2)
          to[generic, l=$N$, v=$\dot{U}$] (3.5,0)
          -- (0,0);
    \node[above, font=\scriptsize] at (3.5, 1) {$Z = ?$};
\end{circuitikz}
\end{document}
""",

    "chapter7_example_7_5_3": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0) to[sV, l=$\dot{U}_s$] (0,3)
          to[L, l=$j2\Omega$, i=$\dot{I}$] (3,3) node[above] {U}
          to[R, l=$1\Omega$] (3,1.5)
          to[C, l=$-j1\Omega$, i=$\dot{I}_1$] (3,0)
          
          (3,3) to[R, l=$2\Omega$] (5.5,3)
          to[L, l=$j3\Omega$, i=$\dot{I}_2$] (5.5,0)
          
          (3,3) -- (7.5,3)
          to[sI, l=$\dot{I}_s$] (7.5,0)
          (0,0) -- (7.5,0);
\end{circuitikz}
\end{document}
""",

    "chapter7_example_7_5_4": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0) to[sV, l={$\dot{U}_s(220\mathrm{V})$}] (0,3.5) -- (6.5,3.5)
          (1.8,3.5) to[generic, l=$Z_1$, i=$\dot{I}_1$] (1.8,0)
          (4,3.5) to[generic, l=$Z_2$, i=$\dot{I}_2$] (4,0)
          (6.2,3.5) to[C, l={$-jX_C$}, i=$\dot{I}_C$] (6.2,0)
          (0,0) -- (6.5,0);
    \draw[->, thick] (0.8,3.7) -- (1.4,3.7) node[midway, above] {$\dot{I}$};
    \node[right, font=\scriptsize, align=left] at (6.6, 1.75) {
        $Z_1$: 50只日光灯 ($\cos\varphi_1=0.5$感性) \\
        $Z_2$: 50只白炽灯 ($\cos\varphi_2=1$) \\
        $C$: 补偿电容
    };
\end{circuitikz}
\end{document}
""",

    "chapter7_max_power_transfer": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0) to[sV, l=$\dot{U}_s$] (0,2.5)
          to[generic, l=$Z_o$, i=$\dot{I}$] (3.5,2.5)
          to[generic, l=$Z_L$] (3.5,0)
          -- (0,0);
    \node[above, font=\scriptsize] at (2.2, 2.7) {$Z_o = R_o + jX_o$};
    \node[right, font=\scriptsize] at (3.7, 1.25) {$Z_L = R_L + jX_L$};
    
    \node[below, font=\small, align=left] at (1.75, -0.4) {
        共轭匹配条件：$Z_L = Z_o^*$ \\
        即 $R_L = R_o$, $X_L = -X_o$ \\
        最大有功功率：$P_{L\max} = \frac{U_s^2}{4R_o}$
    };
\end{circuitikz}
\end{document}
""",

    "chapter7_series_resonance": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usetikzlibrary{arrows.meta}
\begin{document}
\begin{tikzpicture}[>=Stealth, semithick]
    \draw[->, gray!40] (-0.5,0) -- (4.5,0) node[right] {Re};
    \draw[->, gray!40] (0,-2.5) -- (0,2.5) node[above] {Im};
    \draw[->, ultra thick, black] (0,0) -- (3.5,0) node[above right] {$\dot{I}$};
    \draw[->, thick, blue] (0,0) -- (2.5,0) node[below] {$\dot{U}_R = \dot{U}_s$};
    \draw[->, thick, red] (0,0) -- (0,2.0) node[left] {$\dot{U}_L$};
    \draw[->, thick, orange] (0,0) -- (0,-2.0) node[left] {$\dot{U}_C$};
    
    \draw[dashed, red] (0.2,2.0) -- (0.8,2.0) node[right] {$U_L = Q U_s$};
    \draw[dashed, orange] (0.2,-2.0) -- (0.8,-2.0) node[right] {$U_C = Q U_s$};
    
    \node[draw, fill=blue!5, rounded corners, align=left, font=\small] at (6, 0) {
        \textbf{串联谐振状态：} \\
        谐振角频率：$\omega_0 = \frac{1}{\sqrt{LC}}$ \\
        输入阻抗最小：$Z = R$ \\
        回路电流最大：$I = \frac{U_s}{R}$ \\
        电感与电容电压大小相等、相位相反
    };
\end{tikzpicture}
\end{document}
""",

    "chapter7_frequency_response": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usetikzlibrary{arrows.meta}
\begin{document}
\begin{tikzpicture}[>=Stealth, semithick]
    \draw[->] (-0.5,0) -- (4,0) node[right] {$\omega$};
    \draw[->] (0,-0.5) -- (0,3) node[above] {$|Z|$};
    \draw[domain=0.2:3.5, samples=100, blue, thick] plot (\x, {0.6 + 0.4*(\x - 1.5)^2 + 0.1/(\x)});
    \draw[dashed, gray] (1.5,0) node[below, black] {$\omega_0$} -- (1.5, 0.67) -- (0, 0.67) node[left, black] {$R$};
    \node[below, font=\small] at (1.75, -0.6) {(a) 阻抗幅频特性};
\end{tikzpicture}

\begin{tikzpicture}[>=Stealth, semithick]
    \draw[->] (-0.5,0) -- (4,0) node[right] {$\omega$};
    \draw[->] (0,-2) -- (0,2) node[above] {$\varphi_Z$};
    \draw[domain=0.1:3.5, samples=100, red, thick] plot (\x, {1.5*atan(2*(\x - 1.5))/90});
    \draw[dashed, gray] (1.5,-2) -- (1.5,2);
    \node[below] at (1.5,0) {$\omega_0$};
    \node[left] at (0, 1) {$90^\circ$};
    \node[left] at (0, -1) {$-90^\circ$};
    \node[below, font=\small] at (1.75, -2.2) {(b) 阻抗相频特性};
\end{tikzpicture}

\begin{tikzpicture}[>=Stealth, semithick]
    \draw[->] (-0.5,0) -- (4,0) node[right] {$\omega$};
    \draw[->] (0,-0.5) -- (0,3) node[above] {$I$};
    \draw[domain=0.1:3.5, samples=100, purple, thick] plot (\x, {2.5/(1 + 3*(\x - 1.5)^2)});
    \draw[dashed, gray] (1.5,0) node[below, black] {$\omega_0$} -- (1.5, 2.5) -- (0, 2.5) node[left, black] {$I_0 = \frac{U_s}{R}$};
    \node[below, font=\small] at (1.75, -0.6) {(c) 电流幅频特性};
\end{tikzpicture}
\end{document}
""",

    "chapter7_parallel_resonance": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0) to[sI, l=$i_s$] (0,2.5) -- (6,2.5)
          (2,2.5) to[R, l=$R$, i=$\dot{I}_R$, v=$\dot{U}$] (2,0)
          (4,2.5) to[L, l=$L$, i=$\dot{I}_L$] (4,0)
          (6,2.5) to[C, l=$C$, i=$\dot{I}_C$] (6,0)
          (0,0) -- (6,0);
    \node[below, font=\small] at (3, -0.3) {(a) 并联谐振电路};
\end{circuitikz}

\begin{tikzpicture}[>=Stealth, semithick]
    \draw[->, gray!40] (-0.5,0) -- (4.5,0) node[right] {Re};
    \draw[->, gray!40] (0,-2.5) -- (0,2.5) node[above] {Im};
    \draw[->, ultra thick, black] (0,0) -- (3.5,0) node[above right] {$\dot{U}$};
    \draw[->, thick, blue] (0,0) -- (2.5,0) node[below] {$\dot{I}_R = \dot{I}_s$};
    \draw[->, thick, red] (0,0) -- (0,2.0) node[left] {$\dot{I}_C$};
    \draw[->, thick, orange] (0,0) -- (0,-2.0) node[left] {$\dot{I}_L$};
    
    \draw[dashed, red] (0.2,2.0) -- (0.8,2.0) node[right] {$I_C = Q I_s$};
    \draw[dashed, orange] (0.2,-2.0) -- (0.8,-2.0) node[right] {$I_L = Q I_s$};
    
    \node[draw, fill=blue!5, rounded corners, align=left, font=\small] at (6, 0) {
        \textbf{并联谐振状态：} \\
        谐振角频率：$\omega_0 = \frac{1}{\sqrt{LC}}$ \\
        输入导纳最小：$Y = G$ \\
        端电压最大：$U = \frac{I_s}{G}$ \\
        电容与电感电流大小相等、相位相反
    };
\end{tikzpicture}
\end{document}
""",

    "chapter7_example_7_6_2": r"""\documentclass[tikz,border=2bp]{standalone}
\usepackage{ctex}
\usepackage[europeanresistors, americanvoltages, americancurrents, americanports, siunitx]{circuitikz}
\standaloneenv{circuitikz}
\usetikzlibrary{fit, backgrounds, positioning}
\begin{document}
\begin{circuitikz}[semithick]
    \draw (0,0) to[sV, l=$u$] (0,3) -- (6,3)
          (2,3) to[R, l=$R_1$, i=$i_1$] (2,1.5)
                to[L, l=$L_1$] (2,0)
          
          (5,3) to[R, l=$R_2$, i=$i_2$] (5,2)
          (5,2) -- (4.2,2) to[C, l=$C$, i=$i_3$] (4.2,0.5) -- (5,0.5)
          (5,2) -- (5.8,2) to[L, l=$L_2$, i=$i_4$] (5.8,0.5) -- (5,0.5)
          (5,0.5) -- (5,0)
          (0,0) -- (6,0);
          
    \node[draw, red, dashed, inner sep=2.5mm, fit={(3.8,2.1) (6.2,0.4)}] (box) {};
    \node[red, left=0.1cm of box, font=\scriptsize, text width=4em, align=right] {并联谐振部分};
\end{circuitikz}
\end{document}
"""
}

# 路径定义
SRC_TEX_DIR = r"C:\Users\Spane\Desktop\prompt_base\circuit\重构教材\src_tex"
IMAGES_DIR = r"C:\Users\Spane\Desktop\prompt_base\circuit\重构教材\images"
TEX_BUILD_CMD = r"C:\Users\Spane\tools\latex\tex-build.cmd"

if not os.path.exists(SRC_TEX_DIR):
    os.makedirs(SRC_TEX_DIR)

if not os.path.exists(IMAGES_DIR):
    os.makedirs(IMAGES_DIR)

def compile_and_convert(name, content):
    tex_path = os.path.join(SRC_TEX_DIR, f"{name}.tex")
    pdf_path = os.path.join(SRC_TEX_DIR, f"{name}.pdf")
    
    # 1. 写入.tex文件
    with open(tex_path, "w", encoding="utf-8") as f:
        f.write(content)
    print(f"\n[INFO] Written {tex_path}")
    
    # 2. 调用编译脚本
    cmd = [TEX_BUILD_CMD, tex_path, SRC_TEX_DIR]
    print(f"[INFO] Compiling {tex_path} ...")
    res = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if res.returncode != 0:
        print(f"[ERROR] Failed to compile {name}.tex")
        print(res.stderr.decode('gbk', errors='ignore'))
        return False
    print(f"[INFO] Successfully compiled {name}.pdf")
    
    # 3. 转换为高清透明SVG并注入自适应反色样式
    print(f"[INFO] Converting {pdf_path} to SVG ...")
    success = build_svg(pdf_path, IMAGES_DIR, name)
    if success:
        print(f"[INFO] Finished process for: {name}")
    return success

def clean_aux_files():
    print("[INFO] Cleaning auxiliary files...")
    extensions = [".aux", ".log", ".pdf"]
    for file in os.listdir(SRC_TEX_DIR):
        ext = os.path.splitext(file)[1]
        if ext in extensions and not file.startswith("chapter5"):
            try:
                os.remove(os.path.join(SRC_TEX_DIR, file))
            except Exception as e:
                pass

if __name__ == "__main__":
    success_count = 0
    
    # 这次我们只重新跑唯一失败的那个
    failed_names = ["chapter7_example_7_4_4"]
    
    for name in failed_names:
        if compile_and_convert(name, TEX_FILES[name]):
            success_count += 1
            
    print(f"\n[SUMMARY] Re-processed {success_count}/{len(failed_names)} failed files successfully.")
    clean_aux_files()
