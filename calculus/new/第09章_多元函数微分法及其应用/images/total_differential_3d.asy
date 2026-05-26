settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(1100);  // 高分辨率画布
import three;

// 视角
currentprojection = perspective(5, -6, 4);

// 定义曲面函数
real f(real x, real y) { return 0.5 + 0.12*x*x + 0.15*y*y; }
triple surf_point(real x, real y) { return (x,y,f(x,y)); }

// 1. 绘制坐标轴 (使用淡灰色，不要喧宾夺主)
draw((0,0,0)--(2.8,0,0), gray(0.35)+0.8, arrow=Arrow3());
draw((0,0,0)--(0,2.8,0), gray(0.35)+0.8, arrow=Arrow3());
draw((0,0,0)--(0,0,2.2), gray(0.35)+0.8, arrow=Arrow3());
label("$x$", (2.9,0,0), fontsize(32));
label("$y$", (0,2.9,0), fontsize(32));
label("$z$", (0,0,2.3), fontsize(32));

// 2. 绘制稀疏、淡雅的曲面网格线
real xMin = 0.2, xMax = 2.4;
real yMin = 0.2, yMax = 2.4;
int steps = 7;
for(int i=0; i<=steps; ++i) {
  real x = xMin + i * (xMax - xMin) / steps;
  guide3 g;
  for(int j=0; j<=steps; ++j) {
    real y = yMin + j * (yMax - yMin) / steps;
    g = (j==0) ? surf_point(x,y) : g--surf_point(x,y);
  }
  draw(g, gray(0.83)+0.35);
}
for(int j=0; j<=steps; ++j) {
  real y = yMin + j * (yMax - yMin) / steps;
  guide3 g;
  for(int i=0; i<=steps; ++i) {
    real x = xMin + i * (xMax - xMin) / steps;
    g = (i==0) ? surf_point(x,y) : g--surf_point(x,y);
  }
  draw(g, gray(0.83)+0.35);
}

// 3. 绘制切平面 (淡蓝色半透明)
real L(real x, real y) { return 0.77 + 0.24*(x-1.0) + 0.30*(y-1.0); }
triple T(real x, real y) { return (x,y,L(x,y)); }

triple A_t = T(0.4, 0.4);
triple B_t = T(2.2, 0.4);
triple C_t = T(2.2, 2.2);
triple D_t = T(0.4, 2.2);

path3 tangent_plane = A_t--B_t--C_t--D_t--cycle;
draw(surface(tangent_plane), lightblue+opacity(0.28));
draw(tangent_plane, deepblue+0.9);
label("$T_M$", C_t, 3*NE, fontsize(28));

// 4. 关键几何点定义
triple M0 = (1.0, 1.0, 0.77);  // 切点
triple D = (2.0, 1.0, 1.01);   // 切平面上 dx 对应的点
triple B = (2.0, 2.0, 1.31);   // 切平面上 dx+dy 对应的点
triple C = (2.0, 2.0, 1.58);   // 曲面上 dx+dy 对应的点
triple A = (2.0, 2.0, 0.77);   // 与 M0 同高的垂直虚线上的点

triple B_prime = (2.0, 2.0, 1.01); // 对应 D 高度的垂直线上的点
triple D_prime = (2.0, 1.0, 0.77); // 对应 M0 高度的 x-增量投影点

triple P0 = (1.0, 1.0, 0);     // 投影点 M0
triple P_tmp = (2.0, 1.0, 0);   // 投影点 D
triple P1 = (2.0, 2.0, 0);     // 投影点 B/C

// 5. 绘制地面自变量增量
draw(P0--P_tmp, gray(0.45)+0.8+dashed);
draw(P_tmp--P1, gray(0.45)+0.8+dashed);
label("$dx$", 0.5*(P0+P_tmp), 3*S, fontsize(30));
label("$dy$", 0.5*(P_tmp+P1), 3*E, fontsize(30));

// 6. 绘制垂直投影虚线
draw(P0--M0, gray(0.5)+0.6+dashed);
draw(P1--A, gray(0.5)+0.6+dashed);

// 7. 绘制中间高度的参考水平虚线
draw(M0--D_prime, gray(0.5)+0.6+dashed);
draw(D_prime--A, gray(0.5)+0.6+dashed);
draw(D--B_prime, gray(0.5)+0.6+dashed);

// 8. 绘制垂直线上的分段实线 (拼接展示：f_x*dx + f_y*dy + o(rho) = Delta z)
draw(A--B_prime, rgb(0.7,0.1,0.1)+2.2);        // f_x*dx (深红)
draw(B_prime--B, rgb(0.9,0.4,0.1)+2.2);        // f_y*dy (橘红)
draw(B--C, rgb(0.1,0.6,0.1)+2.2);              // o(\rho) (深绿)

// 9. 绘制左侧的 dz 偏置双头箭头 (3D 往屏幕左下方推)
triple offset_left = (-0.4, -0.4, 0);
draw((A+offset_left)--(B+offset_left), rgb(0.5,0.1,0.5)+1.1, Arrows3(size=6));
label("$dz$", 0.5*(A+B)+offset_left, 3*W, fontsize(30));

// 10. 绘制右侧的 Delta z 偏置双头箭头 (3D 往屏幕右上方推)
triple offset_right = (0.4, 0.4, 0);
draw((A+offset_right)--(C+offset_right), black+1.1, Arrows3(size=6));
label("$\Delta z$", 0.5*(A+C)+offset_right, 3*E, fontsize(30));

// 11. 标注分段垂直分量 (在屏幕上纯粹往左推开，形成整齐列排，完全远离线条)
label("$f_x\,dx$", 0.5*(A+B_prime), 8*W, fontsize(28));
label("$f_y\,dy$", 0.5*(B_prime+B), 8*W, fontsize(28));
label("$o(\rho)$", 0.5*(B+C), 8*W, fontsize(28));

// 12. 切平面上的折线轨迹 (自变量分步变化在切面上的体现)
draw(M0--D, purple+1.6, arrow=Arrow3(size=5));
draw(D--B, purple+1.6, arrow=Arrow3(size=5));

// 13. 绘制关键点的 dot 并放置标签 (使用固定的 2D 偏置脱离线条)
dot(M0, linewidth(7));
dot(D, linewidth(6));
dot(B, linewidth(6));
dot(C, linewidth(6));
dot(A, linewidth(6));
dot(B_prime, linewidth(6));
dot(P0, linewidth(5));
dot(P_tmp, linewidth(5));
dot(P1, linewidth(5));

label("$M$", M0, 4*W, fontsize(30));
label("$D$", D, 4*NW, fontsize(30));
label("$M_L$", B, 4*NE, fontsize(30));
label("$B'$", B_prime, 4*E, fontsize(30));
label("$A$", A, 4*SE, fontsize(30));
label("$M'$", C, 4*N, fontsize(30));
label("$P_0$", P0, 4*W, fontsize(28));
label("$P_{tmp}$", P_tmp, 4*S, fontsize(28));
label("$P_1$", P1, 4*SE, fontsize(28));
