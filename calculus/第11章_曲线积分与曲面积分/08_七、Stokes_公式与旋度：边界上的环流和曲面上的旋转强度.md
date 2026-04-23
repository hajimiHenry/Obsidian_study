# 第11章 曲线积分与曲面积分

## 七、Stokes 公式与旋度：边界上的环流和曲面上的旋转强度

- 和上一节的关系：Gauss 管的是“闭曲面通量”，Stokes 管的是“有边界曲面的环流”。
- 学习目标：掌握 Stokes 公式、右手规则、空间路径无关条件，以及旋度的意义。

### 1. Stokes 公式

设 $\Gamma$ 是有向闭曲线，$\Sigma$ 是以 $\Gamma$ 为边界的有向曲面，且边界方向与曲面法向符合右手规则。  
若 $P,Q,R$ 有一阶连续偏导，则

$$
\oint_\Gamma P\,\mathrm{d}x+Q\,\mathrm{d}y+R\,\mathrm{d}z
=
\iint_\Sigma
\left(
\frac{\partial R}{\partial y}-\frac{\partial Q}{\partial z}
\right)\mathrm{d}y\mathrm{d}z
+
\iint_\Sigma
\left(
\frac{\partial P}{\partial z}-\frac{\partial R}{\partial x}
\right)\mathrm{d}z\mathrm{d}x
+
\iint_\Sigma
\left(
\frac{\partial Q}{\partial x}-\frac{\partial P}{\partial y}
\right)\mathrm{d}x\mathrm{d}y.
$$

更紧凑的向量形式是

$$
\oint_\Gamma \mathbf{A}\cdot \mathrm{d}\mathbf{r}
=
\iint_\Sigma (\nabla\times \mathbf{A})\cdot \mathbf{n}\,\mathrm{d}S.
$$

### 2. 右手规则必须会看

边界方向和曲面法向不是各选各的，它们必须匹配。

![Stokes 公式中的右手规则](../assets/第11章/stokes_right_hand_rule.png)

一句话记忆：

> 右手四指沿着边界正向弯曲，拇指所指就是法向的正方向。

### 3. 核心思路：为什么它像空间版 Green 公式

Green 公式说：平面区域内部的“旋转强度总和”，等于边界上的环流。  
Stokes 公式只是把这件事搬到了空间曲面上。

所以你可以把它理解成：

> 局部旋转的总效果  
> =  
> 边界上的整体环流。

Green 公式其实就是 Stokes 公式在平面上的特例。

### 4. 例题

#### 例 1：最经典的环流题

取向量场

$$
\mathbf{A}=(-y,x,0),
$$

取单位圆

$$
\Gamma:\ x^2+y^2=1,\ z=0
$$

按从 $z$ 轴正向看去逆时针方向取向。求

$$
\oint_\Gamma \mathbf{A}\cdot \mathrm{d}\mathbf{r}.
$$

解：取 $\Gamma$ 所围成的单位圆盘 $\Sigma$ 为积分曲面，法向取上侧。  
先算旋度：

$$
\nabla\times \mathbf{A}
=
\left(0,0,\frac{\partial x}{\partial x}-\frac{\partial(-y)}{\partial y}\right)
=(0,0,2).
$$

所以

$$
\oint_\Gamma \mathbf{A}\cdot \mathrm{d}\mathbf{r}
=
\iint_\Sigma (\nabla\times \mathbf{A})\cdot \mathbf{n}\,\mathrm{d}S
=
\iint_\Sigma 2\,\mathrm{d}S
=
2\pi.
$$

如果把方向改成顺时针，答案就会变成 $-2\pi$。

### 5. 空间曲线积分与路径无关

在一维单连通区域内，若

$$
\mathbf{A}=(P,Q,R),
$$

则空间曲线积分

$$
\int_\Gamma P\,\mathrm{d}x+Q\,\mathrm{d}y+R\,\mathrm{d}z
$$

与路径无关的充分必要条件是

$$
\frac{\partial P}{\partial y}=\frac{\partial Q}{\partial x},\qquad
\frac{\partial Q}{\partial z}=\frac{\partial R}{\partial y},\qquad
\frac{\partial R}{\partial x}=\frac{\partial P}{\partial z}.
$$

也就是

$$
\nabla\times \mathbf{A}=0.
$$

这时它是某个势函数 $u(x,y,z)$ 的全微分：

$$
P\,\mathrm{d}x+Q\,\mathrm{d}y+R\,\mathrm{d}z=\mathrm{d}u.
$$

### 6. 旋度是什么

对向量场

$$
\mathbf{A}=(P,Q,R),
$$

定义

$$
\operatorname{rot}\mathbf{A}
=
\nabla\times \mathbf{A}
=
\left(
\frac{\partial R}{\partial y}-\frac{\partial Q}{\partial z},
\frac{\partial P}{\partial z}-\frac{\partial R}{\partial x},
\frac{\partial Q}{\partial x}-\frac{\partial P}{\partial y}
\right).
$$

它刻画的是一点附近的“旋转趋势”。

- 旋度越大，表示局部越有打转的倾向。
- 旋度为零，表示局部没有净旋转，称为**无旋场**。

### 7. 易错点

- Stokes 公式处理的是**闭曲线 + 它张成的曲面**，不是闭曲面。
- 最容易丢的是右手规则；边界方向和法向不匹配时，答案会差一个负号。
- 路径无关在空间里要看的是“旋度为零”，不是只盯着某一个偏导是否相等。

---
