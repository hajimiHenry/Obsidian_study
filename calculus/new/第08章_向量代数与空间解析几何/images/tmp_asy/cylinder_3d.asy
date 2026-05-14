settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4,3,3);

real R = 1.2;
real H1 = -1.0;
real H2 = 1.0;

// 上下底面圆
draw(circle((0,0,H1), R, normal=Z), black+1.0);
draw(circle((0,0,H2), R, normal=Z), black+1.0);

// 母线
for(int i=0; i<4; ++i) {
  real theta = i*pi/2;
  triple P1 = (R*cos(theta), R*sin(theta), H1);
  triple P2 = (R*cos(theta), R*sin(theta), H2);
  draw(P1--P2, black+0.9);
}

// 轴
draw((0,0,H1-0.2)--(0,0,H2+0.2), gray+0.8);
label("$z$", (0,0,H2+0.3), N, fontsize(20));

// 方程标签
label("$x^2+y^2=R^2$", (R+0.3,0,(H1+H2)/2), E, fontsize(20));
