settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

// 换视角：更正面、对称
currentprojection = perspective(4,3.5,3);

// Pi1: y + 0.6z = 0（向后倾斜）
path3 p1 = (-2.0,1.2,-2.0)--(2.0,1.2,-2.0)--(2.0,-1.2,2.0)--(-2.0,-1.2,2.0)--cycle;
draw(surface(p1), lightblue+opacity(0.32));
draw(p1, black+1.0);

// Pi2: y - 0.6z = 0（向前倾斜）
path3 p2 = (-2.0,-1.2,-2.0)--(2.0,-1.2,-2.0)--(2.0,1.2,2.0)--(-2.0,1.2,2.0)--cycle;
draw(surface(p2), lightyellow+opacity(0.32));
draw(p2, black+1.0);

// 交线 L（X 轴，加粗加红）
draw((-2.2,0,0)--(2.2,0,0), red+2.5);

// 交线上一点 M0
triple M0 = (0.6,0,0);
dot(M0, linewidth(8));
label("$M_0$", M0 + 0.15*Z, N, fontsize(22));

// 平面标签（放在各自平面的上方角）
label("$\Pi_1$", (-1.5,1.0,-1.5), N, fontsize(22));
label("$\Pi_2$", (-1.5,-1.0,1.5), N, fontsize(22));

// 直线标签
label("$L$", (1.8,0,0.2), S, fontsize(22));
