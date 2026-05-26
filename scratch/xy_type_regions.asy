settings.outformat="png";
settings.tex="xelatex";
size(650);
import graph;

pair O = (0,0);

// 坐标轴
draw(O--(4.5, 0), L=Label("$x$", position=EndPoint, align=S), black+1.5, arrow=Arrow(5));
draw(O--(0, 4.0), L=Label("$y$", position=EndPoint, align=W), black+1.5, arrow=Arrow(5));
dot(O, black+3.0);
label("$O$", O, SW);

// 区间 [a, b]
real a = 1.0;
real b = 3.2;

// 边界函数
real phi1(real x) {
    return 0.6 + 0.15*(x-2.1)^2;
}
real phi2(real x) {
    return 2.8 - 0.25*(x-2.1)^2;
}

// 曲线路径
path bottom_curve = graph(phi1, a, b);
path top_curve = graph(phi2, a, b);
path region = bottom_curve -- (b, phi2(b)) -- reverse(top_curve) -- (a, phi1(a)) -- cycle;

// 填充区域
fill(region, lightblue+opacity(0.3));

// 勾勒边界
draw(bottom_curve, blue+1.8);
draw(top_curve, red+1.8);

// 虚线投影到 x 轴
draw((a, phi1(a)) -- (a, 0), gray+dashed+1.2);
draw((b, phi1(b)) -- (b, 0), gray+dashed+1.2);
dot((a, 0), black+4.0);
dot((b, 0), black+4.0);
label("$a$", (a, 0), S, fontsize(12));
label("$b$", (b, 0), S, fontsize(12));

// 垂直扫描线 (x = x0)
real x0 = 2.0;
pair p_bottom = (x0, phi1(x0));
pair p_top = (x0, phi2(x0));
draw(p_bottom -- p_top, darkgreen+2.2, arrow=Arrow(SimpleHead, position=0.65, size=8));

// 标注
label("$D$", (2.1, 1.6), fontsize(16));
label("$y=\varphi_1(x)$", (2.1, phi1(2.1)), S, blue+fontsize(14));
label("$y=\varphi_2(x)$", (2.1, phi2(2.1)), N, red+fontsize(14));

// 扫描线指示
label("扫描线", (x0, 2.3), E, darkgreen+fontsize(13));
draw((x0, 0) -- p_bottom, gray+dashed+1.2);
dot((x0, 0), black+4.0);
label("$x$", (x0, 0), S, fontsize(13));
