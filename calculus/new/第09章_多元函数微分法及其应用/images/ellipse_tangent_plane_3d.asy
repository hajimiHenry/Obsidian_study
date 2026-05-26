settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
import graph3;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(6, -6, 5);

// 坐标轴
draw((0,0,0)--(6.0,0,0), black+0.8, arrow=Arrow3());
draw((0,0,0)--(0,4.5,0), black+0.8, arrow=Arrow3());
draw((0,0,0)--(0,0,4.5), black+0.8, arrow=Arrow3());
label("$x$", (5.8,-0.2,0), S, fontsize(15));
label("$y$", (0.2,4.3,0), E, fontsize(15));
label("$z$", (0,0.2,4.3), N, fontsize(15));

// 椭球面：x^2/9 + y^2/4 + z^2/4 = 1 的第 I 卦限
triple f(pair p) {
  real u = p.x; // theta in [0, pi/2]
  real v = p.y; // phi in [0, pi/2]
  return (3*sin(u)*cos(v), 2*sin(u)*sin(v), 2*cos(u));
}
surface s = surface(f, (0,0), (pi/2, pi/2), 15, 15);
draw(s, lightgray+opacity(0.55), meshpen=gray(0.5)+0.3);

// 切点 M0 (x0, y0, z0) 取体积最小值的切点
real x0 = 3/sqrt(3);
real y0 = 2/sqrt(3);
real z0 = 2/sqrt(3);
triple M0 = (x0, y0, z0);

// 切平面截坐标轴的三个交点
triple Ap = (9/x0, 0, 0);
triple Bp = (0, 4/y0, 0);
triple Cp = (0, 0, 4/z0);

// 绘制切平面本身 (三角形 A-B-C)
path3 plane_tri = Ap--Bp--Cp--cycle;
draw(surface(plane_tri), lightblue+opacity(0.35));
draw(plane_tri, blue+1.0);

// 绘制法向量 (从 M0 出发)
// 椭球面在该点处的法向量方向为 (x0/9, y0/4, z0/4)
triple grad_dir = unit((x0/9, y0/4, z0/4));
triple arrow_tip = M0 + 1.25 * grad_dir;
draw(M0--arrow_tip, heavyred+1.8, arrow=Arrow3());

// 先画线，后画 dot
dot(M0, linewidth(6));

// 标注
label("$M_0(x_0,y_0,z_0)$", M0 + (-0.1, -0.15, 0.15), W, fontsize(14));
label("$\nabla F$", arrow_tip + 0.12*grad_dir, NE, heavyred+fontsize(15));
label("切平面 $\frac{x_0}{a^2}x + \frac{y_0}{b^2}y + \frac{z_0}{c^2}z = 1$", Cp + (0.15, 0.15, 0.2), NE, blue+fontsize(13));
label("椭球面 $\frac{x^2}{a^2} + \frac{y^2}{b^2} + \frac{z^2}{c^2} = 1$", (2.2, 0.2, 0.6), NE, fontsize(13));
