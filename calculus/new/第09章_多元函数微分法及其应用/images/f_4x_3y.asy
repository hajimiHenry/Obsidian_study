settings.outformat="png";
settings.prc = false;
settings.render = 8;
settings.tex="xelatex";
size(600);
import three;
import graph3;

currentprojection = perspective(4, 3, 3.5);

// Axes
real L = 3;
draw((-L,0,0)--(L,0,0), black+1.2, arrow=Arrow3());
label("$x$", (L+0.2,0,0), E);
draw((0,-L,0)--(0,L,0), black+1.2, arrow=Arrow3());
label("$y$", (0,L+0.2,0), N);
draw((0,0,-2)--(0,0,6.5), black+1.2, arrow=Arrow3());
label("$z$", (0,0,6.7), N);

// The plane f(x,y) = 4x + 3y (blue, semi-transparent)
real r = 1.6;
triple fplane(pair p) { return (p.x, p.y, 4*p.x + 3*p.y); }
surface planeSurf = surface(fplane, (-r, -r), (r, r), 20, 20);
draw(planeSurf, lightblue+opacity(0.45));

// Level curves on the plane
pen levelPen = gray+0.6+dashed;
for (real c = -5; c <= 5; c += 1) {
    triple lev(real x) { return (x, (c - 4*x)/3, c); }
    path3 levpath = graph(lev, -2, 2);
    draw(levpath, levelPen);
}

// The cylinder base x^2 + y^2 = 1
real n = 80;
triple cylBase(real t) { return (cos(t), sin(t), 0); }
path3 cylPath = graph(cylBase, 0, 2*pi);
draw(cylPath, red+1.5);

// The intersection curve (cylinder projected onto the plane)
triple interFunc(real t) {
    real x = cos(t);
    real y = sin(t);
    return (x, y, 4*x + 3*y);
}
path3 inter = graph(interFunc, 0, 2*pi);
draw(inter, heavygreen+2.0);

// The vertical cylinder
for (int i = 0; i < 36; i += 6) {
    real t = i * 2*pi / 36;
    triple bottom = (cos(t), sin(t), -0.8);
    triple top = (cos(t), sin(t), 4*cos(t) + 3*sin(t) + 0.3);
    draw(bottom--top, gray+0.3+linewidth(0.3));
}

// Mark max and min points on the intersection
real t_max = atan2(3, 4);  // direction (4/5, 3/5)
real t_min = t_max + pi;    // opposite direction
triple Pmax = (cos(t_max), sin(t_max), 4*cos(t_max) + 3*sin(t_max));
triple Pmin = (cos(t_min), sin(t_min), 4*cos(t_min) + 3*sin(t_min));

dot(Pmax, red+linewidth(6));
label("$\mathrm{max}=5$", Pmax + (0.3, 0.2, 0), NE, red);
dot(Pmin, blue+linewidth(6));
label("$\mathrm{min}=-5$", Pmin + (-0.3, -0.2, 0), SW, blue);

// Labels
label("$f(x,y)=4x+3y$", (r, 0, 4*r), NW, fontsize(11));
label("$x^2+y^2=1$", (0.9, 0.5, -0.5), S, red, fontsize(11));
