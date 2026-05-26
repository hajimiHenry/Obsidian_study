settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import graph3;

// 视角
currentprojection = perspective(camera=(7, 5, 4), target=(1.2, 1.2, 1.8));

// 坐标轴
draw(O--3.5*X, L=Label("$x$", position=EndPoint, align=SW), black+1.5);
draw(O--3.5*Y, L=Label("$y$", position=EndPoint, align=E), black+1.5);
draw(O--4.2*Z, L=Label("$z$", position=EndPoint, align=N), black+1.5);
label("$O$", O, SW);

// 曲面定义 z = f(x,y)
real f(real x, real y) {
    return 3.0 - 0.1*x^2 - 0.1*y^2;
}
real f_pair(pair p) {
    return f(p.x, p.y);
}
surface s_surf = surface(f_pair, (0.4, 0.4), (2.5, 2.5), nx=12, ny=12);
draw(s_surf, lightblue+opacity(0.2), meshpen=gray+0.6);
label("$z=f(x,y)$", (1.0, 1.0, f(1.0,1.0)) + (-0.2, -0.2, 0.4), NW, blue+fontsize(14));

// 投影微元 d\sigma
real x0 = 1.3, y0 = 1.3;
real dx = 0.5, dy = 0.5;
triple P00 = (x0, y0, 0);
triple P10 = (x0+dx, y0, 0);
triple P11 = (x0+dx, y0+dy, 0);
triple P01 = (x0, y0+dy, 0);
path3 dsigma = P00--P10--P11--P01--cycle;
draw(surface(dsigma), lightgray+opacity(0.4));
draw(dsigma, black+1.2);
label("$d\sigma = dx dy$", (x0+dx/2, y0+dy/2, 0), fontsize(12));

// 计算 Q00 点处的导数和切向量
real fx = -0.2*x0; 
real fy = -0.2*y0; 
triple Tx = (1, 0, fx);
triple Ty = (0, 1, fy);

// 切平面小片 dS 的顶点
triple Q00 = (x0, y0, f(x0, y0));
triple Q10 = Q00 + dx*Tx;
triple Q11 = Q00 + dx*Tx + dy*Ty;
triple Q01 = Q00 + dy*Ty;
path3 dS = Q00--Q10--Q11--Q01--cycle;
draw(surface(dS), orange+opacity(0.55));
draw(dS, orange+1.5);
label("$dS$", (Q00+Q11)/2 + (0.1, 0.1, 0.2), NW, orange+fontsize(13));

// 投影线 (虚线)
draw(P00--Q00, gray+dashed+1.0);
draw(P10--Q10, gray+dashed+1.0);
draw(P11--Q11, gray+dashed+1.0);
draw(P01--Q01, gray+dashed+1.0);

// 法向量 n
triple n_vec = unit((-fx, -fy, 1.0)); 
draw(Q00 -- Q00 + 1.2*n_vec, red+1.8, arrow=Arrow3());
label("$\mathbf{n}$", Q00 + 1.3*n_vec, N, red+fontsize(13));

// 倾角 \gamma 标记 (法向量与 z 方向夹角)
triple z_dir = Z;
draw(Q00 -- Q00 + 1.2*z_dir, gray+dashed+1.0);
path3 arc_gamma;
for(int i=0; i<=15; ++i) {
    real t = i / 15.0;
    triple pt = Q00 + 0.5*unit(t*n_vec + (1-t)*z_dir);
    if (i == 0) arc_gamma = pt; else arc_gamma = arc_gamma..pt;
}
draw(arc_gamma, black+1.0);
label("$\gamma$", Q00 + 0.65*unit(n_vec + z_dir), fontsize(11));

// 面积关系公式标注
label("$dS = \frac{d\sigma}{\cos\gamma}$", (2.2, 2.2, 3.2), NE, blue+fontsize(14));
