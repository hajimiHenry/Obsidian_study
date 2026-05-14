settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(7,5,4);

// 坐标轴
draw(O--3.5X, arrow=Arrow3(), black+1.0);
draw(O--3.5Y, arrow=Arrow3(), black+1.0);
draw(O--3.5Z, arrow=Arrow3(), black+1.0);
label("$x$", 3.5X, E, fontsize(20));
label("$y$", 3.5Y, N, fontsize(20));
label("$z$", 3.5Z, N, fontsize(20));

// Π1: x+y+z=3 (浅蓝半透明)
triple A1 = (3,0,0);
triple B1 = (0,3,0);
triple C1 = (0,0,3);
path3 p1 = A1--B1--C1--cycle;
draw(surface(p1), lightblue+opacity(0.35));
draw(p1, black+1.0);
label("$\Pi_1$", (1.2,2.0,1.0), fontsize(20));

// Π2: y=1 (浅绿半透明四边形)
triple D2 = (0,1,0);
triple E2 = (3,1,0);
triple F2 = (3,1,3);
triple G2 = (0,1,3);
path3 p2 = D2--E2--F2--G2--cycle;
draw(surface(p2), lightgreen+opacity(0.35));
draw(p2, black+1.0);
label("$\Pi_2$", (2.5,1.0,2.2), E, fontsize(20));

// 交线 x+z=2, y=1
triple L1 = (0,1,2);
triple L2 = (2,1,0);
draw(L1--L2, black+1.5);

// 交线上一点 M0
triple M0 = (1,1,1);

// 法向量 n1
triple n1 = unit((1,1,1));
triple n1Tip = M0 + 1.4*n1;
draw(M0--n1Tip, red+1.5, arrow=Arrow3());
label("$\mathbf{n}_1$", n1Tip + 0.15*unit(n1), N, fontsize(20));

// 法向量 n2
triple n2 = unit((0,1,0));
triple n2Tip = M0 + 1.4*n2;
draw(M0--n2Tip, blue+1.5, arrow=Arrow3());
label("$\mathbf{n}_2$", n2Tip + 0.15*unit(n2), E, fontsize(20));

// 夹角弧
triple u = 0.5*unit(n1);
triple v = 0.5*unit(n2);
path3 ang = arc(M0, M0+u, M0+v);
draw(ang, black+1.2);
label("$\theta$", M0 + 0.35*unit(n1+n2) + (0.1,0,0.1), N, fontsize(20));

// 点
dot(M0, linewidth(5));
