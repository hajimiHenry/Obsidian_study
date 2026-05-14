settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(900);
import three;

currentprojection = perspective(4.5,3,2.5);

// xOy 平面
triple A = (-2.0,-1.5,0);
triple B = ( 2.2,-1.3,0);
triple C = ( 2.0, 1.8,0);
triple D = (-1.8, 1.6,0);
path3 planePath = A--B--C--D--cycle;
draw(surface(planePath), lightblue+opacity(0.25));
draw(planePath, black+0.8);

// 空间曲线 C
triple[] spaceCurve;
triple[] projCurve;
for(int i=0; i<=60; ++i) {
  real t = -1.2 + i*2.4/60;
  triple p = (t, t*t, 0.8*sin(2*t));
  spaceCurve.push(p);
  projCurve.push((t, t*t, 0));
}

path3 sp = spaceCurve[0];
path3 pr = projCurve[0];
for(int i=1; i<spaceCurve.length; ++i) {
  sp = sp--spaceCurve[i];
  pr = pr--projCurve[i];
}
draw(sp, black+2.0);
draw(pr, darkblue+1.8);

// 投影垂线（选几个点画）
for(int i=0; i<5; ++i) {
  int idx = i*12;
  draw(spaceCurve[idx]--projCurve[idx], gray+0.7);
  dot(spaceCurve[idx], linewidth(5));
  dot(projCurve[idx], linewidth(5));
}

label("$\Pi$", C + 0.2*Z + 0.2*Y, N, fontsize(20));
label("$C$", spaceCurve[spaceCurve.length-1], NE, fontsize(20));
label("$C'$", projCurve[projCurve.length-1], E, fontsize(20));
