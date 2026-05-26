settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(2.2, -3.2, 2.8);

// 点 P0
triple P = (0.5, 0.5, 0);
// 梯度向量
triple grad = (1.9, 1.1, 0);
// 单位方向向量 e
real alpha = 12 * pi / 180;
triple e = (cos(alpha), sin(alpha), 0);
triple e_tip = P + 1.85*e;

// 投影点 H
real proj_len = dot(grad, e);
triple H = P + proj_len * e;

// 绘制向量
draw(P -- P + grad, heavyred+2.0, arrow=Arrow3());
draw(P -- e_tip, royalblue+1.6, arrow=Arrow3());

// 绘制垂线
draw(P + grad -- H, gray(0.3)+0.8+dashed);

// 直角符号
triple tangent = unit(e);
triple normal = (-tangent.y, tangent.x, 0);
real s = 0.12;
triple p1 = H - s*tangent;
triple p2 = H + s*normal;
triple p3 = H - s*tangent + s*normal;
draw(p1 -- p3 -- p2, gray(0.3)+0.8);

// 绘制投影高亮段
draw(P -- H, heavygreen+2.5);

dot(P, linewidth(5));
label("$P$", P + (-0.15,-0.1,0.05), W, fontsize(16));
label("$\nabla f$", P + grad + (0.05,0.05,0.02), NE, heavyred+fontsize(16));
label("$\mathbf{e}$", e_tip + (0.05,-0.05,0.02), SE, royalblue+fontsize(16));
label("$\theta$", P + 0.4*unit(grad) + 0.1*unit(e) + (0.02,0.02,0.02), NE, fontsize(14));
label("投影长度 $= D_{\mathbf{e}}f$", (P + H)/2 + (0.05,-0.2,0.02), S, heavygreen+fontsize(14));
