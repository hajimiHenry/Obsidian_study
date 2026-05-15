settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4.6,-5.4,3.5);

real f(real x, real y) { return 0.18*x*x + 0.14*y*y + 0.16*x*y + 0.40; }
triple S(real x, real y) { return (x,y,f(x,y)); }

real x0 = 0.58;
real y0 = 0.30;
real z0 = f(x0,y0);
real fx = 0.36*x0 + 0.16*y0;
real fy = 0.28*y0 + 0.16*x0;
real L(real x, real y) { return z0 + fx*(x-x0) + fy*(y-y0); }
triple T(real x, real y) { return (x,y,L(x,y)); }
triple M = (x0,y0,z0);
triple nTip = M + 0.82*(-fx,-fy,1);

draw((-1.35,0,0)--(1.55,0,0), black+0.9, arrow=Arrow3());
draw((0,-1.25,0)--(0,1.45,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,1.68), black+1.0, arrow=Arrow3());
label("$x$", (1.38,-0.04,0), S, fontsize(20));
label("$y$", (0.08,1.38,0.08), NE, fontsize(20));
label("$z$", (0.24,-0.18,1.50), E, fontsize(20));

for(int i=-4; i<=4; ++i) {
  real x = i*0.26;
  guide3 g;
  for(int j=-36; j<=36; ++j) {
    real y = j*1.02/36;
    g = (j==-36) ? S(x,y) : g--S(x,y);
  }
  draw(g, gray(0.60)+0.42);
}
for(int j=-4; j<=4; ++j) {
  real y = j*0.24;
  guide3 g;
  for(int i=-36; i<=36; ++i) {
    real x = i*1.05/36;
    g = (i==-36) ? S(x,y) : g--S(x,y);
  }
  draw(g, gray(0.60)+0.42);
}

path3 plane =
  T(x0-0.70,y0-0.58)--T(x0+0.72,y0-0.58)--T(x0+0.72,y0+0.58)--T(x0-0.70,y0+0.58)--cycle;
draw(surface(plane), lightblue+opacity(0.28));
draw(plane, deepblue+0.9);

guide3 curve;
for(int i=-50; i<=50; ++i) {
  real t = i*0.72/50;
  curve = (i==-50) ? S(x0+t,y0+0.28*t) : curve--S(x0+t,y0+0.28*t);
}
draw(curve, heavyred+1.5);
draw(M--nTip, black+1.9, arrow=Arrow3());

dot(M, linewidth(7));
label("$M$", M+(0.09,0.07,0.06), E, fontsize(22));
label("$\mathbf n$", nTip+(-0.06,0.06,0.05), W, fontsize(22));
label("$T_M$", T(x0-0.68,y0-0.56)+(-0.08,-0.06,0.02), W, fontsize(20));
