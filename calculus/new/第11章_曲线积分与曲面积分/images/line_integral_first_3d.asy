settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
import graph3;

// 设置视角
currentprojection = perspective(camera=(9, 7, 5), target=(2, 1.2, 1));

// 坐标轴
draw(O--4.5*X, L=Label("$x$", EndPoint, fontsize(13)), arrow=Arrow3());
draw(O--4.5*Y, L=Label("$y$", EndPoint, fontsize(13)), arrow=Arrow3());
draw(O--3.5*Z, L=Label("$z$", EndPoint, fontsize(13)), arrow=Arrow3());

// 底面曲线 L 参数方程
triple f_base(real t) {
    return (t, 1.2 + 0.8*sin(t), 0);
}

// 顶面曲线 (高度为 f(x,y)) 参数方程
triple f_top(real t) {
    real z = 1.6 + 0.4*cos(t);
    return (t, 1.2 + 0.8*sin(t), z);
}

path3 g_base = graph(f_base, 0.5, 3.5, operator ..);
path3 g_top = graph(f_top, 0.5, 3.5, operator ..);

// 绘制幕墙面 (直纹面)
surface wall = surface(new triple(pair p) {
    real t = p.x;
    real u = p.y;
    triple b = f_base(t);
    triple t_pt = f_top(t);
    return b + u * (t_pt - b);
}, (0.5, 0), (3.5, 1), nu=35, nv=10);

draw(wall, lightred+opacity(0.35), meshpen=nullpen);

// 绘制边界线
draw(g_base, blue+1.5);
draw(g_top, red+1.5);
draw(f_base(0.5)--f_top(0.5), gray+0.8);
draw(f_base(3.5)--f_top(3.5), gray+0.8);

// 标注底面曲线 L
label("$L$", f_base(0.5) - (0.1, 0.2, 0), W, fontsize(14));

// 绘制微元段 ds
real t_ds_start = 2.0;
real t_ds_end = 2.2;
path3 g_ds_base = graph(f_base, t_ds_start, t_ds_end, operator ..);
draw(g_ds_base, black+3.0); // 黑色加粗表示 ds
label("$ds$", f_base((t_ds_start + t_ds_end)/2) - (0, 0.2, 0), S, fontsize(13));

// 绘制微元幕墙窄条
surface ds_wall = surface(new triple(pair p) {
    real t = p.x;
    real u = p.y;
    triple b = f_base(t);
    triple t_pt = f_top(t);
    return b + u * (t_pt - b);
}, (t_ds_start, 0), (t_ds_end, 1), nu=5, nv=5);
draw(ds_wall, red+opacity(0.65), meshpen=nullpen);

// 标注高度 f(x,y)
triple mid_base = f_base((t_ds_start + t_ds_end)/2);
triple mid_top = f_top((t_ds_start + t_ds_end)/2);
draw(mid_base--mid_top, dashed+black+1.0);
label("$f(x,y)$", (mid_base + mid_top)/2 + (0.1, 0.1, 0), E, fontsize(13));

// 标注总面积公式
label("$A = \int_L f(x,y)\,ds$", (2.0, 1.2 + 0.8*sin(2.0), 2.6), N, fontsize(15));
