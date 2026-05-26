settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(700);
import three;

// 定义曲面：椭圆抛物面 z = 4 - 0.2*x^2 - 0.15*y^2
real f(real x, real y) {
  return 4.0 - 0.2*x*x - 0.15*y*y;
}
triple S(real x, real y) {
  return (x, y, f(x, y));
}

// 目标点 P_0(x_0, y_0) = (1.2, 1.2)
real x0 = 1.2;
real y0 = 1.2;
real z0 = f(x0, y0);
triple M0 = (x0, y0, z0);

// 偏导数值
real fx = -0.4 * x0; // -0.48
real fy = -0.3 * y0; // -0.36

// 视角设定
currentprojection = perspective(5.0, -5.5, 4.0);

// 1. 绘制坐标轴
draw((-0.5,0,0)--(3.5,0,0), black+1.0, arrow=Arrow3());
draw((0,-0.5,0)--(0,3.5,0), black+1.0, arrow=Arrow3());
draw((0,0,0)--(0,0,4.5), black+1.0, arrow=Arrow3());

label("$x$", (3.6,0,0), E, fontsize(16));
label("$y$", (0,3.6,0), E, fontsize(16));
label("$z$", (0,0,4.6), N, fontsize(16));
label("$O$", (0,0,0), SW, fontsize(16));

// 2. 绘制曲面网格 (仅在第一卦限绘制部分以保持画面简洁)
real xMin = 0, xMax = 2.4;
real yMin = 0, yMax = 2.4;
int steps = 12;
for(int i=0; i<=steps; ++i) {
  real x = xMin + i * (xMax - xMin) / steps;
  guide3 g;
  for(int j=0; j<=steps; ++j) {
    real y = yMin + j * (yMax - yMin) / steps;
    g = (j==0) ? S(x,y) : g--S(x,y);
  }
  draw(g, gray(0.7)+0.45);
}
for(int j=0; j<=steps; ++j) {
  real y = yMin + j * (yMax - yMin) / steps;
  guide3 g;
  for(int i=0; i<=steps; ++i) {
    real x = xMin + i * (xMax - i) / steps; // 修正这个循环中的 i/steps，注意刚才的 asy 文件中是 i * (xMax - xMin) / steps
    real xVal = xMin + i * (xMax - xMin) / steps;
    g = (i==0) ? S(xVal,y) : g--S(xVal,y);
  }
  draw(g, gray(0.7)+0.45);
}

// 3. 绘制投影点与竖直辅助线
triple P0 = (x0, y0, 0);
draw(M0--P0, dashed+gray(0.4)+0.8);
draw(P0--(x0, 0, 0), dashed+gray(0.4)+0.8);
draw(P0--(0, y0, 0), dashed+gray(0.4)+0.8);

// 4. 绘制半透明截平面
// 截面 y = y0 (平行于 xOz 平面，用浅红色表示)
path3 planeY = (0, y0, 0)--(2.4, y0, 0)--(2.4, y0, 4.2)--(0, y0, 4.2)--cycle;
draw(surface(planeY), lightred+opacity(0.12));
draw(planeY, red+0.5+dashed);

// 截面 x = x0 (平行于 yOz 平面，用浅蓝色表示)
path3 planeX = (x0, 0, 0)--(x0, 2.4, 0)--(x0, 2.4, 4.2)--(x0, 0, 4.2)--cycle;
draw(surface(planeX), lightblue+opacity(0.12));
draw(planeX, blue+0.5+dashed);

// 5. 绘制曲线截线
// x 截线 (y 固定为 y0)
guide3 curveX;
int nPoints = 40;
for(int i=0; i<=nPoints; ++i) {
  real x = xMin + i * (xMax - xMin) / nPoints;
  curveX = (i==0) ? S(x, y0) : curveX--S(x, y0);
}
draw(curveX, heavyred+1.6);

// y 截线 (x 固定为 x0)
guide3 curveY;
for(int j=0; j<=nPoints; ++j) {
  real y = yMin + j * (yMax - yMin) / nPoints;
  curveY = (j==0) ? S(x0, y) : curveY--S(x0, y);
}
draw(curveY, deepblue+1.6);

// 6. 绘制切线
// x 方向切线
triple txStart = M0 - 0.7 * (1.0, 0.0, fx);
triple txEnd = M0 + 0.7 * (1.0, 0.0, fx);
draw(txStart--txEnd, red+2.2);

// y 方向切线
triple tyStart = M0 - 0.7 * (0.0, 1.0, fy);
triple tyEnd = M0 + 0.7 * (0.0, 1.0, fy);
draw(tyStart--tyEnd, blue+2.2);

// 7. 绘制关键点 (最后画，以防被覆盖)
dot(M0, black+linewidth(7.0));
dot(P0, gray(0.3)+linewidth(5.0));

// 8. 绘制标签
label("$M_0(x_0,y_0,z_0)$", M0 + (0.05, 0.05, 0.15), N, fontsize(15));
label("$P_0(x_0,y_0)$", P0 + (0.05, 0.05, -0.15), E, fontsize(14));

label("$x_0$", (x0, 0, 0), S, fontsize(14));
label("$y_0$", (0, y0, 0), W, fontsize(14));

label("$y=y_0$", (2.4, y0, 4.2), N, red+fontsize(14));
label("$x=x_0$", (x0, 2.4, 4.2), N, blue+fontsize(14));

// 将曲线标签放到 x/y 较小的左侧，避免与切线标签在右侧重叠
label("$z=f(x,y_0)$", (0.5, y0, f(0.5, y0)) + (-0.05, 0.0, 0.15), NW, red+fontsize(13));
label("$z=f(x_0,y)$", (x0, 0.5, f(x0, 0.5)) + (0.0, -0.05, 0.15), NW, blue+fontsize(13));

// 切线标签微调位置
label("切线斜率 $f_x(x_0,y_0)$", txEnd + (0.1, 0.0, -0.1), E, red+fontsize(14));
label("切线斜率 $f_y(x_0,y_0)$", tyEnd + (0.0, 0.1, -0.1), E, blue+fontsize(14));
