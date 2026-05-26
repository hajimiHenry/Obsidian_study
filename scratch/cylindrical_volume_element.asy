settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import graph3;

// 视角
currentprojection = perspective(camera=(8, -6, 5), target=(1.5, 1.2, 1.2));

// 坐标轴
draw(O--4.2*X, L=Label("$x$", position=EndPoint, align=SW), black+1.5);
draw(O--4.2*Y, L=Label("$y$", position=EndPoint, align=E), black+1.5);
draw(O--4.2*Z, L=Label("$z$", position=EndPoint, align=N), black+1.5);
label("$O$", O, SW);

// 柱面坐标体积元素参数
real r1 = 2.0;
real r2 = 2.8;
real a1 = 20 * pi / 180;
real a2 = 45 * pi / 180;
real z1 = 1.0;
real z2 = 2.2;

// 8个顶点
triple P0 = (r1*cos(a1), r1*sin(a1), z1);
triple P1 = (r2*cos(a1), r2*sin(a1), z1);
triple P2 = (r2*cos(a2), r2*sin(a2), z1);
triple P3 = (r1*cos(a2), r1*sin(a2), z1);

triple Q0 = (r1*cos(a1), r1*sin(a1), z2);
triple Q1 = (r2*cos(a1), r2*sin(a1), z2);
triple Q2 = (r2*cos(a2), r2*sin(a2), z2);
triple Q3 = (r1*cos(a2), r1*sin(a2), z2);

// 定义表面参数方程
// 1. 底面 (z = z1)
triple bottom_p(pair p) {
    return (p.x*cos(p.y), p.x*sin(p.y), z1);
}
surface bottom_face = surface(bottom_p, (r1, a1), (r2, a2), nu=8, nv=8);

// 2. 顶面 (z = z2)
triple top_p(pair p) {
    return (p.x*cos(p.y), p.x*sin(p.y), z2);
}
surface top_face = surface(top_p, (r1, a1), (r2, a2), nu=8, nv=8);

// 3. 内侧面 (r = r1)
triple inner_p(pair p) {
    return (r1*cos(p.y), r1*sin(p.y), p.x);
}
surface inner_face = surface(inner_p, (z1, a1), (z2, a2), nu=8, nv=8);

// 4. 外侧面 (r = r2)
triple outer_p(pair p) {
    return (r2*cos(p.y), r2*sin(p.y), p.x);
}
surface outer_face = surface(outer_p, (z1, a1), (z2, a2), nu=8, nv=8);

// 绘制半透明面
draw(bottom_face, lightblue+opacity(0.35), meshpen=gray+0.7);
draw(top_face, lightblue+opacity(0.4), meshpen=gray+0.7);
draw(inner_face, lightblue+opacity(0.3), meshpen=gray+0.7);
draw(outer_face, lightblue+opacity(0.3), meshpen=gray+0.7);

// 两个侧平面
draw(surface(P0--P1--Q1--Q0--cycle), lightblue+opacity(0.35));
draw(surface(P3--P2--Q2--Q3--cycle), lightblue+opacity(0.35));

// 绘制棱线
// 垂直线
draw(P0--Q0, black+1.0);
draw(P1--Q1, black+1.2);
draw(P2--Q2, black+1.2);
draw(P3--Q3, black+1.2);

// 径向线
draw(P0--P1, black+1.0);
draw(P3--P2, black+1.2);
draw(Q0--Q1, black+1.2);
draw(Q3--Q2, black+1.2);

// 绘制底顶圆弧
path3 arc_b_in, arc_b_out, arc_t_in, arc_t_out;
int m = 20;
for(int i=0; i<=m; ++i) {
    real a = a1 + i * (a2 - a1) / m;
    triple pbi = (r1*cos(a), r1*sin(a), z1);
    triple pbo = (r2*cos(a), r2*sin(a), z1);
    triple pti = (r1*cos(a), r1*sin(a), z2);
    triple pto = (r2*cos(a), r2*sin(a), z2);
    if(i == 0) {
        arc_b_in = pbi; arc_b_out = pbo; arc_t_in = pti; arc_t_out = pto;
    } else {
        arc_b_in = arc_b_in..pbi; arc_b_out = arc_b_out..pbo;
        arc_t_in = arc_t_in..pti; arc_t_out = arc_t_out..pto;
    }
}
draw(arc_b_in, black+1.0);
draw(arc_b_out, black+1.2);
draw(arc_t_in, black+1.2);
draw(arc_t_out, black+1.2);

// xy平面的投影及角度标记
triple P0_xy = (P0.x, P0.y, 0);
triple P1_xy = (P1.x, P1.y, 0);
triple P2_xy = (P2.x, P2.y, 0);
triple P3_xy = (P3.x, P3.y, 0);

draw(P0--P0_xy, gray+dashed+1.0);
draw(P1--P1_xy, gray+dashed+1.0);
draw(P2--P2_xy, gray+dashed+1.0);
draw(P3--P3_xy, gray+dashed+1.0);

// 绘制xy面上的极坐标网格投影线
draw(O--P1_xy, gray+dashed+1.0);
draw(O--P2_xy, gray+dashed+1.0);
path3 arc_proj;
for(int i=0; i<=m; ++i) {
    real a = a1 + i * (a2 - a1) / m;
    triple p = (r1*cos(a), r1*sin(a), 0);
    if (i == 0) arc_proj = p; else arc_proj = arc_proj..p;
}
draw(arc_proj, gray+dashed+1.0);

// xy面上的夹角标记
// theta
path3 arc_theta;
for(int i=0; i<=m; ++i) {
    real a = i * a1 / m;
    triple p = (0.6*cos(a), 0.6*sin(a), 0);
    if (i == 0) arc_theta = p; else arc_theta = arc_theta..p;
}
draw(arc_theta, black+1.0);
label("$\theta$", (0.8*cos(a1/2), 0.8*sin(a1/2), 0), fontsize(10));

// dtheta
path3 arc_dtheta;
for(int i=0; i<=m; ++i) {
    real a = a1 + i * (a2 - a1) / m;
    triple p = (0.5*cos(a), 0.5*sin(a), 0);
    if (i == 0) arc_dtheta = p; else arc_dtheta = arc_dtheta..p;
}
draw(arc_dtheta, black+1.0);
label("$d\theta$", (0.7*cos((a1+a2)/2), 0.7*sin((a1+a2)/2), 0), fontsize(10));

// 标注棱长
// dz
pair Q1_offset = (Q1.x, Q1.y) + 0.15*(-sin(a1), cos(a1));
triple Q1_off_3d = (Q1_offset.x, Q1_offset.y, Q1.z);
triple P1_off_3d = (Q1_offset.x, Q1_offset.y, P1.z);
draw(P1_off_3d--Q1_off_3d, black+1.0, arrow=Arrows3()); // 3D箭头双向
label("$dz$", (P1_off_3d + Q1_off_3d)/2, (0, 0, 1), fontsize(12));

// dp
pair P1_offset_dp = (P1.x, P1.y) + 0.15*(-sin(a1), cos(a1));
pair P0_offset_dp = (P0.x, P0.y) + 0.15*(-sin(a1), cos(a1));
draw((P0_offset_dp.x, P0_offset_dp.y, z1)--(P1_offset_dp.x, P1_offset_dp.y, z1), black+1.0, arrow=Arrows3());
label("$d\rho$", ( (P0_offset_dp+P1_offset_dp)/2.0 ).x * X + ( (P0_offset_dp+P1_offset_dp)/2.0 ).y * Y + z1*Z, NW, fontsize(12));

// \rho d\theta
triple mid_b_in = (r1*cos((a1+a2)/2), r1*sin((a1+a2)/2), z1);
draw(mid_b_in + (0.3, 0.2, -0.2) -- mid_b_in, black+1.0, arrow=Arrow3(4));
label("$\rho\,d\theta$", mid_b_in + (0.3, 0.2, -0.2), NE, fontsize(12));

// dV
label("$dV = \rho\,d\rho\,d\theta\,dz$", (r2, r2, z2), NE, blue+fontsize(15));
