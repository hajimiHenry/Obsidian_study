settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(700);
import three;

currentprojection = perspective(4.4,-5.2,3.2);

triple Sph(real r, real ph, real th) {
  return (r*sin(ph)*cos(th), r*sin(ph)*sin(th), r*cos(ph));
}

real r1 = 1.35;
real r2 = 1.78;
real p1 = 0.62;
real p2 = 0.90;
real t1 = 0.48;
real t2 = 0.82;

draw((-0.35,0,0)--(1.95,0,0), black+0.85, arrow=Arrow3());
draw((0,-0.35,0)--(0,1.75,0), black+0.85, arrow=Arrow3());
draw((0,0,0)--(0,0,1.95), black+0.85, arrow=Arrow3());
label("$x$", (1.82,-0.05,0), S, fontsize(16));
label("$y$", (0.06,1.62,0), E, fontsize(16));
label("$z$", (0.10,-0.08,1.78), E, fontsize(16));

guide3 patch;
for(int i=0; i<=24; ++i) {
  real th = t1 + (t2-t1)*i/24;
  patch = (i==0) ? Sph(r2,p1,th) : patch--Sph(r2,p1,th);
}
for(int i=0; i<=24; ++i) {
  real ph = p1 + (p2-p1)*i/24;
  patch = patch--Sph(r2,ph,t2);
}
for(int i=24; i>=0; --i) {
  real th = t1 + (t2-t1)*i/24;
  patch = patch--Sph(r2,p2,th);
}
for(int i=24; i>=0; --i) {
  real ph = p1 + (p2-p1)*i/24;
  patch = patch--Sph(r2,ph,t1);
}
path3 outer = patch--cycle;
draw(surface(outer), rgb(1.0,0.84,0.46)+opacity(0.56));
draw(outer, rgb(0.84,0.45,0.02)+1.15);

for(int i=0; i<2; ++i) {
  real ph = (i==0) ? p1 : p2;
  for(int j=0; j<2; ++j) {
    real th = (j==0) ? t1 : t2;
    draw(Sph(r1,ph,th)--Sph(r2,ph,th), rgb(0.84,0.45,0.02)+1.0);
  }
}

for(int i=0; i<2; ++i) {
  real ph = (i==0) ? p1 : p2;
  guide3 g;
  for(int k=0; k<=24; ++k) {
    real th = t1 + (t2-t1)*k/24;
    g = (k==0) ? Sph(r1,ph,th) : g--Sph(r1,ph,th);
  }
  draw(g, gray(0.45)+0.7);
}
for(int j=0; j<2; ++j) {
  real th = (j==0) ? t1 : t2;
  guide3 g;
  for(int k=0; k<=24; ++k) {
    real ph = p1 + (p2-p1)*k/24;
    g = (k==0) ? Sph(r1,ph,th) : g--Sph(r1,ph,th);
  }
  draw(g, gray(0.45)+0.7);
}

draw((0,0,0)--Sph(r2,0.76,0.64), deepblue+1.2, arrow=Arrow3());
draw(Sph(r1,p2,t2)--Sph(r2,p2,t2), heavyred+1.4, arrow=Arrow3());

guide3 pharc;
for(int i=0; i<=36; ++i) {
  real ph = p1 + (p2-p1)*i/36;
  pharc = (i==0) ? Sph(r2,ph,t2) : pharc--Sph(r2,ph,t2);
}
draw(pharc, heavyred+1.4);

guide3 tharc;
for(int i=0; i<=36; ++i) {
  real th = t1 + (t2-t1)*i/36;
  tharc = (i==0) ? Sph(r2,p2,th) : tharc--Sph(r2,p2,th);
}
draw(tharc, heavyred+1.4);

label("$r$", 0.52*Sph(r2,0.76,0.64)+(0.05,0.02,0.04), N, fontsize(17));
label("$dr$", Sph(1.58,p2,t2)+(0.04,0.06,0.04), NE, fontsize(16));
label("$r\,d\varphi$", Sph(r2,0.77,t2)+(0.08,0.04,0.04), E, fontsize(16));
label("$r\sin\varphi\,d\theta$", Sph(r2,p2,0.66)+(0.08,0.04,0.02), N, fontsize(16));
label("$dV=r^2\sin\varphi\,dr\,d\varphi\,d\theta$", (0.58,1.17,1.62), N, fontsize(17));
