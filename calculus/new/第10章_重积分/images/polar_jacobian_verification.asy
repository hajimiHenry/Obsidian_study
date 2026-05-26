settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(550);

texpreamble("\usepackage{amsmath}");

// 定义点计算函数 (改用 polar 以免保留字/重名冲突)
pair polar(real r, real t) { return (r*cos(t), r*sin(t)); }

pair O = (0,0);
draw(O--(3.8, 0), black+0.8, arrow=Arrow(SimpleHead));
draw(O--(0, 3.2), black+0.8, arrow=Arrow(SimpleHead));
label("$x$", (3.8, 0), S, fontsize(14));
label("$y$", (0, 3.2), W, fontsize(14));
label("$O$", O, SW, fontsize(14));

real t1 = 0.30;
real t2 = 0.80;
real t_mid = 0.5 * (t1 + t2);

real r1 = 2.0;
real dr = 0.6;
real r2 = r1 + dr;

// 绘制网格线
draw(O--polar(3.2, t1), gray(0.5)+0.6);
draw(O--polar(3.2, t2), gray(0.5)+0.6);

// 生成微元扇形区域 of 网格路径
path wedge(real rb, real rt, real ta, real tb) {
    path p = polar(rb, ta);
    int n = 20;
    for(int i=1; i<=n; ++i) {
        real t = ta + (tb-ta)*i/n;
        p = p--polar(rb, t);
    }
    for(int i=n; i>=0; --i) {
        real t = ta + (tb-ta)*i/n;
        p = p--polar(rt, t);
    }
    return p--cycle;
}

path cell = wedge(r1, r2, t1, t2);
fill(cell, rgb(0.85, 0.93, 1.0));
draw(cell, rgb(0.2, 0.5, 0.85)+1.2);

// 标注 d\rho
pair offset = 0.12 * (-sin(t2), cos(t2));
pair p1 = polar(r1, t2);
pair p2 = polar(r2, t2);
draw((p1+offset)--(p2+offset), black+0.8, Arrows(SimpleHead));
label("$d\rho$", 0.5*(p1+p2)+offset, NW, fontsize(13));

// 标注内弧长 \rho d\theta
real rb = r1 - 0.15;
path arc_b = polar(rb, t1);
for(int i=1; i<=20; ++i) {
    real t = t1 + (t2-t1)*i/20;
    arc_b = arc_b--polar(rb, t);
}
draw(arc_b, rgb(0.2, 0.5, 0.85)+0.8, Arrows(SimpleHead));
label("$\rho\,d\theta$", polar(rb - 0.15, t_mid), SW, fontsize(13));

// 标注半径 \rho
real t_rho = 0.12;
draw(O--polar(r1, t_rho), gray(0.4)+dashed+0.8, arrow=Arrow(SimpleHead));
label("$\rho$", polar(0.5*r1, t_rho), S, fontsize(13));

// 标注角增量 d\theta
path arc_theta;
real r_theta = 0.7;
arc_theta = polar(r_theta, t1);
for(int i=1; i<=20; ++i) {
    real t = t1 + (t2-t1)*i/20;
    arc_theta = arc_theta--polar(r_theta, t);
}
draw(arc_theta, black+0.8, Arrows(SimpleHead));
label("$d\theta$", polar(r_theta + 0.15, t_mid), NE, fontsize(13));

dot(O, linewidth(5));

// 旁边标注计算式
label("$\vec{a} \approx \begin{pmatrix} \cos\theta \\ \sin\theta \end{pmatrix} d\rho$", (2.1, 2.5), E, fontsize(13));
label("$\vec{b} \approx \begin{pmatrix} -\rho\sin\theta \\ \rho\cos\theta \end{pmatrix} d\theta$", (2.1, 2.05), E, fontsize(13));
label("$d\sigma = |\vec{a} \times \vec{b}| = \rho\,d\rho\,d\theta$", (2.1, 1.6), E, fontsize(13));
label("$\text{Jacobian: } |J| = \rho$", (2.1, 1.25), E, fontsize(13));
