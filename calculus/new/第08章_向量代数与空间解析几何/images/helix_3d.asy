settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4.6,3.2,2.5);

triple O = (0,0,0);
real a = 1.05;
real b = 0.23;
real H = 4*pi*b;
real pitch = 2*pi*b;

draw((-1.55,0,0)--(1.65,0,0), black+0.9, arrow=Arrow3());
draw((0,-1.55,0)--(0,1.65,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,H+0.45), black+1.0, arrow=Arrow3());
label("$x$", (1.48,-0.04,0), S, fontsize(20));
label("$y$", (-0.04,1.48,0), E, fontsize(20));
label("$z$", (0.16,0.10,H+0.25), E, fontsize(20));

draw(circle((0,0,0), a, normal=Z), gray(0.55)+0.8);
draw(circle((0,0,pitch), a, normal=Z), gray(0.45)+0.8);
draw(circle((0,0,H), a, normal=Z), gray(0.55)+0.8);
for(int i=0; i<6; ++i) {
  real t = 2*pi*i/6;
  draw((a*cos(t),a*sin(t),0)--(a*cos(t),a*sin(t),H), gray(0.55)+0.7);
}

guide3 helix;
for(int i=0; i<=180; ++i) {
  real t = 4*pi*i/180;
  triple P = (a*cos(t), a*sin(t), b*t);
  helix = (i==0) ? P : helix--P;
}
draw(helix, heavyred+1.8);
label("$C$", (a*cos(1.0),a*sin(1.0),b*1.0)+(0.10,0.12,0.06), E, fontsize(22));

triple A = (a,0,0);
triple B = (a,0,pitch);
draw(A--B, deepblue+1.4, arrow=Arrow3());
label("$h=2\pi b$", 0.5*(A+B)+(0.10,0.02,0), E, fontsize(20));
dot(A, linewidth(5));
dot(B, linewidth(5));

label("$x=a\cos\theta,\ y=a\sin\theta,\ z=b\theta$", (-1.12,-0.88,H-0.08), W, fontsize(17));
