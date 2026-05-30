import matplotlib.pyplot as plt
import matplotlib.patches as patches
import numpy as np
import os

# Ensure fonts
plt.rcParams['font.sans-serif'] = ['Microsoft YaHei', 'SimHei', 'Arial Unicode MS']
plt.rcParams['axes.unicode_minus'] = False

out_dir = r"C:\Users\Spane\Desktop\prompt_base\calculus\new\第10章_重积分\images"
if not os.path.exists(out_dir):
    os.makedirs(out_dir)

# Image 1: 1D substitution
fig, ax = plt.subplots(figsize=(10, 4))
ax.axis('off')
ax.set_xlim(-1, 11)
ax.set_ylim(-1, 4)

# U axis
ax.hlines(3, 0, 10, color='black', lw=2)
ax.text(-0.5, 3, "u轴", fontsize=14, va='center')
for i in range(11):
    ax.vlines(i, 2.9, 3.1, color='black')
    
u0 = 4
du = 1
ax.hlines(3, u0, u0+du, color='blue', lw=5)
ax.text(u0 + du/2, 3.2, "$du$", fontsize=12, color='blue', ha='center')

# X axis
ax.hlines(1, 0, 10, color='black', lw=2)
ax.text(-0.5, 1, "x轴", fontsize=14, va='center')
def g(u):
    return u**1.5 / 3.16 + 0.5  # just a non-linear mapping
for i in range(11):
    ax.vlines(g(i), 0.9, 1.1, color='black')

x0 = g(u0)
dx = g(u0+du) - g(u0)
ax.hlines(1, x0, x0+dx, color='red', lw=5)
ax.text(x0 + dx/2, 1.2, "$g'(u_0)du$", fontsize=12, color='red', ha='center')

# Mapping arrows
ax.annotate("", xy=(x0, 1.1), xytext=(u0, 2.9), arrowprops=dict(arrowstyle="->", color="gray", ls="--"))
ax.annotate("", xy=(x0+dx, 1.1), xytext=(u0+du, 2.9), arrowprops=dict(arrowstyle="->", color="gray", ls="--"))
ax.text((u0+x0)/2 - 0.5, 2, "映射 $x=g(u)$", fontsize=12, color='gray')

fig.savefig(os.path.join(out_dir, "1d_substitution.png"), bbox_inches='tight', dpi=300)
plt.close(fig)

# Image 2: UV plane rectangle
fig, ax = plt.subplots(figsize=(6, 5))
ax.axis('off')
ax.set_xlim(-0.5, 4)
ax.set_ylim(-0.5, 3.5)

u0, v0 = 1, 1
du, dv = 2, 1.5

# axes
ax.annotate("", xy=(3.5, 0), xytext=(0, 0), arrowprops=dict(arrowstyle="->"))
ax.annotate("", xy=(0, 3), xytext=(0, 0), arrowprops=dict(arrowstyle="->"))
ax.text(3.6, 0, "u", fontsize=14, va='center')
ax.text(0, 3.1, "v", fontsize=14, ha='center')

rect = patches.Rectangle((u0, v0), du, dv, linewidth=2, edgecolor='blue', facecolor='lightblue', alpha=0.5)
ax.add_patch(rect)

ax.plot(u0, v0, 'ko')
ax.text(u0, v0-0.2, "$(u_0, v_0)$", fontsize=12, ha='center')

ax.plot(u0+du, v0, 'ko')
ax.text(u0+du, v0-0.2, "$(u_0+du, v_0)$", fontsize=12, ha='center')

ax.plot(u0, v0+dv, 'ko')
ax.text(u0, v0+dv+0.1, "$(u_0, v_0+dv)$", fontsize=12, ha='center')

ax.plot(u0+du, v0+dv, 'ko')
ax.text(u0+du, v0+dv+0.1, "$(u_0+du, v_0+dv)$", fontsize=12, ha='center')

ax.annotate("", xy=(u0+du, v0), xytext=(u0, v0), arrowprops=dict(arrowstyle="->", color="blue", lw=2))
ax.text(u0+du/2, v0-0.3, "沿u方向: $du$", fontsize=12, color='blue', ha='center')

ax.annotate("", xy=(u0, v0+dv), xytext=(u0, v0), arrowprops=dict(arrowstyle="->", color="blue", lw=2))
ax.text(u0-0.1, v0+dv/2, "沿v方向: $dv$", fontsize=12, color='blue', ha='right', va='center')

fig.savefig(os.path.join(out_dir, "uv_rectangle.png"), bbox_inches='tight', dpi=300)
plt.close(fig)

# Image 3: XY plane parallelogram
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 4))
ax1.axis('off')
ax2.axis('off')
ax1.set_xlim(-0.5, 3)
ax1.set_ylim(-0.5, 2.5)
ax2.set_xlim(-1, 5)
ax2.set_ylim(-1, 4)

# Left: UV rect
ax1.text(1.25, -0.5, "uv平面", fontsize=14, ha='center')
rect1 = patches.Rectangle((0.5, 0.5), 1.5, 1, linewidth=2, edgecolor='blue', facecolor='lightblue', alpha=0.5)
ax1.add_patch(rect1)
ax1.text(1.25, 1, r"面积 = $du\,dv$", fontsize=12, ha='center', va='center')

# Right: XY parallelogram
ax2.text(2, -0.5, "xy平面", fontsize=14, ha='center')
origin = np.array([0.5, 0.5])
vec_a = np.array([3, 0.5])
vec_b = np.array([1, 2])
pts = np.array([origin, origin+vec_a, origin+vec_a+vec_b, origin+vec_b])
poly = patches.Polygon(pts, closed=True, linewidth=2, edgecolor='red', facecolor='lightcoral', alpha=0.5)
ax2.add_patch(poly)

ax2.annotate("", xy=origin+vec_a, xytext=origin, arrowprops=dict(arrowstyle="->", color="red", lw=2))
ax2.text(origin[0]+vec_a[0]/2, origin[1]+vec_a[1]/2 - 0.3, r"$\vec{a}$ (沿u方向映射)", fontsize=10, color='red', ha='center')

ax2.annotate("", xy=origin+vec_b, xytext=origin, arrowprops=dict(arrowstyle="->", color="red", lw=2))
ax2.text(origin[0]+vec_b[0]/2 - 0.2, origin[1]+vec_b[1]/2, r"$\vec{b}$ (沿v方向映射)", fontsize=10, color='red', ha='right')

ax2.text(origin[0]+(vec_a[0]+vec_b[0])/2, origin[1]+(vec_a[1]+vec_b[1])/2, "面积 = ?", fontsize=12, ha='center', va='center')

# Arrow between subplots
fig.text(0.5, 0.52, "T", fontsize=16, ha='center', va='center')
fig.text(0.5, 0.48, r"$\longrightarrow$", fontsize=24, ha='center', va='center')

fig.savefig(os.path.join(out_dir, "xy_parallelogram.png"), bbox_inches='tight', dpi=300)
plt.close(fig)

# Image 4: Polar coordinates Jacobian
fig, (ax1, ax2, ax3) = plt.subplots(1, 3, figsize=(15, 4))
ax1.axis('off')
ax2.axis('off')
ax3.axis('off')

# Panel 1: rho-theta plane
ax1.set_xlim(-0.5, 3)
ax1.set_ylim(-0.5, 2.5)
ax1.text(1.25, -0.3, r"$\rho\theta$ 平面", fontsize=14, ha='center')
rect = patches.Rectangle((0.5, 0.5), 1.5, 1, linewidth=2, edgecolor='blue', facecolor='lightblue', alpha=0.5)
ax1.add_patch(rect)
ax1.annotate("", xy=(2, 0.5), xytext=(0.5, 0.5), arrowprops=dict(arrowstyle="->", color="blue"))
ax1.text(1.25, 0.3, "$d\\rho$", fontsize=12, color='blue', ha='center')
ax1.annotate("", xy=(0.5, 1.5), xytext=(0.5, 0.5), arrowprops=dict(arrowstyle="->", color="blue"))
ax1.text(0.3, 1, "$d\\theta$", fontsize=12, color='blue', ha='right', va='center')

# Panel 2: XY mapped vectors
ax2.set_xlim(-1, 4)
ax2.set_ylim(-1, 3)
ax2.text(1.5, -0.8, r"xy 平面: 向量", fontsize=14, ha='center')
origin = np.array([1, 1])
vec_a = np.array([2, 1]) # radial
vec_b = np.array([-0.5, 1]) # tangential (orthogonal)
ax2.annotate("", xy=origin+vec_a, xytext=origin, arrowprops=dict(arrowstyle="->", color="red", lw=2))
ax2.text(origin[0]+vec_a[0]/2, origin[1]+vec_a[1]/2 - 0.2, r"$\vec{a}$ (长 $d\rho$)", fontsize=10, color='red', ha='left')
ax2.annotate("", xy=origin+vec_b, xytext=origin, arrowprops=dict(arrowstyle="->", color="red", lw=2))
ax2.text(origin[0]+vec_b[0]/2, origin[1]+vec_b[1]/2 + 0.2, r"$\vec{b}$ (长 $\rho d\theta$)", fontsize=10, color='red', ha='right')
# Draw a dashed circle arc to show it's along the arc
theta = np.linspace(0, np.pi/4, 50)
r = np.sqrt(1**2 + 1**2)
ax2.plot(r*np.cos(theta), r*np.sin(theta), 'k--', alpha=0.3)
ax2.plot(0, 0, 'ko') # origin
ax2.text(0, -0.2, "原点", ha='center')

# Panel 3: Parallelogram
ax3.set_xlim(-1, 4)
ax3.set_ylim(-1, 3)
ax3.text(1.5, -0.8, r"xy 平面: 平行四边形", fontsize=14, ha='center')
pts = np.array([origin, origin+vec_a, origin+vec_a+vec_b, origin+vec_b])
poly = patches.Polygon(pts, closed=True, linewidth=2, edgecolor='red', facecolor='lightcoral', alpha=0.5)
ax3.add_patch(poly)
ax3.text(origin[0]+(vec_a[0]+vec_b[0])/2, origin[1]+(vec_a[1]+vec_b[1])/2, r"面积 = $\rho d\rho d\theta$", fontsize=12, ha='center', va='center')

fig.savefig(os.path.join(out_dir, "polar_jacobian_demo.png"), bbox_inches='tight', dpi=300)
plt.close(fig)
print("Images generated.")
