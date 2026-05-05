# 第11章 曲线积分与曲面积分

## 三、Green 公式：闭曲线积分和二重积分之间的桥

- 和上一节的关系：第二类曲线积分是沿曲线算的，Green 公式告诉我们，某些闭曲线积分可以改成区域上的二重积分。
- 学习目标：掌握 Green 公式、正向边界、面积公式、平面路径无关条件与全微分求积。

### 1. 正向边界先搞清楚

对于平面闭区域 $D$ 的边界曲线 $L$，所谓正向，就是：

> 沿着边界前进时，区域始终在左手边。

这在单连通区域里通常就是“逆时针”。

![平面区域的正向边界](../assets/第11章/green_positive_orientation.png)

### 2. Green 公式

若 $L$ 是区域 $D$ 的正向边界，且 $P,Q$ 在 $D$ 上有一阶连续偏导数，则

$$
\oint_L P\,\mathrm{d}x+Q\,\mathrm{d}y
=
\iint_D\left(\frac{\partial Q}{\partial x}-\frac{\partial P}{\partial y}\right)\mathrm{d}x\mathrm{d}y.
$$

这就是 Green 公式。

### 3. 核心思路：它为什么合理

这部分保留核心思路就够了，不必追着每个技术细节跑。

- 对长方形区域，边界积分可以拆成四条边的积分。
- 上下边、左右边整理后，会自然出现 $\dfrac{\partial Q}{\partial x}-\dfrac{\partial P}{\partial y}$。
- 一般区域可以切成很多小块。
- 内部公共边会因为方向相反而互相抵消，只剩最外层边界。

所以它本质上是“**局部旋转累积起来，等于整体边界上的环流**”。

### 4. 一个非常好用的应用：面积公式

在 Green 公式里取

$$
P=-\frac{y}{2},\qquad Q=\frac{x}{2},
$$

就得到

$$
A(D)=\frac12\oint_L (x\,\mathrm{d}y-y\,\mathrm{d}x).
$$

这条式子非常有名，也非常好用。

#### 例 1：求椭圆面积

设椭圆

$$
x=a\cos t,\qquad y=b\sin t,\qquad 0\le t\le 2\pi.
$$

则

$$
\mathrm{d}x=-a\sin t\,\mathrm{d}t,\qquad
\mathrm{d}y=b\cos t\,\mathrm{d}t.
$$

因此

$$
x\,\mathrm{d}y-y\,\mathrm{d}x
=
ab\cos^2 t\,\mathrm{d}t+ab\sin^2 t\,\mathrm{d}t
=
ab\,\mathrm{d}t.
$$

所以

$$
A=\frac12\int_0^{2\pi}ab\,\mathrm{d}t=\pi ab.
$$

### 5. 平面曲线积分与路径无关

在**单连通区域** $G$ 内，若 $P,Q$ 有一阶连续偏导，则

$$
\int_L P\,\mathrm{d}x+Q\,\mathrm{d}y
$$

与路径无关的充分必要条件是

$$
\frac{\partial P}{\partial y}=\frac{\partial Q}{\partial x}.
$$

这条判定非常重要。

它等价于下面三句话：

- 任意两条从 $A$ 到 $B$ 的曲线，积分相同。
- 任意闭曲线上的积分为 $0$。
- 在单连通区域内有 $\dfrac{\partial P}{\partial y}=\dfrac{\partial Q}{\partial x}$。

#### 例 2：判断并求原函数

考虑

$$
2xy\,\mathrm{d}x+x^2\,\mathrm{d}y.
$$

这里

$$
P=2xy,\qquad Q=x^2.
$$

于是

$$
\frac{\partial P}{\partial y}=2x,\qquad \frac{\partial Q}{\partial x}=2x.
$$

在整个平面上它们相等，所以积分与路径无关。

再找势函数 $u$：

$$
u_x=2xy.
$$

对 $x$ 积分得

$$
u=x^2y+C(y).
$$

再对 $y$ 求偏导：

$$
u_y=x^2+C'(y).
$$

要和 $Q=x^2$ 相等，所以 $C'(y)=0$。因此可以取

$$
u=x^2y.
$$

所以

$$
2xy\,\mathrm{d}x+x^2\,\mathrm{d}y=\mathrm{d}(x^2y).
$$

### 6. 二元函数的全微分求积

在单连通区域内，

$$
P\,\mathrm{d}x+Q\,\mathrm{d}y
$$

是某个函数 $u(x,y)$ 的全微分，当且仅当

$$
\frac{\partial P}{\partial y}=\frac{\partial Q}{\partial x}.
$$

这时可以通过

$$
u(x,y)=\int_{(x_0,y_0)}^{(x,y)} P\,\mathrm{d}x+Q\,\mathrm{d}y
$$

来定义势函数，再化成显式表达式。

### 7. 一个必须记住的反例

只看

$$
\frac{\partial P}{\partial y}=\frac{\partial Q}{\partial x}
$$

还不够，**区域必须是单连通的**。

典型反例是

$$
P=-\frac{y}{x^2+y^2},\qquad Q=\frac{x}{x^2+y^2}.
$$

在去掉原点的区域里，它们满足混合偏导相等，但绕原点一圈的闭曲线积分不为 $0$。  
根本原因是：原点把区域“挖了个洞”。

### 8. 易错点

- Green 公式只用于**平面闭曲线**。
- 边界一定要取正向，否则差一个负号。
- 判路径无关时，别把“单连通”漏掉。

---
