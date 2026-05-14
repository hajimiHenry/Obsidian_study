settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4,2.5,3.5);

// 平面 z=0 上一片区域
triple A = (-2.2,-1.5,0);
triple B = ( 2.4,-1.3,0);
triple C = ( 2.2, 1.8,0);
triple D = (-2.0, 2.0,0);
path3 planePath = A--B--C--D--cycle;
draw(surface(planePath), lightblue+opacity(0.35));
draw(planePath, black+1.2);

// 平面上一点 M0
triple M0 = (0,0,0);

// 平面上另一点 M（沿 X 轴方向，让直角符在投影中可见）
triple M = (1.6,0,0);

// 法向量 n（从 M0 出发垂直向上）
triple nTip = M0 + 2.0*Z;
draw(M0--nTip, red+2.2, arrow=Arrow3());
label("$\mathbf{n}$", nTip + 0.3*X + 0.2*Y, NE, fontsize(24));

// 平面内向量 M0M（沿 X 轴，水平）
draw(M0--M, darkgreen+1.8, arrow=Arrow3());
label("$M$", M + 0.25*X, E, fontsize(24));

// 点 M0（大点、后画）
dot(M0, linewidth(10));
label("$M_0$", M0 + 0.25*X + 0.3*Y, SW, fontsize(24));

// 直角符号：沿 X 轴和 Z 轴，长度 0.35
triple a1 = M0 + 0.35*X;
triple b1 = M0 + 0.35*Z;
draw(M0--a1, black+1.5);
draw(M0--b1, black+1.5);

// 平面标签
label("$\Pi$", C + 0.25*Z + 0.25*Y, N, fontsize(24));
