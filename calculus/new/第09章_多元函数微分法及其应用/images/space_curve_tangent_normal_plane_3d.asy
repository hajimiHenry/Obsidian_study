settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(680);
import three;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(4.8,-5.4,3.4);

triple C(real t) { return (0.78*cos(t), 0.78*sin(t), 0.28*t + 0.30); }
triple dC(real t) { return (-0.78*sin(t), 0.78*cos(t), 0.28); }

real t0 = 2.55;
triple M = C(t0);
triple v = unit(dC(t0));
triple a = unit((cos(t0), sin(t0), 0));
triple b = unit(cross(v,a));

draw((-1.15,0,0)--(1.35,0,0), black+0.8, arrow=Arrow3());
draw((0,-1.15,0)--(0,1.35,0), black+0.8, arrow=Arrow3());
draw((0,0,0)--(0,0,2.15), black+0.9, arrow=Arrow3());
label("$x$", (1.23,-0.04,0), S, fontsize(16));
label("$y$", (0.08,1.25,0.04), NE, fontsize(16));
label("$z$", (0.16,-0.12,2.02), E, fontsize(16));

guide3 curve;
for(int i=0; i<=120; ++i) {
  real t = 0.25 + i*5.25/120;
  curve = (i==0) ? C(t) : curve--C(t);
}
draw(curve, deepblue+1.6);

real s = 0.58;
path3 plane =
  M + s*a + s*b -- M - s*a + s*b -- M - s*a - s*b -- M + s*a - s*b -- cycle;
draw(surface(plane), lightblue+opacity(0.30));
draw(plane, deepblue+0.85);

draw(M-0.70*v--M+0.82*v, heavyred+2.0, arrow=Arrow3());

dot(M, linewidth(6));
label("$M$", M+(0.06,0.06,0.05), NE, fontsize(16));
label("$\mathbf r'(t_0)$", M+0.83*v+(0.05,0.05,0.05), NE, red+fontsize(16));
label("法平面", M-0.55*a+0.62*b, W, deepblue+fontsize(15));
label("切线", M-0.58*v+(-0.05,-0.05,0.02), S, red+fontsize(15));
