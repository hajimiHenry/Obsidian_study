settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4,3,3);

triple M0 = (0,0,0);
real R = 1.6;

// 用 sphere 函数画球面
// draw(sphere(M0, R), lightblue+opacity(0.35));

// 改为画线框球面：几条经线和纬线
for(int i=0; i<4; ++i) {
  real phi = i*pi/2;
  path3 meridian = arc(M0, R, 90, phi, -90, phi);
  draw(meridian, black+0.8);
}
for(int i=-2; i<=2; ++i) {
  real z = i*R*0.4;
  real r = sqrt(R^2 - z^2);
  if(r > 0.05)
    draw(circle((0,0,z), r, normal=Z), black+0.8);
}

// 半径
draw(M0--(R,0,0), red+1.8, arrow=Arrow3());
label("$R$", (R/2,0,0.1), S, fontsize(22));

// 球心
dot(M0, linewidth(8));
label("$M_0$", M0, SW, fontsize(22));
