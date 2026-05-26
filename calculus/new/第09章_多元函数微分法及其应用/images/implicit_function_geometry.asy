settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(2, -3, 2.5);

// 坐标轴
draw((-2.2,0,0)--(2.5,0,0), black+0.8, arrow=Arrow3());
draw((0,-2.2,0)--(0,2.5,0), black+0.8, arrow=Arrow3());

label("$x$", (2.4,-0.15,0), S, fontsize(16));
label("$y$", (0.1,2.4,0), NE, fontsize(16));

// 绘制曲线 F(x,y)=0
triple C(real t) { return (2*cos(t), 1.5*sin(t), 0); }
guide3 curve;
for(int i=0; i<=60; ++i) {
  real t = 0.15 + i*1.3/60;
  curve = (i==0) ? C(t) : curve--C(t);
}
draw(curve, deepblue+1.8);
label("$F(x,y)=0$", C(1.1)+(0.1,0.1,0.05), NE, deepblue+fontsize(15));

// 选择点 M
real t0 = 0.75;
triple M = C(t0);

// 在 M 处的切线方向和法线方向
triple tangent = unit((-2*sin(t0), 1.5*cos(t0), 0));
triple normal = unit((1.5*cos(t0), 2*sin(t0), 0)); 

// 绘制切线和法线
draw(M - 0.95*tangent -- M + 1.2*tangent, heavyred+1.2);
draw(M -- M + 1.1*normal, heavygreen+1.6, arrow=Arrow3());

// 绘制直角符号
real s = 0.15;
triple p1 = M + s*tangent;
triple p2 = M + s*normal;
triple p3 = M + s*tangent + s*normal;
draw(p1 -- p3 -- p2, gray(0.3)+0.8);

dot(M, linewidth(6));
label("$M(x_0,y_0)$", M + (-0.2,-0.2,0.05), W, fontsize(16));
label("$\nabla F$", M + 1.1*normal + (0.05,0.05,0.02), NE, heavygreen+fontsize(16));
label("切线", M + 1.2*tangent + (0.02,-0.05,0.02), SE, heavyred+fontsize(15));
