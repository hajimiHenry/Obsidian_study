settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(700);
import three;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(2.2, -3.2, 2.8);

// 绘制背景等值线
for(int k=1; k<=5; ++k) {
  real a = k*0.45;
  real b = k*0.35;
  path3 ell;
  for(int i=0; i<=60; ++i) {
    real th = i*2*pi/60;
    ell = (i==0) ? (a*cos(th), b*sin(th), 0) : ell--(a*cos(th), b*sin(th), 0);
  }
  draw(ell--cycle, gray(0.7)+0.6);
}

// 绘制网格上的梯度小箭头
real a = 2.0;
real b = 1.5;
for(real x = -2.0; x <= 2.0; x += 0.44) {
  for(real y = -1.5; y <= 1.5; y += 0.38) {
    real len2 = x*x + y*y;
    if (len2 < 0.1 || len2 > 4.5) continue;
    triple M = (x, y, 0);
    // 梯度向量
    triple g = (2*x/2.25, 2*y/1.21, 0);
    real g_len = length(g);
    if (g_len == 0) continue;
    triple g_dir = unit(g);
    
    real arrow_len = 0.12 + 0.08*g_len;
    real t = g_len / 3.0;
    if (t > 1.0) t = 1.0;
    pen p = rgb(t, 0.2*(1-t), 1.0-t) + 1.1;
    
    draw(M -- M + arrow_len * g_dir, p, arrow=Arrow3(DefaultHead3));
  }
}
label("梯度场 $\nabla f$", (0, 1.4, 0), N, fontsize(16));
