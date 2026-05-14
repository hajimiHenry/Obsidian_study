settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

// 换视角：让 Y 轴在投影中更接近竖直方向
currentprojection = perspective(5,1.5,4);

// Pi1: y = 0 (xOz 平面)，画大一点
path3 p1 = (-2.0,0,-1.5)--(2.0,0,-1.5)--(2.0,0,1.5)--(-2.0,0,1.5)--cycle;
draw(surface(p1), lightblue+opacity(0.35));
draw(p1, black+1.2);

// Pi2: y = z  (与 Pi1 成 45°)，也画大一点
path3 p2 = (-2.0,-1.2,-1.2)--(2.0,-1.2,-1.2)--(2.0,1.2,1.2)--(-2.0,1.2,1.2)--cycle;
draw(surface(p2), lightyellow+opacity(0.35));
draw(p2, black+1.2);

// 交线 X 轴
draw((-2.2,0,0)--(2.2,0,0), black+1.5);

// 法向量都从原点出发，方向在投影中更易辨认
triple O = (0,0,0);

// n1 = (0,1,0)
triple t1 = O + 1.5*Y;
draw(O--t1, red+2.2, arrow=Arrow3());
label("$\mathbf{n}_1$", t1 + 0.2*Y, N, fontsize(24));

// n2 = unit((0,1,-1))
triple t2 = O + 1.5*unit((0,1,-1));
draw(O--t2, red+2.2, arrow=Arrow3());
label("$\mathbf{n}_2$", t2 + 0.2*Y + 0.15*X, SE, fontsize(24));

// 平面标签
label("$\Pi_1$", (-1.8,0,1.2), N, fontsize(22));
label("$\Pi_2$", (-1.5,1.0,0.8), N, fontsize(22));

// 夹角 theta（放在两法向量之间靠近原点，字号放大）
label("$\theta$", (0.2,0.7,0.1), N, fontsize(24));
