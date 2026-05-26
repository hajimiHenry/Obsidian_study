settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(450);
import three;

currentprojection = orthographic(0,0,10);

triple P(real x, real y) { return (x,y,0); }

// Coordinate range
real xmin = -0.5, xmax = 2.5;
real ymin = -0.5, ymax = 2.5;

// Draw axes
draw(P(xmin,0)--P(xmax,0), black+0.8, arrow=Arrow3());
draw(P(0,ymin)--P(0,ymax), black+0.8, arrow=Arrow3());
label("$x$", P(xmax-0.1, 0.05), NE, fontsize(14));
label("$y$", P(0.05, ymax-0.1), NE, fontsize(14));
label("$O$", P(-0.08, -0.08), SW, fontsize(13));

// Region D vertices
triple A = P(1, 1);
triple B = P(2, 1);
triple C = P(2, 2);

path3 region = A--B--C--cycle;

// Fill region
draw(surface(region), rgb(0.80,0.90,1.0)+opacity(0.46));
// Boundary
draw(region, deepblue+1.2);

// Draw extension lines
draw(P(0.5, 1)--A, gray(0.6)+dashed+0.6);
draw(B--P(2.3, 1), gray(0.6)+dashed+0.6);
draw(P(2, 0.5)--B, gray(0.6)+dashed+0.6);
draw(C--P(2, 2.3), gray(0.6)+dashed+0.6);
draw(P(0.5, 0.5)--A, gray(0.6)+dashed+0.6);
draw(C--P(2.3, 2.3), gray(0.6)+dashed+0.6);

// Equation labels
label("$y=1$", P(0.5, 1), W, fontsize(12));
label("$x=2$", P(2, 2.3), N, fontsize(12));
label("$y=x$", P(2.3, 2.3), E, fontsize(12));
label("$D$", P(1.65, 1.25), fontsize(15));

// Ticks
draw(P(1, 0.04)--P(1, -0.04), black+0.8);
label("$1$", P(1, -0.05), S, fontsize(12));
draw(P(2, 0.04)--P(2, -0.04), black+0.8);
label("$2$", P(2, -0.05), S, fontsize(12));

draw(P(0.04, 1)--P(-0.04, 1), black+0.8);
label("$1$", P(-0.05, 1), W, fontsize(12));
draw(P(0.04, 2)--P(-0.04, 2), black+0.8);
label("$2$", P(-0.05, 2), W, fontsize(12));

// Projections to axes
draw(A--P(1,0), gray(0.65)+dotted+0.5);
draw(A--P(0,1), gray(0.65)+dotted+0.5);
draw(C--P(2,0), gray(0.65)+dotted+0.5);
draw(C--P(0,2), gray(0.65)+dotted+0.5);

dot(A, linewidth(4));
dot(B, linewidth(4));
dot(C, linewidth(4));
