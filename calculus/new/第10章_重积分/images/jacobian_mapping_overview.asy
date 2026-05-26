settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);

// ================= 左侧 uv 平面 =================
pair O_uv = (0,0);
draw(O_uv--(3.2, 0), black+0.8, arrow=Arrow(SimpleHead));
draw(O_uv--(0, 3.2), black+0.8, arrow=Arrow(SimpleHead));
label("$u$", (3.2, 0), S, fontsize(14));
label("$v$", (0, 3.2), W, fontsize(14));
label("$O$", O_uv, SW, fontsize(14));

// 顶点定义
pair A = (1.0, 0.8);
pair B = (2.2, 0.8);
pair C = (2.2, 2.0);
pair D = (1.0, 2.0);
path rect = A--B--C--D--cycle;

fill(rect, rgb(0.85, 0.93, 1.0));
draw(rect, rgb(0.2, 0.5, 0.85)+1.2);

// 标注顶点坐标
dot(A, linewidth(4));
dot(B, linewidth(4));
dot(C, linewidth(4));
dot(D, linewidth(4));
label("$(u_0, v_0)$", A, SW, fontsize(12));
label("$(u_0+du, v_0)$", B, SE, fontsize(12));
label("$(u_0+du, v_0+dv)$", C, NE, fontsize(12));
label("$(u_0, v_0+dv)$", D, NW, fontsize(12));

// ================= 中间 变换箭头 =================
pair mid_start = (3.5, 1.6);
pair mid_end = (5.0, 1.6);
draw(mid_start.. (4.25, 1.8) ..mid_end, black+1.0, arrow=Arrow(SimpleHead));
label("$T$", (4.25, 1.95), N, fontsize(15));
label("$x=x(u,v)$", (4.25, 1.3), fontsize(11));
label("$y=y(u,v)$", (4.25, 0.95), fontsize(11));

// ================= 右侧 xy 平面 =================
pair O_xy = (5.5, 0);
draw(O_xy--(9.0, 0), black+0.8, arrow=Arrow(SimpleHead));
draw(O_xy--(5.5, 3.2), black+0.8, arrow=Arrow(SimpleHead));
label("$x$", (9.0, 0), S, fontsize(14));
label("$y$", (5.5, 3.2), W, fontsize(14));
label("$O$", O_xy, SW, fontsize(14));

// 平行四边形顶点定义 (相对于 O_xy)
pair Ap = O_xy + (1.0, 0.6);
pair Bp = Ap + (1.6, 0.3); // u 向量
pair Dp = Ap + (0.5, 1.4); // v 向量
pair Cp = Bp + (0.5, 1.4);
path para = Ap--Bp--Cp--Dp--cycle;

fill(para, rgb(1.0, 0.9, 0.8));
draw(para, rgb(0.85, 0.4, 0.2)+1.0);

// 标注边向量
draw(Ap--Bp, rgb(0.2, 0.5, 0.85)+1.6, arrow=Arrow(SimpleHead));
draw(Ap--Dp, rgb(0.1, 0.6, 0.3)+1.6, arrow=Arrow(SimpleHead));
label("$\vec{a}$", 0.5*(Ap+Bp), S, fontsize(14));
label("$\vec{b}$", 0.5*(Ap+Dp), W, fontsize(14));

// 标注顶点映射
dot(Ap, linewidth(4));
dot(Bp, linewidth(4));
dot(Dp, linewidth(4));
dot(Cp, linewidth(4));
label("$T(u_0, v_0)$", Ap, SW, fontsize(12));
label("$T(u_0+du, v_0)$", Bp, SE, fontsize(12));
label("$T(u_0, v_0+dv)$", Dp, NW, fontsize(12));
