settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);
import three;

currentprojection = perspective(5.8,3.8,2.8);

triple O = (0,0,0);
real a = 0.72;
real b = 0.50;
real H = 1.85;

guide3 ellipseAt(real z, int n=96) {
  guide3 g;
  real r = abs(z);
  for(int i=0; i<=n; ++i) {
    real u = 2*pi*i/n;
    triple P = (a*r*cos(u), b*r*sin(u), z);
    g = (i==0) ? P : g--P;
  }
  return g;
}

// Cone mesh
for(int k=-4; k<=4; ++k) {
  real z = H*k/4;
  if(abs(z) > 0.02) draw(ellipseAt(z), gray(0.45)+0.75);
}
for(int j=0; j<12; ++j) {
  real u = 2*pi*j/12;
  draw((a*H*cos(u),b*H*sin(u),H)--O--(a*H*cos(u),b*H*sin(u),-H), gray(0.45)+0.75);
}

// Coordinate axes
draw((-1.65,0,0)--(1.75,0,0), black+1.0, arrow=Arrow3());
draw((0,-1.35,0)--(0,1.45,0), black+1.0, arrow=Arrow3());
draw((0,0,-2.05)--(0,0,2.15), black+1.0, arrow=Arrow3());
label("$x$", (1.55,-0.03,0), S, fontsize(16));
label("$y$", (-0.03,1.25,0), E, fontsize(16));
label("$z$", (0.16,0.10,1.95), E, fontsize(16));

// Three horizontal cutting planes and their traces.
real[] zs = {-1.15, 0, 1.15};
pen[] ps = {deepgreen+opacity(0.18), gray(0.80)+opacity(0.18), lightblue+opacity(0.22)};
for(int m=0; m<3; ++m) {
  real z = zs[m];
  path3 plane = (-1.38,-1.05,z)--(1.38,-1.05,z)--(1.38,1.05,z)--(-1.38,1.05,z)--cycle;
  draw(surface(plane), ps[m]);
  draw(plane, gray(0.55)+0.65);
}
draw(ellipseAt(1.15), heavyred+1.65);
draw(ellipseAt(-1.15), heavyred+1.65);
dot(O, linewidth(7));

label("$z=t>0$", (1.34,0.76,1.15), E, fontsize(16));
label("$z=0$", (1.02,-0.92,0), S, fontsize(16));
label("$z=t<0$", (1.34,0.76,-1.15), E, fontsize(16));
