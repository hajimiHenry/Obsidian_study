settings.outformat="png";
settings.tex="xelatex";
size(650);

pair O = (0,0);

// 2D 坐标轴
draw(O--(4.5, 0), L=Label("$x$", position=EndPoint, align=S), black+1.5, arrow=Arrow(5));
draw(O--(0, 4.5), L=Label("$y$", position=EndPoint, align=W), black+1.5, arrow=Arrow(5));

// 区域 D 边界
pair[] pts = {
    (1.0, 0.8), (2.5, 0.6), (3.4, 1.4),
    (3.2, 2.7), (2.1, 3.3), (0.9, 2.5), (0.7, 1.3)
};
path D_path = pts[0]..pts[1]..pts[2]..pts[3]..pts[4]..pts[5]..pts[6]..cycle;

// 填充底色并绘制边界
fill(D_path, lightgray+opacity(0.3));
draw(D_path, black+1.8);

// 绘制网格剖分 (仅在 D 内部)
picture grid_pic;
for(real x=0.5; x<=3.6; x+=0.3) {
    draw(grid_pic, (x, 0)--(x, 4), gray+0.8);
}
for(real y=0.5; y<=3.6; y+=0.3) {
    draw(grid_pic, (0, y)--(4, y), gray+0.8);
}
clip(grid_pic, D_path);
add(grid_pic);

// 高亮其中一个小网格
path sub_block = (1.7, 1.7)--(2.0, 1.7)--(2.0, 2.0)--(1.7, 2.0)--cycle;
fill(sub_block, orange+opacity(0.6));
draw(sub_block, black+1.2);

// 取样点
pair xi = (1.82, 1.88);

// 标注
label("$D$", (2.9, 2.9), fontsize(16));

// 标注小块 (从右上指向小块)
draw((2.5, 2.4) -- (1.9, 1.9), black+1.2, arrow=Arrow(4));
label("$\Delta \sigma_i$", (2.5, 2.4), NE, fontsize(14));

// 标注取样点 (从左下指向红点)
draw((1.1, 1.3) -- (1.78, 1.83), black+1.2, arrow=Arrow(4));
label("$(\xi_i, \eta_i)$", (1.1, 1.3), SW, fontsize(14));

// 最后画取样红点，避免覆盖
dot(xi, red+6.0);
dot(O, black+4.0);
label("$O$", O, SW);
