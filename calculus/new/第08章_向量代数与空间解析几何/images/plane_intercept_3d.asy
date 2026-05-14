settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(6,5,4);

// 坐标轴
draw(O--3.5X, arrow=Arrow3(), black+1.0);
draw(O--3.5Y, arrow=Arrow3(), black+1.0);
draw(O--3.5Z, arrow=Arrow3(), black+1.0);
label("$x$", 3.5X, E, fontsize(20));
label("$y$", 3.5Y, N, fontsize(20));
label("$z$", 3.5Z, N, fontsize(20));

// 截距式平面 x/3 + y/2.5 + z/2 = 1
triple A = (3,0,0);
triple B = (0,2.5,0);
triple C = (0,0,2);
path3 p = A--B--C--cycle;
draw(surface(p), lightblue+opacity(0.35));
draw(p, black+1.2);

// 平面方程标注
label("$\frac{x}{a}+\frac{y}{b}+\frac{z}{c}=1$", (1.5,1.2,1.0), fontsize(20));

// 截距点标注
dot(A, linewidth(5));
dot(B, linewidth(5));
dot(C, linewidth(5));
label("$(a,0,0)$", A, 2.0*S, fontsize(20));
label("$(0,b,0)$", B, 2.0*W, fontsize(20));
label("$(0,0,c)$", C, 2.0*E, fontsize(20));

// 原点标注
label("$O$", O, SW, fontsize(20));
