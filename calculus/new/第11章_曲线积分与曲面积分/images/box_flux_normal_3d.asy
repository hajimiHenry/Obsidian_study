settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;

// 视角设置
currentprojection = perspective(camera=(8.5, 7.0, 5.5), target=(1.5, 1.1, 0.9));

// 长方体尺寸
real a = 2.8;
real b = 2.2;
real c = 1.8;

// 坐标轴
draw(O--4.5*X, L=Label("$x$", EndPoint, fontsize(14)), arrow=Arrow3());
draw(O--3.8*Y, L=Label("$y$", EndPoint, fontsize(14)), arrow=Arrow3());
draw(O--3.2*Z, L=Label("$z$", EndPoint, fontsize(14)), arrow=Arrow3());
label("$O$", O, SW, fontsize(13));

// 定义面
path3 face_x0 = (0,0,0)--(0,b,0)--(0,b,c)--(0,0,c)--cycle;
path3 face_xa = (a,0,0)--(a,b,0)--(a,b,c)--(a,0,c)--cycle;
path3 face_y0 = (0,0,0)--(a,0,0)--(a,0,c)--(0,0,c)--cycle;
path3 face_yb = (0,b,0)--(a,b,0)--(a,b,c)--(0,b,c)--cycle;
path3 face_z0 = (0,0,0)--(a,0,0)--(a,b,0)--(0,b,0)--cycle;
path3 face_zc = (0,0,c)--(a,0,c)--(a,b,c)--(0,b,c)--cycle;

// 绘制半透明面以体现 3D 实体感
draw(surface(face_x0), lightblue+opacity(0.12));
draw(surface(face_xa), lightblue+opacity(0.12));
draw(surface(face_y0), lightblue+opacity(0.12));
draw(surface(face_yb), lightblue+opacity(0.12));
draw(surface(face_z0), lightblue+opacity(0.12));
draw(surface(face_zc), lightblue+opacity(0.12));

// 绘制棱边
pen edge_pen = gray(0.3)+0.8;
draw((0,0,0)--(a,0,0)--(a,b,0)--(0,b,0)--cycle, edge_pen);
draw((0,0,c)--(a,0,c)--(a,b,c)--(0,b,c)--cycle, edge_pen);
draw((0,0,0)--(0,0,c), edge_pen);
draw((a,0,0)--(a,0,c), edge_pen);
draw((a,b,0)--(a,b,c), edge_pen);
draw((0,b,0)--(0,b,c), edge_pen);

// 六个面的中心点
triple C_xa = (a, b/2, c/2);
triple C_x0 = (0, b/2, c/2);
triple C_yb = (a/2, b, c/2);
triple C_y0 = (a/2, 0, c/2);
triple C_zc = (a/2, b/2, c);
triple C_z0 = (a/2, b/2, 0);

real len = 0.8;
pen normal_pen = darkgreen + 1.6;

// x = a (前侧)
draw(C_xa--(C_xa + len*X), normal_pen, arrow=Arrow3());
label("$\mathbf{n}_1 = \mathbf{i}$", C_xa + len*X, E, fontsize(13));

// x = 0 (后侧)
draw(C_x0--(C_x0 - len*X), normal_pen, arrow=Arrow3());
label("$\mathbf{n}_2 = -\mathbf{i}$", C_x0 - len*X, W, fontsize(13));

// y = b (右侧)
draw(C_yb--(C_yb + len*Y), normal_pen, arrow=Arrow3());
label("$\mathbf{n}_3 = \mathbf{j}$", C_yb + len*Y, NE, fontsize(13));

// y = 0 (左侧)
draw(C_y0--(C_y0 - len*Y), normal_pen, arrow=Arrow3());
label("$\mathbf{n}_4 = -\mathbf{j}$", C_y0 - len*Y, SW, fontsize(13));

// z = c (顶侧)
draw(C_zc--(C_zc + len*Z), normal_pen, arrow=Arrow3());
label("$\mathbf{n}_5 = \mathbf{k}$", C_zc + len*Z, N, fontsize(13));

// z = 0 (底侧)
draw(C_z0--(C_z0 - len*Z), normal_pen, arrow=Arrow3());
label("$\mathbf{n}_6 = -\mathbf{k}$", C_z0 - len*Z, S, fontsize(13));

// 流线
pen flux_pen = red + 1.2;
pen flux_dash = red + 1.2 + dashed;

real[] ys = { b*0.3, b*0.7 };
real[] zs = { c*0.3, c*0.7 };

for (real y_p : ys) {
    for (real z_p : zs) {
        triple start_pt = (-0.6, y_p, z_p);
        triple enter_pt = (0, y_p, z_p);
        triple exit_pt  = (a, y_p, z_p);
        triple end_pt   = (a + 0.6, y_p, z_p);
        
        // 进入前：虚线
        draw(start_pt--enter_pt, flux_dash);
        // 穿过中：实线
        draw(enter_pt--exit_pt, flux_pen);
        // 流出后：虚线，带箭头
        draw(exit_pt--end_pt, flux_dash, arrow=Arrow3());
    }
}

// 标注流速场符号 F = x^2 * i
label("$\mathbf{F} = x^2\mathbf{i}$", (-0.7, b*0.5, c*0.8), N, fontsize(14));

// 标注各面的通量贡献 F . n
// x = a 面：F . n_1 = a^2
label("$\mathbf{F}\cdot\mathbf{n}_1 = a^2$", C_xa + len*X + (0, 0.4, 0), SE, fontsize(12));

// x = 0 面：F . n_2 = -x^2 = 0
label("$\mathbf{F}\cdot\mathbf{n}_2 = 0$", C_x0 - len*X + (0, 0.4, 0), NW, fontsize(12));

// y = b 面：F . n_3 = 0
label("$\mathbf{F}\cdot\mathbf{n}_3 = 0$", C_yb + len*Y + (0.3, 0, 0), E, fontsize(12));

// z = c 面：F . n_5 = 0
label("$\mathbf{F}\cdot\mathbf{n}_5 = 0$", C_zc + len*Z + (0.3, 0, 0), N, fontsize(12));
