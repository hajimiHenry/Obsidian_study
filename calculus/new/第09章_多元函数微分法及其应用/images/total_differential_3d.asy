settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4.6,-5.4,3.5);

real f(real x, real y) { return 0.18*x*x + 0.12*y*y + 0.18*x*y + 0.24*x + 0.18*y + 0.45; }
triple S(real x, real y) { return (x,y,f(x,y)); }

real x0 = 0.58;
real y0 = 0.30;
real z0 = f(x0,y0);
real fx = 0.36*x0 + 0.18*y0 + 0.24;
real fy = 0.24*y0 + 0.18*x0 + 0.18;
real L(real x, real y) { return z0 + fx*(x-x0) + fy*(y-y0); }
triple T(real x, real y) { return (x,y,L(x,y)); }
triple M = (x0,y0,z0);

draw((-1.35,0,0)--(1.55,0,0), black+0.9, arrow=Arrow3());
draw((0,-1.25,0)--(0,1.45,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,1.72), black+1.0, arrow=Arrow3());
label("$x$", (1.38,-0.04,0), S, fontsize(20));
label("$y$", (0.08,1.38,0.08), NE, fontsize(20));
label("$z$", (0.24,-0.18,1.54), E, fontsize(20));

for(int i=-4; i<=4; ++i) {
  real x = i*0.26;
  guide3 g;
  for(int j=-36; j<=36; ++j) {
    real y = j*1.00/36;
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

path3 tangent =
  T(x0-0.72,y0-0.62)--T(x0+0.78,y0-0.62)--T(x0+0.78,y0+0.62)--T(x0-0.72,y0+0.62)--cycle;
draw(surface(tangent), lightblue+opacity(0.26));
draw(tangent, deepblue+0.9);

real dx = 0.54;
real dy = 0.44;
triple Q = S(x0+dx,y0+dy);
triple Ql = T(x0+dx,y0+dy);

draw(M--Ql, heavyred+2.0, arrow=Arrow3());
draw(Ql--Q, rgb(0.95,0.45,0.05)+1.1);

dot(M, linewidth(7));
dot(Ql, linewidth(5));
dot(Q, linewidth(5));
label("$M$", M+(-0.10,0.04,0.07), W, fontsize(22));
label("$M_L$", Ql+(0.04,-0.12,0.05), S, fontsize(18));
label("$M'$", Q+(-0.12,0.10,0.12), NW, fontsize(18));
label("$dz=f_xdx+f_ydy$", 0.5*(M+Ql)+(0.02,0.24,0.30), N, fontsize(20));
label("$T_M$", T(x0-0.58,y0-0.46)+(0.00,-0.02,0.02), SW, fontsize(20));
