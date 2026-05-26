settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;

currentprojection = perspective(5.0,-6.0,3.0);

real R = 2.0;
real d = 4.0; // 卫星距离球心的距离
real alpha = pi/3; // 60度, cos(alpha) = R/d = 2/4 = 0.5

// 坐标轴
draw((-2.5,0,0)--(2.8,0,0), black+0.9, arrow=Arrow3());
draw((0,-2.5,0)--(0,2.8,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,4.8), black+0.9, arrow=Arrow3());
label("$x$", (2.65,-0.05,0), S, fontsize(16));
label("$y$", (0.05,2.65,0), NE, fontsize(16));
label("$z$", (0.05,-0.05,4.65), E, fontsize(16));

// 绘制地球球体网格线 (R=2)
int n_lat = 8;
int n_long = 12;
for(int i=0; i<n_long; ++i) {
  real theta = 2*pi*i/n_long;
  guide3 long_line;
  for(int j=0; j<=36; ++j) {
    real phi = pi * j/36;
    triple p = (R*sin(phi)*cos(theta), R*sin(phi)*sin(theta), R*cos(phi));
    long_line = (j==0) ? p : long_line--p;
  }
  draw(long_line, gray(0.7)+0.45);
}
for(int j=1; j<n_lat; ++j) {
  real phi = pi * j/n_lat;
  real r_lev = R*sin(phi);
  real z_lev = R*cos(phi);
  guide3 lat_line;
  for(int i=0; i<=72; ++i) {
    real theta = 2*pi*i/72;
    lat_line = (i==0) ? (r_lev*cos(theta), r_lev*sin(theta), z_lev) : lat_line--(r_lev*cos(theta), r_lev*sin(theta), z_lev);
  }
  draw(lat_line, gray(0.7)+0.45);
}

// 填充整个地球 (极淡的蓝色)
for(int i=0; i<36; ++i) {
  real t1 = 2*pi*i/36;
  real t2 = 2*pi*(i+1)/36;
  for(int j=0; j<18; ++j) {
    real p1 = pi * j/18;
    real p2 = pi * (j+1)/18;
    triple pt11 = (R*sin(p1)*cos(t1), R*sin(p1)*sin(t1), R*cos(p1));
    triple pt12 = (R*sin(p2)*cos(t1), R*sin(p2)*sin(t1), R*cos(p2));
    triple pt21 = (R*sin(p1)*cos(t2), R*sin(p1)*sin(t2), R*cos(p1));
    triple pt22 = (R*sin(p2)*cos(t2), R*sin(p2)*sin(t2), R*cos(p2));
    path3 quad = pt11--pt12--pt22--pt21--cycle;
    draw(surface(quad), rgb(0.85,0.92,1.0)+opacity(0.18));
  }
}

// 卫星点 P0
triple P0 = (0,0,d);
dot(P0, heavyred+linewidth(7));
label("卫星 $P_0(0,0,d)$", P0 + (0.15,0,0.1), E, fontsize(15));

// 切线圆半径与高度
real r_int = R * sin(alpha); // sqrt(3)
real z_int = R * cos(alpha); // 1.0

// 绘制从卫星到切点圆的切线光束
int n_tangents = 12;
for(int i=0; i<n_tangents; ++i) {
  real t = 2*pi*i/n_tangents;
  triple pt = (r_int*cos(t), r_int*sin(t), z_int);
  draw(P0--pt, orange+0.7);
}

// 绘制切点圆周
guide3 tangent_circle;
for(int i=0; i<=60; ++i) {
  real t = 2*pi*i/60;
  tangent_circle = (i==0) ? (r_int*cos(t), r_int*sin(t), z_int) : tangent_circle--(r_int*cos(t), r_int*sin(t), z_int);
}
draw(tangent_circle--cycle, black+1.2);

// 用较深蓝色突出填充覆盖的球冠 (z >= z_int, 即 phi <= alpha)
for(int i=0; i<36; ++i) {
  real t1 = 2*pi*i/36;
  real t2 = 2*pi*(i+1)/36;
  for(int j=0; j<6; ++j) {
    real p1 = alpha * j/6;
    real p2 = alpha * (j+1)/6;
    triple pt11 = (R*sin(p1)*cos(t1), R*sin(p1)*sin(t1), R*cos(p1));
    triple pt12 = (R*sin(p2)*cos(t1), R*sin(p2)*sin(t1), R*cos(p2));
    triple pt21 = (R*sin(p1)*cos(t2), R*sin(p1)*sin(t2), R*cos(p1));
    triple pt22 = (R*sin(p2)*cos(t2), R*sin(p2)*sin(t2), R*cos(p2));
    path3 quad = pt11--pt12--pt22--pt21--cycle;
    draw(surface(quad), rgb(0.2,0.6,1.0)+opacity(0.55));
  }
}

// 球冠的纬线和经线网格
for(int i=0; i<n_long; ++i) {
  real theta = 2*pi*i/n_long;
  guide3 long_line;
  for(int j=0; j<=15; ++j) {
    real phi = alpha * j/15;
    triple p = (R*sin(phi)*cos(theta), R*sin(phi)*sin(theta), R*cos(phi));
    long_line = (j==0) ? p : long_line--p;
  }
  draw(long_line, blue+0.7);
}

// 标出球心到切点之一的半径，并标出角度 alpha
triple Q = (r_int, 0, z_int);
draw((0,0,0)--Q, black+1.0);
draw(Q--P0, heavyred+1.2); // 切线
dot(Q, black+linewidth(4));

// 在 Q 处画直角符号 (OQ 与 QP0 垂直)
real s = 0.15;
triple u_OQ = unit(Q);
triple u_QP0 = unit(P0-Q);
draw((Q - s*u_OQ)--(Q - s*u_OQ + s*u_QP0)--(Q + s*u_QP0), black+0.8);

// 角度 alpha 的弧
guide3 alpha_arc;
for(int i=0; i<=20; ++i) {
  real phi = alpha * i/20;
  alpha_arc = (i==0) ? (0.5*sin(phi), 0, 0.5*cos(phi)) : alpha_arc--(0.5*sin(phi), 0, 0.5*cos(phi));
}
draw(alpha_arc, black+0.8);
label("$\alpha$", (0.16, 0, 0.62), N, fontsize(14));

// 标注
label("地球半径 $R$", Q/2, SE, fontsize(13));
label("球冠高度 $h$", (0, 0, 3.0), W, fontsize(13));
label("覆盖球冠面积 $A$", (0.8, -0.8, 1.7), E, fontsize(14));
