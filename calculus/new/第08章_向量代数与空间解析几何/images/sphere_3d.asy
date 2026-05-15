settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4.8,3.2,2.6);

triple O = (0,0,0);
triple C = O;
real R = 1.55;

draw((-1.95,0,0)--(2.05,0,0), black+1.0, arrow=Arrow3());
draw((0,-1.95,0)--(0,2.05,0), black+1.0, arrow=Arrow3());
draw((0,0,-1.80)--(0,0,2.05), black+1.0, arrow=Arrow3());
label("$x$", (1.86,-0.04,0), S, fontsize(20));
label("$y$", (-0.04,1.86,0), E, fontsize(20));
label("$z$", (0.14,0.10,1.86), E, fontsize(20));

for(int k=-3; k<=3; ++k) {
  real z = C.z + 0.28*k*R;
  real r = sqrt(max(0,R^2-(z-C.z)^2));
  if(r > 0.10)
    draw(circle((C.x,C.y,z), r, normal=Z), gray(0.25)+0.8);
}
for(int i=0; i<5; ++i) {
  real phi = i*pi/5 + 0.28;
  guide3 g;
  for(int j=0; j<=80; ++j) {
    real t = -0.92*pi/2 + 1.84*pi*j/80;
    triple P = C + R*(cos(t)*cos(phi), cos(t)*sin(phi), sin(t));
    g = (j==0) ? P : g--P;
  }
  draw(g, gray(0.35)+0.8);
}

real tp = 0.92;
real up = 0.52;
triple M = C + R*(cos(up)*cos(tp), cos(up)*sin(tp), sin(up));
draw(C--M, heavyred+1.7, arrow=Arrow3());
dot(C, linewidth(7));
dot(M, linewidth(5));
label("$M_0$", C+(0.12,-0.06,-0.06), SE, fontsize(20));
label("$M$", M+(0.12,0.08,0.10), E, fontsize(18));
label("$R$", 0.5*(C+M)+(0.10,0.06,0.08), N, fontsize(20));
