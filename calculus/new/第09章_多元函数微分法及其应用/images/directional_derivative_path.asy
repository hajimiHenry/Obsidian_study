settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(2.2, -3.2, 2.8);

// 坐标轴
draw((-0.5,0,0)--(3.2,0,0), black+0.8, arrow=Arrow3());
draw((0,-0.5,0)--(0,2.8,0), black+0.8, arrow=Arrow3());
label("$x$", (3.1,-0.15,0), S, fontsize(16));
label("$y$", (0.1,2.7,0), NE, fontsize(16));

// 点 P0 和移动后的点 Pt
triple P = (0.8, 0.6, 0);
real t = 1.6;
real alpha = 24 * pi / 180; 
triple e = (cos(alpha), sin(alpha), 0);
triple Pt = P + t*e;

// 绘制虚线直角三角形
triple P_corner = (Pt.x, P.y, 0);
draw(P -- P_corner, gray(0.4)+0.8+dashed);
draw(P_corner -- Pt, gray(0.4)+0.8+dashed);
draw(P -- Pt, heavyred+1.8);

// 绘制单位方向向量 e
draw(P -- P + 0.65*e, royalblue+1.8, arrow=Arrow3());

dot(P, linewidth(6));
dot(Pt, linewidth(6));

label("$P(x_0,y_0)$", P + (-0.2,-0.15,0.05), W, fontsize(16));
label("$P + t\mathbf{e}$", Pt + (0.1,0.1,0.05), NE, fontsize(16));
label("$\mathbf{e}$", P + 0.65*e + (-0.05,0.08,0.02), N, royalblue+fontsize(16));

label("$\Delta x = t\cos\alpha$", (P.x + Pt.x)/2 * X + (P.y - 0.2)*Y, S, fontsize(14));
label("$\Delta y = t\cos\beta$", (Pt.x + 0.1)*X + (P.y + Pt.y)/2 * Y, E, fontsize(14));

// 背景淡色椭圆等值线
for(real a = 0.6; a <= 2.2; a += 0.6) {
  path3 ell;
  for(int i=0; i<=60; ++i) {
    real th = i*2*pi/60;
    ell = (i==0) ? (a*cos(th), 0.7*a*sin(th), 0) : ell--(a*cos(th), 0.7*a*sin(th), 0);
  }
  draw(ell--cycle, gray(0.78)+0.5);
}
