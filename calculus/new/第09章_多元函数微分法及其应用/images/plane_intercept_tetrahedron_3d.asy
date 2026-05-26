settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(6, -6, 5);

// 坐标轴
draw((0,0,0)--(6.0,0,0), black+0.8, arrow=Arrow3());
draw((0,0,0)--(0,4.8,0), black+0.8, arrow=Arrow3());
draw((0,0,0)--(0,0,4.8), black+0.8, arrow=Arrow3());
label("$x$", (5.8,-0.2,0), S, fontsize(15));
label("$y$", (0.2,4.6,0), E, fontsize(15));
label("$z$", (0,0.2,4.6), N, fontsize(15));

// 截距点 (极值对应点)
real x0 = 3/sqrt(3);
real y0 = 2/sqrt(3);
real z0 = 2/sqrt(3);
triple Ap = (9/x0, 0, 0);
triple Bp = (0, 4/y0, 0);
triple Cp = (0, 0, 4/z0);

// 绘制四面体的三个坐标面投影面 (半透明灰色)
draw(surface((0,0,0)--Ap--Bp--cycle), lightgray+opacity(0.22));
draw(surface((0,0,0)--Bp--Cp--cycle), lightgray+opacity(0.22));
draw(surface((0,0,0)--Ap--Cp--cycle), lightgray+opacity(0.22));

// 绘制切平面本身 (半透明淡黄色)
draw(surface(Ap--Bp--Cp--cycle), lightyellow+opacity(0.4));
draw(Ap--Bp--Cp--cycle, red+1.2);

// 先画线，后画 dot
dot(Ap, linewidth(5));
dot(Bp, linewidth(5));
dot(Cp, linewidth(5));
dot((0,0,0), linewidth(5));

// 标注点和坐标截距
label("$A(\frac{a^2}{x_0},0,0)$", Ap + (0.1, -0.22, 0), S, fontsize(13));
label("$B(0,\frac{b^2}{y_0},0)$", Bp + (0.22, 0.1, 0), E, fontsize(13));
label("$C(0,0,\frac{c^2}{z_0})$", Cp + (-0.12, 0.12, 0.12), NW, fontsize(13));
label("$O$", (0,0,0), SW, fontsize(13));

// 标注体积公式与截距文字
label("截距: $A = \frac{a^2}{x_0},\; B = \frac{b^2}{y_0},\; C = \frac{c^2}{z_0}$", (2.2, 2.6, 3.2), NE, fontsize(13));
label("四面体体积: $V = \frac{1}{6}ABC$", (2.2, 2.6, 2.7), NE, red+fontsize(14));
