settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import graph3;

real R = 3.0;

// 视角
currentprojection = perspective(camera=(7, -6, 5), target=(R/2, 0, R/3));

// 坐标轴
draw(O--(R+1.2)*X, L=Label("$x$", position=EndPoint, align=SW), black+1.5);
draw((-R/2)*Y--(R+1.2)*Y, L=Label("$y$", position=EndPoint, align=E), black+1.5);
draw(O--(R+1.2)*Z, L=Label("$z$", position=EndPoint, align=N), black+1.5);
label("$O$", O, SW);

// 1. 绘制上半球面 (只画第一、四象限部分以利于透视观察)
triple sphere_p(pair p) {
    real theta = p.x;
    real phi = p.y;
    return (R*sin(phi)*cos(theta), R*sin(phi)*sin(theta), R*cos(phi));
}
surface hemi = surface(sphere_p, (-pi/2, 0), (pi/2, pi/2), nu=25, nv=25);
draw(hemi, lightblue+opacity(0.2), meshpen=gray+0.6);

// 2. 绘制截出的圆柱面 (高度上限在球面上)
triple cyl_p(pair p) {
    real theta = p.x;
    real v = p.y;
    real z = v * R * abs(sin(theta));
    return (R*cos(theta)^2, R*cos(theta)*sin(theta), z);
}
surface cyl = surface(cyl_p, (-pi/2, 0), (pi/2, 1.0), nu=30, nv=15);
draw(cyl, lightgreen+opacity(0.35), meshpen=gray+0.7);

// 3. 绘制交线 (维维亚尼窗口边界)
path3 viviani_curve;
int n = 80;
for(int i=0; i<=n; ++i) {
    real theta = -pi/2 + i * pi / n;
    triple pt = (R*cos(theta)^2, R*cos(theta)*sin(theta), R*abs(sin(theta)));
    if (i == 0) viviani_curve = pt;
    else viviani_curve = viviani_curve..pt;
}
draw(viviani_curve, red+2.2);
label("维维亚尼曲线", point(viviani_curve, n/4) + (0.1, 0, 0.2), NE, red+fontsize(13));

// 4. 绘制 xy 面投影区域 D_xy
path3 proj_circle;
for(int i=0; i<=n; ++i) {
    real theta = -pi/2 + i * pi / n;
    triple pt = (R*cos(theta)^2, R*cos(theta)*sin(theta), 0);
    if (i == 0) proj_circle = pt;
    else proj_circle = proj_circle..pt;
}
proj_circle = proj_circle..cycle; // 闭合路径
draw(proj_circle, darkgreen+1.5);
draw(surface(proj_circle), lightgray+opacity(0.4));
label("$D_{xy}$", (R/2, 0, 0), fontsize(15));

// 标注方程
label("$x^2+y^2+z^2=R^2$", (0, -R, R/2), NW, blue+fontsize(13));
label("$x^2+y^2=Rx$", (R, 0, R/2), SE, darkgreen+fontsize(13));
