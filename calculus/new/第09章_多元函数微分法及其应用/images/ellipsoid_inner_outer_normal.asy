settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(700);
import three;

currentprojection = perspective(4.2,3.2,2.2);

real a=2.25, b=1.55, c=1.25;
real u=0.42, v=0.78; // representative point on ellipsoid
triple O=(0,0,0);
triple M0=(a*cos(u)*cos(v), b*cos(u)*sin(v), c*sin(u));

// F=x^2/a^2+y^2/b^2+z^2/c^2-1, so grad F is normal.
triple n=(M0.x/(a*a), M0.y/(b*b), M0.z/(c*c));
triple nhat=unit(n);
triple t1=unit((n.y,-n.x,0));
triple t2=unit(cross(nhat,t1));
real s1=0.85, s2=0.60;

pen axispen=gray(0.35)+0.7;
pen wirepen=gray(0.55)+0.75;
pen mainpen=deepcyan+1.1;
pen planepen=orange+1.2;
pen outpen=red+1.9;
pen inpen=blue+1.9;

// axes
real Lx=2.65, Ly=2.05, Lz=1.65;
draw((-Lx,0,0)--(Lx,0,0), axispen, arrow=Arrow3());
draw((0,-Ly,0)--(0,Ly,0), axispen, arrow=Arrow3());
draw((0,0,-0.35)--(0,0,Lz), axispen, arrow=Arrow3());
label("$O$", O, SW, fontsize(12));

// helper to build curves on ellipsoid
guide3 latitude(real phi) {
  guide3 g;
  for(int i=0; i<=144; ++i) {
    real th=2*pi*i/144;
    triple P=(a*cos(phi)*cos(th), b*cos(phi)*sin(th), c*sin(phi));
    if(i==0) g=P; else g=g--P;
  }
  return g;
}

guide3 longitude(real th) {
  guide3 g;
  for(int i=0; i<=120; ++i) {
    real phi=-pi/2 + pi*i/120;
    triple P=(a*cos(phi)*cos(th), b*cos(phi)*sin(th), c*sin(phi));
    if(i==0) g=P; else g=g--P;
  }
  return g;
}

// ellipsoid wireframe
for(real phi : new real[] {-0.75,-0.38,0,0.38,0.75}) draw(latitude(phi), wirepen);
for(real th : new real[] {0,pi/4,pi/2,3*pi/4,pi,5*pi/4,3*pi/2,7*pi/4}) draw(longitude(th), wirepen);
draw(latitude(0), mainpen);
draw(longitude(v), mainpen);

// tangent plane patch at M0
triple P1=M0 + s1*t1 + s2*t2;
triple P2=M0 - s1*t1 + s2*t2;
triple P3=M0 - s1*t1 - s2*t2;
triple P4=M0 + s1*t1 - s2*t2;
path3 patch=P1--P2--P3--P4--cycle;
draw(surface(patch), lightyellow+opacity(0.55));
draw(patch, planepen);
label("tangent plane", P2+0.12*t2, W, fontsize(12));

// dashed normal line
triple A=M0-1.05*nhat;
triple B=M0+1.25*nhat;
draw(A--B, gray(0.25)+0.7+dashed);

// arrows for outer and inner normal
draw(M0--(M0+1.12*nhat), outpen, arrow=Arrow3());
draw(M0--(M0-0.92*nhat), inpen, arrow=Arrow3());

// line from center to M0: shows inside/outside intuition; it is not the normal for a general ellipsoid
draw(O--M0, gray(0.5)+0.7+dashed);

// points and labels last
dot(O, linewidth(4));
dot(M0, linewidth(5));
label("$M_0$", M0+(0.08,0.08,0.12), NE, fontsize(14));
label("$\nabla F$  out", M0+1.16*nhat+(0.05,0,0.06), NE, fontsize(14));
label("$-\nabla F$  in", M0-0.96*nhat+(-0.06,0,-0.05), SW, fontsize(14));
label("$F<0$", O+(-0.35,-0.18,0.20), SW, fontsize(13));
label("$F>0$", M0+1.35*nhat+(0.10,0.05,0.10), NE, fontsize(13));

