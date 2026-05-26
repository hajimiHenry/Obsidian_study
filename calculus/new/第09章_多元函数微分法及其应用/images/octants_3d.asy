settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(680);
import three;

currentprojection = perspective(3.5, 2.4, 2.8);

// Axes
real L = 2.8;
draw((-L,0,0)--(L,0,0), black+1.2, arrow=Arrow3());
label("$x$", (L+0.2,0,0), E, fontsize(11));
draw((0,-L,0)--(0,L,0), black+1.2, arrow=Arrow3());
label("$y$", (0,L+0.2,0), N, fontsize(11));
draw((0,0,-L)--(0,0,L), black+1.2, arrow=Arrow3());
label("$z$", (0,0,L+0.2), N, fontsize(11));

// Negative axis labels
label("$-x$", (-L,0,0), SW, fontsize(9));
label("$-y$", (0,-L,0), SE, fontsize(9));
label("$-z$", (0,0,-L), S, fontsize(9));

// Origin
dot((0,0,0), linewidth(5));
label("$O$", (0,0,-0.32), SW, fontsize(12));

// Coordinate planes
real s = 2.4;

// z=0: xOy plane (blue)
path3 xy = (-s,-s,0)--(s,-s,0)--(s,s,0)--(-s,s,0)--cycle;
draw(surface(xy), lightblue+opacity(0.22));
draw(xy, gray+0.5);

// x=0: yOz plane (green)
path3 yz = (0,-s,-s)--(0,s,-s)--(0,s,s)--(0,-s,s)--cycle;
draw(surface(yz), lightgreen+opacity(0.20));
draw(yz, gray+0.5);

// y=0: xOz plane (yellow)
path3 xz = (-s,0,-s)--(s,0,-s)--(s,0,s)--(-s,0,s)--cycle;
draw(surface(xz), lightyellow+opacity(0.26));
draw(xz, gray+0.5);

// First octant highlight: red triangle corner
real c = 0.65;
triple c1 = (c,0,0), c2 = (0,c,0), c3 = (0,0,c);
path3 octTri = c1--c2--c3--cycle;
draw(surface(octTri), red+opacity(0.5));
draw(octTri, red+1.5);

// Red edges along positive axes inside first octant
draw((0,0,0)--c1, red+2.0);
draw((0,0,0)--c2, red+2.0);
draw((0,0,0)--c3, red+2.0);

// First octant label
label("$\mathbf{I}$", (1.3, 1.3, 1.05), fontsize(14));
label("$x\!>\!0,\;y\!>\!0,\;z\!>\!0$", (1.3, 1.3, 0.6), fontsize(9));

// Other visible octants
label("II", (-1.15, 1.15, 0.9), fontsize(14));
label("III", (-1.15, -1.15, 0.9), fontsize(14));
label("IV", (1.15, -1.15, 0.9), fontsize(14));

// Plane labels
label("$xOy\;(z=0)$", (-1.6, 2.0, 0.15), fontsize(10));
label("$yOz\;(x=0)$", (0.2, 1.8, 1.3), fontsize(10));
label("$xOz\;(y=0)$", (1.5, 0.2, 1.4), fontsize(10));
