settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
import graph3;

// 设置视角
currentprojection = perspective(camera=(8, 7, 5), target=(0, 0, 0));

// 坐标轴
draw(O--3.5*X, L=Label("$x$", EndPoint, fontsize(13)), arrow=Arrow3());
draw(O--3.5*Y, L=Label("$y$", EndPoint, fontsize(13)), arrow=Arrow3());
draw(O--3.2*Z, L=Label("$z$", EndPoint, fontsize(13)), arrow=Arrow3());

// 使用经纬线框 (Wireframe) 绘制椭球，避开 surface 编译崩溃，且方便看清内部
// 1. 绘制纬线圆环
path3 latitude_circle(real theta) {
    real r = 2.0 * sin(theta);
    real z = 1.414 * cos(theta);
    return graph(new triple(real phi) {
        return (r*cos(phi), r*sin(phi), z);
    }, 0, 2*pi, operator ..);
}

for (real th = pi/6; th < pi; th += pi/6) {
    draw(latitude_circle(th), gray+0.5+dashed);
}

// 2. 绘制经线椭圆
path3 longitude_ellipse(real phi) {
    return graph(new triple(real th) {
        return (2.0*sin(th)*cos(phi), 2.0*sin(th)*sin(phi), 1.414*cos(th));
    }, 0, pi, operator ..);
}

for (real ph = 0; ph < pi; ph += pi/4) {
    draw(longitude_ellipse(ph), gray+0.5+dashed);
}

label("$\Sigma$ (线框边界)", (1.8, 1.0, 0.8), NE, fontsize(14));
label("$\Omega$", (-0.5, -0.6, -0.6), fontsize(15));

// 椭球面外法向量计算
triple ell_normal(triple pt) {
    return unit((pt.x / 2.0, pt.y / 2.0, pt.z));
}

// 绘制几个外法向量 n
triple[] pts = {
    (1.414, 1.414, 0.0),
    (0.0, 2.0, 0.0),
    (-1.414, 1.414, 0.0),
    (1.0, 0.0, 1.22),
    (-1.0, -1.0, -0.86),
    (0.0, -2.0, 0.0)
};

for (int i = 0; i < pts.length; ++i) {
    triple pt = pts[i];
    triple n = ell_normal(pt);
    draw(pt--(pt + 0.7*n), darkgreen+1.5, arrow=Arrow3());
    if (i == 0) {
        label("$\mathbf{n}$", pt + 0.85*n, N, fontsize(13));
    }
}

// 内部散度物理概念：正源 div F > 0
triple C1 = (0.7, 0.5, 0.4);
real r_src = 0.28;
triple[] dirs = { X, Y, Z, -X, -Y, -Z };
for (triple d : dirs) {
    draw(C1--(C1 + r_src*d), red+1.2, arrow=Arrow3());
}
label("$\nabla\cdot\mathbf{F} > 0$", C1 + (0.1, 0.1, 0.35), N, fontsize(11));

// 内部散度物理概念：负源 (汇) div F < 0
triple C2 = (-0.7, -0.5, -0.3);
for (triple d : dirs) {
    draw((C2 + r_src*d)--C2, blue+1.2, arrow=Arrow3());
}
label("$\nabla\cdot\mathbf{F} < 0$", C2 + (-0.1, -0.1, 0.35), N, fontsize(11));

// 标注高斯散度公式
label("$\int_\Sigma \mathbf{F}\cdot\mathbf{n}\,dS = \int_\Omega (\nabla\cdot\mathbf{F})\,dV$", (0.0, 0.0, 2.3), N, fontsize(15));
