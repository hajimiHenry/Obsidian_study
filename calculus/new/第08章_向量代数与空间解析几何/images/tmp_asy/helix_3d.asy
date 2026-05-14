settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4,3,3);

real a = 1.0;
real b = 0.25;
real H = 4*pi*b;

// 螺旋线（两圈）
triple[] helix;
for(int i=0; i<=120; ++i) {
  real t = i*4*pi/120;
  helix.push((a*cos(t), a*sin(t), b*t));
}

// 用 path3 连接
path3 helixPath = helix[0];
for(int i=1; i<helix.length; ++i) {
  helixPath = helixPath--helix[i];
}
draw(helixPath, black+2.0);

// 圆柱面参考（线框）
draw(circle((0,0,0), a, normal=Z), gray+0.8);
draw(circle((0,0,H), a, normal=Z), gray+0.8);
for(int i=0; i<4; ++i) {
  real theta = i*pi/2;
  triple P1 = (a*cos(theta), a*sin(theta), 0);
  triple P2 = (a*cos(theta), a*sin(theta), H);
  draw(P1--P2, gray+0.8);
}

// z轴
draw((0,0,-0.2)--(0,0,H+0.3), gray+0.8);
label("$z$", (0,0,H+0.4), N, fontsize(20));

// 螺距标注
label("$h$", (a+0.3,0,H/2), E, fontsize(22));
