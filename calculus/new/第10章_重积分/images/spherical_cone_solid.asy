settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;

currentprojection = perspective(3.5,-4.5,2.5);

real alpha = pi/6; // 30 度

// 坐标轴
draw((-1.0,0,0)--(1.3,0,0), black+0.9, arrow=Arrow3());
draw((0,-1.0,0)--(0,1.3,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,2.5), black+0.9, arrow=Arrow3());
label("$x$", (1.20,-0.05,0), S, fontsize(16));
label("$y$", (0.05,1.15,0), NE, fontsize(16));
label("$z$", (0.05,-0.05,2.35), E, fontsize(16));

// 绘制整个球面作背景参考（非常淡）
guide3 sph_circ_x;
for(int i=0; i<=72; ++i) {
  real t = 2*pi*i/72;
  sph_circ_x = (i==0) ? (0, sin(t), 1+cos(t)) : sph_circ_x--(0, sin(t), 1+cos(t));
}
draw(sph_circ_x, gray(0.7)+0.5+dashed);

guide3 sph_circ_y;
for(int i=0; i<=72; ++i) {
  real t = 2*pi*i/72;
  sph_circ_y = (i==0) ? (sin(t), 0, 1+cos(t)) : sph_circ_y--(sin(t), 0, 1+cos(t));
}
draw(sph_circ_y, gray(0.7)+0.5+dashed);

// 绘制锥面与球面的交线圆
real r_int = sqrt(3); // 2*cos(pi/6)
real z_int = 1.5;
real rho_int = r_int * sin(alpha);
guide3 int_circle;
for(int i=0; i<=60; ++i) {
  real t = 2*pi*i/60;
  int_circle = (i==0) ? (rho_int*cos(t), rho_int*sin(t), z_int) : int_circle--(rho_int*cos(t), rho_int*sin(t), z_int);
}
draw(int_circle--cycle, black+1.2);

// 填充锥面
int n_rays = 16;
for(int i=0; i<n_rays; ++i) {
  real t = 2*pi*i/n_rays;
  triple tip = (rho_int*cos(t), rho_int*sin(t), z_int);
  draw((0,0,0)--tip, gray(0.55)+0.6);
}

// 填充顶部的球冠面网格线
int n_lat = 4;
int n_long = 12;
for(int i=0; i<n_long; ++i) {
  real theta = 2*pi*i/n_long;
  guide3 long_line;
  for(int j=0; j<=20; ++j) {
    real phi = alpha * j/20;
    real r = 2*cos(phi);
    triple p = (r*sin(phi)*cos(theta), r*sin(phi)*sin(theta), r*cos(phi));
    long_line = (j==0) ? p : long_line--p;
  }
  draw(long_line, orange+0.65);
}
for(int j=1; j<=n_lat; ++j) {
  real phi = alpha * j/n_lat;
  real r = 2*cos(phi);
  real rho = r*sin(phi);
  real z = r*cos(phi);
  guide3 lat_line;
  for(int i=0; i<=60; ++i) {
    real theta = 2*pi*i/60;
    lat_line = (i==0) ? (rho*cos(theta), rho*sin(theta), z) : lat_line--(rho*cos(theta), rho*sin(theta), z);
  }
  draw(lat_line, orange+0.65);
}

// 绘制锥体部分的半透明填充
for(int i=0; i<36; ++i) {
  real t1 = 2*pi*i/36;
  real t2 = 2*pi*(i+1)/36;
  triple p1 = (rho_int*cos(t1), rho_int*sin(t1), z_int);
  triple p2 = (rho_int*cos(t2), rho_int*sin(t2), z_int);
  path3 tri = (0,0,0)--p1--p2--cycle;
  draw(surface(tri), rgb(0.9,0.85,0.7)+opacity(0.35));
}

// 填充球冠
for(int i=0; i<36; ++i) {
  real t1 = 2*pi*i/36;
  real t2 = 2*pi*(i+1)/36;
  for(int j=0; j<10; ++j) {
    real p1 = alpha * j/10;
    real p2 = alpha * (j+1)/10;
    
    real r11 = 2*cos(p1), r12 = 2*cos(p2);
    triple pt11 = (r11*sin(p1)*cos(t1), r11*sin(p1)*sin(t1), r11*cos(p1));
    triple pt12 = (r12*sin(p2)*cos(t1), r12*sin(p2)*sin(t1), r12*cos(p2));
    triple pt21 = (r11*sin(p1)*cos(t2), r11*sin(p1)*sin(t2), r11*cos(p1));
    triple pt22 = (r12*sin(p2)*cos(t2), r12*sin(p2)*sin(t2), r12*cos(p2));
    
    path3 quad = pt11--pt12--pt22--pt21--cycle;
    draw(surface(quad), rgb(0.78,0.88,1.0)+opacity(0.5));
  }
}

// 标示角度 phi = alpha
draw((0,0,0)--(r_int*sin(alpha), 0, r_int*cos(alpha)), heavyred+1.1);
guide3 angle_arc;
for(int i=0; i<=20; ++i) {
  real phi = alpha * i/20;
  angle_arc = (i==0) ? (0.4*sin(phi), 0, 0.4*cos(phi)) : angle_arc--(0.4*sin(phi), 0, 0.4*cos(phi));
}
draw(angle_arc, black+0.8);
label("$\alpha$", (0.12, 0, 0.48), fontsize(14));

// 画出代表性向径 r 及其夹角 phi
real p_rep = 0.5 * alpha;
real r_rep = 2*cos(p_rep);
triple M = (r_rep*sin(p_rep)*cos(0), r_rep*sin(p_rep)*sin(0), r_rep*cos(p_rep));
draw((0,0,0)--M, blue+1.2, arrow=Arrow3());
dot(M, blue+linewidth(4));
label("$r$", M/2, SE, fontsize(14));
label("$\varphi$", (0.18*sin(p_rep/2), 0, 0.18*cos(p_rep/2)), N, fontsize(12));

label("球面 $r=2a\cos\varphi$", (0.4, 0, 1.8), E, fontsize(14));
label("锥面 $\varphi=\alpha$", (0.8, 0, 0.9), SE, fontsize(14));
