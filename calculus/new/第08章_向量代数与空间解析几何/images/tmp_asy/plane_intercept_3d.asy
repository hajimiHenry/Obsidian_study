settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(5.5,4,3.2);

// 坐标轴（只画正半轴，灰色）
draw(O--3.5*X, gray+1.0);
draw(O--3.0*Y, gray+1.0);
draw(O--3.0*Z, gray+1.0);
label("$x$", 4.0*X + 0.5*Z, E, fontsize(22));
label("$y$", 4.2*Y + 0.4*Z, N, fontsize(22));
label("$z$", 3.5*Z + 0.3*X, N, fontsize(22));

// 截距
triple A = (3,0,0);
triple B = (0,2.5,0);
triple C = (0,0,2);

// 截距点（大点）
dot(A, linewidth(7));
dot(B, linewidth(7));
dot(C, linewidth(7));

// 平面：用一个大的三角形片，避免拼接缝
triple P_ext = (-0.6,-0.5,-0.2);
path3 planePath = A--B--C--cycle;
draw(surface(planePath), lightblue+opacity(0.35));
draw(planePath, black+1.2);
// 延伸示意线
draw(A--(A+0.6*(A-B)), black+0.8);
draw(B--(B+0.6*(B-A)), black+0.8);
draw(C--(C+0.6*(C-B)), black+0.8);

// 截距标签（远离坐标轴末端）
label("$(a,0,0)$", A + 0.5*X - 0.5*Z, SE, fontsize(20));
label("$(0,b,0)$", B + 0.3*Y - 0.3*Z, SE, fontsize(20));
label("$(0,0,c)$", C + 0.5*Z + 0.2*X, N, fontsize(20));

// 平面名称（放在三角形右侧外部）
label("$\Pi$", (2.2,1.5,0.6), E, fontsize(22));

// 原点（放在左下方外部）
dot(O, linewidth(5));
label("$O$", O - 0.5*X - 0.6*Y, SW, fontsize(20));
