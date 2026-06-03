# 第七章 正弦稳态电路的分析

> 重构版教材。以原教材知识框架为边界，以课后习题 7.1~7.17 为导向，删去过长的数学证明，只保留“为什么要这样想、做题时怎么用”。本章默认采用原教材的**正弦函数参考**：  
> 若 $x(t)=\sqrt2 X\sin(\omega t+\varphi)$，则相量为 $\dot X=X\angle\varphi$。

---

## 本章先解决什么问题

前面章节主要处理直流电路和暂态过程；本章处理的是：

$$
\boxed{\text{线性动态电路}+\text{正弦激励}+\text{已经进入稳态}}
$$

在这个条件下，电路中所有电压、电流都是与激励**同频率**的正弦量。相量法的目的，就是把微分、积分问题变成复数代数问题：

$$
\text{时域正弦量}
\longrightarrow
\text{相量}
\longrightarrow
\text{阻抗/导纳电路}
\longrightarrow
\text{复数代数计算}
\longrightarrow
\text{回到时域}
$$

本章课后题基本分成六类：

- 7.1~7.3：正弦量与相量互换；
- 7.4~7.10：阻抗、导纳、相量电路计算；
- 7.11~7.13：功率因数、有功功率、无功功率；
- 7.14：最大功率传输；
- 7.15：含源电路功率；
- 7.16~7.17：谐振和综合最大值问题。

### 12 小时学习路线

| 时间段 | 内容 | 覆盖题目 |
|--------|------|----------|
| 第 1-2 小时 | §7.1 复数运算 + §7.2 正弦量与相量互换 | 7.1~7.3 |
| 第 3-5 小时 | §7.3 元件相量形式、阻抗与导纳 | 7.4~7.8 |
| 第 6-8 小时 | §7.4 相量电路分析法（节点法/网孔法/戴维南） | 7.9~7.10 |
| 第 9-11 小时 | §7.5 功率 + 最大功率传输 | 7.11~7.15 |
| 第 12 小时 | §7.6 谐振 | 7.16~7.17 |

> **使用建议**：每学完一个时间段的内容，立刻做对应题目。做不出来就回头看例题，不要硬想。12 小时后进入 5 天刷题阶段，遇到卡住的题直接定位回上表对应章节。

![[images/chapter7_flowchart.svg|650]]

---

## 7.1 复数的基本概念

相量本质上是复数，所以必须先会复数的两种常用表示形式和四则运算。

### 7.1.1 复数的表示

一个复数可以写成代数形式：

$$
F=a+jb
$$

其中 $a=\operatorname{Re}[F]$ 是实部，$b=\operatorname{Im}[F]$ 是虚部，$j=\sqrt{-1}$。

也可以写成极坐标形式：

$$
F=|F|\angle\varphi
$$

两种形式的互换为：

$$
|F|=\sqrt{a^2+b^2},\qquad
\varphi=\arctan\frac{b}{a}
$$

$$
a=|F|\cos\varphi,\qquad b=|F|\sin\varphi
$$

做题时要注意象限。尤其是 $a<0$ 时，不能只靠计算器给出的 $\arctan(b/a)$，必须结合复平面判断角度。

> **计算器象限纠正**：$\arctan$ 返回值在 $(-90^\circ,90^\circ)$。若点在第二象限（$a<0,b>0$），实际角度 = 计算器结果 $+180^\circ$；若在第三象限（$a<0,b<0$），实际角度 = 计算器结果 $-180^\circ$（或 $+180^\circ$）。

**(a) 复平面表示**
![[images/chapter7_complex_plane_a.svg|450]]

**(b) 四象限辐角修正**
![[images/chapter7_complex_plane_b.svg|450]]

### 7.1.2 复数的特性

做相量题常用的复数规则只有四类。

**1. 相等**

$$
a_1+jb_1=a_2+jb_2
$$

等价于：

$$
a_1=a_2,\qquad b_1=b_2
$$

或：

$$
|F_1|=|F_2|,\qquad \varphi_1=\varphi_2
$$

**2. 加减用代数形式**

$$
(a_1+jb_1)\pm(a_2+jb_2)
=(a_1\pm a_2)+j(b_1\pm b_2)
$$

电路中 KCL、KVL 需要相量相加减时，通常先化成 $a+jb$。

**3. 乘除用极坐标形式**

$$
|F_1|\angle\varphi_1\cdot |F_2|\angle\varphi_2
=|F_1||F_2|\angle(\varphi_1+\varphi_2)
$$

$$
\frac{|F_1|\angle\varphi_1}{|F_2|\angle\varphi_2}
=\frac{|F_1|}{|F_2|}\angle(\varphi_1-\varphi_2)
$$

阻抗乘电流、电压除阻抗这类题，用极坐标形式最省事。

**4. 乘以 $j$ 是旋转 $90^\circ$**

$$
j=1\angle90^\circ,\qquad -j=1\angle(-90^\circ)
$$

所以：

$$
jF:\text{逆时针转 }90^\circ,\qquad
-jF:\text{顺时针转 }90^\circ
$$

这条是理解电感、电容相位关系的核心。

### 例题 7.1-1：复数加法与除法

已知：

$$
F_1=16-j9,\qquad F_2=20\angle135^\circ
$$

求 $F_1+F_2$ 和 $F_1/F_2$。

**解：**

求和用代数形式：

$$
F_2=20(\cos135^\circ+j\sin135^\circ)
=-14.14+j14.14
$$

$$
F_1+F_2=(16-j9)+(-14.14+j14.14)
=1.86+j5.14
$$

转成极坐标：

$$
|F_1+F_2|=\sqrt{1.86^2+5.14^2}=5.47
$$

$$
\varphi=\arctan\frac{5.14}{1.86}=70.1^\circ
$$

所以：

$$
\boxed{F_1+F_2=5.47\angle70.1^\circ}
$$

求除法先把 $F_1$ 转成极坐标：

$$
|F_1|=\sqrt{16^2+(-9)^2}=18.36,\qquad
\varphi_1=-29.36^\circ
$$

$$
F_1=18.36\angle(-29.36^\circ)
$$

于是：

$$
\frac{F_1}{F_2}
=\frac{18.36\angle(-29.36^\circ)}{20\angle135^\circ}
=0.918\angle(-164.36^\circ)
$$

如果需要代数形式：

$$
0.918\angle(-164.36^\circ)
=-0.88-j0.25
$$

---

## 7.2 正弦量的相量表示

相量法不是把正弦量“变没了”，而是只保留正弦量做题最需要的两个信息：

$$
\boxed{\text{有效值}}\qquad
\boxed{\text{初相位}}
$$

频率 $\omega$ 在同频正弦稳态电路中统一隐含，最后回到时域时再写回来。

---

## 7.2.1 正弦量的基本概念

正弦电压、电流通常写成：

$$
u(t)=U_m\sin(\omega t+\varphi_u)
$$

$$
i(t)=I_m\sin(\omega t+\varphi_i)
$$

其中：

- $U_m,I_m$：最大值；
- $\omega$：角频率，单位 rad/s；
- $f$：频率，单位 Hz；
- $T$：周期，单位 s；
- $\varphi_u,\varphi_i$：初相位。

三者关系：

$$
\omega=2\pi f,\qquad f=\frac1T,\qquad T=\frac1f
$$

正弦有效值：

$$
U=\frac{U_m}{\sqrt2},\qquad I=\frac{I_m}{\sqrt2}
$$

因此常写成：

$$
u(t)=\sqrt2 U\sin(\omega t+\varphi_u)
$$

$$
i(t)=\sqrt2 I\sin(\omega t+\varphi_i)
$$

### 相位差

电压与电流的相位差定义为：

$$
\varphi_{ui}=\varphi_u-\varphi_i
$$

- $\varphi_{ui}>0$：电压超前电流；
- $\varphi_{ui}<0$：电压滞后电流，也就是电流超前电压；
- $\varphi_{ui}=0$：同相；
- $\varphi_{ui}=\pm180^\circ$：反相；
- $\varphi_{ui}=\pm90^\circ$：正交。

做题时不要比较 $\omega t+\varphi$ 里的全部相位。两个正弦量同频时，相位差就是初相位之差。

![[images/chapter7_sin_waveforms.svg|500]]

### 例题 7.2-1：读正弦量三要素

已知：

$$
u=220\sqrt2\sin(314t+45^\circ)\ \mathrm V
$$

$$
i=20\sqrt2\sin(314t-30^\circ)\ \mathrm A
$$

求最大值、有效值、角频率、频率、周期、初相位和相位差。

**解：**

电压：

$$
U=220\ \mathrm V,\qquad U_m=220\sqrt2=311\ \mathrm V
$$

电流：

$$
I=20\ \mathrm A,\qquad I_m=20\sqrt2=28.28\ \mathrm A
$$

共同角频率：

$$
\omega=314\ \mathrm{rad/s}
$$

频率和周期：

$$
f=\frac{\omega}{2\pi}=\frac{314}{2\times3.14}=50\ \mathrm{Hz}
$$

$$
T=\frac1f=0.02\ \mathrm s
$$

初相位：

$$
\varphi_u=45^\circ,\qquad \varphi_i=-30^\circ
$$

相位差：

$$
\varphi_{ui}=45^\circ-(-30^\circ)=75^\circ
$$

所以电压超前电流 $75^\circ$。

### 例题 7.2-2：由有效值、频率、初相位写表达式

某正弦电压有效值为 $110$ V，电流有效值为 $5$ A，频率都是 $100$ Hz，初相位分别为 $-40^\circ$ 和 $-30^\circ$。写出电压和电流表达式。

**解：**

$$
\omega=2\pi f=2\times3.14\times100=628\ \mathrm{rad/s}
$$

$$
\boxed{u=110\sqrt2\sin(628t-40^\circ)\ \mathrm V}
$$

$$
\boxed{i=5\sqrt2\sin(628t-30^\circ)\ \mathrm A}
$$

---

## 7.2.2 正弦量的相量表示

原教材采用正弦函数作为参考，因此：

$$
\boxed{x(t)=\sqrt2 X\sin(\omega t+\varphi)
\Longleftrightarrow
\dot X=X\angle\varphi}
$$

其中 $X$ 是有效值，不是最大值。

电压、电流分别写成：

$$
u(t)=\sqrt2 U\sin(\omega t+\varphi_u)
\Longleftrightarrow
\dot U=U\angle\varphi_u
$$

$$
i(t)=\sqrt2 I\sin(\omega t+\varphi_i)
\Longleftrightarrow
\dot I=I\angle\varphi_i
$$

相量 $\dot U,\dot I$ 是复数，但它不等于瞬时值 $u(t),i(t)$。相量只记录有效值和初相位。

### 做题中最容易错的点

若题目给的是余弦函数，必须先改写成正弦函数：

$$
\cos(\omega t+\theta)=\sin(\omega t+\theta+90^\circ)
$$

因此：

$$
X_m\cos(\omega t+\theta)
=X_m\sin(\omega t+\theta+90^\circ)
$$

对应相量为：

$$
\dot X=\frac{X_m}{\sqrt2}\angle(\theta+90^\circ)
$$

### 例题 7.2-3：由正弦量写相量

已知：

$$
i=\sqrt2\cos(314t+30^\circ)\ \mathrm A
$$

$$
u=311\sin(314t-60^\circ)\ \mathrm V
$$

写出相量。

**解：**

电流先把余弦改成正弦：

$$
i=\sqrt2\sin(314t+120^\circ)\ \mathrm A
$$

有效值为 $1$ A，所以：

$$
\boxed{\dot I=1\angle120^\circ\ \mathrm A}
$$

电压最大值 $311$ V，有效值：

$$
U=\frac{311}{\sqrt2}=220\ \mathrm V
$$

所以：

$$
\boxed{\dot U=220\angle(-60^\circ)\ \mathrm V}
$$

### 例题 7.2-4：由相量写正弦表达式

已知频率 $f=500$ Hz，两个电流相量：

$$
\dot I_1=100\angle\frac{2\pi}{3}\ \mathrm A,\qquad
\dot I_2=10\angle0^\circ\ \mathrm A
$$

写出时域表达式。

**解：**

$$
\omega=2\pi f=1000\pi\approx3140\ \mathrm{rad/s}
$$

$$
\frac{2\pi}{3}=120^\circ
$$

所以：

$$
\boxed{i_1=100\sqrt2\sin(3140t+120^\circ)\ \mathrm A}
$$

$$
\boxed{i_2=10\sqrt2\sin(3140t)\ \mathrm A}
$$

### 相量图的画法（题 7.2、7.5 必考）

相量图就是把各相量画在复平面上，直观看出相位关系。

**画法三步**：

1. **选参考相量**：串联电路取电流为参考（$\dot I=I\angle0^\circ$，画在水平向右）；并联电路取电压为参考（$\dot U=U\angle0^\circ$）
2. **推各元件相量方向**：电阻电压/电流与参考**同相**；电感电压超前电流 $90^\circ$（逆时针）；电容电压滞后电流 $90^\circ$（顺时针）
3. **合成**：用平行四边形法则做向量加减

> **角度归一化**：结果角度超出 $(-180^\circ,180^\circ]$ 或 $[0^\circ,360^\circ)$ 范围时，加减 $360^\circ$ 的整数倍归一化。例如 $-240^\circ \rightarrow 120^\circ$（加 $360^\circ$）。

**(a) 串联 RLC 电路电压相量图**
![[images/chapter7_phasor_diagrams_a.svg|450]]

**(b) 并联 RLC 电路电流相量图**
![[images/chapter7_phasor_diagrams_b.svg|450]]

---

## 7.2.3 相量的性质

相量有三条直接服务解题的性质。

### 1. 线性性质

同频正弦量可以先变成相量再相加：

$$
i=K_1i_1\pm K_2i_2
\Longleftrightarrow
\dot I=K_1\dot I_1\pm K_2\dot I_2
$$

所以多个同频正弦量相加时，不要在时域硬套三角函数公式，直接做复数加减。

### 2. 微分性质

若：

$$
y=\frac{\mathrm di}{\mathrm dt}
$$

则：

$$
\dot Y=j\omega \dot I
$$

微分在相量域里等价于乘 $j\omega$。

### 3. 积分性质

若：

$$
y=\int i\,\mathrm dt
$$

则：

$$
\dot Y=\frac{\dot I}{j\omega}
$$

积分在相量域里等价于除以 $j\omega$。

这就是相量法能把动态元件微分方程变成代数方程的原因。

### 例题 7.2-5：相量处理加法、微分、积分

已知：

$$
i_1=10\sqrt2\sin(314t+60^\circ)\ \mathrm A
$$

$$
i_2=22\sqrt2\sin(314t-150^\circ)\ \mathrm A
$$

求 $i_1+i_2$、$\mathrm di_1/\mathrm dt$、$\int i_2\mathrm dt$。

**解：**

先写相量：

$$
\dot I_1=10\angle60^\circ=5+j8.66
$$

$$
\dot I_2=22\angle(-150^\circ)=-19.05-j11
$$

**(1) 相加**

$$
\dot I=\dot I_1+\dot I_2=-14.05-j2.34
$$

$$
\dot I=14.24\angle(-170.54^\circ)
$$

所以：

$$
\boxed{i_1+i_2=14.24\sqrt2\sin(314t-170.54^\circ)\ \mathrm A}
$$

**(2) 微分**

$$
\frac{\mathrm di_1}{\mathrm dt}
\Longleftrightarrow
j314\dot I_1
$$

$$
j314\cdot10\angle60^\circ
=3140\angle150^\circ
$$

所以：

$$
\boxed{\frac{\mathrm di_1}{\mathrm dt}
=3140\sqrt2\sin(314t+150^\circ)}
$$

**(3) 积分**

$$
\int i_2\,\mathrm dt
\Longleftrightarrow
\frac{\dot I_2}{j314}
$$

$$
\frac{22\angle(-150^\circ)}{314\angle90^\circ}
=0.07\angle(-240^\circ)
=0.07\angle120^\circ
$$

所以：

$$
\boxed{\int i_2\,\mathrm dt
=0.07\sqrt2\sin(314t+120^\circ)}
$$

---

## 7.3 电路定律的相量形式

进入相量域以后，电路分析的骨架没有变：

$$
\boxed{\text{KCL、KVL 仍然成立}}
$$

变化的是：电压、电流变成相量，电阻、电感、电容变成阻抗或导纳。

---

## 7.3.1 基尔霍夫定律的相量形式

### KCL 的相量形式

时域：

$$
\sum i_k(t)=0
$$

相量域：

$$
\boxed{\sum \dot I_k=0}
$$

### KVL 的相量形式

时域：

$$
\sum u_k(t)=0
$$

相量域：

$$
\boxed{\sum \dot U_k=0}
$$

理解上很简单：同频正弦量的代数和仍是同频正弦量，所以可以把所有项一起变成相量。

**(a) KCL 节点电流相量**
![[images/chapter7_kcl_kvl_a.svg|400]]

**(b) KVL 回路电压相量**
![[images/chapter7_kcl_kvl_b.svg|450]]

### 例题 7.3-1：相量形式的 KCL 与 KVL

已知某电路中：

$$
\dot U_s=100\angle0^\circ\ \mathrm V,\quad
\dot I_s=8\angle0^\circ\ \mathrm A
$$

$$
\dot U_1=100\angle60^\circ\ \mathrm V,\quad
\dot I_2=8\angle90^\circ\ \mathrm A,\quad
\dot I_3=2\angle(-90^\circ)\ \mathrm A
$$

求 $\dot I_1,\dot U_2$。

**解：**

由节点 KCL：

$$
\dot I_1=\dot I_3+\dot I_2-\dot I_s
$$

代入：

$$
\dot I_1=(-j2)+j8-8=-8+j6
$$

$$
\boxed{\dot I_1=10\angle143.13^\circ\ \mathrm A}
$$

由回路 KVL：

$$
\dot U_2=\dot U_s-\dot U_1
$$

$$
\dot U_1=100\angle60^\circ=50+j86.6
$$

$$
\dot U_2=100-(50+j86.6)=50-j86.6
$$

$$
\boxed{\dot U_2=100\angle(-60^\circ)\ \mathrm V}
$$

---

## 7.3.2 电路元件伏安关系的相量形式

### 电阻

时域：

$$
u_R=Ri_R
$$

相量域：

$$
\boxed{\dot U_R=R\dot I_R}
$$

电阻电压和电流同相：

$$
\varphi_u=\varphi_i
$$

### 电感

时域：

$$
u_L=L\frac{\mathrm di_L}{\mathrm dt}
$$

相量域：

$$
\boxed{\dot U_L=j\omega L\dot I_L}
$$

电感阻抗：

$$
\boxed{Z_L=j\omega L=jX_L}
$$

其中：

$$
X_L=\omega L
$$

电感电压超前电流 $90^\circ$。频率越高，感抗越大；直流时 $\omega=0$，电感相当于短路。

### 电容

时域：

$$
i_C=C\frac{\mathrm du_C}{\mathrm dt}
$$

相量域：

$$
\dot I_C=j\omega C\dot U_C
$$

也可写成：

$$
\boxed{\dot U_C=\frac{1}{j\omega C}\dot I_C}
$$

电容阻抗：

$$
\boxed{Z_C=\frac1{j\omega C}=-\frac{j}{\omega C}=-jX_C}
$$

其中：

$$
X_C=\frac1{\omega C}
$$

电容电压滞后电流 $90^\circ$，也就是电容电流超前电压 $90^\circ$。频率越高，容抗越小；直流时 $\omega=0$，电容相当于开路。

### 受控源

线性受控源的控制系数是常数，所以相量域中关系保持同样形式：

$$
\dot U_2=\mu \dot U_1,\qquad
\dot I_2=g\dot U_1,\qquad
\dot U_2=r\dot I_1,\qquad
\dot I_2=\alpha \dot I_1
$$

做含受控源题时，把受控源当作普通源列方程，不要因为进入相量域就把控制关系丢掉。

**(a) 电阻元件对照**
![[images/chapter7_rlc_models_a.svg|500]]

**(b) 电感元件对照**
![[images/chapter7_rlc_models_b.svg|500]]

**(c) 电容元件对照**
![[images/chapter7_rlc_models_c.svg|500]]

---

## 7.3.3 复数阻抗

阻抗的作用，是把一个正弦稳态二端网络看成“复数版电阻”：

$$
\boxed{\dot U=Z\dot I}
$$

对于 RLC 串联：

$$
Z=R+jX
$$

其中：

$$
X=X_L-X_C=\omega L-\frac1{\omega C}
$$

所以：

$$
\boxed{Z=R+j\left(\omega L-\frac1{\omega C}\right)}
$$

阻抗也可写成极坐标：

$$
Z=|Z|\angle\varphi_Z
$$

其中：

$$
|Z|=\sqrt{R^2+X^2}
$$

$$
\varphi_Z=\arctan\frac{X}{R}
$$

### 阻抗角的意义

由 $\dot U=Z\dot I$：

$$
|\dot U|=|Z||\dot I|
$$

$$
\varphi_u-\varphi_i=\varphi_Z
$$

所以，阻抗角决定端电压与端电流的相位差。

- $X>0$，$\varphi_Z>0$：感性，电压超前电流；
- $X<0$，$\varphi_Z<0$：容性，电压滞后电流；
- $X=0$，$\varphi_Z=0$：阻性，电压与电流同相。

### 阻抗串联

串联阻抗直接相加：

$$
\boxed{Z_{\mathrm eq}=Z_1+Z_2+\cdots+Z_n}
$$

注意：

$$
|Z_1+Z_2|\ne |Z_1|+|Z_2|
$$

必须做复数加法。

串联分压：

$$
\boxed{\dot U_j=\frac{Z_j}{\sum Z_k}\dot U}
$$

**(a) RLC 串联相量电路**
![[images/chapter7_rlc_series_a.svg|500]]

**(b) 阻抗三角形**
![[images/chapter7_rlc_series_b.svg|450]]

**(c) 串联阻抗分压示意图**
![[images/chapter7_rlc_series_c.svg|500]]

---

## 7.3.4 复数导纳

导纳是阻抗的倒数：

$$
\boxed{Y=\frac1Z}
$$

相量关系：

$$
\boxed{\dot I=Y\dot U}
$$

对于 RLC 并联：

$$
Y=\frac1R+\frac1{j\omega L}+j\omega C
$$

整理为：

$$
\boxed{Y=G+jB}
$$

其中：

$$
G=\frac1R,\qquad
B=\omega C-\frac1{\omega L}
$$

导纳也可写成：

$$
Y=|Y|\angle\varphi_Y
$$

且：

$$
|Y|=\frac1{|Z|},\qquad \varphi_Y=-\varphi_Z
$$

### 导纳并联

并联导纳直接相加：

$$
\boxed{Y_{\mathrm eq}=Y_1+Y_2+\cdots+Y_n}
$$

若用阻抗表示：

$$
\boxed{\frac1{Z_{\mathrm eq}}=\frac1{Z_1}+\frac1{Z_2}+\cdots+\frac1{Z_n}}
$$

两个阻抗并联：

$$
\boxed{Z_{\mathrm eq}=\frac{Z_1Z_2}{Z_1+Z_2}}
$$

并联分流：

$$
\boxed{\dot I_j=\frac{Y_j}{\sum Y_k}\dot I}
$$

两个阻抗并联时也可写成：

$$
\dot I_1=\frac{Z_2}{Z_1+Z_2}\dot I,\qquad
\dot I_2=\frac{Z_1}{Z_1+Z_2}\dot I
$$

**(a) RLC 并联相量电路**
![[images/chapter7_rlc_parallel_a.svg|500]]

**(b) 导纳并联分流示意图**
![[images/chapter7_rlc_parallel_b.svg|500]]

### 例题 7.3-2：RLC 串联电压相量合成

已知 RLC 串联电路中：

$$
U_R=20\ \mathrm V,\qquad U_L=15\ \mathrm V,\qquad U_C=30\ \mathrm V
$$

求电源电压有效值 $U_s$。

**解：**

串联电路电流相同，取电流为参考相量：

$$
\dot I=I\angle0^\circ
$$

则：

$$
\dot U_R=20\angle0^\circ=20
$$

$$
\dot U_L=15\angle90^\circ=j15
$$

$$
\dot U_C=30\angle(-90^\circ)=-j30
$$

由 KVL：

$$
\dot U_s=\dot U_R+\dot U_L+\dot U_C
=20+j15-j30=20-j15
$$

$$
\dot U_s=25\angle(-36.87^\circ)\ \mathrm V
$$

所以：

$$
\boxed{U_s=25\ \mathrm V}
$$

### 例题 7.3-3：RLC 并联电流合成

已知 RLC 并联电路：

$$
R=400\Omega,\qquad L=1\mathrm H,\qquad C=40\mu\mathrm F
$$

且：

$$
i_R=0.01\sin(100t)\ \mathrm A
$$

求电流源 $i_s$。

**解：**

电阻电流有效值：

$$
I_R=\frac{0.01}{\sqrt2}=0.007\ \mathrm A
$$

$$
\dot I_R=0.007\angle0^\circ\ \mathrm A
$$

并联电压：

$$
\dot U=R\dot I_R=400\times0.007=2.8\angle0^\circ\ \mathrm V
$$

电感阻抗：

$$
Z_L=j\omega L=j100
$$

电容阻抗：

$$
Z_C=\frac1{j\omega C}
=\frac1{j\cdot100\cdot40\times10^{-6}}
=-j250
$$

支路电流：

$$
\dot I_L=\frac{\dot U}{j100}=0.028\angle(-90^\circ)=-j0.028
$$

$$
\dot I_C=\frac{\dot U}{-j250}=0.0112\angle90^\circ=j0.0112
$$

总电流：

$$
\dot I_s=\dot I_R+\dot I_L+\dot I_C
=0.007-j0.0168
$$

$$
\dot I_s=0.0182\angle(-67.38^\circ)\ \mathrm A
$$

所以：

$$
\boxed{i_s=0.0182\sqrt2\sin(100t-67.38^\circ)\ \mathrm A}
$$

### 例题 7.3-4：已知端电压和端电流反求等效阻抗（对应题 7.6）

已知二端网络 $N$ 与 $R=3\Omega$、$L=2\mathrm H$ 串联，端口电压 $u_s=30\sqrt2\sin(2t)\ \mathrm V$，端口电流 $i=5\sqrt2\sin(2t)\ \mathrm A$。求 $N$ 的等效阻抗。

![[images/chapter7_series_network.svg|500]]

**解：**

写出相量：

$$
\dot U_s=30\angle0^\circ\ \mathrm V,\qquad \dot I=5\angle0^\circ\ \mathrm A
$$

$R$ 和 $L$ 的阻抗：

$$
Z_{RL}=R+j\omega L=3+j\cdot2\cdot2=3+j4\ \Omega
$$

总阻抗：

$$
Z_{\text{总}}=\frac{\dot U_s}{\dot I}=\frac{30}{5}=6\ \Omega
$$

因为 $Z_{\text{总}}=Z_{RL}+Z_N$，所以：

$$
Z_N=Z_{\text{总}}-Z_{RL}=6-(3+j4)=3-j4\ \Omega
$$

阻抗角：

$$
\varphi_Z=\arctan\frac{-4}{3}=-53.13^\circ
$$

$N$ 为容性（$X<0$）。

---

## 7.4 正弦稳态电路的相量分析

相量法做题就是三步。

### 标准流程

1. **变换**：把正弦源写成相量，把 R、L、C 写成阻抗或导纳。
2. **计算**：在相量电路中使用电阻电路方法，如 KCL、KVL、节点法、网孔法、叠加、戴维南等。
3. **还原**：把求得的相量变回时域正弦表达式。

### 适用前提

相量法直接使用的前提是：

$$
\boxed{\text{所有正弦激励频率相同}}
$$

如果电路中有不同频率的正弦源，不能把不同频率的相量直接相加。正确做法是：每个频率分别计算，再把时域响应相加。

非正弦周期激励可以展开成直流分量和各次谐波；直流分量用直流电路方法，各次谐波分别用相量法，最后在时域叠加。这就是谐波分析法。

### 例题 7.4-1：由已知支路电流求其它量

已知某并联支路中：

$$
i_R=\sqrt2\sin(2000t)\ \mathrm A
$$

电阻 $R=200\Omega$，电感 $L=0.1\mathrm H$，电容 $C=5\mu\mathrm F$。求 $u_s,i_L,i_C$。

![[images/chapter7_mixed_circuit.svg|500]]

**解：**

电阻电流相量：

$$
\dot I_R=1\angle0^\circ\ \mathrm A
$$

感抗：

$$
X_L=\omega L=2000\times0.1=200\ \Omega
$$

容抗：

$$
X_C=\frac1{\omega C}
=\frac1{2000\times5\times10^{-6}}=100\ \Omega
$$

电阻电压（也是电容电压）：

$$
\dot U=R\dot I_R=200\angle0^\circ\ \mathrm V
$$

电容电流：

$$
\dot I_C=\frac{\dot U}{-j100}
=2\angle90^\circ=j2\ \mathrm A
$$

由 KCL：

$$
\dot I_L=\dot I_R+\dot I_C=1+j2
=2.24\angle63.43^\circ\ \mathrm A
$$

电感电压：

$$
\dot U_L=j200\ \dot I_L
=j200(1+j2)=j200-400
=447.2\angle153.43^\circ\ \mathrm V
$$

电源电压由 KVL 合成：

$$
\dot U_s=\dot U+\dot U_L
=200+(-400+j200)
=-200+j200
=282.8\angle135^\circ\ \mathrm V
$$

所以（注意 $282.8\sqrt2\approx400$）：

$$
\boxed{u_s=400\sin(2000t+135^\circ)\ \mathrm V
=282.8\sqrt2\sin(2000t+135^\circ)\ \mathrm V}
$$

$$
\boxed{i_L=2.24\sqrt2\sin(2000t+63.43^\circ)\ \mathrm A}
$$

$$
\boxed{i_C=2\sqrt2\sin(2000t+90^\circ)\ \mathrm A}
$$

### 例题 7.4-2：节点电压法

正弦稳态电路中，若已知多个电压源相量，求支路电流，流程与直流节点法相同，只是电阻换成复阻抗。

![[images/chapter7_example_7_4_2.svg|500]]

**做题骨架：**

1. 选参考节点，设未知节点电压 $\dot U_a,\dot U_b$；
2. 对每个非参考节点列 KCL；
3. 每条支路电流写成“节点电压差/阻抗”；
4. 解复数方程；
5. 用 $\dot I=\dot U/Z$ 求目标支路电流；
6. 若题目要求时域，再把 $\dot I$ 还原成 $i(t)$。

原例结果形式为：

$$
\dot I_1=3.53\angle(-135^\circ)\ \mathrm A
$$

$$
\dot I_2=3.53\angle135^\circ\ \mathrm A
$$

若 $\omega=314\ \mathrm{rad/s}$，则：

$$
i_1=5\sin(314t-135^\circ)\ \mathrm A
$$

$$
i_2=5\sin(314t+135^\circ)\ \mathrm A
$$

### 例题 7.4-3：含受控源的相量方程

含受控源题的关键不是新方法，而是不要把控制量忘掉。

![[images/chapter7_example_7_4_3.svg|500]]

若支路电压：

$$
\dot U_1=(5+j10)\dot I
$$

受控源为 $0.4\dot U_1$，回路 KVL 可写成：

$$
(5+j10)\dot I+0.4\dot U_1-j20\dot I=\dot U_s
$$

代入 $\dot U_s=10\angle0^\circ$ 后解得：

$$
\boxed{\dot I=1.085\angle40.6^\circ\ \mathrm A}
$$

做题时把受控源当作电源处理，但控制关系必须同时列入方程。

### 例题 7.4-4：戴维南定理与叠加

复杂电路要求某一支路电流时，常把该支路拿掉，对外部网络求戴维南等效：

$$
\dot I=\frac{\dot U_{oc}}{Z_o+Z_L}
$$

**(a) 原电路**
![[images/chapter7_example_7_4_4_a.svg|550]]

**(b) 求 $\dot{U}_{oc}'$ (电压源单独作用)**
![[images/chapter7_example_7_4_4_b.svg|450]]

**(c) 求 $\dot{U}_{oc}''$ (电流源单独作用)**
![[images/chapter7_example_7_4_4_c.svg|550]]

**(d) 求等效阻抗 $Z_o$**
![[images/chapter7_example_7_4_4_d.svg|450]]

**(e) 戴维南等效电路**
![[images/chapter7_example_7_4_4_e.svg|450]]

原例的关键步骤：

1. 断开电感支路，求开路电压 $\dot U_{oc}$；
2. 多个同频源共同作用时，可在相量域用叠加求 $\dot U_{oc}$；
3. 独立电压源置零为短路，独立电流源置零为开路，求等效阻抗 $Z_o$；
4. 接回电感阻抗 $j\omega L$，用一条串联支路求电流。

原例计算得到：

$$
\dot U_{oc}=14.98\angle4.6^\circ\ \mathrm V
$$

$$
Z_o=4-j4\ \Omega
$$

电感支路总阻抗为：

$$
Z_o+1+j10=5+j6
$$

所以：

$$
\dot I=1.92\angle(-45.6^\circ)\ \mathrm A
$$

若 $\omega=100\ \mathrm{rad/s}$：

$$
\boxed{i=1.92\sqrt2\sin(100t-45.6^\circ)\ \mathrm A}
$$

### 例题 7.4-5：某支路电流为零的反求问题（对应题 7.10）

题 7.10 的典型题型：已知某支路电流为零，反求电路参数或电源值。核心是 **「支路电流为零 → 该支路两端电位相等」**。

![[images/chapter7_zero_current.svg|500]]

**解题套路**：

1. 设 $i=0$ 支路两端的节点电压 $\dot U_a$ 和 $\dot U_b$
2. 因 $i=0$，支路两端电压相等：$\dot U_a=\dot U_b$
3. 分别从两侧电路用分压/分流公式写出 $\dot U_a$ 和 $\dot U_b$ 的表达式
4. 令两表达式相等，解出未知量

本质上就是**交流电桥平衡条件**：$Z_1Z_4=Z_2Z_3$（比直流电桥多了一个相位条件）。

---

## 7.5 正弦稳态电路的功率

正弦稳态电路中，瞬时功率 $p(t)=u(t)i(t)$ 会随时间变化，有时为正，有时为负。为了描述“真正消耗多少”和“交换能量规模多大”，引入有功功率、无功功率、视在功率和复功率。

---

## 7.5.1 二端网络的正弦稳态功率

设无源二端网络端电压、电流取关联参考方向：

$$
u=\sqrt2 U\sin(\omega t+\varphi_u)
$$

$$
i=\sqrt2 I\sin(\omega t+\varphi_i)
$$

相位差：

$$
\varphi=\varphi_u-\varphi_i
$$

### 有功功率

有功功率是一个周期内瞬时功率的平均值：

$$
\boxed{P=UI\cos\varphi}
$$

单位 W。它表示真正被电阻消耗、转化为热或机械输出的功率。

功率因数：

$$
\boxed{\cos\varphi}
$$

功率因数越接近 1，说明电源输出中真正做功的比例越高。

### 视在功率

$$
\boxed{S=UI}
$$

单位 VA。它表示电源和设备容量上的“总规模”。

### 无功功率

$$
\boxed{Q=UI\sin\varphi}
$$

单位 Var。它表示电感、电容与电源之间交换能量的规模。

- 电感：$Q>0$；
- 电容：$Q<0$；
- 电阻：$Q=0$。

### 功率三角形

$$
\boxed{S^2=P^2+Q^2}
$$

$$
\boxed{\cos\varphi=\frac{P}{S}}
$$

$$
\boxed{\tan\varphi=\frac{Q}{P}}
$$

![[images/chapter7_power_triangle.svg|500]]

### 功率公式速查表

| 已知条件 | 求有功 $P$ | 求无功 $Q$ | 求视在 $S$ |
|---------|-----------|-----------|-----------|
| $U,I,\varphi$ | $UI\cos\varphi$ | $UI\sin\varphi$ | $UI$ |
| $I,R,X$ | $I^2R$ | $I^2X$ | $I^2\sqrt{R^2+X^2}$ |
| $U,|Z|,\varphi$ | $\frac{U^2}{|Z|}\cos\varphi$ | $\frac{U^2}{|Z|}\sin\varphi$ | $\frac{U^2}{|Z|}$ |
| 复功率 $\tilde S$ | $\operatorname{Re}[\tilde S]$ | $\operatorname{Im}[\tilde S]$ | $|\tilde S|$ |

> 做题技巧：如果已知电流有效值 $I$ 和阻抗 $Z=R+jX$，直接用 $P=I^2R$ 和 $Q=I^2X$，比用 $UI\cos\varphi$ 更快且不用求 $\varphi$。

### 用阻抗计算功率

若：

$$
Z=R+jX
$$

且电流有效值为 $I$，则：

$$
\boxed{P=I^2R}
$$

$$
\boxed{Q=I^2X}
$$

$$
\boxed{S=I^2|Z|}
$$

若用电压：

$$
P=\frac{U^2R}{|Z|^2},\qquad
Q=\frac{U^2X}{|Z|^2}
$$

### 复功率

定义：

$$
\boxed{\tilde S=\dot U\dot I^*}
$$

其中 $\dot I^*$ 是电流相量的共轭。

于是：

$$
\boxed{\tilde S=P+jQ}
$$

复功率可以把有功、无功统一在一个复数里。多个元件或支路的复功率可以直接相加：

$$
\tilde S=\sum \tilde S_k
$$

但视在功率一般不能直接相加：

$$
S\ne S_1+S_2+\cdots
$$

### 功率因数校正

多数感性负载电流滞后电压，$Q>0$。并联电容提供负无功 $Q_C<0$，可以抵消一部分感性无功，提高功率因数。

做这类题的思路：

1. 先由原负载求 $P,Q$；
2. 目标功率因数给出目标角 $\varphi'$；
3. 目标无功 $Q'=P\tan\varphi'$；
4. 需要电容补偿：

$$
Q_C=Q'-Q
$$

5. 并联电容无功：

$$
Q_C=-\frac{U^2}{X_C}=-\omega C U^2
$$

从而求 $C$。

### 例题 7.5-1：由电压和有功功率求 R、L

R、L 串联电路中，电源有效值 $U_s=100$ V，角频率 $\omega=1000$ rad/s，电感电压有效值 $U_L=50$ V，电路吸收有功功率 $P=200$ W。求 $R,L$。

![[images/chapter7_example_7_5_1_phasor.svg|450]]

**解：**

R-L 串联中，$\dot U_R$ 与 $\dot I$ 同相，$\dot U_L$ 超前 $\dot I$ $90^\circ$，所以：

$$
U_s^2=U_R^2+U_L^2
$$

$$
U_R=\sqrt{100^2-50^2}=86.6\ \mathrm V
$$

有功功率由电阻消耗：

$$
P=\frac{U_R^2}{R}
$$

$$
R=\frac{U_R^2}{P}
=\frac{86.6^2}{200}=37.5\Omega
$$

电流：

$$
I=\frac{U_R}{R}=\frac{86.6}{37.5}=2.31\ \mathrm A
$$

感抗：

$$
X_L=\frac{U_L}{I}=\frac{50}{2.31}=21.65\Omega
$$

电感：

$$
L=\frac{X_L}{\omega}=\frac{21.65}{1000}=21.65\ \mathrm{mH}
$$

### 例题 7.5-2：由端电压电流求二端网络功率

无源二端网络 $N$ 与电容串联。已知：

$$
u_s=10\sqrt2\sin(314t+45^\circ)\ \mathrm V
$$

$$
u_C=5\sqrt2\sin(314t-135^\circ)\ \mathrm V
$$

电容容抗 $X_C=2.5\Omega$。求 $N$ 的等效阻抗、有功功率和无功功率。

![[images/chapter7_example_7_5_2.svg|500]]

**解：**

相量为：

$$
\dot U_s=10\angle45^\circ
$$

$$
\dot U_C=5\angle(-135^\circ)
$$

二端网络端电压：

$$
\dot U=\dot U_s-\dot U_C
=15\angle45^\circ\ \mathrm V
$$

电容阻抗 $Z_C=-j2.5=2.5\angle(-90^\circ)$，所以串联电流：

$$
\dot I=\frac{\dot U_C}{Z_C}
=\frac{5\angle(-135^\circ)}{2.5\angle(-90^\circ)}
=2\angle(-45^\circ)\ \mathrm A
$$

二端网络阻抗：

$$
Z=\frac{\dot U}{\dot I}
=\frac{15\angle45^\circ}{2\angle(-45^\circ)}
=7.5\angle90^\circ=j7.5\Omega
$$

因此 $N$ 是纯感性：

$$
P=UI\cos90^\circ=0
$$

$$
Q=UI\sin90^\circ=15\times2=30\ \mathrm{Var}
$$

### 例题 7.5-3：用功率守恒求电源发出功率

含电压源、电流源和多个元件的电路中，要求电源发出的总有功功率，常用功率守恒：

$$
\boxed{\text{电源发出的总有功功率}
=\text{所有电阻吸收的有功功率之和}}
$$

> **为什么只看电阻**：电感和电容不消耗有功功率（$P_L=UI\cos90^\circ=0$，$P_C=UI\cos(-90^\circ)=0$），它们只与电源来回交换无功功率。所以总有功功率必定全部消耗在电阻上。

![[images/chapter7_example_7_5_3.svg|500]]

原例中求得两个电阻电流：

$$
\dot I_1=7.21\angle(-70.62^\circ)\ \mathrm A
$$

$$
\dot I_2=2.83\angle(-171.93^\circ)\ \mathrm A
$$

因此电阻吸收有功功率：

$$
P=1\cdot I_1^2+2\cdot I_2^2
$$

$$
P=7.21^2+2\times2.83^2=68.16\ \mathrm W
$$

所以电压源和电流源发出的总有功功率为：

$$
\boxed{68.16\ \mathrm W}
$$

### 例题 7.5-4：并联电容提高功率因数

50 只日光灯：每只 $60$ W，功率因数 $0.5$，感性。  
50 只白炽灯：每只 $100$ W，阻性。  
并联到 $220$ V、$50$ Hz 电源上。求原功率因数；若提高到 $0.92$，求并联电容。

![[images/chapter7_example_7_5_4.svg|550]]

**解题主线：**

日光灯总有功：

$$
P_1=50\times60=3000\ \mathrm W
$$

功率因数 $0.5$，所以：

$$
\varphi_1=60^\circ
$$

日光灯电流：

$$
I_1=\frac{P_1}{U\cos\varphi_1}
=\frac{3000}{220\times0.5}=27.27\ \mathrm A
$$

白炽灯总有功：

$$
P_2=50\times100=5000\ \mathrm W
$$

白炽灯阻性：

$$
I_2=\frac{5000}{220}=22.73\ \mathrm A
$$

取电压为参考：

$$
\dot I_1=27.27\angle(-60^\circ)
$$

$$
\dot I_2=22.73\angle0^\circ
$$

总电流：

$$
\dot I=\dot I_1+\dot I_2=36.37-j23.62
=43.37\angle(-33^\circ)\ \mathrm A
$$

原功率因数：

$$
\boxed{\cos33^\circ=0.839}
$$

若目标功率因数为 $0.92$：

$$
\varphi'=\arccos0.92=23.07^\circ
$$

$$
\tan\varphi'=\tan23.07^\circ=0.426
$$

补偿后有功电流分量仍为 $36.37$ A（电容不提供有功），无功电流分量应为：

$$
36.37\tan\varphi'=36.37\times0.426=15.49\ \mathrm A
$$

原无功电流为 $23.62$ A，电容需要提供的超前电流为：

$$
I_C=23.62-15.49=8.13\ \mathrm A
$$

并联电容：

$$
X_C=\frac{U}{I_C}=\frac{220}{8.13}=27.06\ \Omega
$$

$$
C=\frac1{\omega X_C}
=\frac1{314\times27.06}
=117.7\ \mu\mathrm F
$$

> 关键理解：并联电容只补偿无功，不改变有功。所以 $P$ 不变、$I$ 的有功分量不变，只有无功分量被抵消一部分。

---

## 7.5.2 最大功率传输

对负载 $Z_L$ 来说，前面的含源二端网络可用戴维南等效表示：

$$
\dot U_s\ \text{串联}\ Z_o
$$

其中：

$$
Z_o=R_o+jX_o
$$

负载：

$$
Z_L=R_L+jX_L
$$

负载吸收有功功率：

$$
P_L=I^2R_L
$$

$$
I=\frac{U_s}{|Z_o+Z_L|}
$$

所以：

$$
P_L=
\frac{U_s^2R_L}{(R_o+R_L)^2+(X_o+X_L)^2}
$$

### 情况一：负载电阻和电抗都可调

最大功率条件：

$$
\boxed{Z_L=Z_o^*}
$$

即：

$$
\boxed{R_L=R_o,\qquad X_L=-X_o}
$$

这称为共轭匹配。

最大功率：

$$
\boxed{P_{L\max}=\frac{U_s^2}{4R_o}}
$$

### 情况二：负载只能是纯电阻

若：

$$
Z_L=R_L
$$

最大功率条件：

$$
\boxed{R_L=|Z_o|=\sqrt{R_o^2+X_o^2}}
$$

这称为模匹配。

最大功率：

$$
\boxed{
P_{L\max}
=\frac{U_s^2|Z_o|}{(R_o+|Z_o|)^2+X_o^2}
}
$$

等价写法：

$$
P_{L\max}=\frac{U_s^2}{2(R_o+|Z_o|)}
$$

在同一电源等效下，共轭匹配得到的最大功率大于模匹配。

![[images/chapter7_max_power_transfer.svg|500]]

### 例题 7.5-5：两种匹配条件

已知戴维南电压：

$$
\dot U_s=20\angle0^\circ\ \mathrm V
$$

等效阻抗：

$$
Z_o=5-j5\ \Omega
$$

求负载为纯电阻、负载为可变复阻抗时的最大功率条件和最大功率。

**解：**

**(1) 纯电阻负载**

$$
|Z_o|=\sqrt{5^2+(-5)^2}=7.07\Omega
$$

所以：

$$
\boxed{R_L=7.07\Omega}
$$

最大功率：

$$
P_{L\max}
=\frac{20^2\times7.07}{(5+7.07)^2+(-5)^2}
=16.57\ \mathrm W
$$

**(2) 可变复阻抗负载**

共轭匹配：

$$
\boxed{Z_L=Z_o^*=5+j5\Omega}
$$

最大功率：

$$
P_{L\max}=\frac{20^2}{4\times5}=20\ \mathrm W
$$

---

## 7.6 电路的谐振

谐振不是“电路电压或电流一定很大”的同义词。谐振的定义是：

$$
\boxed{\text{含 L、C 的无源二端网络端电压与端电流同相}}
$$

也就是等效阻抗角为 $0$，或等效导纳角为 $0$。

---

## 7.6.1 RLC 串联电路的谐振

RLC 串联阻抗：

$$
Z=R+j\left(\omega L-\frac1{\omega C}\right)
$$

谐振要求虚部为零：

$$
\omega L-\frac1{\omega C}=0
$$

所以谐振角频率：

$$
\boxed{\omega_0=\frac1{\sqrt{LC}}}
$$

谐振频率：

$$
\boxed{f_0=\frac1{2\pi\sqrt{LC}}}
$$

### 串联谐振的特征

谐振时：

$$
X_L=X_C
$$

$$
Z=R
$$

电流最大：

$$
\boxed{I_0=\frac{U_s}{R}}
$$

电源电压全部落在电阻上：

$$
\dot U_s=\dot U_R
$$

电感电压和电容电压大小相等、方向相反：

$$
\boxed{\dot U_L=-\dot U_C}
$$

所以串联谐振也叫**电压谐振**。

![[images/chapter7_series_resonance.svg|500]]

### 频率特性

当 $\omega<\omega_0$：

$$
X_L<X_C
$$

电路呈容性。

当 $\omega=\omega_0$：

$$
X_L=X_C
$$

电路呈阻性，电流最大。

当 $\omega>\omega_0$：

$$
X_L>X_C
$$

电路呈感性。

**(a) 阻抗幅频特性**
![[images/chapter7_frequency_response_a.svg|450]]

**(b) 阻抗相频特性**
![[images/chapter7_frequency_response_b.svg|450]]

**(c) 电流幅频特性**
![[images/chapter7_frequency_response_c.svg|450]]
> 图1（幅频 $|Z|$）：曲线在 $\omega=\omega_0$ 处取最小值 $R$，左右两侧上升。标出 $\omega_0$ 位置。
> 图2（相频 $\varphi_Z$）：曲线在 $\omega<\omega_0$ 时 $<0$（容性），$\omega=\omega_0$ 时 $=0$，$\omega>\omega_0$ 时 $>0$（感性）。范围 $(-90^\circ,90^\circ)$。
> 图3（电流 $I$）：曲线在 $\omega=\omega_0$ 处取最大值 $I_0=U_s/R$，左右两侧下降趋于 0。标出 $I_0$。再在同一图上画两条虚线曲线表示 Q 值更大时的电流曲线（更尖锐）。

### 品质因数

串联谐振品质因数：

$$
\boxed{Q=\frac1R\sqrt{\frac LC}}
$$

也可写成：

$$
\boxed{Q=\frac{\omega_0L}{R}=\frac1{\omega_0CR}}
$$

谐振时：

$$
\boxed{U_L=U_C=QU_s}
$$

所以若 $Q$ 很大，电感或电容两端电压可能远大于电源电压。这是串联谐振能选频、也可能造成过电压风险的原因。

> **Q 值的物理意义**：$Q$ 越大 → 谐振曲线越尖锐 → 选频能力越强。在谐振频率附近，$Q$ 高的电路对偏离谐振频率的信号衰减更快（即通频带更窄）。做题时只需要记：谐振时 $U_L=U_C=QU_s$（串联），$I_L=I_C=QI_s$（并联）。

---

## 7.6.2 RLC 并联电路的谐振

RLC 并联导纳：

$$
Y=G+j\left(\omega C-\frac1{\omega L}\right)
$$

谐振要求虚部为零：

$$
\omega C-\frac1{\omega L}=0
$$

所以：

$$
\boxed{\omega_0=\frac1{\sqrt{LC}}}
$$

### 并联谐振的特征

谐振时：

$$
Y=G
$$

导纳最小，等效阻抗最大。

若电流源有效值 $I_s$ 一定，则端电压最大：

$$
U=\frac{I_s}{G}=RI_s
$$

电感电流与电容电流大小相等、方向相反：

$$
\boxed{\dot I_L=-\dot I_C}
$$

电源电流全部流过电阻：

$$
\dot I_s=\dot I_R
$$

所以并联谐振也叫**电流谐振**。

并联谐振品质因数：

$$
\boxed{Q=R\sqrt{\frac CL}}
$$

谐振时：

$$
\boxed{I_L=I_C=QI_s}
$$

**(a) 并联谐振电路**
![[images/chapter7_parallel_resonance_a.svg|500]]

**(b) 并联谐振电流相量图**
![[images/chapter7_parallel_resonance_b.svg|500]]

### 例题 7.6-1：求谐振角频率

某二端网络等效阻抗可整理为：

$$
Z=5+j\left(0.5\omega-\frac{5000}{\omega}\right)
$$

求谐振角频率。

**解：**

谐振要求阻抗虚部为零：

$$
0.5\omega-\frac{5000}{\omega}=0
$$

$$
0.5\omega^2=5000
$$

$$
\omega^2=10000
$$

$$
\boxed{\omega_0=100\ \mathrm{rad/s}}
$$

### 例题 7.6-2：由支路电流为零判断局部谐振

题设调节电容 $C$，使某支路电流 $i_2=0$。这通常意味着该支路两侧的某个 L-C 并联部分发生电流抵消：

$$
\dot I_L+\dot I_C=0
$$

也就是：

$$
\frac1{j\omega L}+j\omega C=0
$$

整理：

$$
\omega C-\frac1{\omega L}=0
$$

所以：

$$
\boxed{C=\frac1{\omega^2L}}
$$

原例中：

$$
\omega=100\ \mathrm{rad/s},\qquad L=1\ \mathrm H
$$

所以：

$$
C=\frac1{100^2\times1}=10^{-4}\ \mathrm F=100\ \mu\mathrm F
$$

后续支路电流按相量欧姆定律计算。原例结果：

$$
i_1=\sqrt2\sin(100t-45^\circ)\ \mathrm A
$$

$$
i_4=\sqrt2\sin(100t-45^\circ)\ \mathrm A
$$

$$
i_3=\sqrt2\sin(100t+135^\circ)\ \mathrm A
$$

![[images/chapter7_example_7_6_2.svg|550]]

---

## 课后题训练定位

| 题号 | 主要训练点 | 对应知识位置 |
|---|---|---|
| 7.1 | 正弦量三要素、有效值、频率、周期、相位差 | §7.2.1 |
| 7.2 | 正弦量写相量、相量图 | §7.2.2 |
| 7.3 | 相量写回正弦表达式 | §7.2.2 |
| 7.4 | RL 串联阻抗与相量欧姆定律 | §7.3.2、§7.4 |
| 7.5 | RC 并联支路电流与相量图 | §7.3.4、例 7.3-3 |
| 7.6 | 二端网络等效阻抗 | §7.3.3、§7.3.4 |
| 7.7 | 含受控源正弦稳态电路 | 例 7.4-3 |
| 7.8 | 已知电容电流反求电阻 | §7.3.2、§7.4 |
| 7.9 | 网孔电流法，多个同频正弦源 | §7.4 |
| 7.10 | 已知某支路电流为零，反求电流源（交流电桥平衡） | §7.4（节点电压法 + 支路电流为零 → 两端等电位） |
| 7.11 | 功率因数，由等效阻抗角判断 | §7.5.1 |
| 7.12 | 多负载并联的 P、Q、功率因数合成 | §7.5.1 |
| 7.13 | 由端电压、端电流求 P、Q | §7.5.1、例 7.5-2 |
| 7.14 | 最大功率传输，共轭匹配与模匹配 | §7.5.2、例 7.5-5 |
| 7.15 | 电源发出功率，功率守恒或复功率 | §7.5.1、例 7.5-3 |
| 7.16 | RLC 并联谐振，谐振时各支路电流相对大小与 Q 值 | §7.6.2 |
| 7.17 | 戴维南等效 + 负载调整求最大电流（谐振+匹配综合） | §7.4、§7.5.2、§7.6 |

---

## 本章最小闭环

1. 会在 $a+jb$ 与 $|F|\angle\varphi$ 之间转换，知道加减用代数形式、乘除用极坐标形式。
2. 会把 $\sqrt2X\sin(\omega t+\varphi)$ 写成 $\dot X=X\angle\varphi$，也能反向写回时域。
3. 会把 R、L、C 写成 $R$、$j\omega L$、$1/(j\omega C)$。
4. 会在相量电路中使用 KCL、KVL、节点法、网孔法、叠加和戴维南定理。
5. 会判断阻抗角：感性电压超前电流，容性电流超前电压，阻性同相。
6. 会计算 $P=UI\cos\varphi$、$Q=UI\sin\varphi$、$S=UI$、$\tilde S=\dot U\dot I^*$。
7. 会区分最大功率传输的两种条件：可调复阻抗用共轭匹配，纯电阻负载用模匹配。
8. 会判断谐振：串联看阻抗虚部为零，并联看导纳虚部为零，本质都是端电压与端电流同相。

---

## 本教材例题索引

| 例题 | 知识点 | 对应习题 |
|---|---|---|
| 例 7.1-1 | 复数形式转换、加法、除法 | 7.2、7.3 前置基础 |
| 例 7.2-1 | 正弦量三要素和相位差 | 7.1 |
| 例 7.2-2 | 由有效值和初相位写正弦表达式 | 7.1 |
| 例 7.2-3 | 正弦量写相量，余弦转正弦 | 7.2 |
| 例 7.2-4 | 相量写回正弦函数 | 7.3 |
| 例 7.2-5 | 相量的线性、微分、积分性质 | 7.2~7.4 |
| 例 7.3-1 | KCL、KVL 的相量形式 | 7.5、7.9、7.10 |
| 例 7.3-2 | 串联 RLC 电压相量合成 | 7.4、7.6 |
| 例 7.3-3 | 并联 RLC 电流相量合成 | 7.5 |
| 例 7.3-4 | 已知端电压电流反求等效阻抗 | 7.6 |
| 例 7.4-1 | 相量电路基本计算 | 7.4、7.5 |
| 例 7.4-2 | 节点电压法 | 7.9、7.10 |
| 例 7.4-3 | 含受控源相量方程 | 7.7 |
| 例 7.4-4 | 戴维南定理与叠加 | 7.14、7.17 |
| 例 7.4-5 | 支路电流为零反求参数 | 7.10 |
| 例 7.5-1 | R-L 电路功率反求参数 | 7.11 |
| 例 7.5-2 | 二端网络阻抗、有功和无功 | 7.13 |
| 例 7.5-3 | 功率守恒求电源发出功率 | 7.15 |
| 例 7.5-4 | 功率因数校正 | 7.12 |
| 例 7.5-5 | 最大功率传输 | 7.14 |
| 例 7.6-1 | 由虚部为零求谐振频率 | 7.16 |
| 例 7.6-2 | 局部并联谐振与支路电流抵消 | 7.16、7.17 |
