settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(2.2, -3.2, 2.8);

// 绘制同心椭圆等值线
for(int k=1; k<=3; ++k) {
  real a = k*0.7;
  real b = k*0.48;
  path3 ell;
  for(int i=0; i<=80; ++i) {
    real th = i*2*pi/80;
    ell = (i==0) ? (a*cos(th), b*sin(th), 0) : ell--(a*cos(th), b*sin(th), 0);
  }
  draw(ell--cycle, gray(0.6)+0.7);
  label("$c_"+string(k)+"$", (a, 0, 0), SE, gray(0.5)+fontsize(12));
}

// 选择点绘制梯度向量
real a2 = 2*0.7;
real b2 = 2*0.48;
real[] angles = {0.8, 2.2, -0.6, -2.4};
for(real th : angles) {
  triple M = (a2*cos(th), b2*sin(th), 0);
  triple normal = unit((cos(th)/a2, sin(th)/b2, 0));
  triple tangent = unit((-a2*sin(th), b2*cos(th), 0));
  
  // 绘制梯度向量
  draw(M -- M + 0.58*normal, heavyred+1.6, arrow=Arrow3());
  // 绘制切线段
  draw(M - 0.3*tangent -- M + 0.3*tangent, gray(0.3)+0.8+dashed);
  // 直角符号
  real s = 0.08;
  triple p1 = M + s*tangent;
  triple p2 = M + s*normal;
  triple p3 = M + s*tangent + s*normal;
  draw(p1 -- p3 -- p2, gray(0.4)+0.6);
  
  dot(M, linewidth(4.5));
}

label("$\nabla f$", (a2*cos(0.8), b2*sin(0.8), 0) + 0.6*unit((cos(0.8)/a2, sin(0.8)/b2, 0)) + (0.05,0.05,0.02), NE, heavyred+fontsize(15));
label("等值线 $f(x,y)=c$", (-a2 - 0.1, 0, 0), W, gray(0.4)+fontsize(14));
