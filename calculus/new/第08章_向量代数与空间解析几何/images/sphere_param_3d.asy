settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4.8,3.2,2.6);

triple O = (0,0,0);
real a = 1.55;

draw((-1.95,0,0)--(2.05,0,0), black+0.9, arrow=Arrow3());
draw((0,-1.95,0)--(0,2.05,0), black+0.9, arrow=Arrow3());
draw((0,0,-1.80)--(0,0,2.05), black+1.0, arrow=Arrow3());
label("$x$", (1.82,-0.04,0), S, fontsize(20));
label("$y$", (-0.04,1.82,0), E, fontsize(20));
label("$z$", (0.16,0.10,1.86), E, fontsize(20));

for(int k=-3; k<=3; ++k) {
  real z = 0.28*k*a;
  real r = sqrt(max(0,a^2-z^2));
  if(r > 0.10)
    draw(circle((0,0,z), r, normal=Z), gray(0.35)+0.8);
}
for(int i=0; i<5; ++i) {
  real phi0 = i*pi/5 + 0.25;
  guide3 m;
  for(int j=0; j<=80; ++j) {
    real t = -0.92*pi/2 + 1.84*pi*j/80;
    triple P = a*(cos(t)*cos(phi0), cos(t)*sin(phi0), sin(t));
    m = (j==0) ? P : m--P;
  }
  draw(m, gray(0.45)+0.8);
}

real phi = 0.78;
real theta = 0.95;
triple M = a*(sin(phi)*cos(theta), sin(phi)*sin(theta), cos(phi));
triple Q = a*(sin(phi)*cos(theta), sin(phi)*sin(theta), 0);
draw(O--M, heavyred+1.5, arrow=Arrow3());
draw(O--Q, deepgreen+1.2);
guide3 phiArc;
real rp = 0.58;
for(int i=0; i<=24; ++i) {
  real u = phi*i/24;
  triple P = rp*(sin(u)*cos(theta), sin(u)*sin(theta), cos(u));
  phiArc = (i==0) ? P : phiArc--P;
}
draw(phiArc, deepblue+1.3);
guide3 thetaArc;
real rt = 0.58;
for(int i=0; i<=24; ++i) {
  real u = theta*i/24;
  triple P = (rt*cos(u), rt*sin(u), 0);
  thetaArc = (i==0) ? P : thetaArc--P;
}
draw(thetaArc, deepblue+1.3);
dot(M, linewidth(5));
label("$M$", M+(0.12,0.10,0.10), E, fontsize(20));
label("$a$", 0.5*M+(0.08,0.04,0.04), N, fontsize(19));
label("$\varphi$", (0.30,0.24,0.78), E, fontsize(20));
label("$\theta$", (0.55,0.24,0.06), S, fontsize(20));
