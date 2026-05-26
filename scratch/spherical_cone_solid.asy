settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import graph3;

real a = 1.5;
real alpha = 35 * pi / 180; // 半顶角 35 度

// 视角
currentprojection = perspective(camera=(7, -6, 4.5), target=(0, 0, 1.3));

// 坐标轴
draw(O--2.5*X, L=Label("$x$", position=EndPoint, align=SW), black+1.5);
draw((-1.5)*Y--2.2*Y, L=Label("$y$", position=EndPoint, align=E), black+1.5);
draw(O--3.8*Z, L=Label("$z$", position=EndPoint, align=N), black+1.5);
label("$O$", O, SW);

// 1. 绘制下部锥面 (r 从 0 到 2a*cos(alpha))
real r_inter = 2*a*cos(alpha);
triple cone_surface(pair p) {
    real u = p.x;
    real theta = p.y;
    return (u*sin(alpha)*cos(theta), u*sin(alpha)*sin(theta), u*cos(alpha));
}
surface cone = surface(cone_surface, (0, 0), (r_inter, 2*pi), nu=15, nv=30);
draw(cone, lightgreen+opacity(0.35), meshpen=gray+0.7);

// 2. 绘制上部球冠 (phi 从 0 到 alpha)
triple cap_surface(pair p) {
    real phi = p.x;
    real theta = p.y;
    real r = 2*a*cos(phi);
    return (r*sin(phi)*cos(theta), r*sin(phi)*sin(theta), r*cos(phi));
}
surface cap = surface(cap_surface, (0, 0), (alpha, 2*pi), nu=15, nv=30);
draw(cap, lightblue+opacity(0.35), meshpen=gray+0.7);

// 3. 绘制交线圆 (高亮红色)
path3 inter_circle;
int n = 60;
for(int i=0; i<=n; ++i) {
    real theta = i * 2 * pi / n;
    triple pt = (r_inter*sin(alpha)*cos(theta), r_inter*sin(alpha)*sin(theta), r_inter*cos(alpha));
    if (i == 0) inter_circle = pt; else inter_circle = inter_circle..pt;
}
inter_circle = inter_circle..cycle;
draw(inter_circle, red+1.8);

// 4. 绘制特征子午面母线和夹角 alpha 标注
triple p_cone_tip = (r_inter*sin(alpha), 0, r_inter*cos(alpha));
draw(O--p_cone_tip, black+1.5);

path3 arc_phi;
for(int i=0; i<=15; ++i) {
    real phi = i * alpha / 15;
    triple pt = (0.7*sin(phi), 0, 0.7*cos(phi));
    if (i == 0) arc_phi = pt; else arc_phi = arc_phi..pt;
}
draw(arc_phi, black+1.2);
label("$\alpha$", (0.9*sin(alpha/2), 0, 0.9*cos(alpha/2)), fontsize(12));

// 标注方程
label("$r=2a\cos\varphi$", (r_inter*sin(alpha/2), 0, 2*a*cos(alpha/2)) + (0.1, 0, 0.2), E, blue+fontsize(14));
label("$\varphi=\alpha$", p_cone_tip + (0.1, 0, -0.2), SE, darkgreen+fontsize(14));

// 立体内部虚线圆 (整个球的下半部分边界，以暗示它是球)
path3 sphere_back_circle;
for(int i=0; i<=n; ++i) {
    real theta = i * 2 * pi / n;
    triple pt = (a*cos(theta), a*sin(theta), a);
    if (i == 0) sphere_back_circle = pt; else sphere_back_circle = sphere_back_circle..pt;
}
sphere_back_circle = sphere_back_circle..cycle;
draw(sphere_back_circle, gray+dashed+1.0);
label("球心 $(0,0,a)$", (0, 0, a), E, gray+fontsize(11));
dot((0,0,a), gray+4.0);
