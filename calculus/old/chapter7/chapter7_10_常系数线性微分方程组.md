# 7.10 常系数线性微分方程组

## 前置知识

常系数线性方程的解法（7.7-7.8）。线性代数中解线性方程组的基本操作（消元法）。微分算子 $D = \dfrac{d}{dx}$ 的记号（7.7 中引入）。

## 动机：多个未知函数互相"耦合"

前面我们讨论的都是**一个方程、一个未知函数**的情形。但实际问题中，经常遇到多个变量互相耦合的情况。比如：

- 多回路电路中的多个电流
- 多体力学系统中的多个位置/速度
- 生态系统中的捕食者-猎物模型

这些问题的数学模型就是**微分方程组**——几个微分方程联立起来，共同确定几个具有同一自变量的未知函数。

如果方程组中每个微分方程都是常系数线性的，就叫做**常系数线性微分方程组**。好消息是：这种方程组可以用系统化的**消元法**求解。

---

## 基本方法：消元法

**核心思路**：像解代数方程组一样，从微分方程组中消去其他未知函数，得到只含**一个**未知函数的高阶常系数线性微分方程 → 解这个方程 → 再代回原方程组求出其他未知函数。

> ⚠️ **重要**：求出第一个未知函数后，通过代入（而非重新积分）来求其他函数——这样可以避免引入额外的、不必要的任意常数。

---

### 例 1（两个一阶方程的方程组）

解方程组：
$$
\begin{cases}
\dfrac{dy}{dx} = 3y - 2z, &(10\text{-}1)\\[6pt]
\dfrac{dz}{dx} = 2y - z. &(10\text{-}2)
\end{cases}
$$

**思考过程**：两个未知函数 $y$ 和 $z$ 互相出现在对方方程里（"耦合"）。先消去 $y$。

**解**：

由 (10-2) 解出 $y$：
$$
y = \frac{1}{2}\left(\frac{dz}{dx} + z\right). \tag{10-3}
$$

求导：
$$
\frac{dy}{dx} = \frac{1}{2}\left(\frac{d^2z}{dx^2} + \frac{dz}{dx}\right). \tag{10-4}
$$

将 (10-3) 和 (10-4) 代入 (10-1)：
$$
\frac{1}{2}\left(\frac{d^2z}{dx^2} + \frac{dz}{dx}\right) = 3 \cdot \frac{1}{2}\left(\frac{dz}{dx} + z\right) - 2z,
$$

两边乘 2 并整理：
$$
\frac{d^2z}{dx^2} + \frac{dz}{dx} = 3\frac{dz}{dx} + 3z - 4z,
$$
$$
\frac{d^2z}{dx^2} - 2\frac{dz}{dx} + z = 0.
$$

这是一个二阶常系数齐次线性方程！特征方程：$r^2 - 2r + 1 = (r-1)^2 = 0$，根 $r_1 = r_2 = 1$（重根）。

所以：
$$
z = (C_1 + C_2 x)e^x. \tag{10-5}
$$

再求 $y$：将 (10-5) 代入 (10-3)（注意：代入，不是重新解方程）：
$$
\begin{aligned}
y &= \frac{1}{2}\left[\frac{d}{dx}\big((C_1 + C_2 x)e^x\big) + (C_1 + C_2 x)e^x\right] \\
&= \frac{1}{2}\big[(C_2 e^x + (C_1 + C_2 x)e^x) + (C_1 + C_2 x)e^x\big] \\
&= \frac{1}{2}\big[2C_1 + C_2 + 2C_2 x\big]e^x.
\end{aligned}
$$

所以方程组的通解为：
$$
\begin{cases}
y = \dfrac{1}{2}(2C_1 + C_2 + 2C_2 x)e^x, \\[8pt]
z = (C_1 + C_2 x)e^x.
\end{cases}
$$

若还要求满足初值条件 $y(0) = 1, z(0) = 0$ 的特解：
$$
\begin{cases}
1 = \dfrac{1}{2}(2C_1 + C_2), \\
0 = C_1.
\end{cases}
$$

解得 $C_1 = 0, C_2 = 2$。特解：
$$
\begin{cases}
y = (1 + 2x)e^x, \\
z = 2x e^x.
\end{cases}
$$

---

## 微分算子法（更加系统性）

用第七节介绍的微分算子 $D = \dfrac{d}{dt}$，可以把微分方程组写成类似于代数方程组的形式，然后用行列式或消元法来解。

---

### 例 2（用算子 D 解二阶方程组）

解方程组：
$$
\begin{cases}
\dfrac{d^2x}{dt^2} + \dfrac{dy}{dt} - x = e^t, \\[6pt]
\dfrac{d^2y}{dt^2} + \dfrac{dx}{dt} + y = 0.
\end{cases}
$$

**思考过程**：两个二阶方程，互相耦合。用算子 $D$ 写成代数形式，然后像解二元一次方程组一样消元。

**解**：

用 $D$ 表示 $\dfrac{d}{dt}$，方程组写为：
$$
\begin{cases}
(D^2 - 1)x + Dy = e^t, &(10\text{-}7)\\
Dx + (D^2 + 1)y = 0. &(10\text{-}8)
\end{cases}
$$

**消去 $x$**（目标是得到一个只含 $y$ 的方程）：

$(10\text{-}7) - D \cdot (10\text{-}8)$：

$$
(D^2 - 1)x + Dy - D[Dx + (D^2 + 1)y] = e^t,
$$
$$
(D^2 - 1)x + Dy - D^2x - D(D^2 + 1)y = e^t,
$$
$$
-x - D^3y = e^t. \tag{10-9}
$$

（因为 $(D^2 - 1)x - D^2x = -x$，$Dy - D(D^2+1)y = Dy - D^3y - Dy = -D^3y$。）

再 $(10\text{-}8) + D \cdot (10\text{-}9)$：
$$
Dx + (D^2 + 1)y + D(-x - D^3y) = 0 + De^t,
$$
$$
Dx + (D^2 + 1)y - Dx - D^4y = e^t,
$$
$$
(-D^4 + D^2 + 1)y = e^t.
$$

（$De^t = e^t$，因为 $D = d/dt$。）

即：
$$
-\frac{d^4y}{dt^4} + \frac{d^2y}{dt^2} + y = e^t. \tag{10-10}
$$

这是四阶常系数非齐次线性方程。特征方程：
$$
-r^4 + r^2 + 1 = 0, \quad \text{即} \quad r^4 - r^2 - 1 = 0.
$$

求根（用二次方程求根公式，令 $u = r^2$）：$u^2 - u - 1 = 0$，$u = \dfrac{1 \pm \sqrt{5}}{2}$。

所以四个特征根：
$$
r_{1,2} = \pm\alpha = \pm\sqrt{\frac{1+\sqrt{5}}{2}}, \quad
r_{3,4} = \pm\beta i = \pm i\sqrt{\frac{\sqrt{5}-1}{2}}.
$$

齐次通解含四项。非齐次特解：右端 $e^t$（$\lambda=1$），1 不是特征根，设 $y^* = Ae^t$。代入 (10-10)：
$$
-A + A + A = 1 \quad \Rightarrow \quad A = 1.
$$

所以：
$$
y = C_1 e^{-\alpha t} + C_2 e^{\alpha t} + C_3 \cos\beta t + C_4 \sin\beta t + e^t. \tag{10-11}
$$

**求 $x$**：由 (10-9) 式 $x = -D^3y - e^t$。

对 (10-11) 求导三次：
$$
\begin{aligned}
D^3y &= -\alpha^3 C_1 e^{-\alpha t} + \alpha^3 C_2 e^{\alpha t} + \beta^3 C_3 \sin\beta t - \beta^3 C_4 \cos\beta t + e^t.
\end{aligned}
$$

所以：
$$
x = \alpha^3 C_1 e^{-\alpha t} - \alpha^3 C_2 e^{\alpha t} - \beta^3 C_3 \sin\beta t + \beta^3 C_4 \cos\beta t - 2e^t. \tag{10-12}
$$

(10-11) 和 (10-12) 联立即为通解。

---

### 用行列式的方法（形式上更简洁）

把微分方程组写成：
$$
\begin{cases}
(D^2 - 1)x + Dy = e^t,\\
Dx + (D^2 + 1)y = 0.
\end{cases}
$$

类似于 Cramer 法则，把 $D$ 项式看作"系数"：

$$
\begin{vmatrix}
D^2-1 & D \\
D & D^2+1
\end{vmatrix} y =
\begin{vmatrix}
D^2-1 & e^t \\
D & 0
\end{vmatrix},
$$

即
$$
[(D^2-1)(D^2+1) - D \cdot D]y = -De^t = -e^t,
$$
$$
(D^4 - D^2 - 1)y = -e^t.
$$

这与前面得到的 (10-10) 式一致（乘 $-1$ 后）。但注意用行列式再求 $x$ 时，会引入四个**新的**任意常数——需回头用原方程建立两个常数系之间的关系。

> ⚠️ **注意**：算子行列式的阶数（这里是 $D^4 - D^2 - 1$，四次多项式）标志着微分方程组的总阶数，通解中恰好含有这么多个任意常数。如果对 $x$ 和 $y$ 分别用行列式求解，会得到八个常数——但这些常数并不独立，必须通过原方程组消去多余的。

---

## 核心要点

1. **消元法**是解线性微分方程组的基本方法：把方程组化为一个未知函数的高阶方程。
2. 求第二个未知函数时，通过**代入**（而非重新积分）来得到，以保持任意常数个数的正确性（等于方程组的总阶数）。
3. **微分算子 $D$** 可以把微分方程组写成代数方程组的形式，方便消元和用行列式。
4. ⚠️ 用行列式求各个未知函数时会产生多余的任意常数——必须用原方程消去。
5. 方程组的总阶数 = 算子系数行列式的次数。

---

## 习题 7-10

**1.** 求下列微分方程组的通解：

（1）
$$
\begin{cases}
\dfrac{dy}{dx} = z, \\[6pt]
\dfrac{dz}{dx} = y;
\end{cases}
$$

（2）
$$
\begin{cases}
\dfrac{d^2x}{dt^2} = y, \\[6pt]
\dfrac{d^2y}{dt^2} = x;
\end{cases}
$$

（3）
$$
\begin{cases}
\dfrac{dx}{dt} + \dfrac{dy}{dt} = -x + y + 3, \\[6pt]
\dfrac{dx}{dt} - \dfrac{dy}{dt} = x + y - 3;
\end{cases}
$$

（4）
$$
\begin{cases}
\dfrac{dx}{dt} + 5x + y = e^t, \\[6pt]
\dfrac{dy}{dt} - x - 3y = e^{2t};
\end{cases}
$$

（5）
$$
\begin{cases}
\dfrac{dx}{dt} + 2x + \dfrac{dy}{dt} + y = t, \\[6pt]
5x + \dfrac{dy}{dt} + 3y = t^2;
\end{cases}
$$

（6）
$$
\begin{cases}
\dfrac{dx}{dt} - 3x + 2\dfrac{dy}{dt} + 4y = 2\sin t, \\[6pt]
2\dfrac{dx}{dt} + 2x + \dfrac{dy}{dt} - y = \cos t.
\end{cases}
$$

**2.** 求下列微分方程组满足所给初值条件的特解：

（1）
$$
\begin{cases}
\dfrac{dx}{dt} = y, \quad \left. x \right|_{t=0} = 0, \\[6pt]
\dfrac{dy}{dt} = -x, \quad \left. y \right|_{t=0} = 1;
\end{cases}
$$

（2）
$$
\begin{cases}
\dfrac{d^2x}{dt^2} + 2\dfrac{dy}{dt} - x = 0, \quad \left. x \right|_{t=0} = 1, \\[6pt]
\dfrac{dx}{dt} + y = 0, \quad \left. y \right|_{t=0} = 0;
\end{cases}
$$

（3）
$$
\begin{cases}
\dfrac{dx}{dt} + 3x - y = 0, \quad \left. x \right|_{t=0} = 1, \\[6pt]
\dfrac{dy}{dt} - 8x + y = 0, \quad \left. y \right|_{t=0} = 4;
\end{cases}
$$

（4）
$$
\begin{cases}
2\dfrac{dx}{dt} - 4x + \dfrac{dy}{dt} - y = e^t, \quad \left. x \right|_{t=0} = \dfrac{3}{2}, \\[6pt]
\dfrac{dx}{dt} + 3x + y = 0, \quad \left. y \right|_{t=0} = 0;
\end{cases}
$$

（5）
$$
\begin{cases}
\dfrac{dx}{dt} + 2x - \dfrac{dy}{dt} = 10\cos t, \quad \left. x \right|_{t=0} = 2, \\[6pt]
\dfrac{dx}{dt} + \dfrac{dy}{dt} + 2y = 4e^{-2t}, \quad \left. y \right|_{t=0} = 0;
\end{cases}
$$

（6）
$$
\begin{cases}
\dfrac{dx}{dt} - x + \dfrac{dy}{dt} + 3y = e^{-t} - 1, \quad \left. x \right|_{t=0} = \dfrac{48}{49}, \\[6pt]
\dfrac{dx}{dt} + 2x + \dfrac{dy}{dt} + y = e^{2t} + t, \quad \left. y \right|_{t=0} = \dfrac{95}{98}.
\end{cases}
$$
