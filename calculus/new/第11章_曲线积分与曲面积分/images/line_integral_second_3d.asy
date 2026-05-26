settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
import graph3;

// 设置视角
currentprojection = perspective(camera=(8, 7, 5), target=(2, 1.2, 1.2));

// 自定义 3D 圆弧函数以规避 render=0 崩溃
path3 my_arc(triple c, triple v1, triple v2, real r) {
    triple u = unit(v1 - c);
    triple w = unit(cross(v1 - c, v2 - c));
    triple v = unit(cross(w, u));
    real val = dot(u, unit(v2 - c));
    if (val > 1.0) val = 1.0;
    if (val < -1.0) val = -1.0;
    real angle = acos(val);
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
draw(O--3.5*Z, L=Label("$z$", EndPoint, fontsize(13)), arrow=Arrow3());

// 空间曲线 Gamma 参数方程
triple f(real t) {
    return (t, 1.2 + 0.8*sin(t), 0.5 + 0.5*t);
}

path3 g = graph(f, 1.0, 3.0, operator ..);

// 绘制有向空间曲线 L
draw(g, blue+1.5, arrow=Arrow3());

// 在曲线上取一点 P
real t0 = 2.0;
triple p_pt = f(t0);

// 切向量 tau
triple tangent = unit((1.0, 0.8*cos(t0), 0.5));
draw(p_pt--(p_pt + 1.2*tangent), red+1.5, arrow=Arrow3());
label("$\mathbf{T}$", p_pt + 1.3*tangent, N, fontsize(13));

// 力向量 F
triple F_vec = 1.6 * unit((0.8, 0.3, 1.3));
draw(p_pt--(p_pt + F_vec), darkgreen+1.5, arrow=Arrow3());
label("$\mathbf{F}$", p_pt + F_vec + 0.15*unit(F_vec), N, fontsize(13));

// 投影点 p_proj
real L_proj = dot(F_vec, tangent);
triple p_proj = p_pt + L_proj * tangent;

// 投影线
draw((p_pt + F_vec)--p_proj, dashed+gray+1.0);

// 直角符号 (两段 L-shape)
real s = 0.08;
triple u_dir = unit(p_pt - p_proj);
triple v_dir = unit((p_pt + F_vec) - p_proj);
draw((p_proj + s*u_dir)--(p_proj + s*u_dir + s*v_dir)--(p_proj + s*v_dir), black+1.0);

// 夹角 theta
path3 arc_theta = my_arc(p_pt, p_pt + tangent, p_pt + F_vec, 0.35);
draw(arc_theta, black+1.0);
label("$\theta$", p_pt + 0.45*unit(tangent + unit(F_vec)), NE, fontsize(12));

// 标注投影大小 F.T
label("$\mathbf{F}\cdot\mathbf{T}$", (p_pt + p_proj)/2 - (0, 0.1, 0.12), S, fontsize(12));

// 标注起点 A 和终点 B
label("$A$", f(1.0), W, fontsize(13));
label("$B$", f(3.0), E, fontsize(13));

// 标注总公式
label("$\int_L \mathbf{F}\cdot d\mathbf{r} = \int_L (\mathbf{F}\cdot\mathbf{T})\,ds$", (2.0, 1.2+0.8*sin(2.0), 3.0), N, fontsize(15));

// 端点由曲线自然相交标出，不画 dot 规避崩溃
