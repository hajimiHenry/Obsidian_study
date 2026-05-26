settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(700);
import three;

// Perspective
currentprojection = perspective(5, -6, 4.5);

// Surface equation
real f(real x, real y) { return 2.2 - 0.2*x*x - 0.18*y*y; }
triple P(real x, real y, real z) { return (x,y,z); }
triple S(real x, real y) { return (x,y,f(x,y)); }

// Axes limits
real x_limit = 2.4, y_limit = 2.2, z_limit = 2.8;

// Draw axes
draw(P(-2.0,0,0)--P(x_limit,0,0), black+0.9, arrow=Arrow3());
draw(P(0,-1.8,0)--P(0,y_limit,0), black+0.9, arrow=Arrow3());
draw(P(0,0,0)--P(0,0,z_limit), black+0.9, arrow=Arrow3());
label("$x$", P(x_limit-0.1, -0.08, 0), S, fontsize(16));
label("$y$", P(0.08, y_limit-0.1, 0), NE, fontsize(16));
label("$z$", P(0.12, -0.12, z_limit-0.15), E, fontsize(16));

// Ellipse base D
real a = 1.6;
real b = 1.3;
guide3 base;
for(int i=0; i<=72; ++i) {
  real t = 2*pi*i/72;
  base = (i==0) ? P(a*cos(t), b*sin(t), 0) : base--P(a*cos(t), b*sin(t), 0);
}
path3 D = base--cycle;
draw(surface(D), rgb(0.85,0.92,1.0)+opacity(0.35));
draw(D, deepblue+1.2);
label("$D$", P(1.0, -0.8, 0), fontsize(16));

// Projections of boundary on x axis
draw(P(-a, 0.05, 0)--P(-a, -0.05, 0), black+0.8);
label("$a$", P(-a, -0.08, 0), S, fontsize(13));
draw(P(a, 0.05, 0)--P(a, -0.05, 0), black+0.8);
label("$b$", P(a, -0.08, 0), S, fontsize(13));

// Top surface grid
int nx = 12;
int ny = 10;
for(int i=-nx; i<=nx; ++i) {
  real x = a * i / nx;
  guide3 g;
  bool started = false;
  for(int j=-40; j<=40; ++j) {
    real y = b * j / 40;
    if((x/a)*(x/a) + (y/b)*(y/b) <= 1.001) {
      if(!started) { g = S(x,y); started = true; }
      else g = g--S(x,y);
    }
  }
  if(started) draw(g, orange+0.45);
}
for(int j=-ny; j<=ny; ++j) {
  real y = b * j / ny;
  guide3 g;
  bool started = false;
  for(int i=-40; i<=40; ++i) {
    real x = a * i / 40;
    if((x/a)*(x/a) + (y/b)*(y/b) <= 1.001) {
      if(!started) { g = S(x,y); started = true; }
      else g = g--S(x,y);
    }
  }
  if(started) draw(g, orange+0.45);
}

// Top surface outer boundary
guide3 top_edge;
for(int i=0; i<=72; ++i) {
  real t = 2*pi*i/72;
  top_edge = (i==0) ? S(a*cos(t), b*sin(t)) : top_edge--S(a*cos(t), b*sin(t));
}
draw(top_edge--cycle, orange+1.1);

// Vertical boundary lines (dashed)
for(int i=0; i<12; ++i) {
  real t = 2*pi*i/12;
  triple bp = P(a*cos(t), b*sin(t), 0);
  triple tp = S(a*cos(t), b*sin(t));
  draw(bp--tp, gray(0.6)+0.45+dashed);
}

// === Slice Plane at x = x0 ===
real x0 = 0.5;

// y limits at x = x0
real y_lim_x0 = b * sqrt(1.0 - (x0/a)*(x0/a));
real y1 = -y_lim_x0;
real y2 = y_lim_x0;

// Construct slice boundary
guide3 slice_path;
slice_path = P(x0, y1, 0)--P(x0, y2, 0);
for(int j=40; j>=0; --j) {
  real y = y1 + (y2-y1)*j/40;
  slice_path = slice_path--S(x0, y);
}
path3 slice_surf = slice_path--cycle;

// Fill slice
draw(surface(slice_surf), rgb(1.0,0.65,0.65)+opacity(0.58));
// Outline slice
draw(slice_surf, red+1.3);

// Labels for slice
label("$A(x)$", P(x0, 0.0, f(x0,0)/2), fontsize(15));
label("$y=\varphi_1(x)$", P(x0, y1-0.1, 0), SE, fontsize(12));
label("$y=\varphi_2(x)$", P(x0, y2+0.1, 0), NW, fontsize(12));

// Mark x point on x axis with projection line
draw(P(x0, 0, 0)--P(x0, y1, 0), gray(0.5)+dotted+0.6);
dot(P(x0, 0, 0), red+linewidth(5));
label("$x$", P(x0+0.05, -0.08, 0), SE, fontsize(13));

// Label for top surface
label("$z=f(x,y)$", S(0.3, 0.7), NE, fontsize(15));
