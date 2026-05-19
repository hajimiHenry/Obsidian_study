from pathlib import Path

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
    x = np.linspace(-2.2, 2.35, 320)
    y = np.linspace(-1.8, 1.8, 260)
    X, Y = np.meshgrid(x, y)
    F = (X - 0.85) ** 2 + 0.72 * (Y - 0.34) ** 2
    ax.contour(X, Y, F, levels=[0.25, 0.55, 0.95, 1.45, 2.15], colors="#90a4ae", linewidths=1.25)

    t = np.linspace(0, 2 * np.pi, 360)
    cx = 1.45 * np.cos(t) - 0.10
    cy = 0.92 * np.sin(t)
    ax.plot(cx, cy, color="#1565c0", lw=2.8)

    P = np.array([1.31, 0.39])
    ax.plot(P[0], P[1], "o", color="#111111", ms=6)
    arrow(ax, P, P + np.array([0.58, 0.00]), "#d62728", lw=2.5, ms=16)
    q = P + np.array([0.00, 0.12])
    arrow(ax, q, q + np.array([0.58, 0.00]), "#2e7d32", lw=2.5, ms=16)
    ax.text(P[0] + 0.64, P[1] - 0.06, r"$\nabla f$", color="#d62728", fontsize=13)
    ax.text(q[0] + 0.64, q[1] - 0.02, r"$\nabla \varphi$", color="#2e7d32", fontsize=13)
    ax.text(0.62, 1.34, r"相切时：$\nabla f=\lambda\nabla\varphi$", fontsize=14, weight="bold")
    ax.text(-1.92, -1.55, "蓝色曲线是约束，灰色曲线是目标函数等值线。", fontsize=11, color="#444444")
    ax.axhline(0, color="#333333", lw=0.9)
    ax.axvline(0, color="#333333", lw=0.9)
    ax.set_aspect("equal")
    ax.set_xlim(-2.05, 2.20)
    ax.set_ylim(-1.65, 1.65)
    ax.set_xlabel("$x$", fontsize=12)
    ax.set_ylabel("$y$", fontsize=12, rotation=0, labelpad=10)
    ax.set_xticks([])
    ax.set_yticks([])
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
