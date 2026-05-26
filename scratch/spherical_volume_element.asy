settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import graph3;

// 视角
currentprojection = perspective(camera=(8, -7, 5), target=(1.5, 1.2, 1.5));

// 坐标轴
draw(O--4.2*X, L=Label("$x$", position=EndPoint, align=SW), black+1.5);
draw(O--4.2*Y, L=Label("$y$", position=EndPoint, align=E), black+1.5);
draw(O--4.2*Z, L=Label("$z$", position=EndPoint, align=N), black+1.5);
label("$O$", O, SW);

// 球面坐标体积元参数
real r1 = 2.4;
real r2 = 3.2;
real phi1 = 30 * pi / 180;
real phi2 = 52 * pi / 180;
real theta1 = 18 * pi / 180;
real theta2 = 42 * pi / 180;

// 参数表面定义
// 1. 内球面 (r = r1)
triple sphere_inner(pair p) {
    real phi = p.x; real theta = p.y;
    return (r1*sin(phi)*cos(theta), r1*sin(phi)*sin(theta), r1*cos(phi));
}
surface face_in = surface(sphere_inner, (phi1, theta1), (phi2, theta2), nu=8, nv=8);

// 2. 外球面 (r = r2)
triple sphere_outer(pair p) {
    real phi = p.x; real theta = p.y;
    return (r2*sin(phi)*cos(theta), r2*sin(phi)*sin(theta), r2*cos(phi));
}
surface face_out = surface(sphere_outer, (phi1, theta1), (phi2, theta2), nu=8, nv=8);

// 3. 锥面1 (phi = phi1)
triple cone1(pair p) {
    real r = p.x; real theta = p.y;
    return (r*sin(phi1)*cos(theta), r*sin(phi1)*sin(theta), r*cos(phi1));
}
surface face_cone1 = surface(cone1, (r1, theta1), (r2, theta2), nu=8, nv=8);

// 4. 锥面2 (phi = phi2)
triple cone2(pair p) {
    real r = p.x; real theta = p.y;
    return (r*sin(phi2)*cos(theta), r*sin(phi2)*sin(theta), r*cos(phi2));
}
surface face_cone2 = surface(cone2, (r1, theta1), (r2, theta2), nu=8, nv=8);

// 5. 子午面1 (theta = theta1)
triple plane1(pair p) {
    real r = p.x; real phi = p.y;
    return (r*sin(phi)*cos(theta1), r*sin(phi)*sin(theta1), r*cos(phi));
}
surface face_plane1 = surface(plane1, (r1, phi1), (r2, phi2), nu=8, nv=8);

// 6. 子午面2 (theta = theta2)
triple plane2(pair p) {
    real r = p.x; real phi = p.y;
    return (r*sin(phi)*cos(theta2), r*sin(phi)*sin(theta2), r*cos(phi));
}
surface face_plane2 = surface(plane2, (r1, phi1), (r2, phi2), nu=8, nv=8);

// 绘制半透明面
draw(face_in, lightblue+opacity(0.3), meshpen=gray+0.7);
draw(face_out, lightblue+opacity(0.4), meshpen=gray+0.7);
draw(face_cone1, lightblue+opacity(0.35), meshpen=gray+0.7);
draw(face_cone2, lightblue+opacity(0.35), meshpen=gray+0.7);
draw(face_plane1, lightblue+opacity(0.35), meshpen=gray+0.7);
draw(face_plane2, lightblue+opacity(0.35), meshpen=gray+0.7);

// 8个顶点计算
triple P00 = (r1*sin(phi1)*cos(theta1), r1*sin(phi1)*sin(theta1), r1*cos(phi1));
triple P10 = (r1*sin(phi2)*cos(theta1), r1*sin(phi2)*sin(theta1), r1*cos(phi2));
triple P11 = (r1*sin(phi2)*cos(theta2), r1*sin(phi2)*sin(theta2), r1*cos(phi2));
triple P01 = (r1*sin(phi1)*cos(theta2), r1*sin(phi1)*sin(theta2), r1*cos(phi1));

triple Q00 = (r2*sin(phi1)*cos(theta1), r2*sin(phi1)*sin(theta1), r2*cos(phi1));
triple Q10 = (r2*sin(phi2)*cos(theta1), r2*sin(phi2)*sin(theta1), r2*cos(phi2));
triple Q11 = (r2*sin(phi2)*cos(theta2), r2*sin(phi2)*sin(theta2), r2*cos(phi2));
triple Q01 = (r2*sin(phi1)*cos(theta2), r2*sin(phi1)*sin(theta2), r2*cos(phi1));

// 绘制径向棱线
draw(P00--Q00, black+1.0);
draw(P10--Q10, black+1.2);
draw(P11--Q11, black+1.2);
draw(P01--Q01, black+1.2);

// 绘制经纬向圆弧棱线
path3 arc_phi(real r, real theta) {
    path3 p; int m=20;
    for(int i=0; i<=m; ++i) {
        real phi = phi1 + i*(phi2-phi1)/m;
        triple pt = (r*sin(phi)*cos(theta), r*sin(phi)*sin(theta), r*cos(phi));
        if(i==0) p = pt; else p = p..pt;
    }
    return p;
}
path3 arc_theta(real r, real phi) {
    path3 p; int m=20;
    for(int i=0; i<=m; ++i) {
        real theta = theta1 + i*(theta2-theta1)/m;
        triple pt = (r*sin(phi)*cos(theta), r*sin(phi)*sin(theta), r*cos(phi));
        if(i==0) p = pt; else p = p..pt;
    }
    return p;
}

draw(arc_phi(r1, theta1), black+1.0);
draw(arc_phi(r1, theta2), black+1.2);
draw(arc_phi(r2, theta1), black+1.2);
draw(arc_phi(r2, theta2), black+1.2);

draw(arc_theta(r1, phi1), black+1.0);
draw(arc_theta(r1, phi2), black+1.2);
draw(arc_theta(r2, phi1), black+1.2);
draw(arc_theta(r2, phi2), black+1.2);

// 投影到xy面
triple P00_xy = (P00.x, P00.y, 0);
triple P10_xy = (P10.x, P10.y, 0);
triple P11_xy = (P11.x, P11.y, 0);
triple P01_xy = (P01.x, P01.y, 0);

draw(P00--P00_xy, gray+dashed+1.0);
draw(P10--P10_xy, gray+dashed+1.0);
draw(P11--P11_xy, gray+dashed+1.0);
draw(P01--P01_xy, gray+dashed+1.0);

// 原点到顶点辅助线(向径 r)
draw(O--P00, gray+1.2);
label("$r$", P00/2, NW, fontsize(12));

// z轴与向径夹角 phi 标记
path3 arc_phi_o;
int m=15;
for(int i=0; i<=m; ++i) {
    real phi = i * phi1 / m;
    triple p = (0.7*sin(phi)*cos(theta1), 0.7*sin(phi)*sin(theta1), 0.7*cos(phi));
    if(i==0) arc_phi_o = p; else arc_phi_o = arc_phi_o..p;
}
draw(arc_phi_o, black+1.0);
label("$\varphi$", (0.9*sin(phi1/2)*cos(theta1), 0.9*sin(phi1/2)*sin(theta1), 0.9*cos(phi1/2)), fontsize(11));

// dphi 标记
path3 arc_dphi_o;
for(int i=0; i<=m; ++i) {
    real phi = phi1 + i * (phi2 - phi1) / m;
    triple p = (0.6*sin(phi)*cos(theta1), 0.6*sin(phi)*sin(theta1), 0.6*cos(phi));
    if(i==0) arc_dphi_o = p; else arc_dphi_o = arc_dphi_o..p;
}
draw(arc_dphi_o, black+1.0);
label("$d\varphi$", (0.8*sin((phi1+phi2)/2)*cos(theta1), 0.8*sin((phi1+phi2)/2)*sin(theta1), 0.8*cos((phi1+phi2)/2)), fontsize(10));

// xy平面上的 theta 和 dtheta
draw(O--P00_xy, gray+dashed+1.0);
draw(O--P01_xy, gray+dashed+1.0);

path3 arc_theta_xy;
for(int i=0; i<=m; ++i) {
    real theta = i * theta1 / m;
    triple p = (0.8*cos(theta), 0.8*sin(theta), 0);
    if(i==0) arc_theta_xy = p; else arc_theta_xy = arc_theta_xy..p;
}
draw(arc_theta_xy, black+1.0);
label("$\theta$", (1.0*cos(theta1/2), 1.0*sin(theta1/2), 0), fontsize(11));

path3 arc_dtheta_xy;
for(int i=0; i<=m; ++i) {
    real theta = theta1 + i * (theta2 - theta1) / m;
    triple p = (0.7*cos(theta), 0.7*sin(theta), 0);
    if(i==0) arc_dtheta_xy = p; else arc_dtheta_xy = arc_dtheta_xy..p;
}
draw(arc_dtheta_xy, black+1.0);
label("$d\theta$", (0.9*cos((theta1+theta2)/2), 0.9*sin((theta1+theta2)/2), 0), fontsize(10));

// 标注三棱长
// 1. dr
pair Q11_offset = (Q11.x, Q11.y) + 0.15*(-sin(theta2), cos(theta2));
triple Q11_off_3d = (Q11_offset.x, Q11_offset.y, Q11.z);
triple P11_off_3d = (Q11_offset.x, Q11_offset.y, P11.z);
draw(P11_off_3d--Q11_off_3d, black+1.0, arrow=Arrows3());
label("$dr$", (P11_off_3d+Q11_off_3d)/2, (0, 0, 1), fontsize(12));

// 2. r*dphi
triple mid_phi_arc = point(arc_phi(r2, theta2), m/2);
draw(mid_phi_arc + (0.3, 0, 0.2) -- mid_phi_arc, black+1.0, arrow=Arrow3(4));
label("$r\,d\varphi$", mid_phi_arc + (0.3, 0, 0.2), NE, fontsize(12));

// 3. r*sin(phi)*dtheta
triple mid_theta_arc = point(arc_theta(r2, phi2), m/2);
draw(mid_theta_arc + (0.2, 0.3, -0.1) -- mid_theta_arc, black+1.0, arrow=Arrow3(4));
label("$r\sin\varphi\,d\theta$", mid_theta_arc + (0.2, 0.3, -0.1), NE, fontsize(12));

// dV
label("$dV = r^2\sin\varphi\,dr\,d\varphi\,d\theta$", (r2, r2, 2.5), NE, blue+fontsize(15));
