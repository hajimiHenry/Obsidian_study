settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(600);
import three;

texpreamble("\usepackage{ctex}");

// 视角：右上俯视，配合 1:1:1 匀称比例
currentprojection = perspective(3.0, 2.5, 2.2);

// 坐标轴 (各轴尺度控制在 [-2, 2] 左右，高宽比完美 1:1)
draw((-1.8,0,0)--(2.2,0,0), black+0.8, arrow=Arrow3());
draw((0,-1.8,0)--(0,2.2,0), black+0.8, arrow=Arrow3());
draw((0,0,-2.5)--(0,0,2.7), black+0.8, arrow=Arrow3());
label("$x$", (2.3,0,0), fontsize(14));
label("$y$", (0,2.3,0), fontsize(14));
label("$z$", (0,0,2.9), fontsize(14));

// 1. 绘制红色的单位圆柱面骨架 (z 范围 [-2.2, 2.2])
path3 bot_circle;
for(int i=0; i<=100; ++i) {
  real th = i * 2 * pi / 100;
  bot_circle = (i==0) ? (cos(th), sin(th), -2.2) : bot_circle--(cos(th), sin(th), -2.2);
}
draw(bot_circle--cycle, red+1.0);

path3 top_circle;
for(int i=0; i<=100; ++i) {
  real th = i * 2 * pi / 100;
  top_circle = (i==0) ? (cos(th), sin(th), 2.2) : top_circle--(cos(th), sin(th), 2.2);
}
draw(top_circle--cycle, red+1.0);

// 绘制纵向母线 (使用更细且淡的红色虚线，作为骨架辅助线)
for(int i=0; i<8; ++i) {
  real th = i * 2 * pi / 8;
  draw((cos(th), sin(th), -2.2)--(cos(th), sin(th), 2.2), red+0.4+dashed);
}
label("约束圆柱面 $x^2+y^2=1$", (1.05, -0.3, -2.2), SE, red+fontsize(11));

// 2. 目标函数 z = 1.2x + 0.9y 的倾斜平面 (投影为圆形的椭圆盘，避免尖角破坏构图)
path3 plane_circle;
real r_p = 1.28;
for(int i=0; i<=100; ++i) {
  real th = i * 2 * pi / 100;
  plane_circle = (i==0) ? (r_p*cos(th), r_p*sin(th), 1.2*r_p*cos(th) + 0.9*r_p*sin(th)) : plane_circle--(r_p*cos(th), r_p*sin(th), 1.2*r_p*cos(th) + 0.9*r_p*sin(th));
}
draw(surface(plane_circle--cycle), lightblue+opacity(0.35));
draw(plane_circle--cycle, lightblue+0.8);
label("目标平面 $z=1.2x+0.9y$", (1.02, 0.77, 1.92) + (0, 0, 0.25), N, fontsize(12));

// 3. 平面和圆柱的绿色交线 (空间椭圆)
path3 intersection;
for(int i=0; i<=100; ++i) {
  real th = i * 2 * pi / 100;
  intersection = (i==0) ? (cos(th), sin(th), 1.2*cos(th)+0.9*sin(th)) : intersection--(cos(th), sin(th), 1.2*cos(th)+0.9*sin(th));
}
draw(intersection--cycle, heavygreen+2.2);

// 4. 平面上的等值虚线段
real[] cs = {-1.2, -0.9, -0.6, -0.3, 0.0, 0.3, 0.6, 0.9, 1.2};
for(real c : cs) {
  real d = c / 1.5;
  real disc = 1.0 - d^2;
  if(disc >= 0) {
    real sq = sqrt(disc);
    real x1 = (4*d + 3*sq)/5;
    real y1 = (d - 0.8*x1)/0.6;
    real x2 = (4*d - 3*sq)/5;
    real y2 = (d - 0.8*x2)/0.6;
    draw((x1, y1, c)--(x2, y2, c), gray(0.5)+0.7+dashed);
  }
}

// 5. 标注最高点与最低点 (在最后进行点绘制)
triple P_max = (0.8, 0.6, 1.5);
triple P_min = (-0.8, -0.6, -1.5);

dot(P_max, red+linewidth(7.5));
dot(P_min, blue+linewidth(7.5));

label("$\max=1.5$", P_max + (0.05, 0.05, 0.08), NE, red+fontsize(13));
label("$\min=-1.5$", P_min + (-0.05, -0.05, -0.08), SW, blue+fontsize(13));
