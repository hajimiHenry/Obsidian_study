settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(700);
import three;
texpreamble("\usepackage{ctex}");

// Z轴往下看（正交投影）
currentprojection = orthographic(0,0,1);

// 绘制圆角矩形卡片的函数
void drawCard(string title, string[] items, triple center, real width, real height, pen bg, pen border) {
  path3 p = plane((width, 0, 0), (0, height, 0), center - (width/2)*X - (height/2)*Y);
  draw(surface(p), bg);
  draw(p, border+1.2);
  
  label("{\bf " + title + "}", center + (0, height/2 - 0.22, 0.01), fontsize(15));
  
  for(int i=0; i<items.length; ++i) {
    label(items[i], center + (0, height/2 - 0.55 - i*0.28, 0.01), fontsize(13));
  }
}

string[] items1 = {
  "• 可微的必要/充分条件",
  "• 复合与隐函数求导公式",
  "• 方向导数与切面法向量"
};
drawCard("一、保留核心思路（理清推导）", items1, (0, 1.3, 0), 4.2, 1.5, rgb(0.92, 0.95, 0.98)+opacity(0.85), rgb(0.2, 0.5, 0.8));

string[] items2 = {
  "• 闭区域上连续函数的性质",
  "• 二阶混合偏导数交换定理",
  "• 极值充分条件的直观判定"
};
drawCard("二、压缩为直觉说明（理解内涵）", items2, (0, -0.4, 0), 4.2, 1.5, rgb(0.92, 0.97, 0.92)+opacity(0.85), rgb(0.2, 0.7, 0.3));

string[] items3 = {
  "• 长篇 epsilon-delta 极限证明",
  "• 隐函数存在定理的严格论证",
  "• 泰勒中值公式余项的估计细节"
};
drawCard("三、删除或不展开（避开细枝末节）", items3, (0, -2.1, 0), 4.2, 1.5, rgb(0.98, 0.92, 0.92)+opacity(0.85), rgb(0.8, 0.3, 0.3));

// 绘制连接箭头
draw((0, 0.55, 0.02) -- (0, 0.35, 0.02), black+1.0, arrow=Arrow3(DefaultHead3));
draw((0, -1.15, 0.02) -- (0, -1.35, 0.02), black+1.0, arrow=Arrow3(DefaultHead3));
