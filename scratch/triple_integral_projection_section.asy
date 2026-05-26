settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(750);
import graph3;

// 视角
currentprojection = perspective(camera=(8, -8, 6), target=(1.2, 3.0, 1.2));

// ================== 左图: 投影法 ==================
triple O1 = (0,0,0);
draw(O1--3.0*X, black+1.2);
draw(O1--3.0*Y, black+1.2);
draw(O1--3.2*Z, black+1.2);
label("$x$", 3.0*X, SW);
label("$y$", 3.0*Y, SE);
label("$z$", 3.2*Z, N);
label("$O$", O1, SW);

// 投影法球体
triple sphere_left(pair p) {
    real theta = p.x;
    real phi = p.y;
    real r = 0.8;
    return (1.2 + r*sin(phi)*cos(theta), 1.2 + r*sin(phi)*sin(theta), 1.6 + r*cos(phi));
}
surface s_left = surface(sphere_left, (0, 0), (2*pi, pi), nu=20, nv=20);
draw(s_left, lightblue+opacity(0.25), meshpen=gray+0.6);

// 投影圆 D_xy
path3 circle_left;
int n = 60;
for(int i=0; i<=n; ++i) {
    real theta = i * 2 * pi / n;
    triple pt = (1.2 + 0.8*cos(theta), 1.2 + 0.8*sin(theta), 0);
    if (i == 0) circle_left = pt;
    else circle_left = circle_left..pt;
}
circle_left = circle_left..cycle;
draw(circle_left, blue+1.2);
draw(surface(circle_left), lightgray+opacity(0.4));
label("$D_{xy}$", (1.2, 1.2, 0), fontsize(13));

// 穿过球体的垂直扫描线 (穿入穿出)
triple p_in = (1.2, 1.2, 0.8);
triple p_out = (1.2, 1.2, 2.4);
draw((1.2, 1.2, 0)--p_in, gray+dashed+1.2);
draw(p_in--p_out, darkgreen+2.2, arrow=Arrow3(4));
draw(p_out--(1.2, 1.2, 3.0), gray+dashed+1.2);

dot(p_in, red+5.0);
dot(p_out, red+5.0);
label("$z_1(x,y)$", p_in, E, red+fontsize(12));
label("$z_2(x,y)$", p_out, E, red+fontsize(12));
label("投影法 (先 $z$ 后 $xy$)", (1.2, 1.2, 3.2), fontsize(14));


// ================== 右图: 截面法 ==================
triple O2 = (0, 4.0, 0); // 坐标系右移 4.0
draw(O2--(O2+3.0*X), black+1.2);
draw(O2--(O2+3.0*Y), black+1.2);
draw(O2--(O2+3.2*Z), black+1.2);
label("$x$", O2+3.0*X, SW);
label("$y$", O2+3.0*Y, SE);
label("$z$", O2+3.2*Z, N);
label("$O'$", O2, SW);

// 截面法球体
triple sphere_right(pair p) {
    real theta = p.x;
    real phi = p.y;
    real r = 0.8;
    return (1.2 + r*sin(phi)*cos(theta), 4.7 + r*sin(phi)*sin(theta), 1.6 + r*cos(phi));
}
surface s_right = surface(sphere_right, (0, 0), (2*pi, pi), nu=20, nv=20);
draw(s_right, lightgreen+opacity(0.2), meshpen=gray+0.6);

// 整个球体的 z 轴范围 [0.8, 2.4] -> [c, d]
draw((0, 4.0, 0.8)--(0.1, 4.0, 0.8), black+1.2);
draw((0, 4.0, 2.4)--(0.1, 4.0, 2.4), black+1.2);
label("$c$", (0, 4.0, 0.8), W, fontsize(12));
label("$d$", (0, 4.0, 2.4), W, fontsize(12));

// 水平截面 D_z at z = 1.95
real z_sec = 1.95;
real r_sec = sqrt(0.8^2 - (z_sec - 1.6)^2); // 截面半径
path3 circle_sec;
for(int i=0; i<=n; ++i) {
    real theta = i * 2 * pi / n;
    triple pt = (1.2 + r_sec*cos(theta), 4.7 + r_sec*sin(theta), z_sec);
    if (i == 0) circle_sec = pt;
    else circle_sec = circle_sec..pt;
}
circle_sec = circle_sec..cycle;
draw(circle_sec, orange+1.5);
draw(surface(circle_sec), orange+opacity(0.5));
label("$D_z$", (1.2, 4.7, z_sec), fontsize(13));

// 指向 z 轴的虚线，标出高度 z
draw((1.2, 4.7, z_sec)--(0, 4.0, z_sec), gray+dashed+1.2);
dot((0, 4.0, z_sec), black+4.0);
label("$z$", (0, 4.0, z_sec), W, fontsize(12));
label("截面法 (先 $xy$ 后 $z$)", (1.2, 4.7, 3.2), fontsize(14));
