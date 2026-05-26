settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(500);
import three;

currentprojection = orthographic(0,0,10);

triple P(real x, real y) { return (x,y,0); }

// Coordinate range
real xmin = -1.0, xmax = 5.0;
real ymin = -2.0, ymax = 3.5;

// Draw axes
draw(P(xmin,0)--P(xmax,0), black+0.8, arrow=Arrow3());
draw(P(0,ymin)--P(0,ymax), black+0.8, arrow=Arrow3());
label("$x$", P(xmax-0.15, 0.08), NE, fontsize(14));
label("$y$", P(0.08, ymax-0.15), NE, fontsize(14));
label("$O$", P(-0.15, -0.15), SW, fontsize(13));

// Region D boundaries
guide3 para_bound;
for(int i=0; i<=60; ++i) {
  real y = -1.0 + 3.0*i/60;
  para_bound = (i==0) ? P(y^2, y) : para_bound--P(y^2, y);
}

path3 region = para_bound--P(1,-1)--cycle;

// Fill region
draw(surface(region), rgb(0.80,0.90,1.0)+opacity(0.46));

// Draw extension lines (dashed)
// Parabola extension
guide3 para_ext;
for(int i=0; i<=60; ++i) {
  real y = -1.4 + 3.8*i/60;
  para_ext = (i==0) ? P(y^2, y) : para_ext--P(y^2, y);
}
draw(para_ext, gray(0.5)+dashed+0.6);

// Line extension
draw(P((-1.5)+2, -1.5)--P(2.5+2, 2.5), gray(0.5)+dashed+0.6);

// Draw solid boundary lines
draw(para_bound, deepblue+1.2);
draw(P(4,2)--P(1,-1), deepblue+1.2);

// Labels
label("$y^2=x$", P(4.5, 2.15), N, fontsize(12));
label("$y=x-2$", P(3.7, 1.7-2), SE, fontsize(12));
label("$D$", P(1.8, 0.5), fontsize(15));

// Vertices
triple A = P(1, -1);
triple B = P(4, 2);

draw(A--P(1,0), gray(0.65)+dotted+0.5);
draw(A--P(0,-1), gray(0.65)+dotted+0.5);
draw(B--P(4,0), gray(0.65)+dotted+0.5);
draw(B--P(0,2), gray(0.65)+dotted+0.5);

dot(A, linewidth(4));
dot(B, linewidth(4));

// Ticks
draw(P(1, 0.05)--P(1, -0.05), black+0.8);
label("$1$", P(1, -0.06), S, fontsize(11));
draw(P(4, 0.05)--P(4, -0.05), black+0.8);
label("$4$", P(4, -0.06), S, fontsize(11));

draw(P(0.05, -1)--P(-0.05, -1), black+0.8);
label("$-1$", P(-0.06, -1), W, fontsize(11));
draw(P(0.05, 2)--P(-0.05, 2), black+0.8);
label("$2$", P(-0.06, 2), W, fontsize(11));
