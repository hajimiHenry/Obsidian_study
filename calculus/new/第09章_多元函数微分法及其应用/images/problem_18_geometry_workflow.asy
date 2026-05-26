settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(800);
import three;
import graph3;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(7.2, -8.5, 6.2);

// ================= 左场景：椭球面与切平面 (原点在 (0,0,0)) =================
triple O1 = (0,0,0);
draw(O1--(5.5,0,0), black+0.8, arrow=Arrow3());
draw(O1--(0,4.0,0), black+0.8, arrow=Arrow3());
draw(O1--(0,0,4.0), black+0.8, arrow=Arrow3());
label("$x$", (5.3,-0.2,0), S, fontsize(13));
label("$y$", (0.2,3.8,0), E, fontsize(13));
label("$z$", (0,0.2,3.8), N, fontsize(13));

// 椭球面
triple f(pair p) {
  real u = p.x;
  real v = p.y;
  return (3*sin(u)*cos(v), 2*sin(u)*sin(v), 2*cos(u));
}
surface s = surface(f, (0,0), (pi/2, pi/2), 12, 12);
draw(s, lightgray+opacity(0.55), meshpen=gray(0.55)+0.2);

// 切点 M0
real x0 = 3/sqrt(3);
real y0 = 2/sqrt(3);
real z0 = 2/sqrt(3);
triple M0 = (x0, y0, z0);

// 切平面顶点
triple Ap1 = (9/x0, 0, 0);
triple Bp1 = (0, 4/y0, 0);
triple Cp1 = (0, 0, 4/z0);

path3 plane1 = Ap1--Bp1--Cp1--cycle;
draw(surface(plane1), lightblue+opacity(0.35));
draw(plane1, blue+0.9);

dot(M0, linewidth(5));
label("$M_0(x_0,y_0,z_0)$", M0 + (-0.1, -0.15, 0.15), W, fontsize(12));
label("\textbf{① 椭球面与切点}", (1.5, 0.3, 3.5), N, fontsize(14));


// ================= 中间连接箭头与动作 =================
triple arrow_start = (5.1, 0.8, 1.8);
triple arrow_end = (6.6, 0.8, 1.8);
draw(arrow_start--arrow_end, blue+1.5, arrow=Arrow3());
label("求截距", (5.85, 0.8, 2.0), N, blue+fontsize(12));


// ================= 右场景：围成的四面体 (原点平移至 (7.0,0,0)) =================
triple O2 = (7.0,0,0);
draw(O2--(7.0+5.5,0,0), black+0.8, arrow=Arrow3());
draw(O2--(7.0,4.0,0), black+0.8, arrow=Arrow3());
draw(O2--(7.0,0,4.0), black+0.8, arrow=Arrow3());
label("$x$", (12.3,-0.2,0), S, fontsize(13));
label("$y$", (7.2,3.8,0), E, fontsize(13));
label("$z$", (7.0,0.2,3.8), N, fontsize(13));

// 右场景顶点 (Ap2, Bp2, Cp2)
triple Ap2 = O2 + (9/x0, 0, 0);
triple Bp2 = O2 + (0, 4/y0, 0);
triple Cp2 = O2 + (0, 0, 4/z0);

// 填充四面体投影面和切面
draw(surface(O2--Ap2--Bp2--cycle), lightgray+opacity(0.22));
draw(surface(O2--Bp2--Cp2--cycle), lightgray+opacity(0.22));
draw(surface(O2--Ap2--Cp2--cycle), lightgray+opacity(0.22));
draw(surface(Ap2--Bp2--Cp2--cycle), lightyellow+opacity(0.38));
draw(Ap2--Bp2--Cp2--cycle, red+1.0);

dot(Ap2, linewidth(4.5));
dot(Bp2, linewidth(4.5));
dot(Cp2, linewidth(4.5));
dot(O2, linewidth(4.5));

label("$A(\frac{a^2}{x_0},0,0)$", Ap2 + (0.1, -0.22, 0), S, fontsize(11));
label("$B(0,\frac{b^2}{y_0},0)$", Bp2 + (0.22, 0.1, 0), E, fontsize(11));
label("$C(0,0,\frac{c^2}{z_0})$", Cp2 + (-0.12, 0.12, 0.12), NW, fontsize(11));
label("$O'$", O2, SW, fontsize(11));
label("\textbf{② 截三轴形成四面体}", O2 + (1.5, 0.3, 3.5), N, fontsize(14));


// ================= 底部公式与拉格朗日转换说明 =================
// 放在两幅图的下方正中，平移位置
triple text_pos = (6.0, 0, -1.0);
label("四面体体积公式：$V = \frac{1}{6} A B C = \frac{a^2 b^2 c^2}{6 x_0 y_0 z_0}$", text_pos, S, red+fontsize(13));
label("问题转化：约束条件下最小化体积 $V \iff$ 拉格朗日最大化 $x_0 y_0 z_0$", text_pos + (0, 0, -0.38), S, fontsize(13));
