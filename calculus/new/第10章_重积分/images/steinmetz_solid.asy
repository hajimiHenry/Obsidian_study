settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;

currentprojection = perspective(3.5,-4.0,2.8);

real R = 2.0;

// 坐标轴
draw((0,0,0)--(R+0.8,0,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,R+0.8,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,R+0.8), black+0.9, arrow=Arrow3());
label("$x$", (R+0.65,-0.05,0), S, fontsize(16));
label("$y$", (0.08,R+0.65,0), NE, fontsize(16));
label("$z$", (0.10,-0.10,R+0.65), E, fontsize(16));

// 绘制左侧面（yOz面上的正方形面）
path3 left_face = (0,0,0)--(0,R,0)--(0,R,R)--(0,0,R)--cycle;
draw(surface(left_face), rgb(0.9,0.9,0.9)+opacity(0.3));
draw(left_face, gray(0.5)+0.5);

// 绘制底面（xOy面上的四分之一圆面）
guide3 bottom_guide;
for(int i=0; i<=45; ++i) {
  real t = 0.5*pi*i/45;
  bottom_guide = (i==0) ? (R*cos(t), R*sin(t), 0) : bottom_guide--(R*cos(t), R*sin(t), 0);
}
path3 bottom_face = (0,0,0)--(R,0,0)--bottom_guide--(0,R,0)--cycle;
draw(surface(bottom_face), rgb(0.8,0.9,1.0)+opacity(0.35));
draw(bottom_face, deepblue+0.8);

// 绘制后侧面（xOz面上的四分之一圆面）
guide3 back_guide;
for(int i=0; i<=45; ++i) {
  real t = 0.5*pi*i/45;
  back_guide = (i==0) ? (R*cos(t), 0, R*sin(t)) : back_guide--(R*cos(t), 0, R*sin(t));
}
path3 back_face = (0,0,0)--(R,0,0)--back_guide--(0,0,R)--cycle;
draw(surface(back_face), rgb(0.8,0.9,1.0)+opacity(0.35));
draw(back_face, deepblue+0.8);

// 交线 y = z = sqrt(R^2 - x^2)
guide3 intersection_line;
for(int i=0; i<=45; ++i) {
  real x = R * i / 45;
  real val = sqrt(max(0, R*R - x*x));
  intersection_line = (i==0) ? (x, val, val) : intersection_line--(x, val, val);
}
draw(intersection_line, heavyred+1.5);
label("交线 $y=z$", (R/2, R*0.86/2, R*0.86/2 + 0.15), N, fontsize(14));

// 绘制两个圆柱表面的网格线
int n_slices = 8;
for(int k=0; k<=n_slices; ++k) {
  real x = R * k / n_slices;
  real limit = sqrt(max(0, R*R - x*x));
  
  // 画 x = x_k 处的正方形截面轮廓
  draw((x, 0, 0)--(x, limit, 0)--(x, limit, limit)--(x, 0, limit)--cycle, gray(0.6)+0.6);
}

// 突出某一个正方形截面（例如 x = 0.4*R）
real xs = 0.4 * R;
real ls = sqrt(R*R - xs*xs);
path3 square_sec = (xs, 0, 0)--(xs, ls, 0)--(xs, ls, ls)--(xs, 0, ls)--cycle;
draw(surface(square_sec), rgb(1.0,0.85,0.5)+opacity(0.6));
draw(square_sec, orange+1.2);
dot((xs, 0, 0), black+linewidth(4));
label("$x$", (xs, -0.05, 0), S, fontsize(14));

// 标出截面正方形的边长
draw((xs, ls, 0.05*ls)--(xs, ls, 0.95*ls), black+0.7, arrow=Arrows3());
label("$\sqrt{R^2-x^2}$", (xs, ls + 0.05, ls/2), E, fontsize(14));

label("截面面积 $A(x) = R^2 - x^2$", (xs + 0.2, ls/2, ls + 0.15), N, fontsize(15));
