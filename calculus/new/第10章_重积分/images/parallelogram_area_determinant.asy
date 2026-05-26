settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(550);

texpreamble("\usepackage{amsmath}");
pair polar(real r, real t) { return (r*cos(t), r*sin(t)); }

pair O = (0,0);
draw(O--(4.2, 0), black+0.8, arrow=Arrow(SimpleHead));
draw(O--(0, 3.2), black+0.8, arrow=Arrow(SimpleHead));
label("$x$", (4.2, 0), S, fontsize(14));
label("$y$", (0, 3.2), W, fontsize(14));
label("$O$", O, SW, fontsize(14));

pair a = (2.6, 0.6);
pair b = (0.8, 2.0);
pair C = a + b;

path para = O--a--C--b--cycle;
fill(para, rgb(1.0, 0.97, 0.88));
draw(para, gray(0.5)+0.8);

// 画向量
draw(O--a, rgb(0.85, 0.2, 0.2)+1.8, arrow=Arrow(SimpleHead));
draw(O--b, rgb(0.2, 0.4, 0.85)+1.8, arrow=Arrow(SimpleHead));

label("$\vec{a} = (a_1, a_2)$", a, SE, fontsize(13));
label("$\vec{b} = (b_1, b_2)$", b, NW, fontsize(13));

// 计算投影点 H 以绘制高 h
real dot_ab = a.x*b.x + a.y*b.y;
real len_a2 = a.x*a.x + a.y*a.y;
pair H = (dot_ab / len_a2) * a;

// 画高
draw(b--H, rgb(0.3, 0.3, 0.3)+0.8+dashed);
label("$h$", 0.5*(b+H), NE, fontsize(13));

// 画直角符号
real s = 0.12;
real len_a = sqrt(len_a2);
pair u_a = a / len_a;
pair n_a = (-u_a.y, u_a.x); // 垂直向上的法向
pair pt1 = H + s*u_a;
pair pt2 = H + s*u_a + s*n_a;
pair pt3 = H + s*n_a;
draw(pt1--pt2--pt3, gray(0.3)+0.8);

// 画夹角 theta
real ta = atan2(a.y, a.x);
real tb = atan2(b.y, b.x);
path arc_theta;
real r_theta = 0.5;
arc_theta = polar(r_theta, ta);
for(int i=1; i<=20; ++i) {
    real t = ta + (tb-ta)*i/20;
    arc_theta = arc_theta--polar(r_theta, t);
}
draw(arc_theta, black+0.8);
label("$\theta$", polar(r_theta + 0.15, 0.5*(ta+tb)), NE, fontsize(13));

// 标注面积公式
label("$S = \text{Area} = |\vec{a}| h = |\vec{a}||\vec{b}|\sin\theta$", (1.6, 2.7), E, fontsize(13));
label("$= |a_1 b_2 - a_2 b_1| = \left| \det \begin{pmatrix} a_1 & b_1 \\ a_2 & b_2 \end{pmatrix} \right|$", (1.6, 2.3), E, fontsize(13));
