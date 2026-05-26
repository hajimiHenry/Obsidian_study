settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(800);
import three;

currentprojection = perspective(5.0, -6.5, 4.0);

// Helper function to draw a circle
path3 circle3(triple center, real r) {
  guide3 g;
  for(int i=0; i<=72; ++i) {
    real t = 2*pi*i/72;
    g = g--(center + (r*cos(t), r*sin(t), 0));
  }
  return g--cycle;
}

// Helper functions for half-circles
path3 halfcircle_top(triple center, real r) {
  guide3 g;
  for(int i=0; i<=36; ++i) {
    real t = pi*i/36;
    g = g--(center + (r*cos(t), r*sin(t), 0));
  }
  return g--cycle;
}

path3 halfcircle_bottom(triple center, real r) {
  guide3 g;
  for(int i=0; i<=36; ++i) {
    real t = pi + pi*i/36;
    g = g--(center + (r*cos(t), r*sin(t), 0));
  }
  return g--cycle;
}

path3 halfcircle_left(triple center, real r) {
  guide3 g;
  for(int i=0; i<=36; ++i) {
    real t = pi/2 + pi*i/36;
    g = g--(center + (r*cos(t), r*sin(t), 0));
  }
  return g--cycle;
}

path3 halfcircle_right(triple center, real r) {
  guide3 g;
  for(int i=0; i<=36; ++i) {
    real t = -pi/2 + pi*i/36;
    g = g--(center + (r*cos(t), r*sin(t), 0));
  }
  return g--cycle;
}

// Offsets for the two subplots
triple off1 = (-1.8, 0, 0);
triple off2 = (1.8, 0, 0);

real rx = 1.1;
real ry = 1.1;

// Surface function for Left Plot: z = y*cos(x) (odd in y)
real f1(real x, real y) { return y * cos(x); }
triple S1(real x, real y) { return off1 + (x, y, f1(x, y)); }

// Surface function for Right Plot: z = x*cos(y) (odd in x)
real f2(real x, real y) { return x * cos(y); }
triple S2(real x, real y) { return off2 + (x, y, f2(x, y)); }

int nx = 8;
int ny = 8;

// ================= LEFT PLOT: Symmetric w.r.t. x-axis (f is odd in y) =================
// 1. Color regions on bottom disk (z=0)
draw(surface(halfcircle_top(off1, rx)), rgb(1.0, 0.88, 0.88) + opacity(0.5));
draw(surface(halfcircle_bottom(off1, rx)), rgb(0.88, 0.92, 1.0) + opacity(0.5));
draw(circle3(off1, rx), deepblue + 1.1);

// 2. Axis
draw(off1 + (-1.4, 0, 0) -- off1 + (1.5, 0, 0), black+0.7, arrow=Arrow3());
draw(off1 + (0, -1.4, 0) -- off1 + (0, 1.5, 0), black+0.7, arrow=Arrow3());
draw(off1 + (0, 0, -1.3) -- off1 + (0, 0, 1.4), black+0.7, arrow=Arrow3());
label("$x$", off1 + (1.5, 0, 0), E, fontsize(13));
label("$y$", off1 + (0, 1.5, 0), N, fontsize(13));
label("$z$", off1 + (0, 0, 1.4), N, fontsize(13));
label("$D$", off1 + (-1.0, 0.2, 0), W, fontsize(14));
label("Symmetric w.r.t. $x$-axis", off1 + (0, -2.1, 0), S, fontsize(13));
label("$z = y \cos x$ (odd in $y$)", off1 + (0, 2.1, 0), N, fontsize(13));

// Plus/Minus indicators on the base
label("$+$", off1 + (-0.5, 0.4, 0), fontsize(20)+rgb(0.7, 0.1, 0.1));
label("$-$", off1 + (-0.5, -0.4, 0), fontsize(20)+rgb(0.1, 0.1, 0.7));

// 3. Surface grid lines (red for top/positive, blue for bottom/negative)
for(int i=-nx; i<=nx; ++i) {
  real x = rx * i / nx;
  
  // y >= 0
  guide3 g_top;
  bool started_top = false;
  for(int j=0; j<=25; ++j) {
    real y = ry * j / 25;
    if(x*x + y*y <= rx*rx + 0.001) {
      if(!started_top) { g_top = S1(x,y); started_top = true; }
      else g_top = g_top--S1(x,y);
    }
  }
  if(started_top) draw(g_top, red+0.4);

  // y <= 0
  guide3 g_bot;
  bool started_bot = false;
  for(int j=-25; j<=0; ++j) {
    real y = ry * j / 25;
    if(x*x + y*y <= rx*rx + 0.001) {
      if(!started_bot) { g_bot = S1(x,y); started_bot = true; }
      else g_bot = g_bot--S1(x,y);
    }
  }
  if(started_bot) draw(g_bot, blue+0.4);
}

for(int j=-ny; j<=ny; ++j) {
  real y = ry * j / ny;
  guide3 g;
  bool started = false;
  for(int i=-25; i<=25; ++i) {
    real x = rx * i / 25;
    if(x*x + y*y <= rx*rx + 0.001) {
      if(!started) { g = S1(x,y); started = true; }
      else g = g--S1(x,y);
    }
  }
  pen p = (y >= 0) ? (red+0.4) : (blue+0.4);
  if(started) draw(g, p);
}

// 4. Side generators (dashed vertical boundary lines)
for(int i=0; i<24; ++i) {
  real t = 2*pi*i/24;
  real x = rx*cos(t);
  real y = ry*sin(t);
  triple b = off1 + (x, y, 0);
  triple tp = S1(x, y);
  pen p = (y >= 0) ? (red+0.35+dashed) : (blue+0.35+dashed);
  draw(b--tp, p);
}

// 5. Symmetric points & Volume elements (represented as vertical lines to surface)
triple P1 = off1 + (0.5, 0.7, 0);
triple P2 = off1 + (0.5, -0.7, 0);
triple M1 = S1(0.5, 0.7);
triple M2 = S1(0.5, -0.7);

draw(P1--P2, gray(0.4)+0.8+dashed);
dot(P1, heavyred+linewidth(5));
dot(P2, heavyred+linewidth(5));
label("$P_1(x,y)$", P1, SE, fontsize(10));
label("$P_2(x,-y)$", P2, E, fontsize(10));

draw(P1--M1, red+1.6);
draw(P2--M2, blue+1.6);
dot(M1, red+linewidth(4.5));
dot(M2, blue+linewidth(4.5));
label("$z = f(x,y) > 0$", M1, N, fontsize(10));
label("$z = -f(x,y) < 0$", M2, S, fontsize(10));


// ================= RIGHT PLOT: Symmetric w.r.t. y-axis (f is odd in x) =================
// 1. Color regions on bottom disk (z=0)
draw(surface(halfcircle_left(off2, rx)), rgb(0.88, 0.92, 1.0) + opacity(0.5));
draw(surface(halfcircle_right(off2, rx)), rgb(1.0, 0.88, 0.88) + opacity(0.5));
draw(circle3(off2, rx), deepblue + 1.1);

// 2. Axis
draw(off2 + (-1.4, 0, 0) -- off2 + (1.5, 0, 0), black+0.7, arrow=Arrow3());
draw(off2 + (0, -1.4, 0) -- off2 + (0, 1.5, 0), black+0.7, arrow=Arrow3());
draw(off2 + (0, 0, -1.3) -- off2 + (0, 0, 1.4), black+0.7, arrow=Arrow3());
label("$x$", off2 + (1.5, 0, 0), E, fontsize(13));
label("$y$", off2 + (0, 1.5, 0), N, fontsize(13));
label("$z$", off2 + (0, 0, 1.4), N, fontsize(13));
label("$D$", off2 + (-1.0, 0.2, 0), W, fontsize(14));
label("Symmetric w.r.t. $y$-axis", off2 + (0, -2.1, 0), S, fontsize(13));
label("$z = x \cos y$ (odd in $x$)", off2 + (0, 2.1, 0), N, fontsize(13));

// Plus/Minus indicators on the base (empty area)
label("$-$", off2 + (-0.5, -0.4, 0), fontsize(20)+rgb(0.1, 0.1, 0.7));
label("$+$", off2 + (0.5, -0.4, 0), fontsize(20)+rgb(0.7, 0.1, 0.1));

// 3. Surface grid lines (red for right/positive, blue for left/negative)
for(int i=-nx; i<=nx; ++i) {
  real x = rx * i / nx;
  guide3 g;
  bool started = false;
  for(int j=-25; j<=25; ++j) {
    real y = ry * j / 25;
    if(x*x + y*y <= rx*rx + 0.001) {
      if(!started) { g = S2(x,y); started = true; }
      else g = g--S2(x,y);
    }
  }
  pen p = (x >= 0) ? (red+0.4) : (blue+0.4);
  if(started) draw(g, p);
}

for(int j=-ny; j<=ny; ++j) {
  real y = ry * j / ny;
  
  // x >= 0 (Right)
  guide3 g_right;
  bool started_right = false;
  for(int i=0; i<=25; ++i) {
    real x = rx * i / 25;
    if(x*x + y*y <= rx*rx + 0.001) {
      if(!started_right) { g_right = S2(x,y); started_right = true; }
      else g_right = g_right--S2(x,y);
    }
  }
  if(started_right) draw(g_right, red+0.4);

  // x <= 0 (Left)
  guide3 g_left;
  bool started_left = false;
  for(int i=-25; i<=0; ++i) {
    real x = rx * i / 25;
    if(x*x + y*y <= rx*rx + 0.001) {
      if(!started_left) { g_left = S2(x,y); started_left = true; }
      else g_left = g_left--S2(x,y);
    }
  }
  if(started_left) draw(g_left, blue+0.4);
}

// 4. Side generators (dashed vertical boundary lines)
for(int i=0; i<24; ++i) {
  real t = 2*pi*i/24;
  real x = rx*cos(t);
  real y = ry*sin(t);
  triple b = off2 + (x, y, 0);
  triple tp = S2(x, y);
  pen p = (x >= 0) ? (red+0.35+dashed) : (blue+0.35+dashed);
  draw(b--tp, p);
}

// 5. Symmetric points & Volume elements (represented as vertical lines to surface)
triple Q1 = off2 + (0.5, 0.7, 0);
triple Q2 = off2 + (-0.5, 0.7, 0);
triple N1 = S2(0.5, 0.7);
triple N2 = S2(-0.5, 0.7);

draw(Q1--Q2, gray(0.4)+0.8+dashed);
dot(Q1, heavyred+linewidth(5));
dot(Q2, heavyred+linewidth(5));
label("$Q_1(x,y)$", Q1, S, fontsize(10));
label("$Q_2(-x,y)$", Q2, S, fontsize(10));

draw(Q1--N1, red+1.6);
draw(Q2--N2, blue+1.6);
dot(N1, red+linewidth(4.5));
dot(N2, blue+linewidth(4.5));
label("$z = f(x,y) > 0$", N1, E, fontsize(10));
label("$z = -f(x,y) < 0$", N2, W, fontsize(10));
