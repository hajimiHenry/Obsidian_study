import os

md_path = r"C:\Users\Spane\Desktop\prompt_base\circuit\重构教材\circuit-Chapter7-restructured.md"

if not os.path.exists(md_path):
    print(f"[ERROR] Markdown file not found: {md_path}")
    sys.exit(1)

with open(md_path, "r", encoding="utf-8") as f:
    content = f.read()

# 进行多行或单行的精准替换
replacements = {
    # 1. 本章总流程图
    r"""> TODO 配图：本章总流程图。画一条从左到右的箭头流程：
> 「时域正弦量 $u(t),i(t)$」→「相量 $\dot U,\dot I$」→「相量电路（R/jωL/1/jωC）」→「复数代数计算（KCL/KVL/节点法/戴维南）」→「还原时域结果」。
> 箭头下方标注每一步用到的核心公式：第一步用 $\dot X=X\angle\varphi$，第二步用 $Z_R=R, Z_L=j\omega L, Z_C=1/j\omega C$，第三步用复数运算，第四步用 $x(t)=\sqrt2 X\sin(\omega t+\varphi)$。""":
    r"""![[images/chapter7_flowchart.svg|650]]""",

    # 2. 复平面
    r"""> TODO 配图：复平面。画出实轴（Re）和虚轴（Im），在复平面上标出点 $F=a+jb$，从原点出发画向量 $|F|$，标出模长 $|F|$ 和辐角 $\varphi$。旁边写出 $a=|F|\cos\varphi$、$b=|F|\sin\varphi$ 和 $|F|=\sqrt{a^2+b^2}$、$\varphi=\arctan(b/a)$。再画一个小图展示点在四个象限时 $\varphi$ 的实际取值。""":
    r"""**(a) 复平面表示**
![[images/chapter7_complex_plane_a.svg|450]]

**(b) 四象限辐角修正**
![[images/chapter7_complex_plane_b.svg|450]]""",

    # 3. 同频波形对比
    r"""> TODO 配图：两个同频正弦量 $u(t)$ 和 $i(t)$ 的波形对比图。横轴为 $\omega t$（弧度），画两个完整周期。纵轴为电压和电流。蓝色实线画 $u=U_m\sin(\omega t+\varphi_u)$，红色虚线画 $i=I_m\sin(\omega t+\varphi_i)$。在波形上标出：最大值 $U_m$、$I_m$，初相位 $\varphi_u$（$u$ 从零上升的位置）、$\varphi_i$、相位差 $\varphi_{ui}=\varphi_u-\varphi_i$（用大括号标出两条曲线过零点之间的距离），周期 $T=2\pi/\omega$。再标注频率 $f=1/T$。""":
    r"""![[images/chapter7_sin_waveforms.svg|500]]""",

    # 4. 画两张相量图
    r"""> TODO 配图：画两张相量图示例。
> 图1（串联RLC电路）：以 $\dot I=I\angle0^\circ$ 为水平参考，在原点画出 $\dot U_R$ 与 $\dot I$ 同方向、$\dot U_L$ 超前 $90^\circ$ 垂直向上、$\dot U_C$ 滞后 $90^\circ$ 垂直向下，然后用虚线做平行四边形画出 $\dot U_s = \dot U_R+\dot U_L+\dot U_C$，标出相位差角 $\varphi$。
> 图2（并联RLC电路）：以 $\dot U=U\angle0^\circ$ 为水平参考，画出 $\dot I_R$ 同方向、$\dot I_L$ 滞后 $90^\circ$ 向下、$\dot I_C$ 超前 $90^\circ$ 向上，虚线做平行四边形画出 $\dot I_s = \dot I_R+\dot I_L+\dot I_C$。""":
    r"""**(a) 串联 RLC 电路电压相量图**
![[images/chapter7_phasor_diagrams_a.svg|450]]

**(b) 并联 RLC 电路电流相量图**
![[images/chapter7_phasor_diagrams_b.svg|450]]""",

    # 5. KCL KVL
    r"""> TODO 配图：一个节点的相量 KCL 图和一个回路的相量 KVL 图。
> 左图（KCL）：画一个节点，流入电流相量 $\dot I_1$、$\dot I_2$，流出电流相量 $\dot I_3$、$\dot I_4$。旁边标注 $\dot I_1+\dot I_2-\dot I_3-\dot I_4=0$。
> 右图（KVL）：画一个闭合回路，标出各元件电压 $\dot U_1$、$\dot U_2$、$\dot U_3$、$\dot U_4$ 的极性（+/-），旁边标注 $\dot U_1+\dot U_2-\dot U_3+\dot U_4=0$（沿回路绕行方向）。""":
    r"""**(a) KCL 节点电流相量**
![[images/chapter7_kcl_kvl_a.svg|400]]

**(b) KVL 回路电压相量**
![[images/chapter7_kcl_kvl_b.svg|450]]""",

    # 6. RLC 模型对照
    r"""> TODO 配图：R、L、C 在时域和相量域的模型对照图；标出 $R$、$j\omega L$、$1/(j\omega C)$。""":
    r"""**(a) 电阻元件对照**
![[images/chapter7_rlc_models_a.svg|500]]

**(b) 电感元件对照**
![[images/chapter7_rlc_models_b.svg|500]]

**(c) 电容元件对照**
![[images/chapter7_rlc_models_c.svg|500]]""",

    # 7. RLC 串联阻抗
    r"""> TODO 配图：RLC 串联相量电路、阻抗三角形、串联阻抗分压示意图。""":
    r"""**(a) RLC 串联相量电路**
![[images/chapter7_rlc_series_a.svg|500]]

**(b) 阻抗三角形**
![[images/chapter7_rlc_series_b.svg|450]]

**(c) 串联阻抗分压示意图**
![[images/chapter7_rlc_series_c.svg|500]]""",

    # 8. RLC 并联导纳
    r"""> TODO 配图：RLC 并联相量电路、导纳并联分流示意图。""":
    r"""**(a) RLC 并联相量电路**
![[images/chapter7_rlc_parallel_a.svg|500]]

**(b) 导纳并联分流示意图**
![[images/chapter7_rlc_parallel_b.svg|500]]""",

    # 9. 串联电路
    r"""> TODO 配图：串联电路：电源 $u_s$ → 电阻 $R=3\Omega$ → 电感 $L=2\mathrm H$ → 二端网络 $N$（方框标注 $Z=R_1+jX_1$），标出端口电流 $i$ 和端口电压 $u_s$。""":
    r"""![[images/chapter7_series_network.svg|500]]""",

    # 10. 混联电路
    r"""> TODO 配图：R、L、C 混联电路图。电源 $u_s$ 串联电感 $L$，然后并联两个支路——电容 $C$ 支路和电阻 $R$ 支路。标出 $u_s$、$i_L$（流过电感和电源的总电流）、$i_R$（流过电阻）、$i_C$（流过电容）、$u$（电阻两端电压）。""":
    r"""![[images/chapter7_mixed_circuit.svg|500]]""",

    # 11. 例 7.4-2
    r"""> TODO 配图：例 7.4-2 电路图。两个独立节点 a 和 b。左侧：电压源 $\dot U_{s1}$ 通过 $j4\Omega$ 阻抗连接到节点 a。中间：节点 a 和 b 之间接一条 $3\Omega$ 电阻支路和一条 $j4\Omega$ 支路并联。右侧：节点 b 通过 $-j4\Omega$ 连接到电压源 $\dot U_{s2}$，再通过 $4\Omega$ 连接到电压源 $\dot U_{s3}$（接地）。标出待求电流 $i_1$（流过 $3\Omega$ 的电流，方向 a→地）和 $i_2$（流过 $4\Omega$ 的电流，方向 b→地）。""":
    r"""![[images/chapter7_example_7_4_2.svg|500]]""",

    # 12. 例 7.4-3
    r"""> TODO 配图：例 7.4-3 含受控源单回路电路图。一个串联回路：独立电压源 $\dot U_s=10\angle0^\circ$ → $5\Omega$ 电阻 → $j10\Omega$ 感抗 → 受控电压源 $0.4\dot U_1$（控制电压 $\dot U_1$ 是 $(5+j10)$ 两端电压，标出控制关系虚线箭头）→ $-j20\Omega$ 容抗 → 回到电源。标出回路电流 $\dot I$。""":
    r"""![[images/chapter7_example_7_4_3.svg|500]]""",

    # 13. 例 7.4-4
    r"""> TODO 配图：例 7.4-4 四张子图。
> 子图(a)原电路：左半部分含独立电压源 $u_s=10\sqrt2\sin(100t)$（相量 $\dot U_s=10\angle0^\circ$）和独立电流源 $i_s=2\sqrt2\sin(100t+60^\circ)$（相量 $\dot I_s=2\angle60^\circ$），含 $8\Omega$ 电阻、$1250\mu\mathrm F$ 电容（容抗 $-j8\Omega$）、$6\Omega$ 电阻、$2\Omega$ 电阻。右半部分含一个 $0.1\mathrm H$ 电感（感抗 $j10\Omega$）和 $1\Omega$ 电阻串联——这是目标支路，电流为 $i$。
> 子图(b)求 $\dot U_{oc}$（电压源单独作用）：电流源置零（开路），画出分压电路，标出 $\dot U_{oc}'$。
> 子图(c)求 $\dot U_{oc}''$（电流源单独作用）：电压源置零（短路），画出含 $8\Omega$ 与 $(6+2)\Omega$ 并联再与 $-j8\Omega$ 串联的阻抗网络，标出 $\dot U_{oc}''$。
> 子图(d)求 $Z_o$：所有独立源置零后从目标支路端口看入的等效阻抗。
> 子图(e)戴维南等效：$\dot U_{oc}$ 串联 $Z_o$ 串联 $Z_L=(1+j10)\Omega$，标出电流 $\dot I$。""":
    r"""**(a) 原电路**
![[images/chapter7_example_7_4_4_a.svg|550]]

**(b) 求 $\dot{U}_{oc}'$ (电压源单独作用)**
![[images/chapter7_example_7_4_4_b.svg|450]]

**(c) 求 $\dot{U}_{oc}''$ (电流源单独作用)**
![[images/chapter7_example_7_4_4_c.svg|550]]

**(d) 求等效阻抗 $Z_o$**
![[images/chapter7_example_7_4_4_d.svg|450]]

**(e) 戴维南等效电路**
![[images/chapter7_example_7_4_4_e.svg|450]]""",

    # 14. i=0
    r"""> TODO 配图：含源电路，其中一条支路标 $i=0$，用虚线框标出该支路两端的节点 a 和 b。在图中标注 $\dot U_a=\dot U_b$。""":
    r"""![[images/chapter7_zero_current.svg|500]]""",

    # 15. 功率三角形
    r"""> TODO 配图：功率三角形。直角三角形，横轴直角边标 $P$（有功功率/W），纵轴直角边标 $Q$（无功功率/Var），斜边标 $S$（视在功率/VA），$P$ 和 $S$ 之间的夹角标 $\varphi$（功率因数角）。旁边标注关系：$S^2=P^2+Q^2$, $\cos\varphi=P/S$, $\tan\varphi=Q/P$。""":
    r"""![[images/chapter7_power_triangle.svg|500]]""",

    # 16. 例 7.5-1
    r"""> TODO 配图：例 7.5-1 的 R-L 串联相量图。画 $\dot I$ 为水平参考相量（$0^\circ$）。画出 $\dot U_R$ 与 $\dot I$ 同方向。画出 $\dot U_L$ 超前 $\dot I$ $90^\circ$（垂直向上）。用虚线做平行四边形得 $\dot U_s=\dot U_R+\dot U_L$。标出 $\dot U_s$ 和 $\dot I$ 之间的夹角 $\varphi$（感性，$\varphi>0$）。标出各电压数值：$U_s=100\mathrm V$, $U_R=86.6\mathrm V$, $U_L=50\mathrm V$。""":
    r"""![[images/chapter7_example_7_5_1_phasor.svg|450]]""",

    # 17. 例 7.5-2
    r"""> TODO 配图：例 7.5-2 电路图。串联电路：交流电源 $\dot U_s=10\angle45^\circ$ → 电容 $C$（容抗 $X_C=2.5\Omega$，标出 $\dot U_C=5\angle-135^\circ$）→ 二端网络 $N$（方框标注 $Z=?$），标出 $N$ 两端电压 $\dot U$ 和串联电流 $\dot I$。""":
    r"""![[images/chapter7_example_7_5_2.svg|500]]""",

    # 18. 原例 7.5-3
    r"""> TODO 配图：原例 7.5-3 电路图。含一个电压源、一个电流源、两个电阻和若干电感电容的相量电路图，标出各支路电流参考方向。""":
    r"""![[images/chapter7_example_7_5_3.svg|500]]""",

    # 19. 例 7.5-4
    r"""> TODO 配图：例 7.5-4 并联负载和补偿电容图。$220\mathrm V$ 交流电源母线上并联三个负载支路：支路 1 是 50 只日光灯等效阻抗 $Z_1$（感性，$\cos\varphi_1=0.5$），支路 2 是 50 只白炽灯等效电阻 $Z_2$（阻性，$\cos\varphi_2=1$），支路 3 是补偿电容 $C$（容性，纯无功）。标出总电流 $\dot I$、$\dot I_1$、$\dot I_2$ 和电容电流 $\dot I_C$。""":
    r"""![[images/chapter7_example_7_5_4.svg|550]]""",

    # 20. 最大功率传输
    r"""> TODO 配图：最大功率传输戴维南等效电路。左边：戴维南等效电压源 $\dot U_s$（相量），串联等效阻抗 $Z_o=R_o+jX_o$（标出实部和虚部）。右边：负载阻抗 $Z_L=R_L+jX_L$。标出串联电流 $\dot I$。下方附文字：共轭匹配条件 $Z_L=Z_o^*$（$R_L=R_o$, $X_L=-X_o$），最大功率 $P_{L\max}=U_s^2/(4R_o)$。""":
    r"""![[images/chapter7_max_power_transfer.svg|500]]""",

    # 21. RLC 串联谐振相量图
    r"""> TODO 配图：RLC 串联谐振相量图。以 $\dot I$ 为水平参考（$0^\circ$）。画出 $\dot U_R$ 与 $\dot I$ 同方向，标为 $\dot U_R=\dot U_s$。画出 $\dot U_L$ 垂直向上（$+90^\circ$），画出 $\dot U_C$ 垂直向下（$-90^\circ$），$\dot U_L$ 和 $\dot U_C$ 长度相等方向相反。标出 $U_L=U_C=QU_s$。框内注明：谐振时 $\omega_0=1/\sqrt{LC}$，$Z=R$（最小），$I=U_s/R$（最大）。""":
    r"""![[images/chapter7_series_resonance.svg|500]]""",

    # 22. RLC 频率特性
    r"""> TODO 配图：三张串联 RLC 频率特性曲线图（横轴均为 $\omega$，纵轴分别为 $|Z|$、$\varphi_Z$、$I$）。""":
    r"""**(a) 阻抗幅频特性**
![[images/chapter7_frequency_response_a.svg|450]]

**(b) 阻抗相频特性**
![[images/chapter7_frequency_response_b.svg|450]]

**(c) 电流幅频特性**
![[images/chapter7_frequency_response_c.svg|450]]""",

    # 23. 并联谐振
    r"""> TODO 配图：两张子图。
> 子图1（并联谐振电路）：电流源 $i_s$ 并联 $R$、$L$、$C$ 三个元件，标出 $\dot I_s$、$\dot I_R$、$\dot I_L$、$\dot I_C$ 和端电压 $\dot U$。
> 子图2（谐振时电流相量图）：以 $\dot U$ 为水平参考（$0^\circ$）。画出 $\dot I_R$ 与 $\dot U$ 同方向，标为 $\dot I_R=\dot I_s$。画出 $\dot I_L$ 垂直向下（滞后 $90^\circ$），画出 $\dot I_C$ 垂直向上（超前 $90^\circ$），$\dot I_L$ 和 $\dot I_C$ 长度相等方向相反。标出 $I_L=I_C=QI_s$。框内注明：谐振时 $\omega_0=1/\sqrt{LC}$，$Y=G$（最小），$U=I_s/G$（最大）。""":
    r"""**(a) 并联谐振电路**
![[images/chapter7_parallel_resonance_a.svg|500]]

**(b) 并联谐振电流相量图**
![[images/chapter7_parallel_resonance_b.svg|500]]""",

    # 24. 例 7.6-2
    r"""> TODO 配图：例 7.6-2 电路图。电源 $u=100\sqrt2\sin(100t)$，两个 $100\Omega$ 电阻 $R_1$ 和 $R_2$，两个 $1\mathrm H$ 电感 $L_1$ 和 $L_2$。$R_1$ 与 $L_1$ 串联后再与 $L_2$（并联电容 $C$）串联。标出各支路电流 $i_1$（流过 $R_1$ 和 $L_1$）、$i_2$（流过 $R_2$，是题目要求调零的那条支路）、$i_3$（流过 $C$）、$i_4$（流过 $L_2$）。用虚线框圈出 $L_2$ 与 $C$ 组成的并联谐振部分。""":
    r"""![[images/chapter7_example_7_6_2.svg|550]]"""
}

# 逐一替换
for original, replacement in replacements.items():
    # 规范换行符
    original_normalized = original.replace("\r\n", "\n")
    replacement_normalized = replacement.replace("\r\n", "\n")
    content_normalized = content.replace("\r\n", "\n")
    
    if original_normalized in content_normalized:
        content = content_normalized.replace(original_normalized, replacement_normalized)
        print(f"[INFO] Successfully replaced matching TODO.")
    else:
        # 部分匹配或包含微小换行差异时
        # 我们进行不带回车的逐行替换或者提醒
        print(f"[WARN] Failed to find exact match for TODO:\n{original[:60]}...")

with open(md_path, "w", encoding="utf-8") as f:
    f.write(content)
print("[INFO] Markdown update finished.")
