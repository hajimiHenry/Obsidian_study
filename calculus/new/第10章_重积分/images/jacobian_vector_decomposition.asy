settings.outformat="png";
settings.prc = false;
settings.render = 0;
settings.tex="xelatex";
size(650);

texpreamble("\usepackage{amsmath}");

// ================= 左侧 uv 平面 =================
pair O_uv = (0,0);
draw(O_uv--(3.2, 0), black+0.8, arrow=Arrow(SimpleHead));
draw(O_uv--(0, 3.2), black+0.8, arrow=Arrow(SimpleHead));
label("$u$", (3.2, 0), S, fontsize(14));
label("$v$", (0, 3.2), W, fontsize(14));
label("$O$", O_uv, SW, fontsize(14));

pair A = (1.0, 0.8);
real du = 1.2;
real dv = 1.0;
pair B = A + (du, 0);
pair D = A + (0, dv);
pair C = A + (du, dv);

// 填充虚线背景
fill(A--B--C--D--cycle, rgb(0.95, 0.97, 1.0));
draw(A--B--C--D--cycle, gray(0.7)+dashed);

// 画边向量
draw(A--B, rgb(0.2, 0.5, 0.85)+1.6, arrow=Arrow(SimpleHead));
draw(A--D, rgb(0.1, 0.6, 0.3)+1.6, arrow=Arrow(SimpleHead));

label("$\vec{u} = \begin{pmatrix} du \\ 0 \end{pmatrix}$", 0.5*(A+B), S, fontsize(13));
label("$\vec{v} = \begin{pmatrix} 0 \\ dv \end{pmatrix}$", 0.5*(A+D), W, fontsize(13));
dot(A, linewidth(4));

// ================= 中间 变换指示 =================
pair mid_start = (3.5, 1.6);
pair mid_end = (5.0, 1.6);
draw(mid_start--mid_end, gray(0.5)+0.8+dashed, arrow=Arrow(SimpleHead));
label("$T$", (4.25, 1.7), N, fontsize(14));

// ================= 右侧 xy 平面 =================
pair O_xy = (5.5, 0);
draw(O_xy--(9.2, 0), black+0.8, arrow=Arrow(SimpleHead));
draw(O_xy--(5.5, 3.2), black+0.8, arrow=Arrow(SimpleHead));
label("$x$", (9.2, 0), S, fontsize(14));
label("$y$", (5.5, 3.2), W, fontsize(14));
label("$O$", O_xy, SW, fontsize(14));

pair Ap = O_xy + (0.8, 0.6);
pair Bp = Ap + (1.8, 0.4);
pair Dp = Ap + (0.5, 1.5);
pair Cp = Bp + (0.5, 1.5);

// 填充虚线背景平行四边形
fill(Ap--Bp--Cp--Dp--cycle, rgb(1.0, 0.95, 0.9));
draw(Ap--Bp--Cp--Dp--cycle, gray(0.7)+dashed);

// 画映射后的向量 \vec{a} 和 \vec{b}
draw(Ap--Bp, rgb(0.2, 0.5, 0.85)+1.8, arrow=Arrow(SimpleHead));
draw(Ap--Dp, rgb(0.1, 0.6, 0.3)+1.8, arrow=Arrow(SimpleHead));

label("$\vec{a}$", Bp, E, fontsize(14));
label("$\vec{b}$", Dp, N, fontsize(14));

// 向量 \vec{a} 的直角分解虚线
pair Bp_proj = (Bp.x, Ap.y);
draw(Ap--Bp_proj, rgb(0.2, 0.5, 0.85)+0.8+dashed);
draw(Bp_proj--Bp, rgb(0.2, 0.5, 0.85)+0.8+dashed);
label("$\frac{\partial x}{\partial u} du$", 0.5*(Ap+Bp_proj), S, fontsize(12));
label("$\frac{\partial y}{\partial u} du$", 0.5*(Bp_proj+Bp), E, fontsize(12));

// 向量 \vec{b} 的直角分解虚线
pair Dp_proj = (Ap.x, Dp.y);
draw(Ap--Dp_proj, rgb(0.1, 0.6, 0.3)+0.8+dashed);
draw(Dp_proj--Dp, rgb(0.1, 0.6, 0.3)+0.8+dashed);
label("$\frac{\partial y}{\partial v} dv$", 0.5*(Ap+Dp_proj), W, fontsize(12));
label("$\frac{\partial x}{\partial v} dv$", 0.5*(Dp_proj+Dp), N, fontsize(12));

dot(Ap, linewidth(4));
