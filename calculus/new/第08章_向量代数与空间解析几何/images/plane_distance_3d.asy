settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(6,2,3);

// 坐标轴（缩短一点，避免被裁切）
draw(O--3X, arrow=Arrow3(), black+1.0);
draw(O--3Y, arrow=Arrow3(), black+1.0);
draw(O--3Z, arrow=Arrow3(), black+1.0);
label("$x$", 3X, E, fontsize(20));
label("$y$", 3Y, N, fontsize(20));
label("$z$", 3Z, N, fontsize(20));

// 平面 z=0（半透明浅灰）
triple pa = (0,0,0);
triple pb = (3,0,0);
triple pc = (3,2.2,0);
triple pd = (0,2.2,0);
path3 plane = pa--pb--pc--pd--cycle;
draw(surface(plane), lightblue+opacity(0.35));
draw(plane, black+1.0);

// 点 P0（平面上方）和垂足 Q
triple P0 = (1.5,1.2,2);
triple Q = (1.5,1.2,0);

// 距离 d（红色，从 Q 指向 P0）
draw(Q--P0, red+1.5, arrow=Arrow3());
label("$d$", (Q+P0)/2 + 0.2*unit(cross(P0-Q,X)), E, fontsize(20));

// 法向量 n：从 Q 旁边偏移出发，避免和 d 重合
triple nBase = Q + 0.4*Y + 0.5*X;
triple nTip = nBase + 1.0*Z;
draw(nBase--nTip, black+1.2, arrow=Arrow3());
label("$\mathbf{n}$", nTip + 0.15*Z, N, fontsize(20));

// 直角符号（在 Q 处）：小弧线 + 90° 标注
real s = 0.22;
path3 rightAngle = arc(Q, Q + s*X, Q + s*Z);
draw(rightAngle, black+1.2);
label("$90^o$", Q + 0.35*X + 0.35*Z, N, fontsize(20));

// 从原点出发的辅助虚线
draw(O--Q, grey+0.6);
draw(O--P0, grey+0.6);

// 点最后画，放大
dot(P0, linewidth(5));
dot(Q, linewidth(5));
label("$P_0(x_0,y_0,z_0)$", P0, W, fontsize(20));
label("$Q$", Q, S, fontsize(20));
