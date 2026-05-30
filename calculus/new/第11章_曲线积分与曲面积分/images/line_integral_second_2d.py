import matplotlib.pyplot as plt
import numpy as np
import matplotlib

# Setup fonts for Chinese
matplotlib.rcParams['font.sans-serif'] = ['Microsoft YaHei', 'SimHei', 'Arial Unicode MS']
matplotlib.rcParams['axes.unicode_minus'] = False

fig, ax = plt.subplots(figsize=(6, 4))

a = 2.0

# Path 1: Upper semicircle from A(a,0) to B(-a,0)
theta = np.linspace(0, np.pi, 100)
x1 = a * np.cos(theta)
y1 = a * np.sin(theta)
ax.plot(x1, y1, color='blue', linewidth=2, label='路径1: $y=\sqrt{a^2-x^2}$')

# Arrow for Path 1 (at the top, going left)
ax.annotate('', xy=(-0.1, a), xytext=(0.1, a),
            arrowprops=dict(arrowstyle="->", color='blue', lw=2))

# Path 2: Straight line from A(a,0) to B(-a,0)
x2 = np.linspace(a, -a, 100)
y2 = np.zeros_like(x2)
ax.plot(x2, y2, color='red', linestyle='--', linewidth=2, label='路径2: $y=0$')

# Arrow for Path 2 (in the middle, going left)
ax.annotate('', xy=(-0.1, 0), xytext=(0.1, 0),
            arrowprops=dict(arrowstyle="->", color='red', lw=2))

# Points A and B
ax.plot(a, 0, 'ko', markersize=6)
ax.plot(-a, 0, 'ko', markersize=6)

ax.text(a + 0.1, -0.1, '$A(a,0)$', fontsize=12, verticalalignment='top')
ax.text(-a - 0.1, -0.1, '$B(-a,0)$', fontsize=12, verticalalignment='top', horizontalalignment='right')

# Limits and styling
ax.set_xlim(-a - 0.8, a + 0.8)
ax.set_ylim(-0.8, a + 0.8)

# Center axes
ax.spines['left'].set_position('zero')
ax.spines['bottom'].set_position('zero')
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')

# Hide ticks
ax.set_xticks([])
ax.set_yticks([])

# Add axis labels
ax.text(a + 0.7, -0.2, '$x$', fontsize=12)
ax.text(-0.2, a + 0.7, '$y$', fontsize=12)

plt.title('起点 A 和终点 B 相同，路径不同', fontsize=14, pad=10)
plt.legend(loc='upper right')

plt.tight_layout()
plt.savefig('line_integral_second_2d.png', dpi=300)
