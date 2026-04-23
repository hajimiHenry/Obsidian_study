# 第11章 曲线积分与曲面积分

## 六、Gauss 公式与散度：闭曲面上的通量怎么一下子算出来

- 和上一节的关系：上一节会算开放曲面上的通量，这一节处理的是**闭曲面**，并把它和三重积分连起来。
- 学习目标：掌握 Gauss 公式，理解散度的含义，能把闭曲面通量题改成三重积分题。

### 1. Gauss 公式

若闭区域 $\Omega$ 的边界曲面是取外侧的闭曲面 $\Sigma$，且 $P,Q,R$ 有一阶连续偏导，则

$$
\iint_\Sigma P\,\mathrm{d}y\mathrm{d}z+Q\,\mathrm{d}z\mathrm{d}x+R\,\mathrm{d}x\mathrm{d}y
=
\iiint_\Omega
\left(
\frac{\partial P}{\partial x}
+
\frac{\partial Q}{\partial y}
+
\frac{\partial R}{\partial z}
\right)\mathrm{d}V.
$$

向量形式更好记：

$$
\iint_\Sigma \mathbf{A}\cdot\mathbf{n}\,\mathrm{d}S
=
\iiint_\Omega \nabla\cdot \mathbf{A}\,\mathrm{d}V.
$$

### 2. 直觉说明

Gauss 公式说的是：

> 闭曲面向外流出的总通量  
> =  
> 内部所有“源”的总强度。

![闭曲面的外法向与向外通量](../assets/第11章/gauss_outward_flux.png)

如果你把闭曲面内部想成一个小房间，那么：

- 左边是“有多少东西从房间表面流出去了”；
- 右边是“房间里面总共制造了多少东西”。

### 3. 什么时候优先想到它

只要题目同时满足下面两个条件，就优先想 Gauss：

- 曲面是**闭曲面**。
- 被积式是第二类曲面积分，或者已经能写成 $\mathbf{A}\cdot\mathbf{n}$。

### 4. 例题

#### 例 1：球面通量

求向量场

$$
\mathbf{A}(x,y,z)=(x,y,z)
$$

通过球面

$$
x^2+y^2+z^2=a^2
$$

外侧的通量。

解：先求散度：

$$
\nabla\cdot \mathbf{A}
=
\frac{\partial x}{\partial x}
+
\frac{\partial y}{\partial y}
+
\frac{\partial z}{\partial z}
=3.
$$

球体体积为

$$
V=\frac{4}{3}\pi a^3.
$$

所以

$$
\iint_\Sigma \mathbf{A}\cdot\mathbf{n}\,\mathrm{d}S
=
\iiint_\Omega 3\,\mathrm{d}V
=
3\cdot \frac{4}{3}\pi a^3
=
4\pi a^3.
$$

这题如果直接做曲面积分会很麻烦，用 Gauss 一步就结束。

### 5. 闭曲面通量为零的条件

在合适的空间区域里，若

$$
\frac{\partial P}{\partial x}
+
\frac{\partial Q}{\partial y}
+
\frac{\partial R}{\partial z}
=0,
$$

也就是

$$
\nabla\cdot \mathbf{A}=0,
$$

那么任意闭曲面的总通量都为零。  
这类场叫**无源场**。

### 6. 散度是什么

对向量场

$$
\mathbf{A}=(P,Q,R),
$$

定义

$$
\operatorname{div}\mathbf{A}
=
\nabla\cdot\mathbf{A}
=
\frac{\partial P}{\partial x}
+
\frac{\partial Q}{\partial y}
+
\frac{\partial R}{\partial z}.
$$

它描述的是一点附近“向外发散”的强弱。

- $\operatorname{div}\mathbf{A}>0$：这里像源头，往外冒。
- $\operatorname{div}\mathbf{A}<0$：这里像汇点，往里吸。
- $\operatorname{div}\mathbf{A}=0$：这里既不净产生也不净吸收。

### 7. 易错点

- Gauss 公式只能直接用于**闭曲面**。
- 若题目给的是开曲面，要先补一个盖子把它封起来，再减去补上的那部分。
- 闭曲面默认取**外侧**。若题目写内侧，整体要变号。

---
