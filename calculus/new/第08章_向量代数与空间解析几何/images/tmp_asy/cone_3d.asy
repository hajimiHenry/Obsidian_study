settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4,3,3);

// 圆锥：顶点在原点，轴为 z 轴
triple V = (0,0,0);
real H = 2.0;
real R = 1.2;

// 底面圆（z=H）
draw(circle((0,0,H), R, normal=Z), black+1.0);

// 母线（从顶点到底面圆周均匀分布）
for(int i=0; i<6; ++i) {
  real theta = i*pi/3;
  triple P = (R*cos(theta), R*sin(theta), H);
  draw(V--P, black+0.9);
}

// 轴
draw(V--(0,0,H+0.3), gray+0.8);
label("$z$", (0,0,H+0.4), N, fontsize(20));

// 顶点
dot(V, linewidth(6));
label("$O$", V, S, fontsize(22));

// 半顶角 alpha 标注
label("$\alpha$", (0.25,0.1,H*0.35), E, fontsize(22));
