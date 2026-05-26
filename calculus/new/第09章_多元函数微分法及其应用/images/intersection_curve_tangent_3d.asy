settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(700);
import three;
texpreamble("\usepackage{ctex}");

currentprojection = perspective(4.9,-5.3,3.6);

triple S(real u, real v) { return (u, v, 0.62 - 0.22*u - 0.10*v); }
triple C(real t) { return (0.74*cos(t), 0.74*sin(t), 0.62 - 0.22*0.74*cos(t) - 0.10*0.74*sin(t)); }

real t0 = 0.82;
triple M = C(t0);
triple n1 = unit((0,0,1));
triple n2 = unit((0.22,0.10,1));
triple tau = unit(cross(n1,n2));

draw((-1.20,0,0)--(1.35,0,0), black+0.8, arrow=Arrow3());
draw((0,-1.15,0)--(0,1.35,0), black+0.8, arrow=Arrow3());
draw((0,0,0)--(0,0,1.55), black+0.9, arrow=Arrow3());
label("$x$", (1.22,-0.04,0), S, fontsize(16));
label("$y$", (0.08,1.25,0.04), NE, fontsize(16));
label("$z$", (0.16,-0.12,1.42), E, fontsize(16));

path3 disk;
for(int i=0; i<=120; ++i) {
  real t = i*2*pi/120;
  triple p = (0.82*cos(t),0.82*sin(t),0.62);
  disk = (i==0) ? p : disk--p;
}
draw(surface(disk--cycle), rgb(0.85,0.88,0.92)+opacity(0.24));
draw(disk--cycle, gray(0.45)+0.75);

path3 plane =
  S(-0.95,-0.85)--S(0.98,-0.85)--S(0.98,0.90)--S(-0.95,0.90)--cycle;
draw(surface(plane), lightblue+opacity(0.26));
draw(plane, deepblue+0.8);

guide3 inter;
for(int i=0; i<=160; ++i) {
  real t = i*2*pi/160;
  inter = (i==0) ? C(t) : inter--C(t);
}
draw(inter, heavyred+1.8);

draw(M-0.55*tau--M+0.72*tau, red+2.0, arrow=Arrow3());
draw(M--M+0.42*n1, gray(0.25)+1.3, arrow=Arrow3());
draw(M--M+0.44*n2, deepblue+1.3, arrow=Arrow3());

dot(M, linewidth(5.5));
label("$M$", M+(0.06,0.04,0.03), E, fontsize(16));
label("$\mathbf n_1$", M+0.43*n1+(0.01,-0.02,0.02), N, fontsize(15));
label("$\mathbf n_2$", M+0.44*n2+(0.02,0.02,0.02), NE, deepblue+fontsize(15));
label("$\mathbf t=\mathbf n_1\times\mathbf n_2$", M+0.72*tau+(0.02,0.02,0.02), NE, red+fontsize(15));
label("交线", C(3.85)+(0.02,-0.02,0.04), S, red+fontsize(15));

// 绘制直角符号表示垂直关系
real s_ang = 0.08;
// t 和 n1 垂直
draw((M + s_ang*n1) -- (M + s_ang*n1 + s_ang*tau) -- (M + s_ang*tau), gray(0.4)+0.6);
// t 和 n2 垂直
draw((M + s_ang*n2) -- (M + s_ang*n2 + s_ang*tau) -- (M + s_ang*tau), gray(0.4)+0.6);

