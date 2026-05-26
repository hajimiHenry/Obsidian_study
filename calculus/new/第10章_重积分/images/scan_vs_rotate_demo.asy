settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(720);
import three;

currentprojection = orthographic(0,0,9);

triple P(real x, real y) { return (x,y,0); }

// Define left translation region curves
real yl(real x) { return 0.16 + 0.18*(x+0.35)^2; }
real yu(real x) { return 1.42 - 0.10*x; }

// Define right polar region curves
real alpha = pi/6;      // 30 deg
real beta = 2*pi/3;     // 120 deg
real r1(real theta) { return 0.5 + 0.12*cos(2*theta); }
real r2(real theta) { return 1.35 - 0.15*sin(theta); }

triple off1 = (-1.65,0,0);
triple off2 = (1.65,0,0);

// --- Draw Left Side: Translation Scan (Rectangular) ---
guide3 bx;
for(int i=0; i<=70; ++i) {
  real x = -1.05 + 2.10*i/70;
  bx = (i==0) ? off1+P(x,yl(x)) : bx--(off1+P(x,yl(x)));
}
for(int i=70; i>=0; --i) {
  real x = -1.05 + 2.10*i/70;
  bx = bx--(off1+P(x,yu(x)));
}
path3 DX = bx--cycle;
draw(surface(DX), rgb(0.80,0.90,1.0)+opacity(0.46));
draw(DX, deepblue+1.1);

// Helper scanning lines (translation)
real[] x_ticks = {-0.65, -0.2, 0.65};
for(int i=0; i<x_ticks.length; ++i) {
  real xt = x_ticks[i];
  draw(off1+P(xt, yl(xt))--off1+P(xt, yu(xt)), gray(0.5)+dashed+0.8);
}
// Main scan line
real xs = 0.25;
draw(off1+P(xs,yl(xs))--off1+P(xs,yu(xs)), heavyred+1.6, arrow=Arrow3());
label("$\varphi_1(x)$", off1+P(xs-0.10,yl(xs)-0.05), S, fontsize(13));
label("$\varphi_2(x)$", off1+P(xs+0.10,yu(xs)+0.06), N, fontsize(13));
label("$x=a$", off1+P(-1.05,-0.10), S, fontsize(12));
label("$x=b$", off1+P(1.05,-0.10), S, fontsize(12));

// Translation direction arrow
draw(off1+P(-0.8, -0.3)--off1+P(0.8, -0.3), deepblue+1.3, arrow=Arrow3());
label("平移扫描方向", off1+P(0, -0.45), fontsize(11));
label("直角坐标：平移扫描（“扫”一整面）", off1+P(0.0, 1.58), N, fontsize(14));

// --- Draw Right Side: Rotation Scan (Polar) ---
guide3 by;
for(int i=0; i<=70; ++i) {
  real theta = alpha + (beta-alpha)*i/70;
  real r = r2(theta);
  by = (i==0) ? off2+P(r*cos(theta), r*sin(theta)) : by--(off2+P(r*cos(theta), r*sin(theta)));
}
for(int i=70; i>=0; --i) {
  real theta = alpha + (beta-alpha)*i/70;
  real r = r1(theta);
  by = by--(off2+P(r*cos(theta), r*sin(theta)));
}
path3 DY = by--cycle;
draw(surface(DY), rgb(0.82,0.95,0.84)+opacity(0.46));
draw(DY, rgb(0.05,0.48,0.22)+1.1);

// Helper scanning lines (rotation)
real[] ang_ticks = {alpha+0.25, alpha+0.75, alpha+1.15};
for(int i=0; i<ang_ticks.length; ++i) {
  real ang = ang_ticks[i];
  draw(off2+P(r1(ang)*cos(ang), r1(ang)*sin(ang))--off2+P(r2(ang)*cos(ang), r2(ang)*sin(ang)), gray(0.5)+dashed+0.8);
}
// Main scan ray line
real main_ang = alpha + 0.52;
draw(off2+P(r1(main_ang)*cos(main_ang), r1(main_ang)*sin(main_ang))--off2+P(r2(main_ang)*cos(main_ang), r2(main_ang)*sin(main_ang)), heavyred+1.6, arrow=Arrow3());
label("$\rho=\rho_1(\theta)$", off2+P(r1(main_ang)*cos(main_ang), r1(main_ang)*sin(main_ang))-0.08*cos(main_ang)*X-0.08*sin(main_ang)*Y, SW, fontsize(12));
label("$\rho=\rho_2(\theta)$", off2+P(r2(main_ang)*cos(main_ang), r2(main_ang)*sin(main_ang))+0.06*cos(main_ang)*X+0.06*sin(main_ang)*Y, NE, fontsize(12));
label("$\theta=\alpha$", off2+P(1.4*cos(alpha), 1.4*sin(alpha)), SE, fontsize(12));
label("$\theta=\beta$", off2+P(1.3*cos(beta), 1.3*sin(beta)), NW, fontsize(12));

// Rotation direction arc arrow
guide3 arc_path;
real r_arc = 0.35;
for(int i=0; i<=30; ++i) {
  real theta = (alpha - 0.1) + ((beta + 0.1) - (alpha - 0.1))*i/30;
  arc_path = (i==0) ? off2+P(r_arc*cos(theta), r_arc*sin(theta)) : arc_path--(off2+P(r_arc*cos(theta), r_arc*sin(theta)));
}
draw(arc_path, rgb(0.05,0.48,0.22)+1.2, arrow=Arrow3());
label("旋转扫描方向", off2+P(0.48*cos(main_ang), 0.48*sin(main_ang)), NE, fontsize(11));
label("极坐标：旋转扫描（“转”一整圈）", off2+P(0.0, 1.58), N, fontsize(14));

// --- Draw Coordinate Axes with x, y, O labels ---
// Left Side Axes (centered at off1)
draw(off1+P(-1.25, 0)--off1+P(1.25, 0), black+0.7, arrow=Arrow3());
draw(off1+P(0, -0.15)--off1+P(0, 1.55), black+0.7, arrow=Arrow3());
label("$x$", off1+P(1.25, 0), NE, fontsize(12));
label("$y$", off1+P(0, 1.55), N, fontsize(12));
label("$O$", off1+P(-0.08, -0.08), SW, fontsize(11));

// Right Side Axes (centered at off2)
draw(off2+P(-0.3, 0)--off2+P(1.25, 0), black+0.7, arrow=Arrow3());
draw(off2+P(0, -0.15)--off2+P(0, 1.55), black+0.7, arrow=Arrow3());
label("$x$", off2+P(1.25, 0), NE, fontsize(12));
label("$y$", off2+P(0, 1.55), N, fontsize(12));
label("$O$", off2+P(-0.08, -0.08), SW, fontsize(11));
