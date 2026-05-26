settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(750, 480);
texpreamble("\usepackage{ctex}");

// 颜色定义
pen royalblue = rgb(0.15, 0.45, 0.75);
pen deepred = rgb(0.75, 0.25, 0.25);
pen deepgreen = rgb(0.20, 0.60, 0.35);
pen goldbrown = rgb(0.75, 0.55, 0.20);
pen darkgray = rgb(0.25, 0.25, 0.25);

// 定义画圆角矩形的辅助函数
path roundedbox(pair a, pair b, real r) {
  real x1 = min(a.x, b.x), x2 = max(a.x, b.x);
  real y1 = min(a.y, b.y), y2 = max(a.y, b.y);
  if (r <= 0) return box(a, b);
  real maxr = min(x2 - x1, y2 - y1) / 2;
  if (r > maxr) r = maxr;
  path p = (x1+r, y1) -- (x2-r, y1) {E} .. {N} (x2, y1+r) -- (x2, y2-r) {N} .. {W} (x2-r, y2) -- (x1+r, y2) {W} .. {S} (x1, y2-r) -- (x1, y1+r) {S} .. {E} cycle;
  return p;
}

// 绘制卡片
void drawCard(string text, pair center, real width, real height, pen bg, pen border, real r=0.15) {
  pair bl = center - (width/2, height/2);
  pair tr = center + (width/2, height/2);
  path p = roundedbox(bl, tr, r);
  fill(p, bg);
  draw(p, border+1.5);
  label(text, center);
}

// 1. 绘制标题
label("{\bf\Large 复合函数求导法则依赖关系图}", (5.0, 5.2), fontsize(17));

// 2. 绘制连线与标注 (带箭头)
// 自变量 x 发出的路径 (使用蓝色)
draw((2.3, 4.0) -- (3.9, 4.0), royalblue+1.2, arrow=Arrow(SimpleHead, size=5));
label("$\displaystyle \frac{\partial u}{\partial x}$", (3.1, 4.0), N, royalblue+fontsize(13));

draw((2.3, 3.8) -- (3.9, 2.0), royalblue+1.2, arrow=Arrow(SimpleHead, size=5));
pair pt_xv = 0.7 * (2.3, 3.8) + 0.3 * (3.9, 2.0);
label("$\displaystyle \frac{\partial v}{\partial x}$", pt_xv, NW, royalblue+fontsize(13));

// 自变量 y 发出的路径 (使用红色)
draw((2.3, 1.8) -- (3.9, 1.8), deepred+1.2, arrow=Arrow(SimpleHead, size=5));
label("$\displaystyle \frac{\partial v}{\partial y}$", (3.1, 1.8), S, deepred+fontsize(13));

draw((2.3, 2.0) -- (3.9, 3.8), deepred+1.2, arrow=Arrow(SimpleHead, size=5));
pair pt_yu = 0.7 * (2.3, 2.0) + 0.3 * (3.9, 3.8);
label("$\displaystyle \frac{\partial u}{\partial y}$", pt_yu, SW, deepred+fontsize(13));

// 中间变量 u, v 发出的路径 (使用深灰色)
draw((6.1, 3.8) -- (7.3, 3.15), darkgray+1.2, arrow=Arrow(SimpleHead, size=5));
label("$\displaystyle \frac{\partial z}{\partial u}$", (6.7, 3.475), NE, darkgray+fontsize(13));

draw((6.1, 2.0) -- (7.3, 2.65), darkgray+1.2, arrow=Arrow(SimpleHead, size=5));
label("$\displaystyle \frac{\partial z}{\partial v}$", (6.7, 2.325), SE, darkgray+fontsize(13));

// 3. 绘制节点卡片
// x 节点 (淡蓝背景，深蓝边框)
drawCard("{\bf\large 自变量 $x$}", (1.5, 4.0), 1.6, 0.9, rgb(0.90, 0.94, 0.98), royalblue);
// y 节点 (淡红背景，深红边框)
drawCard("{\bf\large 自变量 $y$}", (1.5, 1.8), 1.6, 0.9, rgb(0.98, 0.92, 0.92), deepred);

// u 节点 (淡绿背景，深绿边框)
drawCard("{\bf\large 中间变量 $u(x,y)$}", (5.0, 4.0), 2.2, 0.9, rgb(0.92, 0.97, 0.92), deepgreen);
// v 节点 (淡绿背景，深绿边框)
drawCard("{\bf\large 中间变量 $v(x,y)$}", (5.0, 1.8), 2.2, 0.9, rgb(0.92, 0.97, 0.92), deepgreen);

// z 节点 (淡黄背景，金褐边框)
drawCard("{\bf\large 因变量 $z=f(u,v)$}", (8.5, 2.9), 2.4, 0.9, rgb(0.98, 0.95, 0.88), goldbrown);

// 4. 底部公式框
real box_w = 8.2;
real box_h = 1.15;
pair box_c = (5.0, 0.6);
drawCard("", box_c, box_w, box_h, rgb(0.97, 0.97, 0.97), gray(0.7), r=0.1);
// 在框内绘制两行公式
label("$\displaystyle \frac{\partial z}{\partial x} = \frac{\partial z}{\partial u}\frac{\partial u}{\partial x} + \frac{\partial z}{\partial v}\frac{\partial v}{\partial x} \quad \left(z_x = z_u u_x + z_v v_x\right)$", (5.0, 0.88), fontsize(12.5));
label("$\displaystyle \frac{\partial z}{\partial y} = \frac{\partial z}{\partial u}\frac{\partial u}{\partial y} + \frac{\partial z}{\partial v}\frac{\partial v}{\partial y} \quad \left(z_y = z_u u_y + z_v v_y\right)$", (5.0, 0.32), fontsize(12.5));
