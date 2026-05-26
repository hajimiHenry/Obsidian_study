settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;

currentprojection = perspective(4.5,-5.5,3.5);

// 顶面曲面方程
real f(real x, real y) { return 2.0 - 0.3*x*x - 0.2*y*y; }
triple P(real x, real y, real z) { return (x,y,z); }
triple S(real x, real y) { return (x,y,f(x,y)); }

// 画坐标轴
draw((-1.8,0,0)--(2.2,0,0), black+0.9, arrow=Arrow3());
draw((0,-1.5,0)--(0,1.8,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,2.5), black+0.9, arrow=Arrow3());
label("$x$", (2.05,-0.05,0), S, fontsize(16));
label("$y$", (0.08,1.65,0), NE, fontsize(16));
label("$z$", (0.10,-0.10,2.35), E, fontsize(16));

// 绘制底面椭圆
real rx = 1.5;
real ry = 1.0;
guide3 base;
for(int i=0; i<=72; ++i) {
  real t = 2*pi*i/72;
  base = (i==0) ? (rx*cos(t), ry*sin(t), 0) : base--(rx*cos(t), ry*sin(t), 0);
}
path3 D = base--cycle;
draw(surface(D), rgb(0.78,0.88,1.0)+opacity(0.4));
draw(D, deepblue+1.2);
label("$D$", (0.7,-0.5,0), fontsize(17));

// 绘制顶面网格线
int nx = 12;
int ny = 10;
for(int i=-nx; i<=nx; ++i) {
  real x = rx * i / nx;
  guide3 g;
  bool started = false;
  for(int j=-40; j<=40; ++j) {
    real y = ry * j / 40;
    if((x/rx)*(x/rx) + (y/ry)*(y/ry) <= 1.001) {
      if(!started) { g = S(x,y); started = true; }
      else g = g--S(x,y);
    }
  }
  if(started) draw(g, orange+0.65);
}
for(int j=-ny; j<=ny; ++j) {
  real y = ry * j / ny;
  guide3 g;
  bool started = false;
  for(int i=-40; i<=40; ++i) {
    real x = rx * i / 40;
    if((x/rx)*(x/rx) + (y/ry)*(y/ry) <= 1.001) {
      if(!started) { g = S(x,y); started = true; }
      else g = g--S(x,y);
    }
  }
  if(started) draw(g, orange+0.65);
}

// 顶面外边缘线
guide3 top_edge;
for(int i=0; i<=72; ++i) {
  real t = 2*pi*i/72;
  top_edge = (i==0) ? S(rx*cos(t), ry*sin(t)) : top_edge--S(rx*cos(t), ry*sin(t));
}
draw(top_edge--cycle, orange+1.3);

// 绘制侧母线（从底面到顶面）
for(int i=0; i<12; ++i) {
  real t = 2*pi*i/12;
  triple b = (rx*cos(t), ry*sin(t), 0);
  triple tp = S(rx*cos(t), ry*sin(t));
  draw(b--tp, gray(0.55)+0.5+dashed);
}

label("$z=f(x,y)$", S(0.3, 0.4), NE, fontsize(16));
