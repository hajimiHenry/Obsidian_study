settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(5,4,3);

// 交点
triple O = (0,0,0);

// 直线 L1 方向
triple d1 = unit((1.2,0.5,0.3));
// 直线 L2 方向
triple d2 = unit((0.8,-0.8,0.4));

// 画两条相交直线（从交点向两端延伸）
draw(O - 2.2*d1--O + 2.5*d1, black+2.0);
draw(O - 2.0*d2--O + 2.2*d2, darkblue+2.0);

// 方向向量 s1（红色箭头）
triple s1Tip = O + 1.2*d1;
draw(O--s1Tip, red+2.2, arrow=Arrow3());
label("$\mathbf{s}_1$", s1Tip + 0.3*Y + 0.15*Z, N, fontsize(22));

// 方向向量 s2（红色箭头）
triple s2Tip = O + 1.2*d2;
draw(O--s2Tip, red+2.2, arrow=Arrow3());
label("$\mathbf{s}_2$", s2Tip - 0.3*Y + 0.15*Z, N, fontsize(22));

// 交点
dot(O, linewidth(8));

// 夹角 phi（放在两向量之间）
label("$\varphi$", O + 0.6*unit(d1+d2) + 0.15*Z, N, fontsize(22));

// 直线标签
label("$L_1$", O + 2.5*d1 + 0.2*Y, E, fontsize(22));
label("$L_2$", O + 2.2*d2 - 0.2*Y, E, fontsize(22));
