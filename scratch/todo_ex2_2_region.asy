settings.outformat="png";
settings.tex="xelatex";
size(650);
import graph;

pair O = (0,0);

// 坐标轴
draw((-1.0, 0)--(5.2, 0), L=Label("$x$", position=EndPoint, align=S), black+1.5, arrow=Arrow(5));
draw((0, -2.0)--(0, 3.2), L=Label("$y$", position=EndPoint, align=W), black+1.5, arrow=Arrow(5));
dot(O, black+3.0);
label("$O$", O, SW);

// 刻度
real tick_sz = 0.05;
int[] x_ticks = {1, 2, 3, 4};
for(int x : x_ticks) {
    draw((x, -tick_sz)--(x, tick_sz));
    label(string(x), (x, 0), S);
}
int[] y_ticks = {-1, 1, 2};
for(int y : y_ticks) {
    draw((-tick_sz, y)--(tick_sz, y));
    label(string(y), (0, y), W);
}

// 抛物线参数方程 x = t^2, y = t
pair para(real t) {
    return (t^2, t);
}

// 绘制曲线和直线
path parabola = graph(para, -1.4, 2.4);
path line = (-0.5, -2.5) -- (5.0, 3.0); // 延长线

// 围成区域的边界
path region_parabola = graph(para, -1.0, 2.0);
path region = region_parabola -- cycle; // 自动连回 (1,-1)

// 填充区域
fill(region, lightblue+opacity(0.35));

// 绘制抛物线和直线
draw(parabola, blue+1.8);
draw(line, red+1.8);

// 绘制辅助线和交点
pair A = (1, -1);
pair B = (4, 2);
dot(A, black+5.0);
dot(B, black+5.0);

draw((1, -1)--(1, 0), gray+dashed+1.2);
draw((1, -1)--(0, -1), gray+dashed+1.2);
draw((4, 2)--(4, 0), gray+dashed+1.2);
draw((4, 2)--(0, 2), gray+dashed+1.2);

label("$(1,-1)$", A, SW, fontsize(12));
label("$(4,2)$", B, NE, fontsize(12));

// 标注
label("$y^2=x$", (1.5, 1.25), W, blue+fontsize(14));
label("$y=x-2$", (3.0, 1.0), SE, red+fontsize(14));
label("$D$", (2.2, 0.5), fontsize(16));
