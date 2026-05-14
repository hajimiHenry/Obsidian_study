settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(5,4,3);

// 直线方向
triple sDir = unit((1.5,0.1,0.2));

// 直线上一点 M0
triple M0 = (0,0,0);

// 直线上另一点 M
triple M = M0 + 3.0*sDir;

// 直线的两端
triple L1 = M0 - 2.0*sDir;
triple L2 = M0 + 4.5*sDir;

// 画直线 L
draw(L1--L2, black+2.0);

// 方向向量 s（从 M0 出发，红色短箭头）
triple sTip = M0 + 0.8*sDir;
draw(M0--sTip, red+2.2, arrow=Arrow3());
label("$\mathbf{s}$", sTip + 0.35*Y + 0.15*Z, N, fontsize(22));

// 向量 M0M（从 M0 到 M，蓝色箭头）
draw(M0--M, blue+1.8, arrow=Arrow3());

// 点 M0
dot(M0, linewidth(8));
label("$M_0$", M0 - 0.35*X - 0.25*Y, S, fontsize(22));

// 点 M
dot(M, linewidth(8));
label("$M$", M + 0.3*Y + 0.1*Z, N, fontsize(22));

// 直线标签
label("$L$", L2 + 0.3*X + 0.1*Y, E, fontsize(22));
