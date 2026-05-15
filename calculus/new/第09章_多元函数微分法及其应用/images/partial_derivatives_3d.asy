settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4.6,-5.4,3.5);

real f(real x, real y) { return 0.20*x*x + 0.14*y*y + 0.16*x*y + 0.42; }
triple S(real x, real y) { return (x,y,f(x,y)); }

real x0 = 0.42;
real y0 = 0.28;
real z0 = f(x0,y0);
real fx = 0.40*x0 + 0.16*y0;
real fy = 0.28*y0 + 0.16*x0;
triple P = (x0,y0,z0);

draw((-1.45,0,0)--(1.65,0,0), black+0.9, arrow=Arrow3());
draw((0,-1.35,0)--(0,1.55,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,1.58), black+1.0, arrow=Arrow3());
label("$x$", (1.48,-0.04,0), S, fontsize(20));
label("$y$", (0.08,1.50,0.08), NE, fontsize(20));
label("$z$", (0.24,-0.16,1.42), E, fontsize(20));

// 只画稀疏网格，避免曲面线条抢走截线信息。
for(int i=-4; i<=4; ++i) {
  real x = i*0.26;
  guide3 g;
  for(int j=-36; j<=36; ++j) {
    real y = j*1.08/36;
    g = (j==-36) ? S(x,y) : g--S(x,y);
  }
  draw(g, gray(0.58)+0.45);
}
for(int j=-4; j<=4; ++j) {
  real y = j*0.26;
  guide3 g;
  for(int i=-36; i<=36; ++i) {
    real x = i*1.08/36;
    g = (i==-36) ? S(x,y) : g--S(x,y);
  }
  draw(g, gray(0.58)+0.45);
}

// 用 xy 平面上的固定变量轨迹提示截线，避免半透明竖墙遮挡曲面。
draw((x0-0.76,y0,0)--(x0+0.76,y0,0), red+1.0);
draw((x0,y0-0.72,0)--(x0,y0+0.72,0), blue+1.0);
draw((x0-0.64,y0,0)--S(x0-0.64,y0), red+0.45);
draw((x0+0.64,y0,0)--S(x0+0.64,y0), red+0.45);
draw((x0,y0-0.60,0)--S(x0,y0-0.60), blue+0.45);
draw((x0,y0+0.60,0)--S(x0,y0+0.60), blue+0.45);

guide3 cx;
for(int i=-50; i<=50; ++i) {
  real x = x0 + i*0.72/50;
  cx = (i==-50) ? S(x,y0) : cx--S(x,y0);
}
draw(cx, heavyred+1.7);

guide3 cy;
for(int j=-50; j<=50; ++j) {
  real y = y0 + j*0.68/50;
  cy = (j==-50) ? S(x0,y) : cy--S(x0,y);
}
draw(cy, deepblue+1.7);

triple tx1 = P + (-0.42,0,-0.42*fx);
triple tx2 = P + ( 0.42,0, 0.42*fx);
triple ty1 = P + (0,-0.42,-0.42*fy);
triple ty2 = P + (0, 0.42, 0.42*fy);
draw(tx1--tx2, red+2.1);
draw(ty1--ty2, blue+2.1);

dot(P, linewidth(7));
label("$P$", P+(0.08,0.07,0.05), E, fontsize(22));
label("$y=y_0$", (x0-0.74,y0,0.08), SW, red+fontsize(18));
label("$x=x_0$", (x0,y0+0.72,0.08), E, blue+fontsize(18));
label("$f_x(x_0,y_0)$", tx1+(-0.08,-0.02,0.04), W, red+fontsize(18));
label("$f_y(x_0,y_0)$", ty2+(0.07,0.05,0.10), NE, blue+fontsize(18));
