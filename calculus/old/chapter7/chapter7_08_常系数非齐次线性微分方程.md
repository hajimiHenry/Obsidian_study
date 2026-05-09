# 7.8 常系数非齐次线性微分方程

## 前置知识

常系数齐次线性方程的解法（7.7，特征方程法）。非齐次方程解的结构定理（7.6，定理 3：通解 = 齐次通解 + 非齐次特解）。

## 动机：齐次方程会解了，非齐次怎么办？

根据 7.6 定理 3，非齐次方程

$$
y'' + py' + qy = f(x) \quad (p, q \text{ 为常数})
$$

的通解 = 齐次通解 $Y$ + 非齐次特解 $y^*$。

齐次通解 $Y$ 已经在 7.7 中用特征方程法解决了。剩下唯一的问题是：**如何求出非齐次方程的一个特解 $y^*$？**

本节介绍**待定系数法**——当 $f(x)$ 是某些特殊类型时，不需要积分，只需要"猜测" $y^*$ 的形式然后代入定系数。

> **为什么只讨论特殊类型？** 因为一般的 $f(x)$（比如 $\sqrt{x}$ 或 $\ln x$），特解很难"猜"出来。但工程和物理中，$f(x)$ 绝大多数情况是指数函数、多项式、正弦/余弦函数或者它们的乘积。

---

## 方法概述：待定系数法

**核心思想**：$f(x)$ 是什么类型的函数，特解 $y^*$ 就"模仿"什么类型——但要根据 $f(x)$ 是否与齐次解"冲突"（即 $\lambda$ 是不是特征根）来决定是否需要多乘 $x^k$。

下面分两种常见的 $f(x)$ 类型来讨论。

---

## 类型一：$f(x) = e^{\lambda x} P_m(x)$

其中 $P_m(x)$ 是一个 $m$ 次多项式。特解的设法是：

$$
y^* = x^k \cdot R_m(x) \cdot e^{\lambda x},
$$

其中 $R_m(x)$ 是一个与 $P_m(x)$ 同次（$m$ 次）的多项式，其系数待定；而

$$
k = \begin{cases}
0, & \text{若 } \lambda \text{ 不是特征方程的根},\\
1, & \text{若 } \lambda \text{ 是特征方程的单根},\\
2, & \text{若 } \lambda \text{ 是特征方程的重根}.
\end{cases}
$$

> **直观理解**：$k$ 叫做"冲突次数"。如果 $f(x)$ 的指数 $\lambda$ 恰好是特征根，那么 $e^{\lambda x}$ 在齐次通解里已经"被占用了"，你就必须乘上一个 $x$（或 $x^2$）来"升维"，否则代入方程后会全抵消，得不出新解。

⚠️ 这个规则对 $n$ 阶方程同样适用：$k$ 就是 $\lambda$ 在特征方程中的**重数**。

---

### 例 1（$\lambda$ 不是特征根）

求 $y'' - 2y' - 3y = 3x + 1$ 的一个特解。

**思考过程**：
- $f(x) = (3x+1)e^{0\cdot x}$，所以 $\lambda = 0$，$P_m(x) = 3x+1$ 是一次多项式。
- 特征方程 $r^2 - 2r - 3 = 0$ 的根是 $r = -1, 3$。$\lambda = 0$ 不是根，所以 $k = 0$。
- 设 $y^* = b_0 x + b_1$（一次多项式，含两个待定系数）。

**解**：

特征方程 $r^2 - 2r - 3 = 0$，根为 $r_1 = -1, r_2 = 3$。$\lambda = 0$ 不是根，所以 $k = 0$。

设 $y^* = b_0 x + b_1$。求导：
$$
y^{*'} = b_0, \quad y^{*''} = 0.
$$

代入原方程：
$$
0 - 2b_0 - 3(b_0 x + b_1) = 3x + 1,
$$
$$
-3b_0 x + (-2b_0 - 3b_1) = 3x + 1.
$$

比较系数（左右两边同次幂的系数相等）：
$$
\begin{cases}
-3b_0 = 3, \\
-2b_0 - 3b_1 = 1.
\end{cases}
$$

解得 $b_0 = -1$，代入第二式：$2 - 3b_1 = 1$，$b_1 = \dfrac{1}{3}$。

所以特解为 $y^* = -x + \dfrac{1}{3}$。

---

### 例 2（$\lambda$ 是特征单根）

求 $y'' - 5y' + 6y = x e^{2x}$ 的通解。

**思考过程**：
- $f(x) = x e^{2x}$，$\lambda = 2$，$P_m(x) = x$（一次多项式）。
- 特征方程 $r^2 - 5r + 6 = 0$，根 $r = 2, 3$。$\lambda = 2$ 是单根，所以 $k = 1$。
- 需要设 $y^* = x \cdot (b_0 x + b_1) \cdot e^{2x} = x(b_0 x + b_1)e^{2x}$。
- 然后求齐次通解 + 非齐次特解 = 通解。

**解**：

（1）先求齐次通解。

特征方程 $r^2 - 5r + 6 = 0$，根 $r_1 = 2, r_2 = 3$。齐次通解：
$$
Y = C_1 e^{2x} + C_2 e^{3x}.
$$

（2）求非齐次特解。

$\lambda = 2$ 是特征单根，$m = 1$，$k = 1$。设：
$$
y^* = x(b_0 x + b_1)e^{2x} = (b_0 x^2 + b_1 x)e^{2x}.
$$

（注意：不要省略 $b_0 x^2$ 项——虽然 $P_m$ 只有 $x$ 项，但因为多乘了 $x$，$R_m(x)$ 必须保留完整的 $m$ 次多项式。）

求导：
$$
\begin{aligned}
y^{*'} &= (2b_0 x + b_1)e^{2x} + 2(b_0 x^2 + b_1 x)e^{2x} = [2b_0 x^2 + 2(b_0 + b_1)x + b_1]e^{2x}, \\
y^{*''} &= [4b_0 x + 2(b_0 + b_1)]e^{2x} + 2[2b_0 x^2 + 2(b_0 + b_1)x + b_1]e^{2x} \\
&= [4b_0 x^2 + 4(2b_0 + b_1)x + 2(b_0 + 2b_1)]e^{2x}.
\end{aligned}
$$

代入 $y'' - 5y' + 6y = x e^{2x}$，约去 $e^{2x}$，整理同类项：

$x^2$ 的系数：$4b_0 - 5(2b_0) + 6b_0 = 0$ ✓（自动抵消）
$x$ 的系数：$4(2b_0 + b_1) - 5 \cdot 2(b_0 + b_1) + 6b_1 = (8b_0 + 4b_1) - (10b_0 + 10b_1) + 6b_1 = -2b_0 + 0b_1$
常数项：$2(b_0 + 2b_1) - 5b_1 = 2b_0 + 4b_1 - 5b_1 = 2b_0 - b_1$

但代入后右边只有 $x$ 项（系数为 1），所以：

比较 $x$ 系数：$-2b_0 = 1 \Rightarrow b_0 = -\dfrac{1}{2}$。
比较常数项：$2b_0 - b_1 = 0 \Rightarrow b_1 = 2b_0 = -1$。

所以：
$$
y^* = x\left(-\frac{1}{2}x - 1\right)e^{2x} = -\frac{1}{2}(x^2 + 2x)e^{2x}.
$$

（3）通解：
$$
y = C_1 e^{2x} + C_2 e^{3x} - \frac{1}{2}(x^2 + 2x)e^{2x}.
$$

---

## 类型二：$f(x) = e^{\lambda x}[P_l(x)\cos\omega x + Q_n(x)\sin\omega x]$

其中 $P_l, Q_n$ 分别是 $l$ 次和 $n$ 次多项式（可以有一个恒为零）。

特解的设法是：

$$
y^* = x^k e^{\lambda x}\left[R_m^{(1)}(x)\cos\omega x + R_m^{(2)}(x)\sin\omega x\right],
$$

其中 $m = \max\{l, n\}$，$R_m^{(1)}, R_m^{(2)}$ 是两个 $m$ 次多项式，系数待定；而

$$
k = \begin{cases}
0, & \text{若 } \lambda + \omega i \text{ 不是特征方程的根},\\
1, & \text{若 } \lambda + \omega i \text{ 是特征方程的根}.
\end{cases}
$$

> ⚠️ **关键提醒**：即使 $f(x)$ 中只有 $\cos$ 项（$Q_n \equiv 0$）或只有 $\sin$ 项（$P_l \equiv 0$），设特解时也**必须同时包含 $\cos$ 和 $\sin$ 两项**！因为 $\cos$ 的导数会出 $\sin$，$\sin$ 的导数会出 $\cos$，单独设一项代入后会"配对不齐"。

---

### 例 3（三角函数型，$k = 0$）

求 $y'' + y = x\cos 2x$ 的一个特解。

**思考过程**：
- $\lambda = 0$，$\omega = 2$，$P_l = x$（一次），$Q_n \equiv 0$。
- $m = \max\{1, 0\} = 1$。
- 特征方程 $r^2 + 1 = 0$，根 $r = \pm i$。$\lambda + \omega i = 2i$ 不是根，所以 $k = 0$。
- 设 $y^* = (ax + b)\cos 2x + (cx + d)\sin 2x$（∵ $m=1$，$R_m$ 是一次多项式）。

**解**：

特征方程 $r^2 + 1 = 0$，根为 $\pm i$。$\lambda + \omega i = 2i$ 不是根，$k = 0$。

设 $y^* = (ax + b)\cos 2x + (cx + d)\sin 2x$。

求导（注意乘法法则和链式法则）：
$$
\begin{aligned}
y^{*'} &= a\cos 2x - 2(ax + b)\sin 2x + c\sin 2x + 2(cx + d)\cos 2x \\
&= [a + 2(cx + d)]\cos 2x + [c - 2(ax + b)]\sin 2x,
\end{aligned}
$$

$$
\begin{aligned}
y^{*''} &= 2c\cos 2x - 2[a + 2(cx + d)]\sin 2x - 2a\sin 2x - 2[c - 2(ax + b)]\cos 2x \\
&= [2c - 2c + 4(ax + b)]\cos 2x + [-2a - 4(cx + d) - 2a]\sin 2x \\
&= 4(ax + b)\cos 2x - [4(cx + d) + 4a]\sin 2x.
\end{aligned}
$$

代入 $y'' + y = x\cos 2x$：

$y^{*''} + y^* = [4(ax+b) + (ax+b)]\cos 2x + \{-[4(cx+d)+4a] + (cx+d)\}\sin 2x$：

即：
$$
(-3ax - 3b + 4c)\cos 2x + (-3cx - 3d - 4a)\sin 2x = x\cos 2x + 0 \cdot \sin 2x.
$$

比较系数：
$$
\begin{cases}
-3a = 1,\\
-3b + 4c = 0,\\
-3c = 0,\\
-3d - 4a = 0.
\end{cases}
$$

解得 $a = -\dfrac{1}{3}$，$c = 0$，$b = 0$，$d = -\dfrac{4a}{3} = \dfrac{4}{9}$。

所以：
$$
y^* = -\frac{1}{3}x\cos 2x + \frac{4}{9}\sin 2x.
$$

---

### 例 4（指数 × 三角函数）

求 $y'' - y = e^x \cos 2x$ 的一个特解。

**解**：

$\lambda = 1$，$\omega = 2$，$P_l \equiv 1$（零次），$Q_n \equiv 0$。$m = 0$。

特征方程 $r^2 - 1 = 0$，根 $r = \pm 1$。$\lambda + \omega i = 1 + 2i$ 不是根，$k = 0$。

设 $y^* = e^x(a\cos 2x + b\sin 2x)$。

求导：
$$
\begin{aligned}
y^{*'} &= e^x(a\cos 2x + b\sin 2x) + e^x(-2a\sin 2x + 2b\cos 2x) \\
&= e^x[(a + 2b)\cos 2x + (b - 2a)\sin 2x], \\[4pt]
y^{*''} &= e^x[(a + 2b)\cos 2x + (b - 2a)\sin 2x] \\
&\quad + e^x[-2(a + 2b)\sin 2x + 2(b - 2a)\cos 2x] \\
&= e^x[(a + 2b + 2b - 4a)\cos 2x + (b - 2a - 2a - 4b)\sin 2x] \\
&= e^x[(-3a + 4b)\cos 2x + (-4a - 3b)\sin 2x].
\end{aligned}
$$

代入 $y'' - y = e^x\cos 2x$：
$$
\begin{aligned}
y^{*''} - y^* &= e^x[(-3a + 4b - a)\cos 2x + (-4a - 3b - b)\sin 2x] \\
&= e^x[(-4a + 4b)\cos 2x + (-4a - 4b)\sin 2x] \\
&= 4e^x[(-a + b)\cos 2x - (a + b)\sin 2x].
\end{aligned}
$$

令其等于 $e^x\cos 2x$：
$$
\begin{cases}
4(-a + b) = 1, \\
-4(a + b) = 0.
\end{cases}
$$

解得 $a = -\dfrac{1}{8}$，$b = \dfrac{1}{8}$。

所以 $y^* = \dfrac{1}{8}e^x(\sin 2x - \cos 2x)$。

---

### 例 5（共振问题——$\lambda + \omega i$ 是特征根）

求无阻尼强迫振动方程 $\dfrac{d^2x}{dt^2} + k^2 x = h\sin pt$ 的通解。

**思考过程**：这是 $f(x)$ 属于类型二的方程。$\lambda = 0$，$\omega = p$。特征方程 $r^2 + k^2 = 0$，根为 $\pm ki$。$\lambda + \omega i = pi$ 是不是特征根取决于 $p$ 是否等于 $k$。

**解**：

齐次方程 $x'' + k^2 x = 0$ 的特征方程为 $r^2 + k^2 = 0$，根 $r = \pm ki$。

齐次通解：
$$
X = C_1\cos kt + C_2\sin kt = A\sin(kt + \varphi).
$$

（i）**$p \neq k$ 时**：$\lambda + \omega i = pi$ 不是特征根，$k = 0$。

设 $x^* = a_1\cos pt + b_1\sin pt$。代入方程 $x'' + k^2 x = h\sin pt$：
$$
(-a_1 p^2\cos pt - b_1 p^2\sin pt) + k^2(a_1\cos pt + b_1\sin pt) = h\sin pt,
$$
$$
a_1(k^2 - p^2)\cos pt + b_1(k^2 - p^2)\sin pt = h\sin pt.
$$

比较系数：$a_1(k^2 - p^2) = 0 \Rightarrow a_1 = 0$（因为 $p \neq k$）；$b_1(k^2 - p^2) = h \Rightarrow b_1 = \dfrac{h}{k^2 - p^2}$。

所以：
$$
x^* = \frac{h}{k^2 - p^2}\sin pt.
$$

通解：
$$
x = A\sin(kt + \varphi) + \frac{h}{k^2 - p^2}\sin pt.
$$

（ii）**$p = k$ 时**：$\lambda + \omega i = ki$ 是特征根，$k = 1$。

设 $x^* = t(a_1\cos kt + b_1\sin kt)$。

代入方程后可求得 $a_1 = -\dfrac{h}{2k}$，$b_1 = 0$。所以：
$$
x^* = -\frac{h}{2k}t\cos kt.
$$

通解：
$$
x = A\sin(kt + \varphi) - \frac{h}{2k}t\cos kt.
$$

> **共振现象**：当 $p = k$（干扰力频率等于系统固有频率）时，特解中的振幅 $\dfrac{h}{2k}t$ 随时间 $t$ 的增大而**无限增大**！这就是**共振**。工程上必须避免这种情况——1940 年美国 Tacoma 海峡大桥的倒塌就是风引起的共振导致的。

---

## 待定系数法速查表

| $f(x)$ 的形式 | 特解 $y^*$ 的设法规格 | $k$ 的取值 |
|---|---|---|
| $e^{\lambda x}P_m(x)$ | $x^k R_m(x) e^{\lambda x}$ | $k = \lambda$ 作为特征根的重数（0, 1, 2） |
| $e^{\lambda x}[P_l\cos\omega x + Q_n\sin\omega x]$ | $x^k e^{\lambda x}[R_m^{(1)}\cos\omega x + R_m^{(2)}\sin\omega x]$ | $k = 1$ 若 $\lambda+\omega i$ 是特征根，否则 $k = 0$ |

> 其中 $m = \max\{l, n\}$，$R$ 表示 $m$ 次多项式（系数待定）。

---

## 核心要点

1. **待定系数法的精髓**："猜"特解的形式 → 代入方程 → 比较系数 → 解出系数。全程不需要积分。
2. **"冲突次数" $k$** 非常关键：$f(x)$ 中的指数 $\lambda$（或复频率 $\lambda + \omega i$）与特征根匹配几次，就乘几个 $x$。
3. ⚠️ 三角函数的情况，即使 $f(x)$ 只含 $\cos$ 或只含 $\sin$，特解必须同时包含两者。
4. ⚠️ 多项式部分 $R_m(x)$ 必须是**完整的 $m$ 次多项式**（含所有低次项），即便 $P_m(x)$ 缺少某些项。
5. **通解** = 齐次通解 + 上面求出的特解。别忘了两步都要做。

---

## 习题 7-8

**1.** 求下列各微分方程的通解：

（1）$2y'' + y' - y = 2e^x$；
（2）$y'' + a^2 y = e^x$；
（3）$2y'' + 5y' = 5x^2 - 2x - 1$；
（4）$y'' + 3y' + 2y = 3xe^{-x}$；
（5）$y'' - 2y' + 5y = e^x \sin 2x$；
（6）$y'' - 6y' + 9y = (x+1)e^{3x}$；
（7）$y'' + 5y' + 4y = 3 - 2x$；
（8）$y'' + 4y = x\cos x$；
（9）$y'' + y = e^x + \cos x$；
（10）$y'' - y = \sin^2 x$。

**2.** 求下列各微分方程满足已给初值条件的特解：

（1）$y'' + y + \sin 2x = 0$，$\left. y \right|_{x=\pi} = 1$，$\left. y' \right|_{x=\pi} = 1$；
（2）$y'' - 3y' + 2y = 5$，$\left. y \right|_{x=0} = 1$，$\left. y' \right|_{x=0} = 2$；
（3）$y'' - 10y' + 9y = e^{2x}$，$\left. y \right|_{x=0} = \dfrac{6}{7}$，$\left. y' \right|_{x=0} = \dfrac{33}{7}$；
（4）$y'' - y = 4xe^x$，$\left. y \right|_{x=0} = 0$，$\left. y' \right|_{x=0} = 1$；
（5）$y'' - 4y' = 5$，$\left. y \right|_{x=0} = 1$，$\left. y' \right|_{x=0} = 0$。

**3.** 已知二阶常系数齐次线性微分方程 $y'' + my' + ny = 0$ 的通解为 $y = (C_1 + C_2 x)e^x$，求 $m, n$ 的值，并求非齐次方程 $y'' + my' + ny = x$ 满足初值条件 $y(0) = 2, y'(0) = 0$ 的特解。

**4.** 大炮以仰角 $\alpha$、初速度 $v_0$ 发射炮弹，若不计空气阻力，求弹道曲线。

**5.** 在 $RLC$ 含源串联电路中，电动势为 $E$ 的电源对电容器 $C$ 充电。已知 $E = 20$ V，$C = 0.2\,\mu\mathrm{F}$，$L = 0.1$ H，$R = 1000\,\Omega$，试求合上开关 $S$ 后的电流 $i(t)$ 及电压 $u_C(t)$。

**6.** 设函数 $\varphi(x)$ 连续，且满足
$$
\varphi(x) = e^x + \int_0^x t\varphi(t)\,dt - x\int_0^x \varphi(t)\,dt,
$$
求 $\varphi(x)$。
