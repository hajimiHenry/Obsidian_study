settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import graph3;

// 视角
currentprojection = perspective(camera=(6, 5, 4), target=(1.0, 0.5, 1.0));

// 顶点定义 (进行3倍放大以利于排版)
real scale_factor = 3.0;
triple O = (0,0,0);
triple A = (1.0*scale_factor, 0, 0);
triple B = (0, 0.5*scale_factor, 0);
triple C = (0, 0, 1.0*scale_factor);

// 坐标轴 (稍微比顶点长一些)
draw(O--(A+1.2*X), L=Label("$x$", position=EndPoint, align=SW), black+1.5);
draw(O--(B+1.2*Y), L=Label("$y$", position=EndPoint, align=E), black+1.5);
draw(O--(C+1.2*Z), L=Label("$z$", position=EndPoint, align=N), black+1.5);

// 填充底面投影区域 D_xy
draw(surface(O--A--B--cycle), lightgray+opacity(0.4));
draw(O--A, black+1.2);
draw(O--B, black+1.2);
draw(A--B, black+1.5);

// 填充斜面 x+2y+z=1
draw(surface(A--B--C--cycle), lightblue+opacity(0.35));
draw(A--C, black+1.5);
draw(B--C, black+1.5);
draw(O--C, black+1.2);

// 标注
label("$D_{xy}$", (A+B)/3, fontsize(14));
label("$x+2y+z=1$", (A+B+C)/3 + (0.1, 0.1, 0.3), NE, blue+fontsize(14));

// 标注顶点坐标
dot(A, red+5.0);
dot(B, red+5.0);
dot(C, red+5.0);
dot(O, black+5.0);

label("$(1,0,0)$", A, S+W*0.1, fontsize(12));
label("$(0,\frac{1}{2},0)$", B, E, fontsize(12));
label("$(0,0,1)$", C, NW, fontsize(12));
label("$O(0,0,0)$", O, SW, fontsize(11));
