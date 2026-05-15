settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4.6,3.4,2.7);

triple O = (0,0,0);
real R = 1.0;
real zMin = 1.10;
real zMax = 2.90;

draw((-1.55,0,0)--(1.65,0,0), black+0.9, arrow=Arrow3());
draw((0,-1.55,0)--(0,1.65,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,3.25), black+1.0, arrow=Arrow3());
label("$x$", (1.34,-0.02,0), SW, fontsize(20));
label("$y$", (-0.04,1.48,0), E, fontsize(20));
label("$z$", (0.16,0.10,3.05), E, fontsize(20));

draw(circle((0,0,zMin), R, normal=Z), gray(0.35)+0.8);
draw(circle((0,0,zMax), R, normal=Z), gray(0.35)+0.8);
for(int i=0; i<6; ++i) {
  real t = 2*pi*i/6;
  triple A = (R*cos(t), R*sin(t), zMin);
  triple B = (R*cos(t), R*sin(t), zMax);
  draw(A--B, gray(0.45)+0.7);
}
label("$x^2+y^2=1$", (-1.15,-0.60,1.45), W, fontsize(18));

triple P1 = (-1.25,-1.20,(6-2*(-1.25))/3);
triple P2 = ( 1.25,-1.20,(6-2*( 1.25))/3);
triple P3 = ( 1.25, 1.20,(6-2*( 1.25))/3);
triple P4 = (-1.25, 1.20,(6-2*(-1.25))/3);
path3 plane = P1--P2--P3--P4--cycle;
draw(surface(plane), lightblue+opacity(0.22));
draw(plane, gray(0.35)+0.9);
label("$2x+3z=6$", P3+(0.06,0.10,0.10), E, fontsize(18));

guide3 C;
for(int i=0; i<=120; ++i) {
  real t = 2*pi*i/120;
  triple P = (cos(t), sin(t), (6-2*cos(t))/3);
  C = (i==0) ? P : C--P;
}
draw(C, heavyred+1.8);
label("$C$", (0.66,0.86,(6-2*0.66)/3+0.10), NE, fontsize(22));

dot((1,0,4/3), linewidth(5));
