settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4.5,3,2.5);

// 平面 z=0
triple A = (-2.0,-1.5,0);
triple B = ( 2.2,-1.3,0);
triple C = ( 2.0, 1.8,0);
triple D = (-1.8, 1.6,0);
path3 planePath = A--B--C--D--cycle;
draw(surface(planePath), lightblue+opacity(0.35));
draw(planePath, black+1.2);

// 交点 P（直线穿过平面的点）
triple P = (0,0,0);

// 直线 L（斜穿平面，沿 (0.5,0,1) 方向）
triple lDir = unit((0.6,0,1));
triple L_top = P + 2.2*lDir;
triple L_bot = P - 1.5*lDir;
draw(L_bot--L_top, black+2.2);

// 投影直线 L'（在平面内，沿 (0.6,0,0) 方向）
triple lProj = unit((0.6,0,0));
triple Lp_end = P + 2.0*lProj;
triple Lp_start = P - 1.2*lProj;
draw(Lp_start--Lp_end, darkblue+2.0);

// 法向量 n
triple nBase = (1.2,1.0,0);
triple nTip  = nBase + 1.4*Z;
draw(nBase--nTip, red+2.2, arrow=Arrow3());
label("$\mathbf{n}$", nTip, N, fontsize(22));

// 方向向量 s（沿直线 L）
triple sTip = P + 1.2*lDir;
draw(P--sTip, purple+2.0, arrow=Arrow3());
label("$\mathbf{s}$", sTip, NE, fontsize(22));

// 交点 P
dot(P, linewidth(8));
label("$P$", P, SW, fontsize(22));

// 夹角 phi（放在 L 与 L' 之间）
label("$\varphi$", P + 0.5*lDir + 0.3*lProj, N, fontsize(22));

// 标签
label("$\Pi$", C + 0.2*Z + 0.2*Y, N, fontsize(22));
label("$L$", L_top, NE, fontsize(22));
label("$L'$", Lp_end, E, fontsize(22));
