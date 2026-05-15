settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4.8,3.2,2.6);

triple O = (0,0,0);

path3 plane =
  (-1.80,-1.35,0)--
  ( 1.90,-1.35,0)--
  ( 1.90, 1.70,0)--
  (-1.80, 1.70,0)--cycle;
draw(surface(plane), lightblue+opacity(0.20));
draw(plane, gray(0.45)+0.8);

draw((-1.65,0,0)--(1.75,0,0), black+0.9, arrow=Arrow3());
draw((0,-1.25,0)--(0,1.55,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,1.65), black+1.0, arrow=Arrow3());
label("$x$", (1.58,-0.04,0), S, fontsize(20));
label("$y$", (-0.04,1.38,0), E, fontsize(20));
label("$z$", (0.15,0.10,1.48), E, fontsize(20));
label("$xOy$", (1.55,1.36,0.05), E, fontsize(18));

guide3 C;
guide3 Cp;
triple[] P;
triple[] Q;
for(int i=0; i<=90; ++i) {
  real t = -1.15 + 2.30*i/90;
  triple A = (t, 0.58*t*t-0.30, 0.70+0.35*sin(2.2*t));
  triple B = (t, 0.58*t*t-0.30, 0);
  P.push(A);
  Q.push(B);
  C = (i==0) ? A : C--A;
  Cp = (i==0) ? B : Cp--B;
}
draw(C, heavyred+1.8);
draw(Cp, deepblue+1.6);

for(int k=0; k<6; ++k) {
  int idx = 12 + k*13;
  draw(P[idx]--Q[idx], gray(0.45)+0.7);
  dot(P[idx], linewidth(4));
  dot(Q[idx], linewidth(4));
}

label("$C$", P[72]+(0.10,0.08,0.08), E, fontsize(22));
label("$C'$", Q[74]+(0.10,0.06,0.04), E, fontsize(22));
label("$z=0$", (-1.45,1.35,0.08), W, fontsize(18));
