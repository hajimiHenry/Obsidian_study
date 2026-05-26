settings.outformat="png";
settings.tex="xelatex";
size(650, 320);

// 定义左图 (单连通区域 D)
picture pic1;
size(pic1, 280, 280);

// 单连通边界 (逆时针)
path g1 = (0.5, 0.5) .. (1.5, 2.2) .. (3.2, 1.8) .. (3.8, 0.6) .. (2.5, -0.5) .. (0.8, -0.2) .. cycle;
fill(pic1, g1, lightblue+opacity(0.35));
draw(pic1, g1, blue+1.5, MidArrow(SimpleHead));

label(pic1, "$D$", (2.1, 0.8), fontsize(16));
label(pic1, "$L$", (1.5, 2.2), NW, fontsize(14));
label(pic1, "单连通区域：逆时针为正向", (2.1, -0.8), S, fontsize(12));

// 定义右图 (复连通区域 D')
picture pic2;
size(pic2, 280, 280);

// 复连通外边界 (逆时针)
path g2_out = (0.5, 0.5) .. (1.5, 2.2) .. (3.2, 1.8) .. (3.8, 0.6) .. (2.5, -0.5) .. (0.8, -0.2) .. cycle;
// 复连通内边界 (逆时针定义)
path g2_in = shift(1.8, 0.6) * scale(0.6) * ((0.3, 0.3) .. (1.2, 1.0) .. (1.8, 0.4) .. (1.0, -0.3) .. cycle);

// 填充带洞区域 (evenodd)
fill(pic2, g2_out ^^ g2_in, evenodd + lightyellow+opacity(0.35));

// 绘制外边界 (逆时针)
draw(pic2, g2_out, red+1.5, MidArrow(SimpleHead));
// 绘制内边界 (顺时针，使用 reverse)
draw(pic2, reverse(g2_in), red+1.5, MidArrow(SimpleHead));

label(pic2, "$D'$", (1.0, 1.2), fontsize(16));
label(pic2, "$L_{out}$", (1.5, 2.2), NW, fontsize(14));
label(pic2, "$L_{in}$", (2.2, 1.0), SE, fontsize(14));
label(pic2, "复连通区域：外逆内顺", (2.1, -0.8), S, fontsize(12));

// 将两幅图并排画出
add(pic1.fit(), (0,0), W);
add(pic2.fit(), (50,0), E);

// 顶部总标题
label("格林公式边界正向判定：区域始终在行进方向的左侧", (0, 150), N, fontsize(14));
