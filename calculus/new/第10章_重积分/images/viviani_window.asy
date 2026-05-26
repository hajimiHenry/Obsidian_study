settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;

currentprojection = perspective(4.0,-5.0,3.5);

// 坐标轴
draw((-0.5,0,0)--(2.8,0,0), black+0.9, arrow=Arrow3());
draw((0,-2.3,0)--(0,2.3,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,2.6), black+0.9, arrow=Arrow3());
label("$x$", (2.65,-0.05,0), S, fontsize(16));
label("$y$", (0.08,2.15,0), NE, fontsize(16));
label("$z$", (0.10,-0.10,2.45), E, fontsize(16));

// 绘制球体赤道圆
guide3 equator;
for(int i=0; i<=72; ++i) {
  real t = 2*pi*i/72;
  equator = (i==0) ? (2*cos(t), 2*sin(t), 0) : equator--(2*cos(t), 2*sin(t), 0);
}
draw(equator--cycle, gray(0.6)+0.6+dashed);

// 绘制球体的大致子午线（z>0 部分）
guide3 meridian_x;
for(int i=0; i<=36; ++i) {
  real t = pi*i/36;
  meridian_x = (i==0) ? (2*cos(t), 0, 2*sin(t)) : meridian_x--(2*cos(t), 0, 2*sin(t));
}
draw(meridian_x, gray(0.6)+0.6+dashed);

guide3 meridian_y;
for(int i=0; i<=36; ++i) {
  real t = pi*i/36;
  meridian_y = (i==0) ? (0, 2*cos(t), 2*sin(t)) : meridian_y--(0, 2*cos(t), 2*sin(t));
}
draw(meridian_y, gray(0.6)+0.6+dashed);

// 绘制圆柱的底面圆 (x-1)^2 + y^2 = 1
guide3 cyl_base_guide;
for(int i=0; i<=72; ++i) {
  real t = 2*pi*i/72;
  cyl_base_guide = (i==0) ? (1+cos(t), sin(t), 0) : cyl_base_guide--(1+cos(t), sin(t), 0);
}
path3 cyl_base = cyl_base_guide--cycle;
draw(surface(cyl_base), rgb(0.85,0.92,1.0)+opacity(0.3));
draw(cyl_base, deepblue+1.2);
label("$D$", (1.2,0.4,0), fontsize(16));

// 绘制 Viviani 曲线 (z >= 0)
// x = 1 + cos(t), y = sin(t), z = 2*sin(t/2)
guide3 viviani;
for(int i=0; i<=90; ++i) {
  real t = 2*pi*i/90;
  viviani = (i==0) ? (1+cos(t), sin(t), 2*sin(t/2)) : viviani--(1+cos(t), sin(t), 2*sin(t/2));
}
draw(viviani, heavyred+1.6);
label("Viviani 曲线", (1.0, 0.2, 1.8), N, fontsize(14));

// 绘制立体侧面的垂直母线
int n_lines = 16;
for(int i=0; i<n_lines; ++i) {
  real t = 2*pi*i/n_lines;
  triple b = (1+cos(t), sin(t), 0);
  triple tp = (1+cos(t), sin(t), 2*sin(t/2));
  draw(b--tp, gray(0.42)+0.6+dashed);
}

// 绘制被截得的立体顶部的球冠面网格线
int n_rays = 12;
for(int i=0; i<n_rays; ++i) {
  real theta = -0.5*pi + pi*i/n_rays;
  real r_max = 2*cos(theta);
  guide3 ray;
  bool started = false;
  for(int j=0; j<=20; ++j) {
    real r = r_max * j/20;
    real x = r*cos(theta);
    real y = r*sin(theta);
    real z = sqrt(max(0, 4 - r*r));
    if(!started) { ray = (x,y,z); started = true; }
    else ray = ray--(x,y,z);
  }
  draw(ray, orange+0.6);
}

int n_rings = 6;
for(int j=1; j<=n_rings; ++j) {
  real r = 2.0 * j/n_rings;
  guide3 ring;
  bool started = false;
  for(int i=0; i<=60; ++i) {
    real theta = -0.5*pi + pi*i/60;
    if(r <= 2*cos(theta)) {
      real x = r*cos(theta);
      real y = r*sin(theta);
      real z = sqrt(max(0, 4 - r*r));
      if(!started) { ring = (x,y,z); started = true; }
      else ring = ring--(x,y,z);
    }
  }
  if(started) draw(ring, orange+0.6);
}

label("球顶面 $z=\sqrt{4-x^2-y^2}$", (0.5, -0.6, 1.6), W, fontsize(14));
label("圆柱面 $x^2+y^2=2x$", (1.9, 0.9, 0.6), E, fontsize(14));
