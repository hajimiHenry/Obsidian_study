from pathlib import Path

import matplotlib

matplotlib.use("Agg")

import matplotlib.pyplot as plt
import numpy as np
from matplotlib import font_manager
from mpl_toolkits.mplot3d.art3d import Poly3DCollection


BASE = Path(__file__).resolve().parent
OUT = BASE / "quadric_saddle_trace_3d.png"

FONT = font_manager.FontProperties(fname=r"C:\Windows\Fonts\msyh.ttc")
FONT_BOLD = font_manager.FontProperties(fname=r"C:\Windows\Fonts\msyhbd.ttc")


def z_value(x, y):
    return x * x - y * y


def setup_3d(ax, title):
    ax.view_init(elev=24, azim=-56)
    ax.set_proj_type("ortho")
    ax.set_box_aspect((1.35, 1.25, 1.0))
    ax.set_xlim(-1.35, 1.35)
    ax.set_ylim(-1.35, 1.35)
    ax.set_zlim(-1.25, 1.55)
    ax.set_axis_off()
    ax.set_title(title, fontproperties=FONT_BOLD, fontsize=16, pad=2)


def draw_axes(ax, length=1.25):
    ax.quiver(0, 0, 0, length, 0, 0, color="#222222", arrow_length_ratio=0.08, linewidth=1.2)
    ax.quiver(0, 0, 0, 0, length, 0, color="#222222", arrow_length_ratio=0.08, linewidth=1.2)
    ax.quiver(0, 0, -0.95, 0, 0, 2.25, color="#222222", arrow_length_ratio=0.06, linewidth=1.2)
    ax.text(length + 0.08, 0, 0, "$x$", fontsize=12)
    ax.text(0, length + 0.08, 0, "$y$", fontsize=12)
    ax.text(0, 0, 1.37, "$z$", fontsize=12)


def add_plane_x(ax, x0, y_min=-1.18, y_max=1.18, z_min=-1.05, z_max=1.28):
    verts = [[
        (x0, y_min, z_min),
        (x0, y_max, z_min),
        (x0, y_max, z_max),
        (x0, y_min, z_max),
    ]]
    poly = Poly3DCollection(
        verts,
        facecolors=(0.72, 0.80, 0.92, 0.23),
        edgecolors=(0.45, 0.50, 0.56, 0.45),
        linewidths=0.7,
    )
    ax.add_collection3d(poly)


def draw_left_panel(ax):
    setup_3d(ax, "空间中取截面 $x=t$")
    draw_axes(ax)

    xs = np.linspace(-1.15, 1.15, 48)
    ys = np.linspace(-1.15, 1.15, 48)
    X, Y = np.meshgrid(xs, ys)
    Z = z_value(X, Y)
    ax.plot_surface(
        X,
        Y,
        Z,
        rstride=2,
        cstride=2,
        color="#cfd8e8",
        alpha=0.34,
        linewidth=0,
        antialiased=True,
        shade=False,
    )

    # A few faint reference traces show saddle direction without becoming a mesh.
    s = np.linspace(-1.15, 1.15, 120)
    for y0 in (-0.85, 0.85):
        ax.plot(s, np.full_like(s, y0), z_value(s, y0), color="#8d8d8d", linewidth=0.8, alpha=0.55)
    ax.plot(s, np.zeros_like(s), z_value(s, 0), color="#16803a", linewidth=1.1, alpha=0.45)

    x0 = 0.78
    add_plane_x(ax, x0)
    y = np.linspace(-1.15, 1.15, 160)
    ax.plot(np.full_like(y, x0), y, z_value(x0, y), color="#d7191c", linewidth=2.4)
    ax.scatter([x0], [0], [z_value(x0, 0)], color="#d7191c", s=16)
    ax.text(x0 + 0.06, 1.04, 1.05, "$x=t$", fontsize=13)


def draw_right_panel(ax):
    setup_3d(ax, "截痕族与顶点轨迹")
    draw_axes(ax, length=1.18)

    y = np.linspace(-1.10, 1.10, 180)
    t_values = [-0.85, 0.0, 0.85]
    labels = ["$t=-t_0$", "$t=0$", "$t=t_0$"]
    for t, label in zip(t_values, labels):
        z = z_value(t, y)
        ax.plot(np.full_like(y, t), y, z, color="#d7191c", linewidth=2.2)
        ax.scatter([t], [0], [z_value(t, 0)], color="#d7191c", s=14)
        ax.text(t + 0.05, -1.06, z_value(t, -1.06), label, fontsize=11)

    x = np.linspace(-1.02, 1.02, 160)
    ax.plot(x, np.zeros_like(x), z_value(x, 0), color="#16803a", linewidth=2.0)
    ax.text(0.15, 0.10, 0.78, "$y=0,\\ z=x^2$", fontsize=12)

    # A very light base plane helps read the parallel x=t slices.
    verts = [[(-1.05, -1.12, -1.08), (1.05, -1.12, -1.08), (1.05, 1.12, -1.08), (-1.05, 1.12, -1.08)]]
    base = Poly3DCollection(verts, facecolors=(0.92, 0.92, 0.92, 0.22), edgecolors=(0.72, 0.72, 0.72, 0.25))
    ax.add_collection3d(base)


def main():
    fig = plt.figure(figsize=(11.2, 5.2), dpi=170)
    fig.patch.set_facecolor("white")

    left = fig.add_axes([0.025, 0.15, 0.46, 0.78], projection="3d")
    right = fig.add_axes([0.515, 0.15, 0.46, 0.78], projection="3d")
    draw_left_panel(left)
    draw_right_panel(right)

    fig.text(
        0.5,
        0.045,
        r"$\frac{x^2}{a^2}-\frac{y^2}{b^2}=z$：固定 $x=t$ 时，截痕是一族开口向下的抛物线；顶点沿 $y=0,\ z=x^2/a^2$ 移动。",
        ha="center",
        va="center",
        fontsize=12,
        fontproperties=FONT,
        color="#222222",
    )

    fig.savefig(OUT, facecolor="white", bbox_inches="tight", pad_inches=0.08)
    plt.close(fig)


if __name__ == "__main__":
    main()
