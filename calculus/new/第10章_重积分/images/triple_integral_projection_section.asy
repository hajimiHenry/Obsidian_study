settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(780);
import three;

currentprojection = perspective(4.7,-5.2,3.2);

real f(real x, real y) { return 1.35 - 0.24*x*x - 0.18*y*y + 0.12*x; }
triple P(real x, real y, real z) { return (x,y,z); }
triple S(real x, real y) { return (x,y,f(x,y)); }

draw((-1.55,0,0)--(1.75,0,0), black+0.9, arrow=Arrow3());
draw((0,-1.42,0)--(0,1.55,0), black+0.9, arrow=Arrow3());
draw((0,0,0)--(0,0,1.82), black+0.9, arrow=Arrow3());
label("$x$", (1.60,-0.05,0), S, fontsize(17));
label("$y$", (0.08,1.42,0), NE, fontsize(17));
label("$z$", (0.12,-0.10,1.68), E, fontsize(17));

real rx = 1.18;
real ry = 0.88;

guide3 base;
for(int i=0; i<=96; ++i) {
  real t = 2*pi*i/96;
  triple q = (rx*cos(t), ry*sin(t), 0);
  base = (i==0) ? q : base--q;
}
path3 D = base--cycle;
draw(surface(D), rgb(0.82,0.88,1.0)+opacity(0.34));
draw(D, deepblue+1.0);
label("$D_{xy}$", (0.62,-0.62,0.03), S, fontsize(18));

for(int k=0; k<8; ++k) {
  real t = 2*pi*k/8;
  triple b = (rx*cos(t), ry*sin(t), 0);
  triple top = S(rx*cos(t), ry*sin(t));
  draw(b--top, gray(0.55)+0.45);
}

for(int k=-3; k<=3; ++k) {
  real y = 0.22*k;
  guide3 g;
  for(int i=-50; i<=50; ++i) {
    real x = rx*i/50;
    if(x*x/(rx*rx)+y*y/(ry*ry) <= 1.001) {
      g = (i==-50) ? S(x,y) : g--S(x,y);
    }
  }
  draw(g, gray(0.42)+0.55);
}
for(int k=-4; k<=4; ++k) {
  real x = 0.22*k;
  guide3 g;
  bool started = false;
  for(int i=-50; i<=50; ++i) {
    real y = ry*i/50;
    if(x*x/(rx*rx)+y*y/(ry*ry) <= 1.001) {
      if(!started) { g = S(x,y); started = true; }
      else g = g--S(x,y);
    }
  }
  if(started) draw(g, gray(0.42)+0.55);
}

real zc = 0.78;
real rxs = sqrt(max(0,(1.35+0.12*0-zc)/0.24));
real rys = sqrt(max(0,(1.35-zc)/0.18));
guide3 sec;
for(int i=0; i<=96; ++i) {
  real t = 2*pi*i/96;
  real x = min(rx,rxs)*cos(t);
  real y = min(ry,rys)*sin(t);
  sec = (i==0) ? P(x,y,zc) : sec--P(x,y,zc);
}
path3 Dz = sec--cycle;
draw(surface(Dz), rgb(0.95,0.78,0.46)+opacity(0.48));
draw(Dz, rgb(0.88,0.38,0.05)+1.4);
label("$D_z$", (0.70,0.34,zc+0.05), E, fontsize(18));
label("$z=\mathrm{const}$", (-1.05,0.45,zc+0.04), W, fontsize(15));

label("$\Omega$", (0.10,0.12,1.42), N, fontsize(20));
