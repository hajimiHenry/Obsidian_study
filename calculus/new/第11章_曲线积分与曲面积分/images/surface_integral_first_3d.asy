settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
import graph3;

// 设置视角
currentprojection = perspective(camera=(8, 7, 5), target=(1.5, 1.5, 1.5));

// 自定义 3D 圆弧函数以规避 render=0 崩溃
path3 my_arc(triple c, triple v1, triple v2, real r) {
    triple u = unit(v1 - c);
    triple w = unit(cross(v1 - c, v2 - c));
    triple v = unit(cross(w, u));
    real angle = acos(dot(u, unit(v2 - c)));
    path3 g;
    int n = 15;
    for (int i = 0; i <= n; ++i) {
        real t = i * angle / n;
        g = g -- (c + r * (cos(t)*u + sin(t)*v));
    }
    return g;
}


// 坐标轴
draw(O--4.5*X, L=Label("$x$", EndPoint, fontsize(13)), arrow=Arrow3());
draw(O--4.5*Y, L=Label("$y$", EndPoint, fontsize(13)), arrow=Arrow3());
draw(O--4.2*Z, L=Label("$z$", EndPoint, fontsize(13)), arrow=Arrow3());

// 曲面 Sigma 方程 z = z(x,y) = 3.2 - 0.15*(x^2 + y^2)
triple surf_eq(pair p) {
    real x = p.x;
    real y = p.y;
    return (x, y, 3.2 - 0.15*(x^2 + y^2));
}

// 绘制半透明曲面 Sigma
surface Sigma = surface(surf_eq, (0.5, 0.5), (2.5, 2.5), nu=12, nv=12);
draw(Sigma, lightblue+opacity(0.35), meshpen=gray+0.3);
label("$\Sigma$", surf_eq((0.5, 0.5)) + (-0.2, -0.2, 0.2), W, fontsize(14));

// 绘制底面投影区域 D_xy
path3 D_xy_bd = (0.5,0.5,0)--(2.5,0.5,0)--(2.5,2.5,0)--(0.5,2.5,0)--cycle;
draw(surface(D_xy_bd), gray+opacity(0.12));
draw(D_xy_bd, gray+dashed+0.8);
label("$D_{xy}$", (1.5, 1.5, 0), fontsize(13));

// 选取微元面片 dS
surface dS = surface(surf_eq, (1.4, 1.4), (1.8, 1.8), nu=4, nv=4);
draw(dS, orange+opacity(0.7), meshpen=black+0.3);

// 对应投影微元 dxdy
path3 dxdy = (1.4,1.4,0)--(1.8,1.4,0)--(1.8,1.8,0)--(1.4,1.8,0)--cycle;
draw(surface(dxdy), orange+opacity(0.4));
draw(dxdy, orange+dashed+0.8);

// 绘制投影垂直柱线
draw((1.4,1.4,0)--surf_eq((1.4,1.4)), gray+dashed+0.6);
draw((1.8,1.4,0)--surf_eq((1.8,1.4)), gray+dashed+0.6);
draw((1.8,1.8,0)--surf_eq((1.8,1.8)), gray+dashed+0.6);
draw((1.4,1.8,0)--surf_eq((1.4,1.8)), gray+dashed+0.6);

// 微元标注
triple M = surf_eq((1.6, 1.6));
label("$dS$", M + (0.15, 0.15, 0.2), NE, fontsize(12));
label("$dx\,dy$", (1.6, 1.6, 0) - (0.1, 0.1, 0), S, fontsize(12));

// 在 dS 中心 M 处画法向量 n
triple n_vec = unit((0.3*1.6, 0.3*1.6, 1.0)); // grad F = (2*0.15*x, 2*0.15*y, 1)
draw(M--(M + 1.2*n_vec), red+1.5, arrow=Arrow3());
label("$\mathbf{n}$", M + 1.3*n_vec, N, fontsize(13));

// 画垂直方向的单位向量 k
draw(M--(M + 1.2*Z), darkgreen+1.2, arrow=Arrow3());
label("$\mathbf{k}$", M + 1.3*Z, N, fontsize(13));

// 标注夹角 gamma
path3 arc_gamma = my_arc(M, M + Z, M + n_vec, 0.35);
draw(arc_gamma, black+1.0);
label("$\gamma$", M + 0.45*unit(Z + n_vec), N, fontsize(11));

// 标注投影关系公式
label("$dS = \frac{dx\,dy}{\cos\gamma} = \sqrt{1+z_x^2+z_y^2}\,dx\,dy$", (1.5, 1.5, 3.9), N, fontsize(13));
label("$\sqrt{1+z_x^2+z_y^2} \ge 1$ 为面积伸缩因子", (1.5, 1.5, 3.5), N, fontsize(11));
