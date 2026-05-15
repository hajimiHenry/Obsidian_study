settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4.8,3.0,2.4);

triple O = (0,0,0);
real R = 1.22;
real H = 2.55;

draw(O--(2.25,0,0), black+1.0, arrow=Arrow3());
draw(O--(0,2.20,0), black+1.0, arrow=Arrow3());
draw(O--(0,0,H+0.45), black+1.0, arrow=Arrow3());
label("$x$", (2.02,-0.03,0), S, fontsize(20));
label("$y$", (-0.05,2.00,0), E, fontsize(20));
label("$z$", (0.16,0.10,H+0.28), E, fontsize(20));

draw(circle((0,0,0), R, normal=Z), black+1.0);
draw(circle((0,0,H), R, normal=Z), black+1.0);

for(int i=0; i<6; ++i) {
  real t = 2*pi*i/6 + 0.18;
  triple A = (R*cos(t), R*sin(t), 0);
  triple B = (R*cos(t), R*sin(t), H);
  draw(A--B, gray(0.35)+0.8);
}

real tg = 0.90;
triple G0 = (R*cos(tg), R*sin(tg), 0);
triple G1 = (R*cos(tg), R*sin(tg), H);
draw(G0--G1, heavyred+1.6, arrow=Arrow3());
label("$l\parallel z$", 0.5*(G0+G1)+(0.12,0.06,0.04), E, fontsize(18));

triple P = (R,0,0);
draw(O--P, deepgreen+1.5, arrow=Arrow3());
label("$R$", 0.5*P+(0.06,-0.06,0.04), S, fontsize(20));
dot(O, linewidth(6));
label("$O$", O, SW, fontsize(22));

label("$x^2+y^2=R^2$", (-1.15,-0.78,0.35), W, fontsize(20));
