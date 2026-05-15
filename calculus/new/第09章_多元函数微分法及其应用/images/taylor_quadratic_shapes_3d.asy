settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(1000);
import three;

currentprojection = perspective(5.0,3.6,2.8);

triple P(real x, real y, real z, real shift) { return (x+shift,y,z); }
real fmin(real x, real y) { return 0.35*(x*x+y*y); }
real fmax(real x, real y) { return -0.35*(x*x+y*y)+1.05; }
real fsad(real x, real y) { return 0.35*(x*x-y*y)+0.50; }

void mesh(real shift, real kind) {
  for(int i=-5; i<=5; ++i) {
    real x = i*0.16;
    guide3 g;
    for(int j=-35; j<=35; ++j) {
      real y = j*0.80/35;
      real z = kind==0 ? fmin(x,y) : (kind==1 ? fmax(x,y) : fsad(x,y));
      g = (j==-35) ? P(x,y,z,shift) : g--P(x,y,z,shift);
    }
    draw(g, gray(0.45)+0.6);
  }
  for(int j=-5; j<=5; ++j) {
    real y = j*0.16;
    guide3 g;
    for(int i=-35; i<=35; ++i) {
      real x = i*0.80/35;
      real z = kind==0 ? fmin(x,y) : (kind==1 ? fmax(x,y) : fsad(x,y));
      g = (i==-35) ? P(x,y,z,shift) : g--P(x,y,z,shift);
    }
    draw(g, gray(0.45)+0.6);
  }
}

mesh(-2.10,0);
mesh(0,1);
mesh(2.10,2);

dot(P(0,0,fmin(0,0),-2.10), linewidth(6));
dot(P(0,0,fmax(0,0),0), linewidth(6));
dot(P(0,0,fsad(0,0),2.10), linewidth(6));

label("$D>0,\ A>0$", P(0,-0.92,0.62,-2.10), S, fontsize(20));
label("min", P(0,0.92,0.72,-2.10), N, fontsize(20));
label("$D>0,\ A<0$", P(0,-0.92,1.12,0), S, fontsize(20));
label("max", P(0,0.92,1.16,0), N, fontsize(20));
label("$D<0$", P(0,-0.92,0.95,2.10), S, fontsize(20));
label("saddle", P(0,0.92,1.00,2.10), N, fontsize(20));
