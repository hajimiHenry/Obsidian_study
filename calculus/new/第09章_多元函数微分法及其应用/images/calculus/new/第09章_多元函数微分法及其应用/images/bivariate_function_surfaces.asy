settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(1050, 390);
import three;

currentprojection = orthographic(7.5, 5.0, 3.2);

defaultpen(fontsize(11));

real R = 1.45;
int N = 54;

real zval(int typ, real x, real y) {
  if(typ == 0) return 0.34*(x*x + y*y) - 0.55;       // bowl: local minimum
  if(typ == 1) return 0.55 - 0.34*(x*x + y*y);       // cap: local maximum
  return 0.42*x*y;                                   // saddle: stationary but not extremum
}

guide3 meshLine(int typ, real ox, real c, bool xfixed) {
  guide3 g;
  for(int i=0; i<=N; ++i) {
    real t = -R + 2*R*i/N;
    real x = xfixed ? c : t;
    real y = xfixed ? t : c;
    triple P = (ox + x, y, zval(typ,x,y));
    g = (i==0) ? P : g--P;
  }
  return g;
}

void drawGround(real ox, pen p) {
  path3 sq = (ox-R,-R,0)--(ox+R,-R,0)--(ox+R,R,0)--(ox-R,R,0)--cycle;
  draw(surface(sq), p+opacity(0.10));
  draw(sq, gray(0.72)+0.45);
  for(int k=-1; k<=1; ++k) {
    real t = k*R/2;
    draw((ox-R,t,0)--(ox+R,t,0), gray(0.80)+0.25);
    draw((ox+t,-R,0)--(ox+t,R,0), gray(0.80)+0.25);
  }
}

void drawAxes(real ox) {
  draw((ox-1.75,0,0)--(ox+1.85,0,0), black+0.75, arrow=Arrow3(4));
  draw((ox,-1.65,0)--(ox,1.75,0), black+0.75, arrow=Arrow3(4));
  draw((ox,0,-1.0)--(ox,0,1.25), black+0.75, arrow=Arrow3(4));
  label("$x$", (ox+1.75,0,0), S, fontsize(12));
  label("$y$", (ox,1.63,0), E, fontsize(12));
  label("$z$", (ox,0,1.18), E, fontsize(12));
}

void drawSurface(int typ, real ox, pen p, string title, string formula) {
  drawGround(ox, p);
  drawAxes(ox);
  for(int k=-3; k<=3; ++k) {
    real c = k*R/3;
    draw(meshLine(typ, ox, c, true), p+0.9);
    draw(meshLine(typ, ox, c, false), p+0.9);
  }
  draw(meshLine(typ, ox, 0, true), black+1.1);
  draw(meshLine(typ, ox, 0, false), black+1.1);
  dot((ox,0,zval(typ,0,0)), black+linewidth(5));
  draw((ox,0,0)--(ox,0,zval(typ,0,0)), gray(0.45)+dashed+0.7);
  label(title, (ox, -1.9, 1.28), fontsize(14));
  label(formula, (ox, -1.9, 1.03), fontsize(13));
}

drawSurface(0, -4.6, deepblue, "$\mathrm{local\ min}$", "$z=x^2+y^2$");
drawSurface(1, 0.0, heavyred, "$\mathrm{local\ max}$", "$z=-x^2-y^2$");
drawSurface(2, 4.6, deepgreen, "$\mathrm{saddle}$", "$z=xy$");

label("$z=f(x,y)$: $(x,y)$ on the floor gets a height $z$", (0, -2.35, -1.05), fontsize(13));
