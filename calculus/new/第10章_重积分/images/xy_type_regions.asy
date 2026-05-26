settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(750);
import three;

// Perspective view
currentprojection = perspective(4.5, -6.5, 3.8);

triple P(real x, real y, real z) { return (x,y,z); }

// Surface definition
real f(real x, real y) { return 1.8 - 0.22*x*x - 0.22*y*y; }
triple S(real x, real y) { return (x,y,f(x,y)); }

// Base Ellipse D parameters
real a = 1.2;
real b = 1.0;

triple off1 = (-1.8, 0, 0);
triple off2 = (1.8, 0, 0);

// --- HELPER FUNCTION TO DRAW ONE COLUMN (base, grid, edge) ---
void drawColumn(triple off, pen gridPen) {
  // Base region D
  guide3 base;
  for(int i=0; i<=72; ++i) {
    real t = 2*pi*i/72;
    base = (i==0) ? off+P(a*cos(t), b*sin(t), 0) : base--(off+P(a*cos(t), b*sin(t), 0));
  }
  draw(surface(base--cycle), rgb(0.85,0.92,1.0)+opacity(0.30));
  draw(base--cycle, deepblue+0.8);
  
  // Surface Grid
  int nx = 8;
  int ny = 8;
  for(int i=-nx; i<=nx; ++i) {
    real x = a * i / nx;
    guide3 g;
    bool started = false;
    for(int j=-40; j<=40; ++j) {
      real y = b * j / 40;
      if((x/a)*(x/a) + (y/b)*(y/b) <= 1.001) {
        if(!started) { g = off+S(x,y); started = true; }
        else g = g--(off+S(x,y));
      }
    }
    if(started) draw(g, gridPen+0.35);
  }
  for(int j=-ny; j<=ny; ++j) {
    real y = b * j / ny;
    guide3 g;
    bool started = false;
    for(int i=-40; i<=40; ++i) {
      real x = a * i / 40;
      if((x/a)*(x/a) + (y/b)*(y/b) <= 1.001) {
        if(!started) { g = off+S(x,y); started = true; }
        else g = g--(off+S(x,y));
      }
    }
    if(started) draw(g, gridPen+0.35);
  }
  
  // Surface edge
  guide3 top_edge;
  for(int i=0; i<=72; ++i) {
    real t = 2*pi*i/72;
    top_edge = (i==0) ? off+S(a*cos(t), b*sin(t)) : top_edge--(off+S(a*cos(t), b*sin(t)));
  }
  draw(top_edge--cycle, orange+0.8);
  
  // Side boundary dashed lines
  for(int i=0; i<8; ++i) {
    real t = 2*pi*i/8;
    triple bp = off+P(a*cos(t), b*sin(t), 0);
    triple tp = off+S(a*cos(t), b*sin(t));
    draw(bp--tp, gray(0.6)+0.4+dashed);
  }
}

// Draw the two columns
drawColumn(off1, orange);
drawColumn(off2, orange);

// --- LEFT SIDE: X-Type Slicing (Slice perpendicular to X-axis) ---
real x0 = 0.35;
real y_lim_x0 = b * sqrt(1.0 - (x0/a)*(x0/a));
real y1 = -y_lim_x0;
real y2 = y_lim_x0;

guide3 x_slice;
x_slice = off1+P(x0, y1, 0)--off1+P(x0, y2, 0);
for(int j=30; j>=0; --j) {
  real y = y1 + (y2-y1)*j/30;
  x_slice = x_slice--(off1+S(x0, y));
}
path3 x_slice_path = x_slice--cycle;
draw(surface(x_slice_path), rgb(1.0,0.65,0.65)+opacity(0.55));
draw(x_slice_path, red+1.1);

// Labels Left
label("$A(x)$", off1+P(x0, 0, f(x0,0)/2), W, fontsize(12));
label("$y=\varphi_1(x)$", off1+P(x0, y1-0.1, 0), S, fontsize(11));
label("$y=\varphi_2(x)$", off1+P(x0, y2+0.1, 0), N, fontsize(11));
label("$X$ 型区域（竖线平移切片）", off1+P(0, -1.2, 0), S, fontsize(13));
draw(off1+P(x0, 0, 0)--off1+P(x0, y1, 0), gray(0.55)+dotted+0.5);
dot(off1+P(x0,0,0), red+linewidth(4.5));
label("$x$", off1+P(x0+0.05, -0.05, 0), SE, fontsize(11));

// Sweep direction arrow for Left
draw(off1+P(-1.0, -1.2, 0)--off1+P(1.0, -1.2, 0), deepblue+1.2, arrow=Arrow3());
label("扫描方向", off1+P(0, -1.35, 0), fontsize(10));


// --- RIGHT SIDE: Y-Type Slicing (Slice perpendicular to Y-axis) ---
real y0 = 0.3;
real x_lim_y0 = a * sqrt(1.0 - (y0/b)*(y0/b));
real x1 = -x_lim_y0;
real x2 = x_lim_y0;

guide3 y_slice;
y_slice = off2+P(x1, y0, 0)--off2+P(x2, y0, 0);
for(int j=30; j>=0; --j) {
  real x = x1 + (x2-x1)*j/30;
  y_slice = y_slice--(off2+S(x, y0));
}
path3 y_slice_path = y_slice--cycle;
draw(surface(y_slice_path), rgb(0.65,0.95,0.65)+opacity(0.55));
draw(y_slice_path, rgb(0.05,0.48,0.22)+1.1);

// Labels Right
label("$B(y)$", off2+P(0, y0, f(0,y0)/2), E, fontsize(12));
label("$x=\psi_1(y)$", off2+P(x1-0.1, y0, 0), W, fontsize(11));
label("$x=\psi_2(y)$", off2+P(x2+0.1, y0, 0), E, fontsize(11));
label("$Y$ 型区域（横线平移切片）", off2+P(0, -1.2, 0), S, fontsize(13));
draw(off2+P(0, y0, 0)--off2+P(x1, y0, 0), gray(0.55)+dotted+0.5);
dot(off2+P(0,y0,0), rgb(0.05,0.48,0.22)+linewidth(4.5));
label("$y$", off2+P(-0.06, y0+0.06, 0), NW, fontsize(11));

// Sweep direction arrow for Right
draw(off2+P(-1.3, -0.8, 0)--off2+P(-1.3, 0.8, 0), rgb(0.05,0.48,0.22)+1.2, arrow=Arrow3());
label("扫描方向", off2+P(-1.4, 0, 0), W, fontsize(10));


// --- Draw Coordinate Axes for both sides ---
real x_limit = 1.7, y_limit = 1.5, z_limit = 2.2;

// Left axes
draw(off1+P(-1.4,0,0)--off1+P(x_limit,0,0), black+0.7, arrow=Arrow3());
draw(off1+P(0,-1.3,0)--off1+P(0,y_limit,0), black+0.7, arrow=Arrow3());
draw(off1+P(0,0,0)--off1+P(0,0,z_limit), black+0.7, arrow=Arrow3());
label("$x$", off1+P(x_limit-0.08, -0.05, 0), S, fontsize(13));
label("$y$", off1+P(0.05, y_limit-0.08, 0), NE, fontsize(13));
label("$z$", off1+P(0.08, -0.08, z_limit-0.12), E, fontsize(13));
label("$O$", off1+P(-0.08, -0.08, 0), SW, fontsize(11));

// Right axes
draw(off2+P(-1.4,0,0)--off2+P(x_limit,0,0), black+0.7, arrow=Arrow3());
draw(off2+P(0,-1.3,0)--off2+P(0,y_limit,0), black+0.7, arrow=Arrow3());
draw(off2+P(0,0,0)--off2+P(0,0,z_limit), black+0.7, arrow=Arrow3());
label("$x$", off2+P(x_limit-0.08, -0.05, 0), S, fontsize(13));
label("$y$", off2+P(0.05, y_limit-0.08, 0), NE, fontsize(13));
label("$z$", off2+P(0.08, -0.08, z_limit-0.12), E, fontsize(13));
label("$O$", off2+P(-0.08, -0.08, 0), SW, fontsize(11));
