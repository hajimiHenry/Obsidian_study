# 第五章 公式速查卡

> 一阶动态电路时域分析——所有核心公式，一页搞定。

---

## 1. 电容元件（关联参考方向）

$$
i_C = C\frac{\mathrm{d}u_C}{\mathrm{d}t}
\qquad
u_C(t) = u_C(0^-) + \frac{1}{C}\int_{0^-}^{t} i_C(\xi)\,\mathrm{d}\xi
$$

$$
W_C = \frac{1}{2}Cu_C^2
$$

- 直流稳态：电容 → **开路**（$i_C=0$）
- 有限电流下 $u_C$ **不能突变**

---

## 2. 电感元件（关联参考方向）

$$
u_L = L\frac{\mathrm{d}i_L}{\mathrm{d}t}
\qquad
i_L(t) = i_L(0^-) + \frac{1}{L}\int_{0^-}^{t} u_L(\xi)\,\mathrm{d}\xi
$$

$$
W_L = \frac{1}{2}Li_L^2
$$

- 直流稳态：电感 → **短路**（$u_L=0$）
- 有限电压下 $i_L$ **不能突变**

---

## 3. 串并联等效

| | 串联 | 并联 |
|---|---|---|
| 电容 | $\dfrac{1}{C_{eq}}=\sum\dfrac{1}{C_k}$ | $C_{eq}=\sum C_k$ |
| 电感 | $L_{eq}=\sum L_k$ | $\dfrac{1}{L_{eq}}=\sum\dfrac{1}{L_k}$ |

> 电容串联 ↔ 电阻并联形式相同

---

## 4. 换路定则

$$
\boxed{u_C(0^+) = u_C(0^-)} \qquad \boxed{i_L(0^+) = i_L(0^-)}
$$

- 只保护**状态量**（$u_C$ 和 $i_L$）
- $i_C$、$u_L$、电阻上的电压电流**都可以跳变**

---

## 5. 初始值求解 5 步流程

1. 画 $0^-$ 电路：C 开路，L 短路
2. 求 $u_C(0^-)$、$i_L(0^-)$
3. 换路定则：$u_C(0^+)=u_C(0^-)$，$i_L(0^+)=i_L(0^-)$
4. 画 $0^+$ 电路：C → **电压源**，L → **电流源**
5. 在 $0^+$ 电路中求其他量

---

## 6. 三要素公式（核心）

$$
\boxed{x(t) = x(\infty) + \big[x(0^+) - x(\infty)\big]\,e^{-t/\tau}}, \quad t \ge 0
$$

| 要素 | 方法 |
|---|---|
| $x(0^+)$ | 换路定则 + $0^+$ 等效电路 |
| $x(\infty)$ | 稳态电路：C 开路、L 短路 |
| $\tau$ | RC 电路：$\tau = R_{eq}C$；RL 电路：$\tau = L/R_{eq}$ |

$R_{eq}$：从动态元件端口向外看，独立源置零，受控源保留。

---

## 7. 时间常数 $\tau$ 的物理含义

$$
e^{-1} \approx 0.368 \quad \Rightarrow \quad 1\tau\ \text{后暂态剩}\ 36.8\%
$$

$$
5\tau\ \text{后暂态剩}\ <1\% \approx \text{到达稳态}
$$

---

## 8. 零输入响应（无外加电源，仅初始储能）

**RC**：

$$
u_C(t) = U_0\,e^{-t/\tau}, \quad \tau = R_{eq}C
$$

**RL**：

$$
i_L(t) = I_0\,e^{-t/\tau}, \quad \tau = \frac{L}{R_{eq}}
$$

---

## 9. 零状态响应（初始储能为零，有外加电源）

**RC**：

$$
u_C(t) = U_s(1-e^{-t/\tau}), \quad i(t) = \frac{U_s}{R}e^{-t/\tau}
$$

**RL**：

$$
i_L(t) = \frac{U_s}{R}(1-e^{-t/\tau}), \quad u_L(t) = U_s\,e^{-t/\tau}
$$

---

## 10. 全响应分解

$$
\text{全响应} = \underbrace{\text{零输入响应}}_{\text{仅由初始状态产生}} + \underbrace{\text{零状态响应}}_{\text{仅由外加激励产生}}
$$

$$
\text{全响应} = \underbrace{\text{稳态分量}}_{x(\infty)} + \underbrace{\text{暂态分量}}_{[x(0^+)-x(\infty)]e^{-t/\tau}}
$$

---

## 11. 阶跃函数与延迟

$$
\varepsilon(t) = \begin{cases} 0, & t<0 \\ 1, & t>0 \end{cases}
\qquad
\varepsilon(t-a):\ t=a\ \text{时接通}
$$

矩形脉冲：$A[\varepsilon(t) - \varepsilon(t-a)]$

---

## 12. 分段输入处理要点

1. 每段用三要素公式
2. 段交界处状态量**必须连续继承**
3. 时间变量写 $t - t_0$（起点平移）

---

## 13. 冲激函数与冲激响应

$$
\delta(t) = \frac{\mathrm{d}\varepsilon(t)}{\mathrm{d}t}, \qquad \int_{-\infty}^{+\infty}\delta(t)\,\mathrm{d}t = 1
$$

冲激激励造成状态跳变：

$$
\Delta u_C = \frac{1}{C}\int i_C\,\mathrm{d}t \qquad \Delta i_L = \frac{1}{L}\int u_L\,\mathrm{d}t
$$

---

## 14. 卷积积分

$$
y(t) = \int_0^t h(t-\xi)\,f(\xi)\,\mathrm{d}\xi = f(t) * h(t)
$$

- $h(t)$：冲激响应
- $f(t)$：任意输入
- **常值输入优先用三要素法**，非常值（斜坡、指数等）才用卷积

---

## 速记口诀

| 场景 | 记法 |
|---|---|
| 稳态等效 | C 开 L 短 |
| $0^+$ 等效 | C 变压源，L 变流源 |
| 求 $\tau$ | 去源看端口（受控源留） |
| 三要素顺序 | 初值→终值→$\tau$→代公式 |
| 换路定则 | 只保护 $u_C$ 和 $i_L$ |
