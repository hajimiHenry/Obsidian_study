settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(600);
import three;

currentprojection = perspective(5.5,4.2,3.2);

triple O = (0,0,0);
real H = 2.65;
real R = 1.62;
int n = 40;

// yOz 平面：只保留贴近母线的小三角面，避免大矩形拖出无效留白
path3 planeFace =
  (0,0,0)--
  (0,R+0.12,H+0.03)--
  (0,0,H+0.03)--
  cycle;
draw(surface(planeFace), lightblue+opacity(0.14));
draw(planeFace, gray(0.65)+0.7);

// 圆锥侧面：由许多三角面片拼出半透明曲面
for(int i=0; i<n; ++i) {
  real t1 = 2*pi*i/n;
  real t2 = 2*pi*(i+1)/n;
  triple A = (R*cos(t1), R*sin(t1), H);
  triple B = (R*cos(t2), R*sin(t2), H);
  draw(surface(O--A--B--cycle), rgb(0.98,0.78,0.46)+opacity(0.28));
}

// 顶部截圆与若干母线
draw(circle((0,0,H), R, normal=Z), black+1.0);
for(int i=0; i<6; ++i) {
  real t = 2*pi*i/6;
  triple P = (R*cos(t), R*sin(t), H);
  draw(O--P, gray(0.45)+0.8);
}

// 坐标轴
draw(O--(1.34,0,0), black+1.1, arrow=Arrow3());
draw(O--(0,1.36,0), black+1.1, arrow=Arrow3());
draw(O--(0,0,H+0.30), black+1.2, arrow=Arrow3());
label("$x$", (1.16,-0.02,-0.02), SW, fontsize(16));
label("$y$", (-0.04,1.16,-0.02), E, fontsize(16));
label("$z$", (0.20,0.12,H+0.14), E, fontsize(16));

// yOz 面内的母线 l
triple G = (0,R,H);
draw(O--G, heavyred+1.6, arrow=Arrow3());
label("$l$", (0,0.88,1.58), E, fontsize(16));

// 旋转方向
real rr = 0.70*R;
path3 rotArc =
  (rr*cos(-0.45), rr*sin(-0.45), H)--
  (rr*cos(0.00), rr*sin(0.00), H)--
  (rr*cos(0.45), rr*sin(0.45), H)--
  (rr*cos(0.90), rr*sin(0.90), H);
draw(rotArc, deepblue+1.2, arrow=Arrow3());

// 锥面上一点到 z 轴的距离：强调 y 被替换成 sqrt(x^2+y^2)
real tp = 1.02;
triple P = (R*cos(tp), R*sin(tp), H);
triple Q = (0,0,H);
draw(Q--P, deepgreen+1.5);
dot(P, linewidth(5));
label("$M(x,y,z)$", P+(0.10,0.10,0.08), E, fontsize(15));
label("$\sqrt{x^2+y^2}$", 0.5*(P+Q)+(0.02,0.12,0.10), N, fontsize(15));

// 半顶角 alpha
real beta = atan(R/H);
real r0 = 0.62;
path3 alphaArc = (0,0,r0);
for(int k=1; k<=18; ++k) {
  real t = beta*k/18;
  alphaArc = alphaArc--(0,r0*sin(t),r0*cos(t));
}
draw(alphaArc, black+1.0);
label("$\alpha$", (0,0.42*r0*sin(beta/2),1.08*r0*cos(beta/2)), E, fontsize(16));

dot(O, linewidth(7));
label("$O$", O, SW, fontsize(17));

// 给顶圈和 z 轴箭头留出上边距；用白色极细线参与边界但不影响观感。
draw((0,0,H+0.48)--(0.01,0,H+0.48), white+0.1);
