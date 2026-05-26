settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(600);

// 定义极坐标转直角坐标的函数
pair P(real r, real t) { return (r*cos(t), r*sin(t)); }

// 角度范围 (弧度)
real t1 = 0.25;
real t2 = 0.85;
real t_mid = 0.5 * (t1 + t2);

// 径向厚度
real dr = 0.6;

// 内侧微元参数 (整体外推以腾出内侧空间)
real r1 = 1.6;
real r2 = r1 + dr;

// 外侧微元参数 (整体外推)
real R1 = 3.3;
real R2 = R1 + dr;

// 生成微元扇形区域的路径
path wedge(real rb, real rt, real ta, real tb) {
    path p = P(rb, ta);
    int n = 20;
    for(int i=1; i<=n; ++i) {
        real t = ta + (tb-ta)*i/n;
        p = p--P(rb, t);
    }
    for(int i=n; i>=0; --i) {
        real t = ta + (tb-ta)*i/n;
        p = p--P(rt, t);
    }
    return p--cycle;
}

path cell_inner = wedge(r1, r2, t1, t2);
path cell_outer = wedge(R1, R2, t1, t2);

// 填充微元 (使用高对比度但温和的淡色)
fill(cell_inner, rgb(0.85, 0.93, 1.0));
fill(cell_outer, rgb(1.0, 0.9, 0.8));

// 描边微元
draw(cell_inner, rgb(0.2, 0.5, 0.85)+1.2);
draw(cell_outer, rgb(0.85, 0.4, 0.2)+1.2);

// 画坐标轴 (使用直角坐标，延伸长度)
draw((0,0)--(4.5, 0), black+0.8, arrow=Arrow(SimpleHead));
draw((0,0)--(0, 3.8), black+0.8, arrow=Arrow(SimpleHead));
label("$x$", (4.5, 0), S, fontsize(14));
label("$y$", (0, 3.8), W, fontsize(14));

// 画射线
draw((0,0)--P(4.2, t1), gray(0.5)+0.6);
draw((0,0)--P(4.2, t2), gray(0.5)+0.6);

// 标注 d\theta (放在半径 0.6 处，避开任何干扰)
path arc_theta;
real r_theta = 0.6;
arc_theta = P(r_theta, t1);
for(int i=1; i<=20; ++i) {
    real t = t1 + (t2-t1)*i/20;
    arc_theta = arc_theta--P(r_theta, t);
}
draw(arc_theta, black+0.8, Arrows(SimpleHead));
label("$d\theta$", P(r_theta + 0.12, t_mid), NE, fontsize(14));

// 标注 d\rho (向外侧法向偏置，避开微元边界)
pair offset = 0.12 * (-sin(t2), cos(t2));
pair p1_inner = P(r1, t2);
pair p2_inner = P(r2, t2);
draw((p1_inner+offset)--(p2_inner+offset), black+0.8, Arrows(SimpleHead));
label("$d\rho$", 0.5*(p1_inner+p2_inner)+offset, NW, fontsize(14));

pair p1_outer = P(R1, t2);
pair p2_outer = P(R2, t2);
draw((p1_outer+offset)--(p2_outer+offset), black+0.8, Arrows(SimpleHead));
label("$d\rho$", 0.5*(p1_outer+p2_outer)+offset, NW, fontsize(14));

// 标注内弧长 \rho_1 d\theta 和外弧长 \rho_2 d\theta
real rb1 = r1 - 0.18;
path arc_b1 = P(rb1, t1);
for(int i=1; i<=20; ++i) {
    real t = t1 + (t2-t1)*i/20;
    arc_b1 = arc_b1--P(rb1, t);
}
draw(arc_b1, rgb(0.2, 0.5, 0.85)+0.8, Arrows(SimpleHead));
label("$\rho_1 d\theta$", P(rb1 - 0.15, t_mid), SW, fontsize(14));

real rb2 = R1 - 0.18;
path arc_b2 = P(rb2, t1);
for(int i=1; i<=20; ++i) {
    real t = t1 + (t2-t1)*i/20;
    arc_b2 = arc_b2--P(rb2, t);
}
draw(arc_b2, rgb(0.85, 0.4, 0.2)+0.8, Arrows(SimpleHead));
label("$\rho_2 d\theta$", P(rb2 - 0.15, t_mid), SW, fontsize(14));

// 标注半径 \rho_1 和 \rho_2 (移动到射线两侧的空旷区域)
real t_rho1 = 0.14; // 射线 t1 下方，稍微抬高避开 x 轴
draw((0,0)--P(r1, t_rho1), gray(0.4)+dashed+0.8, arrow=Arrow(SimpleHead));
label("$\rho_1$", P(0.55*r1, t_rho1), S, fontsize(14));

real t_rho2 = 0.98; // 射线 t2 上方
draw((0,0)--P(R1, t_rho2), gray(0.4)+dashed+0.8, arrow=Arrow(SimpleHead));
label("$\rho_2$", P(0.35*R1, t_rho2), NW, fontsize(14));

// 标注面积 d\sigma_1 和 d\sigma_2 (使用平滑引线引出到开阔区域)
pair c1 = P(0.5*(r1+r2), t_mid);
pair tag1 = (2.2, 0.35); // 引出到 x 轴上方的开阔区
draw(c1--tag1, gray(0.4)+0.8);
label("$d\sigma_1 \approx \rho_1 d\rho d\theta$", tag1, E, fontsize(14));

pair c2 = P(0.5*(R1+R2), t_mid);
pair tag2 = c2 + (0.5, 0.35); // 引出到右上方开阔区
draw(c2--tag2, gray(0.4)+0.8);
label("$d\sigma_2 \approx \rho_2 d\rho d\theta$", tag2, E, fontsize(14));

// 原点 O
dot((0,0), linewidth(5));
label("$O$", (0,0), SW, fontsize(14));
