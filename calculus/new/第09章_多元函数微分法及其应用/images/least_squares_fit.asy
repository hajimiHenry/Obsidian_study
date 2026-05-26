settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(2.2, -3.2, 2.8);

// 坐标轴
draw((-0.5,0,0)--(6.5,0,0), black+0.8, arrow=Arrow3());
draw((0,-0.5,0)--(0,4.8,0), black+0.8, arrow=Arrow3());
label("$t$", (6.4,-0.15,0), S, fontsize(16));
label("$y$", (0.1,4.7,0), NE, fontsize(16));

// 拟合直线
real a = -0.45;
real b = 4.1;
real fit(real t) { return a*t + b; }

draw((0, fit(0), 0) -- (6.0, fit(6.0), 0), royalblue+1.8);
label("拟合直线 $y = at + b$", (5.0, fit(5.0), 0) + (0.1,0.2,0.05), NE, royalblue+fontsize(15));

// 实验数据点
real[][] pts = {
  {0.5, 3.9},
  {1.5, 3.2},
  {2.5, 3.3},
  {3.5, 2.3},
  {4.5, 2.2},
  {5.5, 1.5}
};

for(int i=0; i<pts.length; ++i) {
  real t_i = pts[i][0];
  real y_i = pts[i][1];
  triple M = (t_i, y_i, 0);
  triple M_proj = (t_i, fit(t_i), 0);
  
  draw(M -- M_proj, gray(0.3)+0.8+dashed);
  dot(M, heavyred+5);
}

label("偏差平方和最小", (3.0, 4.0, 0), N, fontsize(16));
label("残差 $v_i$", (2.5, (3.3+fit(2.5))/2, 0) + (0.1, 0, 0.02), E, gray(0.3)+fontsize(13));
