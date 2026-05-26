settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
import graph3;

// 设置视角
currentprojection = perspective(camera=(8, 8, 5), target=(0, 0, 1.0));

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
draw(O--3.5*X, L=Label("$x$", EndPoint, fontsize(13)), arrow=Arrow3());
draw(O--3.5*Y, L=Label("$y$", EndPoint, fontsize(13)), arrow=Arrow3());
draw(O--3.5*Z, L=Label("$z$", EndPoint, fontsize(13)), arrow=Arrow3());

// 曲面 Sigma 方程 z = 0.15*(x^2 + y^2)
triple surf_eq(pair p) {
    return (p.x, p.y, 0.15*(p.x^2 + p.y^2));
}

// 绘制半透明曲面 Sigma
surface Sigma = surface(surf_eq, (-2.0, -2.0), (2.0, 2.0), nu=15, nv=15);
draw(Sigma, lightblue+opacity(0.28), meshpen=gray+0.3);
label("$\Sigma$", surf_eq((-2.0, -2.0)) + (-0.2, -0.2, 0.2), W, fontsize(14));

// 法向量函数 (上侧)
triple n_vec(real x, real y) {
    return unit((-0.3*x, -0.3*y, 1.0)); // grad F = (-2*0.15*x, -2*0.15*y, 1)
}

// 向量场 F
triple F_const = (0.4, 0.3, 1.2);

// 在几个点绘制法向量和场向量，用以衬托
pair[] pts = { (-1.2, -1.2), (-1.2, 1.0), (0.8, -1.2), (0.0, 0.0) };
for (pair p : pts) {
    triple pt = surf_eq(p);
    triple n = n_vec(p.x, p.y);
    // 绘制法向量 (淡绿色，较细)
    draw(pt--(pt + 0.7*n), green+1.0, arrow=Arrow3());
    // 绘制向量场 (淡红色，较细)
    draw(pt--(pt + 0.6*F_const), red+1.0, arrow=Arrow3());
}

// 选择代表点 P 展示细节
triple P = surf_eq((1.2, 0.8));
triple n_rep = n_vec(1.2, 0.8);
triple F_rep = (0.4, 0.3, 1.3);

// 绘制代表点的法向量 n (粗绿色)
draw(P--(P + 1.3*n_rep), darkgreen+1.8, arrow=Arrow3());
label("$\mathbf{n}$", P + 1.45*n_rep, N, fontsize(13));

// 绘制代表点的向量场 F (粗红色)
draw(P--(P + F_rep), red+1.8, arrow=Arrow3());
label("$\mathbf{F}$", P + F_rep + 0.15*unit(F_rep), NE, fontsize(13));

// 绘制夹角 theta
path3 arc_theta = my_arc(P, P + n_rep, P + F_rep, 0.35);
draw(arc_theta, black+1.0);
label("$\theta$", P + 0.45*unit(n_rep + unit(F_rep)), N, fontsize(11));

// 绘制投影段
real proj_len = dot(F_rep, n_rep);
triple p_proj = P + proj_len * n_rep;
draw((P + F_rep)--p_proj, dashed+gray+1.0);
label("$\mathbf{F}\cdot\mathbf{n}$", (P + p_proj)/2 - (0.12, 0.08, 0), W, fontsize(12));

// 绘制直角符号
real s = 0.07;
triple u_dir = unit(P - p_proj);
triple v_dir = unit((P + F_rep) - p_proj);
draw((p_proj + s*u_dir)--(p_proj + s*u_dir + s*v_dir)--(p_proj + s*v_dir), black+1.0);

// 采样点由向量起点自然标出，不画 dot 规避崩溃

// 标注总公式
label("$\mathrm{Flux} = \int_\Sigma \mathbf{F}\cdot\mathbf{n}\,dS$", (0.0, 0.0, 3.2), N, fontsize(15));
