from pathlib import Path
import shutil

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import font_manager
from matplotlib.patches import Arc, Circle, FancyArrowPatch


ROOT = Path(__file__).resolve().parent


def setup_font():
    for path in [
        r"C:\Windows\Fonts\msyh.ttc",
        r"C:\Windows\Fonts\simhei.ttf",
        r"C:\Windows\Fonts\simsun.ttc",
    ]:
        if Path(path).exists():
            font_manager.fontManager.addfont(path)
            name = font_manager.FontProperties(fname=path).get_name()
            plt.rcParams["font.sans-serif"] = [name]
            break
    plt.rcParams["axes.unicode_minus"] = False
    plt.rcParams["mathtext.fontset"] = "dejavusans"


def save(fig, name):
    fig.savefig(ROOT / name, dpi=180, bbox_inches="tight", pad_inches=0.18, facecolor="white")
    plt.close(fig)


def arrow(ax, start, end, color, lw=2.0, ms=14, zorder=4):
    ax.add_patch(
        FancyArrowPatch(
            start,
            end,
            arrowstyle="-|>",
            mutation_scale=ms,
            linewidth=lw,
            color=color,
            shrinkA=0,
            shrinkB=0,
            zorder=zorder,
        )
    )


def direction_derivative():
    fig, ax = plt.subplots(figsize=(6.2, 4.2))
    ax.set_aspect("equal")
    ax.set_xlim(-0.9, 3.3)
    ax.set_ylim(-1.15, 2.15)
    ax.axis("off")

    ax.axhline(0, color="#333333", lw=1.0)
    ax.axvline(0, color="#333333", lw=1.0)
    ax.text(3.12, -0.17, "$x$", fontsize=13)
    ax.text(-0.18, 1.98, "$y$", fontsize=13)

    P = np.array([0.55, 0.45])
    e = np.array([1.0, 0.42])
    e = e / np.linalg.norm(e)
    Q = P + 1.65 * e
    ax.plot(P[0], P[1], "o", color="#111111", ms=5)
    ax.text(P[0] - 0.18, P[1] - 0.26, "$P(x_0,y_0)$", fontsize=12)
    arrow(ax, P, Q, "#d62728", lw=2.5, ms=16)
    ax.text(Q[0] + 0.04, Q[1] + 0.03, r"$\mathbf{e}=(\cos\alpha,\cos\beta)$", color="#d62728", fontsize=12)

    for r, c in [(0.46, "#cfd8dc"), (0.78, "#b0bec5"), (1.12, "#90a4ae")]:
        ax.add_patch(Circle(P, r, fill=False, ec=c, lw=1.1))

    ax.plot([P[0], Q[0]], [P[1], Q[1]], color="#d62728", lw=2.0)
    ax.plot([Q[0], Q[0]], [P[1], Q[1]], color="#777777", lw=1.0, ls="--")
    ax.plot([P[0], Q[0]], [P[1], P[1]], color="#777777", lw=1.0, ls="--")
    ax.text((P[0] + Q[0]) / 2, P[1] - 0.23, r"$\Delta x=t\cos\alpha$", fontsize=11, color="#555555")
    ax.text(Q[0] + 0.05, (P[1] + Q[1]) / 2, r"$\Delta y=t\cos\beta$", fontsize=11, color="#555555")
    ax.text(0.2, -0.88, r"$D_{\mathbf{e}}f(P)=\lim_{t\to0^+}\frac{f(P+t\mathbf{e})-f(P)}{t}$", fontsize=13)
    save(fig, "directional_derivative_path.png")


def limit_paths():
    fig, ax = plt.subplots(figsize=(6.4, 4.5))
    ax.set_xlim(-0.35, 2.65)
    ax.set_ylim(-0.35, 2.65)
    ax.set_aspect("equal")
    ax.spines[["top", "right"]].set_visible(False)
    ax.spines[["left", "bottom"]].set_position("zero")
    ax.set_xticks([])
    ax.set_yticks([])
    ax.set_xlabel("$x$", fontsize=13, loc="right")
    ax.set_ylabel("$y$", fontsize=13, rotation=0, loc="top", labelpad=12)

    x = np.linspace(0, 2.25, 240)
    paths = [
        (x, np.zeros_like(x), "#d62728", r"$y=0$", r"$\to 0$"),
        (x, x, "#1f77b4", r"$y=x$", r"$\to \frac{1}{2}$"),
        (x, 2 * x, "#2ca02c", r"$y=2x$", r"$\to \frac{2}{5}$"),
        (x, 0.42 * x**2, "#ff7f0e", r"$y=x^2$", r"$\to 0$"),
    ]
    for px, py, color, label, result in paths:
        mask = py <= 1.95
        ax.plot(px[mask], py[mask], color=color, lw=2.5)
        k = np.where(mask)[0][-1]
        arrow(ax, (px[max(0, k - 18)], py[max(0, k - 18)]), (px[k], py[k]), color, lw=2.3, ms=13)

    ax.plot(0, 0, "o", color="#111111", ms=5)
    ax.text(0.05, -0.18, "$(0,0)$", fontsize=12)
    ax.text(0.05, 2.42, "二重极限：不同路径必须靠近同一个值", fontsize=15, weight="bold")
    ax.text(0.05, 2.22, r"例：$f(x,y)=\frac{xy}{x^2+y^2}$，沿不同路径靠近原点。", fontsize=12, color="#444444")

    y0 = 1.82
    for i, (_, _, color, label, result) in enumerate(paths):
        ax.text(1.42, y0 - 0.28 * i, f"沿 {label}：", color=color, fontsize=12)
        ax.text(2.08, y0 - 0.28 * i, result, color=color, fontsize=12)

    save(fig, "limit_paths.png")


def gradient_angle():
    fig, ax = plt.subplots(figsize=(6.2, 4.2))
    ax.set_aspect("equal")
    ax.set_xlim(0.15, 3.18)
    ax.set_ylim(0.18, 2.18)
    ax.axis("off")

    P = np.array([0.55, 0.45])
    grad = np.array([1.9, 1.05])
    e = np.array([1.95, 0.18])
    ax.plot(P[0], P[1], "o", color="#111111", ms=5)
    ax.text(P[0] - 0.17, P[1] - 0.24, "$P$", fontsize=12)
    arrow(ax, P, P + grad, "#d62728", lw=2.8, ms=17)
    arrow(ax, P, P + e, "#1f77b4", lw=2.4, ms=16)
    ax.text(P[0] + grad[0] + 0.05, P[1] + grad[1], r"$\nabla f$", color="#d62728", fontsize=14)
    ax.text(P[0] + e[0] + 0.05, P[1] + e[1] - 0.02, r"$\mathbf{e}$", color="#1f77b4", fontsize=14)

    a1 = np.degrees(np.arctan2(e[1], e[0]))
    a2 = np.degrees(np.arctan2(grad[1], grad[0]))
    ax.add_patch(Arc(P, 0.72, 0.72, angle=0, theta1=a1, theta2=a2, color="#444444", lw=1.4))
    mid = np.radians((a1 + a2) / 2)
    ax.text(P[0] + 0.48 * np.cos(mid), P[1] + 0.48 * np.sin(mid) + 0.02, r"$\theta$", fontsize=13)

    ax.text(0.02, 1.95, r"$D_{\mathbf{e}}f=\nabla f\cdot\mathbf{e}=|\nabla f|\cos\theta$", fontsize=14)
    ax.text(0.02, 1.66, "方向越接近梯度，方向导数越大；垂直时为 0。", fontsize=12, color="#444444")
    save(fig, "gradient_direction_angle.png")


def gradient_field():
    fig, ax = plt.subplots(figsize=(6.0, 4.6))
    x = np.linspace(-2.1, 2.1, 21)
    y = np.linspace(-1.8, 1.8, 19)
    X, Y = np.meshgrid(x, y)
    Z = 0.45 * X**2 + 0.16 * Y**2
    U = 0.90 * X
    V = 0.32 * Y
    speed = np.hypot(U, V)
    U = U / (speed + 1e-6)
    V = V / (speed + 1e-6)
    levels = np.linspace(0.18, 1.95, 7)
    ax.contour(X, Y, Z, levels=levels, colors="#9aa6ad", linewidths=1.0)
    ax.quiver(X[::2, ::2], Y[::2, ::2], U[::2, ::2], V[::2, ::2], color="#d62728", angles="xy", scale_units="xy", scale=8.0, width=0.005)
    ax.set_aspect("equal")
    ax.set_xlim(-2.25, 2.25)
    ax.set_ylim(-1.95, 1.95)
    ax.set_xlabel("$x$", fontsize=12)
    ax.set_ylabel("$y$", fontsize=12, rotation=0, labelpad=10)
    ax.set_title(r"梯度场：每一点的箭头都是 $\nabla f$", fontsize=14, pad=10)
    ax.text(-2.15, -1.78, r"$f(x,y)=0.45x^2+0.16y^2$", fontsize=11, color="#444444")
    ax.grid(color="#eeeeee", lw=0.6)
    save(fig, "gradient_field_contours.png")


def gradient_contours():
    fig, ax = plt.subplots(figsize=(6.4, 5.0))
    x = np.linspace(-2.3, 2.3, 320)
    y = np.linspace(-1.9, 1.9, 260)
    X, Y = np.meshgrid(x, y)
    Z = 0.42 * X**2 + 0.22 * Y**2
    ax.contour(X, Y, Z, levels=[0.4, 0.8, 1.3, 1.9, 2.7], colors="#607d8b", linewidths=1.35)

    pts = [(-1.35, 0.70), (0.85, 0.62), (1.35, -0.85), (-0.55, -1.22)]
    for px, py in pts:
        g = np.array([0.84 * px, 0.44 * py])
        g = g / np.linalg.norm(g) * 0.48
        arrow(ax, (px, py), (px + g[0], py + g[1]), "#d62728", lw=2.3, ms=15)
    ax.text(1.03, 0.77, r"$\nabla f$", color="#d62728", fontsize=16, weight="bold")
    ax.text(-2.08, 1.48, "梯度垂直等值线，并指向函数增加最快方向", fontsize=13, weight="bold")
    ax.axhline(0, color="#333333", lw=0.9)
    ax.axvline(0, color="#333333", lw=0.9)
    ax.set_aspect("equal")
    ax.set_xlim(-2.25, 2.25)
    ax.set_ylim(-1.82, 1.82)
    ax.set_xlabel("$x$", fontsize=12)
    ax.set_ylabel("$y$", fontsize=12, rotation=0, labelpad=10)
    ax.set_xticks([])
    ax.set_yticks([])
    save(fig, "gradient_contours.png")


def lagrange_multiplier():
    fig, ax = plt.subplots(figsize=(6.4, 4.9))
    ax.set_aspect("equal")
    ax.set_xlim(-2.05, 2.20)
    ax.set_ylim(-1.65, 1.65)
    ax.axis("off")

    # 画坐标轴
    ax.axhline(0, color="#333333", lw=0.9)
    ax.axvline(0, color="#333333", lw=0.9)
    ax.text(2.10, -0.15, "$x$", fontsize=12)
    ax.text(-0.15, 1.55, "$y$", fontsize=12)

    # 约束曲线（圆，半径 R = 1.35）
    R = 1.35
    t = np.linspace(0, 2 * np.pi, 360)
    cx = R * np.cos(t)
    cy = R * np.sin(t)
    ax.plot(cx, cy, color="#1565c0", lw=2.8)
    ax.text(-1.52, -1.05, "约束曲线 $\\varphi(x,y)=0$", color="#1565c0", fontsize=12)

    # 切向 v = (-0.6, 0.8)，法向 u = (0.8, 0.6)
    u = np.array([0.8, 0.6])
    v = np.array([-0.6, 0.8])

    # 绘制若干条相交与不相交的等值线（使用虚线，灰色）
    ds = [-0.9, -0.3, 0.3, 0.9]
    for d in ds:
        p1 = d * u - 1.8 * v
        p2 = d * u + 1.8 * v
        ax.plot([p1[0], p2[0]], [p1[1], p2[1]], color="#90a4ae", lw=1.25, ls="--")

    # 绘制一条圆外不相交的等值线 (虚线)
    d_out = 1.8
    po1 = d_out * u - 1.2 * v
    po2 = d_out * u + 1.2 * v
    ax.plot([po1[0], po2[0]], [po1[1], po2[1]], color="#90a4ae", lw=1.25, ls="--")

    # 标注等值线（精确计算以保证在画布内整齐排列）
    ax.text(-0.25, -1.28, "$f(x,y)=c_1$", color="#78909c", fontsize=10)
    ax.text(0.50, -1.28, "$f(x,y)=c_2$", color="#78909c", fontsize=10)
    ax.text(1.25, -1.28, "$f(x,y)=c_3$", color="#78909c", fontsize=10)
    ax.text(2.00, -1.28, "$f(x,y)=c_4$", color="#78909c", fontsize=10)
    ax.text(2.00, 0.28, "$f(x,y)=c_5$", color="#78909c", fontsize=10)

    # 绘制极值点处的相切等值线（实线，红色）
    pt1 = R * u - 1.8 * v
    pt2 = R * u + 1.8 * v
    ax.plot([pt1[0], pt2[0]], [pt1[1], pt2[1]], color="#d62728", lw=1.5)
    ax.text(1.35, -0.65, "等值线 $f(x,y)=c_{\\max}$", color="#d62728", fontsize=11)

    # 相切点 P (即 M)
    P = R * u
    ax.plot(P[0], P[1], "o", color="#111111", ms=6, zorder=5)
    ax.text(P[0] - 0.35, P[1] - 0.25, "$M(x_0,y_0)$", fontsize=12, fontweight="bold")

    # 绘制梯度向量
    grad_f_end = P + 0.55 * u
    arrow(ax, P, grad_f_end, "#d62728", lw=2.5, ms=16)

    # 约束梯度，沿着切线平移一小段以避免重叠
    q = P + 0.12 * v
    grad_phi_end = q + 0.95 * u
    arrow(ax, q, grad_phi_end, "#1565c0", lw=2.5, ms=16)

    ax.text(1.55, 0.95, r"$\nabla f$", color="#d62728", fontsize=14)
    ax.text(1.80, 1.30, r"$\nabla \varphi$", color="#1565c0", fontsize=14)

    ax.text(-1.95, 1.35, r"相切时：$\nabla f=\lambda\nabla\varphi$ (梯度平行)", fontsize=13, weight="bold")
    ax.text(-1.95, -1.52, "蓝色曲线是约束，灰色虚线是目标函数等值线。", fontsize=11, color="#444444")
    save(fig, "lagrange_multiplier.png")


def extrema_candidates():
    fig, ax = plt.subplots(figsize=(6.2, 4.6))
    x = np.linspace(-2.4, 2.4, 300)
    y = np.linspace(-1.75, 1.75, 240)
    X, Y = np.meshgrid(x, y)
    Z = (X - 0.15) ** 2 + 0.55 * (Y + 0.05) ** 2 + 0.12 * X * Y
    ax.contour(X, Y, Z, levels=12, colors="#9aa6ad", linewidths=1.0)
    region = Circle((0, 0), 1.45, fill=False, ec="#1f77b4", lw=2.0)
    ax.add_patch(region)
    ax.plot(0.15, -0.05, "o", color="#d62728", ms=6)
    ax.text(0.23, -0.28, "内部驻点", color="#d62728", fontsize=12)
    ax.plot([1.45, 0, -1.45], [0, 1.45, 0], "o", color="#2ca02c", ms=5)
    ax.text(0.62, 1.34, "边界也要检查", color="#2ca02c", fontsize=12)
    ax.text(-2.25, -1.55, "闭区域最值候选：内部驻点 + 边界点", fontsize=13)
    ax.set_aspect("equal")
    ax.set_xlim(-2.35, 2.35)
    ax.set_ylim(-1.75, 1.75)
    ax.set_xlabel("$x$", fontsize=12)
    ax.set_ylabel("$y$", fontsize=12, rotation=0, labelpad=10)
    ax.grid(color="#eeeeee", lw=0.6)
    save(fig, "extrema_candidates_boundary.png")


def stationary_point_warning():
    fig, axes = plt.subplots(1, 3, figsize=(9.2, 3.3), subplot_kw={"projection": "3d"})
    x = np.linspace(-1.1, 1.1, 45)
    y = np.linspace(-1.1, 1.1, 45)
    X, Y = np.meshgrid(x, y)
    cases = [
        (X**2 + Y**2, "极小", r"$D>0,\ A>0$", "#dbeafe"),
        (-(X**2 + Y**2), "极大", r"$D>0,\ A<0$", "#fee2e2"),
        (X**2 - Y**2, "驻点但无极值", r"$D<0$", "#e5e7eb"),
    ]
    for ax, (Z, title, cond, color) in zip(axes, cases):
        ax.plot_surface(X, Y, Z, rstride=2, cstride=2, color=color, edgecolor="#9ca3af", linewidth=0.35, alpha=0.96, shade=False)
        ax.scatter([0], [0], [0], color="#111111", s=28, depthshade=False)
        ax.set_title(title + "\n" + cond, fontsize=12, pad=6)
        ax.set_xticks([])
        ax.set_yticks([])
        ax.set_zticks([])
        ax.set_box_aspect((1, 1, 0.72))
        ax.view_init(elev=24, azim=-55)
        ax.set_xlim(-1.1, 1.1)
        ax.set_ylim(-1.1, 1.1)
    fig.text(0.5, 0.03, "驻点只是候选点，二阶项的符号决定局部形状。", ha="center", fontsize=12)
    save(fig, "stationary_point_types.png")


def implicit_function_geometry():
    fig, ax = plt.subplots(figsize=(6.4, 5.0))
    ax.set_aspect("equal")
    ax.set_xlim(-2.4, 2.4)
    ax.set_ylim(-2.4, 2.4)
    ax.axis("off")

    # 画坐标轴
    ax.axhline(0, color="#333333", lw=1.0)
    ax.axvline(0, color="#333333", lw=1.0)
    ax.text(2.3, -0.18, "$x$", fontsize=13)
    ax.text(-0.18, 2.3, "$y$", fontsize=13)

    # 画曲线 F(x,y) = 0. 使用圆弧来表示，半径为 2
    theta = np.linspace(-np.pi/3, 5*np.pi/6, 300)
    R = 2.0
    cx = R * np.cos(theta)
    cy = R * np.sin(theta)
    ax.plot(cx, cy, color="#1976d2", lw=2.5)
    ax.text(-1.8, 1.4, "$F(x,y)=0$", color="#1976d2", fontsize=13)

    # 选择圆上的点 P(1.2, 1.6)
    px, py = 1.2, 1.6
    ax.plot(px, py, "o", color="#111111", ms=6)
    ax.text(px - 0.22, py - 0.26, "$P(x_0, y_0)$", fontsize=12, fontweight="bold")

    # 法向量 \nabla F = (F_x, F_y)
    # 在 (1.2, 1.6) 处，法向量方向为径向 (0.6, 0.8)
    # 画一个长度为 1.1 的箭头
    nx, ny = 0.6, 0.8
    arrow_len = 1.1
    ax.add_patch(
        FancyArrowPatch(
            (px, py),
            (px + arrow_len * nx, py + arrow_len * ny),
            arrowstyle="-|>",
            mutation_scale=15,
            linewidth=2.5,
            color="#2e7d32",
            shrinkA=0,
            shrinkB=0,
            zorder=4,
        )
    )
    # 标注 \nabla F = (F_x, F_y)
    ax.text(px + arrow_len * nx + 0.05, py + arrow_len * ny, r"$\nabla F = (F_x, F_y)$", color="#2e7d32", fontsize=13)

    # 切线。斜率为 -0.75。方程为 y - 1.6 = -0.75(x - 1.2) => y = -0.75x + 2.5
    # 切线画在 x 范围为 [0.2, 2.2] 之间
    tx = np.linspace(0.2, 2.2, 100)
    ty = -0.75 * tx + 2.5
    ax.plot(tx, ty, color="#d32f2f", lw=2.2)
    ax.text(0.5, 2.2, "切线", color="#d32f2f", fontsize=12)

    # 在 P 点画直角符号（切线与法线垂直）
    # 切向向量为 (0.8, -0.6)
    s = 0.15
    p_n = np.array([px + s*nx, py + s*ny])
    p_t = np.array([px + s*0.8, py - s*0.6])
    p_corner = p_n + np.array([s*0.8, -s*0.6])
    ax.plot([p_n[0], p_corner[0], p_t[0]], [p_n[1], p_corner[1], p_t[1]], color="#555555", lw=1.0)

    # 右下角放置精美的公式卡片 (bbox)
    formula_text = (
        r"$F_x + F_y y' = 0$" + "\n" +
        r"$y' = -\frac{F_x}{F_y}$"
    )
    ax.text(
        0.5, -1.8, formula_text,
        fontsize=13, color="#0f172a",
        bbox=dict(
            boxstyle="round,pad=0.6",
            facecolor="#f8fafc",
            edgecolor="#cbd5e1",
            linewidth=1.2
        )
    )

    # 保存图片
    save(fig, "implicit_function_geometry.png")

    # 额外拷贝一份到桌面以满足规范
    try:
        shutil.copy(ROOT / "implicit_function_geometry.png", Path(r"C:\Users\Spane\Desktop") / "implicit_function_geometry.png")
    except Exception as e:
        print(f"Copy to desktop failed: {e}")


if __name__ == "__main__":
    setup_font()
    limit_paths()
    direction_derivative()
    gradient_angle()
    gradient_field()
    gradient_contours()
    lagrange_multiplier()
    extrema_candidates()
    stationary_point_warning()
    implicit_function_geometry()
