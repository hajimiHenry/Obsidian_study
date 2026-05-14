settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4.5,3,2.8);

// 平面 z=0
triple A = (-2.2,-1.5,0);
triple B = ( 2.4,-1.3,0);
triple C = ( 2.2, 1.8,0);
triple D = (-2.0, 2.0,0);
path3 planePath = A--B--C--D--cycle;
draw(surface(planePath), lightblue+opacity(0.35));
draw(planePath, black+1.2);

// 平面上任一点 P1
triple P1 = (-1.0,1.2,0);

// 平面外一点 P0
triple P0 = (1.2,0.8,2.0);

// 垂足 Q（P0 在平面上的投影）
triple Q = (1.2,0.8,0);

// 向量 P1P0（斜向量，说明投影关系）
draw(P1--P0, blue+1.8, arrow=Arrow3());

// 垂线 P0Q（距离）
draw(P0--Q, darkgreen+2.2);

// 距离标签 d
label("$d$", (P0+Q)/2 + 0.5*Y, E, fontsize(24));

// 法向量 n
triple nBase = (-1.5,1.5,0);
triple nTip  = nBase + 1.6*Z;
draw(nBase--nTip, red+2.2, arrow=Arrow3());
label("$\mathbf{n}$", nTip + 0.2*X + 0.2*Y, N, fontsize(24));

// 点 P0
dot(P0, linewidth(10));
label("$P_0$", P0 + 0.25*X + 0.25*Z, NE, fontsize(24));

// 点 P1（平面上任一点）
dot(P1, linewidth(10));
label("$P_1$", P1 - 0.25*X + 0.2*Y, NW, fontsize(24));

// 垂足 Q
dot(Q, linewidth(10));
label("$Q$", Q + 0.25*X + 0.3*Y, SE, fontsize(24));

// 平面标签
label("$\Pi$", C + 0.2*Z + 0.2*Y, N, fontsize(24));
