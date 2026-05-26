settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(700);
import three;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(4.5, -4.5, 3.2);

// 坐标轴
draw((-1.5,0,0)--(1.8,0,0), black+0.8, arrow=Arrow3());
draw((0,-1.5,0)--(0,1.8,0), black+0.8, arrow=Arrow3());
draw((0,0,-0.2)--(0,0,1.8), black+0.8, arrow=Arrow3());
label("$x$", (1.7,-0.1,0), S, fontsize(15));
label("$y$", (0.1,1.7,0), NE, fontsize(15));
label("$z$", (0.1,-0.1,1.7), E, fontsize(15));

// 定义曲面
real f(real x, real y) { return 1.2 - 0.45*(x*x + y*y); }
triple S(real x, real y) { return (x, y, f(x,y)); }

// 投影闭区域 D (圆面 x^2+y^2 <= 1)
path3 boundary;
for(int i=0; i<=60; ++i) {
  real th = i*2*pi/60;
  boundary = (i==0) ? (cos(th), sin(th), 0) : boundary--(cos(th), sin(th), 0);
}
draw(surface(boundary--cycle), lightblue+opacity(0.18));
draw(boundary--cycle, royalblue+1.2);
label("$D$", (0.45,-0.45,0), SE, royalblue+fontsize(16));

// 绘制在 D 上的曲面网格线
int num_r = 5;
int num_th = 24;
for(int i=0; i<=num_r; ++i) {
  real r = i/num_r;
  path3 circle_wire;
  for(int j=0; j<=num_th; ++j) {
    real th = j*2*pi/num_th;
    circle_wire = (j==0) ? S(r*cos(th), r*sin(th)) : circle_wire--S(r*cos(th), r*sin(th));
  }
  draw(circle_wire, gray(0.55)+0.5);
}
for(int j=0; j<num_th; ++j) {
  real th = j*2*pi/num_th;
  draw(S(0,0)--S(cos(th),sin(th)), gray(0.55)+0.5);
}

// 内部驻点
triple P_in_flat = (0.15, -0.1, 0); 
triple P_in_surf = S(P_in_flat.x, P_in_flat.y);
draw(P_in_flat -- P_in_surf, heavyred+0.8+dashed);
dot(P_in_flat, heavyred+6);
dot(P_in_surf, heavyred+6);
label("内部驻点", P_in_flat + (0.02, -0.05, 0.05), S, heavyred+fontsize(14));

// 边界候选点
real[] b_angles = {0.0, pi/2, pi, -pi/2};
for(real th : b_angles) {
  triple Pb_flat = (cos(th), sin(th), 0);
  triple Pb_surf = S(cos(th), sin(th));
  draw(Pb_flat -- Pb_surf, heavygreen+0.8+dashed);
  dot(Pb_flat, heavygreen+5);
  dot(Pb_surf, heavygreen+5);
}
label("边界候选点", (cos(0.0), sin(0.0), 0) + (0.1, 0.1, 0.05), E, heavygreen+fontsize(14));
label("区域最值候选点", (0, 0, 1.45), N, fontsize(16));
