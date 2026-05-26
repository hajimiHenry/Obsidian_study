settings.outformat="png";
settings.tex="xelatex";
size(650);

pair O = (0,0);

// 坐标轴
draw(O--(3.2, 0), L=Label("$x$", position=EndPoint, align=S), black+1.5, arrow=Arrow(5));
draw(O--(0, 3.2), L=Label("$y$", position=EndPoint, align=W), black+1.5, arrow=Arrow(5));
dot(O, black+3.0);
label("$O$", O, SW);

// 刻度
real tick_sz = 0.05;
draw((1, -tick_sz)--(1, tick_sz));
label("$1$", (1, 0), S);
draw((2, -tick_sz)--(2, tick_sz));
label("$2$", (2, 0), S);

draw((-tick_sz, 1)--(tick_sz, 1));
label("$1$", (0, 1), W);
draw((-tick_sz, 2)--(tick_sz, 2));
label("$2$", (0, 2), W);

// 三角形顶点
pair A = (1,1);
pair B = (2,1);
pair C = (2,2);
path tri = A--B--C--cycle;

// 填充区域D
fill(tri, lightblue+opacity(0.35));

// 绘制直线 (延长线)
draw((0.5, 1)--(2.5, 1), blue+1.5);
draw((2, 0.5)--(2, 2.5), red+1.5);
draw((0.5, 0.5)--(2.5, 2.5), darkgreen+1.5);

// 辅助虚线
draw((1, 1)--(1, 0), gray+dashed+1.2);
draw((1, 1)--(0, 1), gray+dashed+1.2);
draw((2, 2)--(0, 2), gray+dashed+1.2);

// 标注
label("$y=1$", (0.7, 1), N, blue+fontsize(13));
label("$x=2$", (2, 0.7), E, red+fontsize(13));
label("$y=x$", (1.4, 1.4), NW, darkgreen+fontsize(13));
label("$D$", (1.7, 1.3), fontsize(16));

// 标记交点
dot(A, black+5.0);
dot(B, black+5.0);
dot(C, black+5.0);
label("$(1,1)$", A, NW+W*0.2, fontsize(12));
label("$(2,1)$", B, SE, fontsize(12));
label("$(2,2)$", C, NE, fontsize(12));
