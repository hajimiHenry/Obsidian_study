settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;

currentprojection = perspective(3.0,-4.0,2.5);

// 坐标轴
draw((0,0,0)--(1.4,0,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0.8,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,1.4), black+0.9, arrow=Arrow3());
label("$x$", (1.25,-0.05,0), S, fontsize(16));
label("$y$", (0.05,0.72,0), NE, fontsize(16));
label("$z$", (0.05,-0.05,1.25), E, fontsize(16));

triple O = (0,0,0);
triple A = (1,0,0);
triple B = (0,0.5,0);
triple C = (0,0,1);

// 绘制底面三角形 OAB
path3 bottom = O--A--B--cycle;
draw(surface(bottom), rgb(0.78,0.88,1.0)+opacity(0.4));
draw(bottom, deepblue+1.2);
label("$D_{xy}$", (0.3,0.15,0), fontsize(16));

// 绘制斜面三角形 ABC
path3 slope = A--B--C--cycle;
draw(surface(slope), rgb(1.0,0.8,0.8)+opacity(0.55));
draw(slope, heavyred+1.3);

// 绘制后侧三角形 OAC (在 xOz 面)
path3 back_xOz = O--A--C--cycle;
draw(surface(back_xOz), rgb(0.9,0.9,0.9)+opacity(0.2));
draw(back_xOz, gray(0.5)+0.5);

// 绘制左侧三角形 OBC (在 yOz 面)
path3 left_yOz = O--B--C--cycle;
draw(surface(left_yOz), rgb(0.9,0.9,0.9)+opacity(0.2));
draw(left_yOz, gray(0.5)+0.5);

// 标出坐标轴上的截点
dot(A, linewidth(5));
dot(B, linewidth(5));
dot(C, linewidth(5));

label("$1$", A + (0.05,-0.05,0), SE, fontsize(14));
label("$\frac{1}{2}$", B + (0.05,0.05,0), E, fontsize(14));
label("$1$", C + (0.05,0,0.05), N, fontsize(14));

// 标出斜面方程
label("$x+2y+z=1$", (0.4, 0.25, 0.45), NE, fontsize(15));
