settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import graph3;

real R = 3.0;

// 视角
currentprojection = perspective(camera=(8, 7, 5), target=(R/2, R/2, R/2));

// 坐标轴
draw(O--(R+1.5)*X, L=Label("$x$", position=EndPoint, align=SW), black+1.5);
draw(O--(R+1.5)*Y, L=Label("$y$", position=EndPoint, align=E), black+1.5);
draw(O--(R+1.5)*Z, L=Label("$z$", position=EndPoint, align=N), black+1.5);
label("$O$", O, SW);

// 顶面柱面: x=R*cos(theta), y=v*R*sin(theta), z=R*sin(theta)
triple surface_top(pair p) {
    real theta = p.x;
    real v = p.y;
    return (R*cos(theta), v*R*sin(theta), R*sin(theta));
}
surface top_face = surface(surface_top, (0,0), (pi/2, 1.0), nu=15, nv=15);

// 右侧面柱面: x=R*cos(theta), y=R*sin(theta), z=v*R*sin(theta)
triple surface_right(pair p) {
    real theta = p.x;
    real v = p.y;
    return (R*cos(theta), R*sin(theta), v*R*sin(theta));
}
surface right_face = surface(surface_right, (0,0), (pi/2, 1.0), nu=15, nv=15);

// 绘制半透明表面
draw(top_face, lightblue+opacity(0.4), meshpen=gray+0.8);
draw(right_face, lightgreen+opacity(0.4), meshpen=gray+0.8);

// 绘制交线 (y = z = sqrt(R^2-x^2))
path3 intersection_curve;
int n = 50;
for(int i=0; i<=n; ++i) {
    real theta = i * (pi/2) / n;
    triple pt = (R*cos(theta), R*sin(theta), R*sin(theta));
    if (i == 0) intersection_curve = pt;
    else intersection_curve = intersection_curve..pt;
}
draw(intersection_curve, red+2.2);
label("交线 $y=z$", point(intersection_curve, n/2), N, red+fontsize(13));

// 绘制外边缘圆弧
path3 bottom_arc;
path3 back_arc;
for(int i=0; i<=n; ++i) {
    real theta = i * (pi/2) / n;
    if (i == 0) {
        bottom_arc = (R*cos(theta), R*sin(theta), 0);
        back_arc = (R*cos(theta), 0, R*sin(theta));
    } else {
        bottom_arc = bottom_arc..(R*cos(theta), R*sin(theta), 0);
        back_arc = back_arc..(R*cos(theta), 0, R*sin(theta));
    }
}
draw(bottom_arc, black+1.5);
draw(back_arc, black+1.5);

// 绘制立体的直角棱线
draw(O--R*X, black+1.5);
draw(O--R*Y, black+1.5);
draw(O--R*Z, black+1.5);

// 标注
dot(R*X, black+4.0);
dot(R*Y, black+4.0);
dot(R*Z, black+4.0);
label("$R$", R*X, S, fontsize(12));
label("$R$", R*Y, E, fontsize(12));
label("$R$", R*Z, W, fontsize(12));

label("$z=\sqrt{R^2-x^2}$", (R/2, R/4, R*sin(acos(1/2))), NW, blue+fontsize(13));
label("$y=\sqrt{R^2-x^2}$", (R/2, R*sin(acos(1/2)), R/4), SE, darkgreen+fontsize(13));

label("牟合方盖", (R/2, R/2, R), NE, fontsize(15));
label("(第一卦限部分)", (R/2, R/2, R) + (0, 0, -0.3), NE, fontsize(12));
