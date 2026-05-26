settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import graph3;

real R = 1.8;
real H_sat = 4.0; // 卫星在 z = 4.0
real h = H_sat - R; // 高度 h = 2.2

// 视角
currentprojection = perspective(camera=(8, -6, 3), target=(0, 0, 1.6));

// 坐标轴
draw(O--2.6*X, L=Label("$x$", position=EndPoint, align=SW), black+1.2);
draw((-2.2)*Y--2.2*Y, L=Label("$y$", position=EndPoint, align=E), black+1.2);
draw(O--4.8*Z, L=Label("$z$", position=EndPoint, align=N), black+1.2);
label("$O$", O, SW);

// 1. 绘制地球 (半透明)
triple sphere_p(pair p) {
    real theta = p.x; real phi = p.y;
    return (R*sin(phi)*cos(theta), R*sin(phi)*sin(theta), R*cos(phi));
}
surface earth = surface(sphere_p, (0, 0), (2*pi, pi), nu=25, nv=25);
draw(earth, lightblue+opacity(0.12), meshpen=gray+0.6);

// 2. 绘制覆盖的球冠 (天顶角 phi 从 0 到 phi0)
real phi0 = acos(R / H_sat); 
surface cap = surface(sphere_p, (0, 0), (2*pi, phi0), nu=25, nv=10);
draw(cap, cyan+opacity(0.4), meshpen=blue+0.8);
label("覆盖球冠 (面积 $A$)", (R*sin(phi0/2), 0, R*cos(phi0/2)) + (0.1, 0, 0.1), NE, blue+fontsize(13));

// 3. 绘制切线圆锥面 (卫星到切点圆)
real z_cut = R^2 / H_sat; 
real rho_cut = R * sin(phi0); 
triple cone_p(pair p) {
    real u = p.x; real theta = p.y;
    triple pt = (rho_cut*cos(theta), rho_cut*sin(theta), z_cut);
    return (0, 0, H_sat) + u * (pt - (0, 0, H_sat));
}
surface satellite_cone = surface(cone_p, (0, 0), (1.0, 2*pi), nu=8, nv=25);
draw(satellite_cone, yellow+opacity(0.12), meshpen=orange+0.6);

// 4. 绘制切点圆 (红色高亮)
path3 cut_circle;
int n = 60;
for(int i=0; i<=n; ++i) {
    real theta = i * 2 * pi / n;
    triple pt = (rho_cut*cos(theta), rho_cut*sin(theta), z_cut);
    if (i == 0) cut_circle = pt; else cut_circle = cut_circle..pt;
}
cut_circle = cut_circle..cycle;
draw(cut_circle, red+1.8);

// 5. 绘制一侧的切线母线、球半径及直角符号 (在 xz 面)
triple T = (rho_cut, 0, z_cut); // 切点
triple S = (0, 0, H_sat); // 卫星点
draw(S--T, black+1.2);
draw(O--T, gray+dashed+1.2);
label("$R$", O--T, NW, fontsize(12));

// 直角符号 (在 T 点处，ST 垂直于 OT)
triple u_dir = unit(S - T);
triple v_dir = unit(-T); 
real s_len = 0.15;
triple a1 = T + s_len*u_dir;
triple b1 = T + s_len*v_dir;
triple c1 = T + s_len*u_dir + s_len*v_dir;
draw(a1--c1--b1, black+1.0);

// 6. 标记卫星高度 h
draw((-0.2, 0, R) -- (-0.2, 0, H_sat), black+1.0, arrow=Arrows3());
label("$h$", (-0.2, 0, (R+H_sat)/2), W, fontsize(12));

// 7. 标出地球另一侧的半径 R 示意线
triple p_R_left = (-R*sin(45*pi/180), 0, -R*cos(45*pi/180));
draw(O--p_R_left, black+1.2);
label("$R$", p_R_left/2, SE, fontsize(12));

// 8. 标出半顶角 \alpha (在卫星点 S 处，z轴负方向与切线之间)
path3 arc_alpha;
triple T_dir = unit(T - S);
for(int i=0; i<=15; ++i) {
    real t = i / 15.0;
    triple pt = S + 0.6*unit(t*T_dir + (1-t)*(-Z));
    if (i == 0) arc_alpha = pt; else arc_alpha = arc_alpha..pt;
}
draw(arc_alpha, black+1.0);
label("$\alpha$", S + 0.85*unit(T_dir + (-Z)), fontsize(12));

// 标出卫星位置
dot(S, red+5.0);
label("卫星", S, NE, red+fontsize(13));
