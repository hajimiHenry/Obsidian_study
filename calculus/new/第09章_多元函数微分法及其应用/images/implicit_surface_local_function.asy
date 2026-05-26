settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(760);
import three;

currentprojection = perspective(5,-7,4);

pen axisPen = gray(0.35)+0.8;
pen spherePen = lightblue+opacity(0.18);
pen gridPen = lightblue+0.7+opacity(0.55);
pen topPen = deepgreen+1.8;
pen sidePen = red+1.8;
pen projPen = gray(0.45)+dashed+0.8;
pen zPen = blue+1.5;
pen xPen = orange+1.5;

real R=2;
triple C=(0,0,2);

// axes
real a=3.0;
draw((-a,0,0)--(a,0,0), axisPen, arrow=Arrow3());
draw((0,-a,0)--(0,a,0), axisPen, arrow=Arrow3());
draw((0,0,0)--(0,0,4.6), axisPen, arrow=Arrow3());
label("$x$", (a,0,0), E, fontsize(13));
label("$y$", (0,a,0), N, fontsize(13));
label("$z$", (0,0,4.6), N, fontsize(13));

// sphere surface
surface sph = shift(C)*scale3(R)*unitsphere;
draw(sph, spherePen);

// latitude circles
for (real zz : new real[] {0.5, 1.2, 2.0, 2.8, 3.5}) {
  real rr = sqrt(max(0, R*R-(zz-2)*(zz-2)));
  path3 q;
  for (int i=0; i<=120; ++i) {
    real t=2*pi*i/120;
    triple p=(rr*cos(t), rr*sin(t), zz);
    if (i==0) q=p; else q=q--p;
  }
  draw(q, gridPen);
}

// longitude curves
for (real phi : new real[] {0, pi/4, pi/2, 3*pi/4}) {
  path3 q;
  for (int i=0; i<=120; ++i) {
    real th=pi*i/120;
    triple p=(R*sin(th)*cos(phi), R*sin(th)*sin(phi), 2+R*cos(th));
    if (i==0) q=p; else q=q--p;
  }
  draw(q, gridPen);
}

// xy projection disk boundary
path3 disk;
for (int i=0; i<=120; ++i) {
  real t=2*pi*i/120;
  triple p=(R*cos(t), R*sin(t), 0);
  if (i==0) disk=p; else disk=disk--p;
}
draw(disk, gray(0.7)+dashed+0.8);
label("投影到 $xy$ 平面", (1.2,-1.6,0), S, fontsize(12));

// Top patch point: z as f(x,y)
triple P=(0.85,0.65, 2+sqrt(R*R-0.85*0.85-0.65*0.65));
triple Pxy=(0.85,0.65,0);
draw(Pxy--P, zPen, arrow=Arrow3());
draw((0,0,0)--Pxy, projPen);
dot(P, topPen+linewidth(5));
dot(Pxy, blue+linewidth(4));
label("$P$: 可写 $z=f(x,y)$", P+(0.15,0.05,0.35), NE, fontsize(13));
label("固定 $(x,y)$，上下调 $z$", (1.05,0.8,1.8), E, fontsize(12));

// small tangent-ish patch around P drawn by local level curves
real x0=0.85, y0=0.65;
for (real dx : new real[] {-0.35,0,0.35}) {
  path3 q;
  bool first=true;
  for (int j=-24; j<=24; ++j) {
    real yy=y0+j*0.018;
    real xx=x0+dx;
    real inside=R*R-xx*xx-yy*yy;
    if (inside>0) {
      triple p=(xx,yy,2+sqrt(inside));
      if (first) { q=p; first=false; } else q=q--p;
    }
  }
  draw(q, topPen+0.8);
}
for (real dy : new real[] {-0.30,0,0.30}) {
  path3 q;
  bool first=true;
  for (int j=-24; j<=24; ++j) {
    real xx=x0+j*0.018;
    real yy=y0+dy;
    real inside=R*R-xx*xx-yy*yy;
    if (inside>0) {
      triple p=(xx,yy,2+sqrt(inside));
      if (first) { q=p; first=false; } else q=q--p;
    }
  }
  draw(q, topPen+0.8);
}

// Side point: cannot write z as f(x,y) there, but can write x as g(y,z)
triple Q=(R,0,2);
triple Qyz=(0,0,2);
draw(Qyz--Q, xPen, arrow=Arrow3());
dot(Q, sidePen+linewidth(5));
dot(Qyz, orange+linewidth(4));
label("$Q$: $F_z=0$", Q+(0.2,0,0.25), E, fontsize(13));
label("这里改写 $x=g(y,z)$", (1.1,0.15,2.45), N, fontsize(12));

// vertical tangent indication around Q: small vertical line on surface edge
path3 vline;
for (int i=-35; i<=35; ++i) {
  real zz=2+i*0.018;
  real xx=sqrt(max(0, R*R-(zz-2)*(zz-2)));
  triple p=(xx,0,zz);
  if (i==-35) vline=p; else vline=vline--p;
}
draw(vline, sidePen+1.2);

label("球面：$x^2+y^2+(z-2)^2=4$", (-1.8,1.7,4.25), N, fontsize(14));
label("分母看你想解谁：$F_z\ne0$ 解 $z$；$F_x\ne0$ 解 $x$", (-2.2,-2.35,0.25), S, fontsize(13));
