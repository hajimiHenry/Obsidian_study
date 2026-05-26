settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
import graph3;

// 设置视角
currentprojection = perspective(camera=(8, 7, 5), target=(0, 0, 1.0));

// 坐标轴
draw(O--3.5*X, L=Label("$x$", EndPoint, fontsize(13)), arrow=Arrow3());
draw(O--3.5*Y, L=Label("$y$", EndPoint, fontsize(13)), arrow=Arrow3());
draw(O--3.2*Z, L=Label("$z$", EndPoint, fontsize(13)), arrow=Arrow3());

// 开曲面 Sigma 极坐标方程 z = 2.1 - 0.3*r^2
// 使用经纬线框 (Wireframe) 绘制，避免 surface 崩溃并方便观察内部
// 1. 绘制水平纬线圆环 (同心圆环)
path3 lat_circle(real r) {
    return graph(new triple(real th) {
        return (r*cos(th), r*sin(th), 2.1 - 0.3*r^2);
    }, 0, 2*pi, operator ..);
}

for (real r = 0.55; r < 2.2; r += 0.55) {
    draw(lat_circle(r), gray+0.5+dashed);
}

// 2. 绘制径向母线 (抛物线段)
path3 rad_parabola(real th) {
    return graph(new triple(real r) {
        return (r*cos(th), r*sin(th), 2.1 - 0.3*r^2);
    }, 0.0, 2.2, operator ..);
}

for (real th = 0; th < pi; th += pi/4) {
    draw(rad_parabola(th), gray+0.5+dashed);
}

label("$\Sigma$ (线框曲面)", (1.0, 1.2, 1.5), N, fontsize(14));

// 边界圆周 Gamma (r = 2.2, z = 0.648)
triple f_gamma(real t) {
    return (2.2*cos(t), 2.2*sin(t), 2.1 - 0.3*2.2^2);
}

path3 g_gamma1 = graph(f_gamma, 0, pi, operator ..);
path3 g_gamma2 = graph(f_gamma, pi, 2*pi, operator ..);

// 绘制有向边界曲线 Gamma (逆时针)
draw(g_gamma1, red+1.8, arrow=Arrow3());
draw(g_gamma2, red+1.8, arrow=Arrow3());
label("$\Gamma$", f_gamma(pi/4) - (0.1, 0.1, 0), S, fontsize(14));

// 法向量函数
triple n_vec(triple pt) {
    return unit((0.6*pt.x, 0.6*pt.y, 1.0));
}

// 在曲面顶部附近绘制法向量 n
triple P_n = (0.4, 0.69, 2.1 - 0.3*0.64); // r=0.8, theta=pi/3
triple n_rep = n_vec(P_n);
draw(P_n--(P_n + 1.2*n_rep), darkgreen+1.5, arrow=Arrow3());
label("$\mathbf{n}$", P_n + 1.35*n_rep, N, fontsize(13));

// 绘制局部旋度环 (带箭头的逆时针小旋涡)
void draw_rot_loop(triple Q, real r_loop, string label_text="") {
    triple nQ = n_vec(Q);
    triple u = unit(cross(nQ, X));
    if (length(cross(nQ, X)) < 0.1) {
        u = unit(cross(nQ, Y));
    }
    triple v = unit(cross(nQ, u));
    
    // 用折线拼接画小圆弧，稍微留缺口展示方向，规避 graph3 库的潜在崩溃问题
    path3 loop1;
    int n_pts = 18;
    real max_t = 1.75 * pi;
    for (int i = 0; i <= n_pts; ++i) {
        real t = i * max_t / n_pts;
        loop1 = loop1 -- (Q + r_loop*cos(t)*u + r_loop*sin(t)*v);
    }
    
    draw(loop1, darkblue+1.2, arrow=Arrow3());
    if (label_text != "") {
        label(label_text, Q + 0.3*v + (0, 0, 0.1), N, fontsize(11));
    }
}

// 在曲面不同位置画小旋度环
triple Q1 = (1.2, 0.0, 2.1 - 0.3*1.44);
triple Q2 = (-0.65, 1.12, 2.1 - 0.3*1.69); // r=1.3, theta=2pi/3
triple Q3 = (-0.7, -0.7, 2.1 - 0.3*1.0);   // r=1.0, theta=-3pi/4

draw_rot_loop(Q1, 0.23, "$\nabla\times\mathbf{F}$");
draw_rot_loop(Q2, 0.23);
draw_rot_loop(Q3, 0.23);

// 标注斯托克斯公式
label("$\int_\Gamma \mathbf{F}\cdot d\mathbf{r} = \int_\Sigma (\nabla\times\mathbf{F})\cdot\mathbf{n}\,dS$", (0.0, 0.0, 2.7), N, fontsize(15));
label("Right-hand rule for $\Gamma$ and $\mathbf{n}$", (0.0, -2.4, 0.3), S, fontsize(12));
