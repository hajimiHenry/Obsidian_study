settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;

currentprojection = orthographic(0,0,8);

real yl(real x) { return 0.18 + 0.10*(x+0.45)^2; }
real yu(real x) { return 1.58 - 0.12*x + 0.10*sin(2.3*x+0.4); }
triple P(real x, real y) { return (x,y,0); }

real a = -1.65;
real b = 1.65;

guide3 bd;
for(int i=0; i<=90; ++i) {
  real x = a + (b-a)*i/90;
  bd = (i==0) ? P(x,yl(x)) : bd--P(x,yl(x));
}
for(int i=90; i>=0; --i) {
  real x = a + (b-a)*i/90;
  bd = bd--P(x,yu(x));
}
path3 D = bd--cycle;

draw(surface(D), rgb(0.78,0.88,1.0)+opacity(0.45));
draw(D, deepblue+1.3);

for(int k=1; k<=7; ++k) {
  real x = a + (b-a)*k/8;
  draw(P(x,yl(x))--P(x,yu(x)), gray(0.55)+0.7);
}
for(int k=1; k<=4; ++k) {
  real t = k/5;
  guide3 g;
  for(int i=0; i<=90; ++i) {
    real x = a + (b-a)*i/90;
    real y = (1-t)*yl(x) + t*yu(x);
    g = (i==0) ? P(x,y) : g--P(x,y);
  }
  draw(g, gray(0.55)+0.7);
}

real x0 = -0.40;
real y0 = (1-0.58)*yl(x0) + 0.58*yu(x0);
real x1 = a + (b-a)*3/8;
real x2 = a + (b-a)*4/8;
real y1 = (1-0.40)*yl(x1) + 0.40*yu(x1);
real y2 = (1-0.60)*yl(x1) + 0.60*yu(x1);
path3 cell = P(x1,y1)--P(x2,(1-0.40)*yl(x2)+0.40*yu(x2))--
             P(x2,(1-0.60)*yl(x2)+0.60*yu(x2))--P(x1,y2)--cycle;
draw(surface(cell), rgb(1.0,0.88,0.50)+opacity(0.70));
draw(cell, rgb(0.80,0.48,0.05)+1.1);

dot(P(x0,y0), heavyred+linewidth(6));
label("$D$", P(1.35,1.18), E, fontsize(17));
label("$(\xi_i,\eta_i)$", P(x0+0.12,y0+0.12), NE, fontsize(15));
label("$\Delta\sigma_i$", P(0.08,0.86), E, fontsize(16));
label("$x$", P(1.80,0.06), N, fontsize(16));
label("$y$", P(-1.75,1.64), E, fontsize(16));

draw(P(-1.90,0)--P(1.92,0), black+0.8, arrow=Arrow3());
draw(P(-1.85,0)--P(-1.85,1.80), black+0.8, arrow=Arrow3());
