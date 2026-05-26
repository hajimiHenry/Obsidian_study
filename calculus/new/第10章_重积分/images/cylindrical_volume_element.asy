settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(680);
import three;

currentprojection = perspective(4.7,-5.0,3.0);

triple C(real r, real t, real z) { return (r*cos(t),r*sin(t),z); }

real r1 = 1.18;
real r2 = 1.55;
real t1 = 0.48;
real t2 = 0.82;
real z1 = 0.30;
real z2 = 1.25;

draw((-0.35,0,0)--(2.05,0,0), black+0.85, arrow=Arrow3());
draw((0,-0.35,0)--(0,1.85,0), black+0.85, arrow=Arrow3());
draw((0,0,0)--(0,0,1.65), black+0.85, arrow=Arrow3());
label("$x$", (1.90,-0.04,0), S, fontsize(16));
label("$y$", (0.06,1.70,0), E, fontsize(16));
label("$z$", (0.10,-0.10,1.52), E, fontsize(16));

guide3 bottom, top, inner1, outer1, side1, side2;
for(int i=0; i<=36; ++i) {
  real t = t1 + (t2-t1)*i/36;
  bottom = (i==0) ? C(r1,t,z1) : bottom--C(r1,t,z1);
  top = (i==0) ? C(r1,t,z2) : top--C(r1,t,z2);
}
for(int i=36; i>=0; --i) {
  real t = t1 + (t2-t1)*i/36;
  bottom = bottom--C(r2,t,z1);
  top = top--C(r2,t,z2);
}
path3 B = bottom--cycle;
path3 T = top--cycle;
draw(surface(B), rgb(1.0,0.86,0.48)+opacity(0.58));
draw(surface(T), rgb(1.0,0.86,0.48)+opacity(0.36));
draw(B, rgb(0.85,0.45,0.05)+1.1);
draw(T, rgb(0.85,0.45,0.05)+1.1);

for(int edge=0; edge<4; ++edge) {
  real r = edge < 2 ? r1 : r2;
  real t = (edge==0 || edge==2) ? t1 : t2;
  draw(C(r,t,z1)--C(r,t,z2), rgb(0.80,0.38,0.02)+1.1);
}

draw((0,0,z1)--C(r1,0.64,z1), deepblue+1.2, arrow=Arrow3());
draw(C(r1,t2,z2)--C(r2,t2,z2), heavyred+1.4, arrow=Arrow3());
draw(C(r2,t1,z1)--C(r2,t1,z2), heavyred+1.4, arrow=Arrow3());

guide3 arc;
for(int i=0; i<=36; ++i) {
  real t = t1 + (t2-t1)*i/36;
  arc = (i==0) ? C(r2,t,z2) : arc--C(r2,t,z2);
}
draw(arc, heavyred+1.4);

label("$\rho$", C(0.72,0.64,z1)+(0.04,0.02,0), N, fontsize(17));
label("$d\rho$", C(1.38,t2,z2)+(0.04,0.05,0.02), NE, fontsize(16));
label("$\rho\,d\theta$", C(r2,0.65,z2)+(0.06,0.04,0.04), N, fontsize(16));
label("$dz$", C(r2,t1,0.80)+(0.08,-0.02,0), E, fontsize(16));
label("$dV=\rho\,d\rho\,d\theta\,dz$", (0.72,1.28,1.45), N, fontsize(18));
