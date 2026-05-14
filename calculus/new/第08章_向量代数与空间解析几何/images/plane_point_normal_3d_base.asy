settings.outformat="png";
settings.prc = false;
settings.render = 4;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(8,6,4);

// 坐标轴
draw(O--3.5X, arrow=Arrow3(TeXHead2), black+1.0);
draw(O--3.5Y, arrow=Arrow3(TeXHead2), black+1.0);
draw(O--3.5Z, arrow=Arrow3(TeXHead2), black+1.0);
label("$x$", 3.5X, E, fontsize(14));
label("$y$", 3.5Y, N, fontsize(14));
label("$z$", 3.5Z, N, fontsize(14));

// 平面 x+y+z=3 —— 用极淡的蓝色，尽可能让后面几何体能透出来
triple A = (3,0,0);
triple B = (0,3,0);
triple C = (0,0,3);
path3 p = A--B--C--cycle;
draw(surface(p), paleblue);
draw(p, black+1.2);

// 平面标注
label("$\Pi:\,x+y+z=3$", (1.2,2.0,1.0), fontsize(12));

// 点
triple M0 = (1,1,1);
triple M = (2,1,0);
triple n = unit((1,1,1));

// 向量 M0M
draw(M0--M, blue+1.5, arrow=Arrow3(TeXHead2));
label("$\overrightarrow{M_0M}$", (M0+M)/2, S, fontsize(11));

// 法向量 n
triple nTip = M0 + 1.6*n;
draw(M0--nTip, red+1.5, arrow=Arrow3(TeXHead2));
label("$\mathbf{n}=(A,B,C)$", nTip + 0.3*n, N, fontsize(11));

// 醒目直角符号：黑色填充小方块
triple u = unit(M - M0);
triple v = unit(n);
real s = 0.22;
triple a1 = M0 + s*u;
triple b1 = M0 + s*v;
triple c1 = M0 + s*u + s*v;
draw(surface(M0--a1--c1--b1--cycle), black);

triple perpLabel = M0 + 0.7*s*u + 0.7*s*v + 0.15*unit(cross(u,v));
label("$90^\circ$", perpLabel, fontsize(11));

// 点最后画，确保在顶层
dot(M0);
dot(M);
label("$M_0(x_0,y_0,z_0)$", M0, W, fontsize(11));
label("$M(x,y,z)$", M, S, fontsize(11));
