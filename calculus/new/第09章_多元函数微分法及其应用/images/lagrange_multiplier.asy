settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(2.2, -3.2, 2.8);

// 坐标轴
draw((-2.0,0,0)--(2.2,0,0), black+0.8, arrow=Arrow3());
draw((0,-1.8,0)--(0,1.8,0), black+0.8, arrow=Arrow3());
label("$x$", (2.1,-0.15,0), S, fontsize(15));
label("$y$", (0.1,1.7,0), NE, fontsize(15));

// 约束曲线 (圆，半径 R = 1.35)
real R = 1.35;
path3 constr;
for(int i=0; i<=100; ++i) {
  real th = i*2*pi/100;
  constr = (i==0) ? (R*cos(th), R*sin(th), 0) : constr--(R*cos(th), R*sin(th), 0);
}
draw(constr--cycle, royalblue+2.0);
label("约束曲线 $\varphi(x,y)=0$", (0, -R, 0), S, royalblue+fontsize(14));

// 目标等值线平行方向：斜率由梯度 (4,3) 决定
// 切方向 v = (-0.6, 0.8, 0)，法方向 u = (0.8, 0.6, 0)
triple u = (0.8, 0.6, 0);
triple v = (-0.6, 0.8, 0);

// 绘制若干条相交与不相交的等值线 (除切线外)
real[] ds = {-0.9, -0.3, 0.3, 0.9};
string[] labels = {"$f(x,y)=c_1$", "$f(x,y)=c_2$", "$f(x,y)=c_3$", "$f(x,y)=c_4$"};

for(int i=0; i<ds.length; ++i) {
  real d = ds[i];
  triple p1 = d * u - 1.8 * v;
  triple p2 = d * u + 1.8 * v;
  draw(p1--p2, gray(0.65)+0.6);
  // 在右下端点标注等值线
  label(labels[i], p1 + (0.05, -0.05, 0), SE, gray(0.55)+fontsize(11));
}

// 绘制一条圆外不相交的等值线
real d_out = 1.8;
triple po1 = d_out * u - 1.2 * v;
triple po2 = d_out * u + 1.2 * v;
draw(po1--po2, gray(0.65)+0.6);
label("$f(x,y)=c_5$", po1 + (0.05, -0.05, 0), SE, gray(0.55)+fontsize(11));

// 绘制极值点处的相切等值线 (切线)
triple pt1 = R * u - 1.8 * v;
triple pt2 = R * u + 1.8 * v;
draw(pt1--pt2, heavyred+1.0);
label("等值线 $f(x,y)=c_{\max}$", pt2 + (-0.1, 0.1, 0), NW, heavyred+fontsize(12));

// 相切点 M (极值点)
triple M = R * u;

// 绘制梯度向量
// 目标函数梯度向量 (较短)
triple grad_f_end = M + 0.55 * u;
draw(M--grad_f_end, heavyred+1.8, arrow=Arrow3());

// 约束函数梯度向量 (较长)
triple grad_phi_end = M + 0.95 * u;
draw(M--grad_phi_end, heavygreen+1.8, arrow=Arrow3());

// 先画线，后 dot
dot(M, linewidth(6));

// 标注
label("$M(x_0,y_0)$", M + (-0.15, -0.15, 0.02), W, fontsize(14));
label("$\nabla f$", grad_f_end + (0.08, -0.08, 0.02), SE, heavyred+fontsize(14));
label("$\nabla \varphi$", grad_phi_end + (0.08, 0.02, 0.02), NE, heavygreen+fontsize(14));
label("极值点：等值线与约束曲线相切", M + (-0.2, 0.45, 0.05), N, fontsize(12));
label("$\nabla f = \lambda \nabla \varphi$ (梯度平行)", M + (-0.2, 0.22, 0.05), N, fontsize(13));
