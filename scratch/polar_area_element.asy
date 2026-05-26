settings.outformat="png";
settings.tex="xelatex";
size(650);

pair O = (0,0);

// 坐标轴
draw(O--(4.2, 0), L=Label("$x$", position=EndPoint, align=S), black+1.5, arrow=Arrow(5));
draw(O--(0, 4.2), L=Label("$y$", position=EndPoint, align=W), black+1.5, arrow=Arrow(5));
dot(O, black+3.0);
label("$O$", O, SW);

// 极坐标参数
real r1 = 2.2;
real r2 = 3.0;
real a1 = 22; // 角度（度）
real a2 = 48;

// 辅助网格线 (灰色)
real[] r_grid = {1.4, 2.2, 3.0, 3.8};
real[] a_grid = {10, 22, 35, 48, 60};
for(real r : r_grid) {
    draw(arc(O, r, 5, 65), gray+0.8+dashed);
}
for(real a : a_grid) {
    draw(O--(4.0*cos(a*pi/180), 4.0*sin(a*pi/180)), gray+0.8+dashed);
}

// 扇形微元顶点
pair A = (r1*cos(a1*pi/180), r1*sin(a1*pi/180));
pair B = (r2*cos(a1*pi/180), r2*sin(a1*pi/180));
pair C = (r2*cos(a2*pi/180), r2*sin(a2*pi/180));
pair D = (r1*cos(a2*pi/180), r1*sin(a2*pi/180));

path arc_inner = arc(O, r1, a1, a2);
path arc_outer = arc(O, r2, a1, a2);

// 围成微元
path element = B -- arc_outer -- D -- reverse(arc_inner) -- cycle;

// 填充微元
fill(element, lightblue+opacity(0.4));
draw(element, blue+1.8);

// 标注: 半径 rho
pair p_rho = (r1*cos(35*pi/180), r1*sin(35*pi/180));
draw(O--p_rho, blue+1.2);
label("$\rho$", p_rho/2, NW, blue+fontsize(13));

// 标注: 夹角 d\theta
draw(arc(O, 0.7, a1, a2), black+1.0);
label("$d\theta$", (0.9*cos(35*pi/180), 0.9*sin(35*pi/180)), fontsize(12));

// 标注: 径向厚度 d\rho
// 使用双向箭头标出 d\rho
pair A_offset = A + 0.15*(-sin(a1*pi/180), cos(a1*pi/180));
pair B_offset = B + 0.15*(-sin(a1*pi/180), cos(a1*pi/180));
draw(A_offset -- B_offset, black+1.2, arrow=Arrows(4));
label("$d\rho$", (A_offset + B_offset)/2, NW, fontsize(13));

// 标注: 弧长 \rho d\theta
// 指向内侧圆弧的中点
pair mid_arc = (r1*cos(35*pi/180), r1*sin(35*pi/180));
draw(mid_arc + (0.3, -0.3) -- mid_arc + (0.02, -0.02), black+1.2, arrow=Arrow(4));
label("$\rho d\theta$", mid_arc + (0.3, -0.3), SE, fontsize(13));

// 标注: 面积元素 d\sigma
label("$d\sigma = \rho\,d\rho\,d\theta$", (2.7, 2.5), NE, blue+fontsize(15));
