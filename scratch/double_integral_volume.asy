settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import graph3;

// 视角
currentprojection = perspective(camera=(7, 6, 5), target=(1.5, 1.5, 1.5));

// 坐标轴
draw(O--4.5*X, L=Label("$x$", position=EndPoint, align=SW), black+1.5);
draw(O--4.5*Y, L=Label("$y$", position=EndPoint, align=E), black+1.5);
draw(O--4.5*Z, L=Label("$z$", position=EndPoint, align=N), black+1.5);

// 函数定义
real f(real x, real y) {
    return 3.5 - 0.08*(x-1.5)^2 - 0.08*(y-1.5)^2;
}
real f_pair(pair p) {
    return f(p.x, p.y);
}

// 顶曲面大范围 (z = f(x,y))
surface s_top = surface(f_pair, (0.4, 0.4), (3.2, 3.2), nx=12, ny=12);
draw(s_top, lightblue+opacity(0.25), meshpen=gray+0.7);

// 底面区域D边界点
triple[] pts_D = {
    (1.0, 0.8, 0),
    (2.4, 0.6, 0),
    (3.0, 1.6, 0),
    (2.3, 2.7, 0),
    (0.9, 2.3, 0),
    (0.6, 1.4, 0)
};
path3 D_path = pts_D[0]..pts_D[1]..pts_D[2]..pts_D[3]..pts_D[4]..pts_D[5]..cycle;

// 绘制底面区域D
draw(surface(D_path), lightgray+opacity(0.4));
draw(D_path, black+1.8);
label("$D$", (2.0, 2.0, 0), fontsize(16));
label("底区域 $D$", (2.0, 2.0, 0) + (-0.3, -0.3, 0), fontsize(13));

// 顶边界路径 (投影D_path到曲面)
path3 top_path;
int n = 80;
for(int i=0; i<=n; ++i) {
    real t = i * length(D_path) / n;
    triple p = point(D_path, t);
    triple pt = (p.x, p.y, f(p.x, p.y));
    if (i == 0) {
        top_path = pt;
    } else {
        top_path = top_path..pt;
    }
}
top_path = top_path..cycle;

// 绘制顶边界
draw(top_path, blue+1.8);
label("$z=f(x,y)$", (1.5, 1.5, f(1.5,1.5)) + (0.2, 0.2, 0.3), fontsize(16));
label("顶曲面", (1.5, 1.5, f(1.5,1.5)) + (-0.2, -0.2, 0.6), fontsize(13));

// 画几根侧面母线
for(int i=0; i<pts_D.length; ++i) {
    triple pt_top = (pts_D[i].x, pts_D[i].y, f(pts_D[i].x, pts_D[i].y));
    draw(pts_D[i]--pt_top, gray+dashed+1.0);
}

// 绘制小柱体
real w = 0.3;
real h = 0.3;
triple p0 = (1.7, 1.2, 0);
triple p1 = p0 + (w, 0, 0);
triple p2 = p0 + (w, h, 0);
triple p3 = p0 + (0, h, 0);
path3 sub_base = p0--p1--p2--p3--cycle;

triple t0 = (p0.x, p0.y, f(p0.x, p0.y));
triple t1 = (p1.x, p1.y, f(p1.x, p1.y));
triple t2 = (p2.x, p2.y, f(p2.x, p2.y));
triple t3 = (p3.x, p3.y, f(p3.x, p3.y));
path3 sub_top = t0--t1--t2--t3--cycle;

// 填充小柱体的各个面
draw(surface(sub_base), orange+opacity(0.5));
draw(surface(sub_top), orange+opacity(0.8));
draw(surface(p0--p1--t1--t0--cycle), orange+opacity(0.6));
draw(surface(p1--p2--t2--t1--cycle), orange+opacity(0.6));
draw(surface(p2--p3--t3--t2--cycle), orange+opacity(0.6));
draw(surface(p3--p0--t0--t3--cycle), orange+opacity(0.6));

// 勾勒小柱体边缘
draw(sub_base, black+1.2);
draw(sub_top, black+1.5);
draw(p0--t0, black+1.2);
draw(p1--t1, black+1.2);
draw(p2--t2, black+1.2);
draw(p3--t3, black+1.2);

label("小柱体", t2 + (0.2, 0.2, 0.4), fontsize(13));
draw(t2 + (0.15, 0.15, 0.35) -- t2 + (0.02, 0.02, 0.05), black+1.0, arrow=Arrow3(4));

// 绘制点，大点后画，避免render=0问题
dot(t0, linewidth(5)+orange);
dot(t1, linewidth(5)+orange);
dot(t2, linewidth(5)+orange);
dot(t3, linewidth(5)+orange);
