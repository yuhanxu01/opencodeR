# 固体物理基础
## Fundamentals of Solid State Physics

### 简介 | Introduction

固体物理研究固体的微观结构和宏观性质。从原子排列的晶体结构，到电子在晶体中的运动，再到半导体、磁性体等功能材料，固体物理涉及广泛的物理现象。固体物理既是基础理论，也是应用技术的源泉，是现代信息技术和能源技术的基础。

Solid state physics studies the microstructure and macroscopic properties of solids. From crystalline atomic arrangements to electron motion in crystals, to semiconductors and magnetic materials, solid state physics encompasses a broad range of physical phenomena. It is both fundamental theory and the source of applied technology, underpinning modern information and energy technologies.

### 晶体结构 | Crystal Structure

**晶体**是原子或分子按一定规律周期排列而成的固体。最基本的概念是晶胞和晶格。

**晶胞**是晶体结构的基本单位，其原子排列方式决定了晶体的所有性质。

**布拉维格子**是描述晶体周期结构的数学模型。三维空间有14种布拉维格子（七种晶系）。

**格矢**定义为：

$$\mathbf{R} = n_1\mathbf{a}_1 + n_2\mathbf{a}_2 + n_3\mathbf{a}_3$$

其中 $n_i$ 是整数，$\mathbf{a}_i$ 是晶胞的基矢。

**晶面和晶向**用米勒指数 $(hkl)$ 标记。对于晶面，$h, k, l$ 是在晶胞三个方向上截距倒数的最小整数比。

### 倒格矢和布里渊区 | Reciprocal Lattice and Brillouin Zone

倒格矢定义为：

$$\mathbf{b}_1 = 2\pi\frac{\mathbf{a}_2 \times \mathbf{a}_3}{\mathbf{a}_1 \cdot (\mathbf{a}_2 \times \mathbf{a}_3)}, \quad \text{及其循环置换}$$

倒格矢满足：

$$\mathbf{a}_i \cdot \mathbf{b}_j = 2\pi\delta_{ij}$$

**倒格矢的意义**：描述晶体的衍射性质。原晶体的衍射图样正好对应其倒格矢的分布。

**第一布里渊区**是倒格矢空间中的维格那-塞茨晶胞，是$k$空间中最重要的区域。第一布里渊区内的所有物理信息就足以描述晶体的电子性质。

**布拉格衍射条件**：

$$2d\sin\theta = n\lambda$$

在倒格矢语言中，当 $\mathbf{k} - \mathbf{k}' = \mathbf{G}$（倒格矢）时发生衍射。

### 晶体中的电子 | Electrons in Crystals

#### 能带论 | Band Theory

在自由电子近似中，电子可在晶体中自由运动。由于周期势的存在，电子的能量不是连续的，而是分成多个**能带**。

能带由色散关系 $E(k)$ 描述，其中 $k$ 是波矢，$|\mathbf{k}| = 2\pi/\lambda$。

对于一维单原子链，在紧束缚近似下：

$$E(k) = \epsilon_0 - 2t\cos(ka)$$

其中 $\epsilon_0$ 是原子能级，$t$ 是跳跃积分，$a$ 是晶格常数。

#### 有效质量 | Effective Mass

在晶体中运动的电子表现得仿佛具有有效质量 $m^*$：

$$m^* = \hbar^2 \left[\frac{d^2E}{dk^2}\right]^{-1}$$

在能带的底部（$k = 0$），有效质量通常为正；在能带的顶部，有效质量为负，表现为正电荷的准粒子，称为**空穴**。

#### 费米面 | Fermi Surface

在绝对零度，电子填充所有能量低于费米能 $E_F$ 的状态。在$k$空间中，所有被填充的状态的边界称为**费米面**。

费米能由电子浓度决定：

$$n = \frac{1}{(2\pi)^3}\int_{E < E_F} d^3k$$

对于自由电子气：

$$E_F = \frac{\hbar^2}{2m}(3\pi^2 n)^{2/3}$$

### 导体、半导体和绝缘体 | Conductors, Semiconductors, and Insulators

三者的区别在于电子的能带结构：

**导体**：价带和导带重叠，或价带未填满。大量电子可以在导带中自由运动，导电性好。

**绝缘体**：价带被电子填满，导带为空，两者之间有大的能隙。需要很大的能量才能激发电子，导电性差。

**半导体**：价带和导带之间有较小的能隙 $E_g$（通常0.1 ~ 3 eV）。在适当温度或掺杂下，可以有相当的导电性。

### 半导体物理 | Semiconductor Physics

#### 本征半导体 | Intrinsic Semiconductor

在绝对零度，本征半导体是绝缘体。但在有限温度，热激发会产生电子-空穴对。

载流子浓度（电子和空穴）：

$$n_i = \sqrt{n_c n_v} \exp\left(-\frac{E_g}{2k_B T}\right)$$

其中 $n_c$ 和 $n_v$ 分别是导带和价带的有效态密度。

#### 掺杂半导体 | Doped Semiconductor

**n型半导体**：掺入施主杂质（如Si中掺As）。施主能级靠近导带底，易激发电子到导带。主要载流子是电子。

$$n \approx N_D, \quad p = \frac{n_i^2}{N_D}$$

**p型半导体**：掺入受主杂质（如Si中掺B）。受主能级靠近价带顶，易从价带捕获电子产生空穴。主要载流子是空穴。

$$p \approx N_A, \quad n = \frac{n_i^2}{N_A}$$

电中性条件：$n + N_A^- = p + N_D^+$

#### pn结 | p-n Junction

在p型和n型半导体的接触处形成pn结。其核心特性是整流性。

**正向偏压**（p接n）：削弱内电场，降低势垒，电流指数增长：

$$I = I_0(e^{eV/k_B T} - 1)$$

**反向偏压**（n接p）：加强内电场，增大势垒，电流几乎为零（理想情况）。

### 晶体缺陷 | Crystal Defects

#### 点缺陷 | Point Defects

**空位**：晶格位置缺少原子。导入正电荷，可接受电子形成受主。

**间隙原子**：原子占据晶格间隙位置。作为给体，贡献电子。

**替换杂质**：外来原子替代晶格原子。可作为给体或受体。

#### 线缺陷 | Line Defects

**位错**：晶体结构的一维缺陷。刃型位错（edge dislocation）和螺型位损（screw dislocation）是两种基本类型。

位错的存在使金属能够通过滑移而塑性变形，而不是整块滑动。

**伯格矢量** $\mathbf{b}$：环绕位错的闭合路径在完美晶体中无法闭合，其差量就是伯格矢量。

#### 面缺陷 | Planar Defects

**晶界**：不同晶粒的交界面，是最常见的二维缺陷。

**堆垛层错**：偏离正常堆积顺序的层。

### 晶体振动和声子 | Crystal Vibrations and Phonons

晶体原子围绕平衡位置振动。这些集体振动可以量子化，量子称为**声子**。

**色散关系** $\omega(k)$ 描述不同频率的振动模式的能量依赖于波矢。

在长波极限（$ka \ll 1$），声子是线性的：

$$\omega = v_s |k|$$

其中 $v_s$ 是声速。

**声子的能量**：

$$E = \hbar\omega = \hbar v_s k$$

**声子的动量**：

$$p = \hbar k$$

声子在热导、光学性质等方面起重要作用。

### 磁性 | Magnetism

固体的磁性来自电子自旋和轨道角动量。

**抗磁性**：所有物质都有，由外磁场对轨道运动的影响引起，磁化率为负。

**顺磁性**：含有未配对电子的原子，在磁场中产生与外场同向的磁矩，磁化率为正但很小。

**铁磁性**：原子磁矩之间的交换相互作用产生的长程有序，导致自发磁化。典型例子是Fe、Ni、Co及其合金。

**反铁磁性**：相邻原子磁矩反平行排列，总磁矩为零。但在外磁场中有特殊的磁响应。

**居里温度** $T_C$：铁磁体的转变温度。$T > T_C$ 时变为顺磁体。

$$M(T) \propto (T_C - T)^\beta, \quad T < T_C$$

### 超导性 | Superconductivity

在临界温度 $T_c$ 以下，某些物质电阻完全消失，这就是超导现象。

**完全导电性**和**完全抗磁性**（迈茨纳效应）是超导体的两个基本特征。

**BCS理论**解释：电子通过晶格形成库帕对（Cooper pair），这些对在费米能表面形成能隙：

$$\Delta = 2\hbar\omega_D \exp\left(-\frac{2}{N(E_F)V}\right)$$

其中 $\omega_D$ 是德拜截断频率。

### 总结 | Conclusion

固体物理从微观的原子排列出发，通过能带论、量子力学等工具，解释了固体的各种宏观性质。从半导体到超导体，从磁性到光学，固体物理的理论和应用十分丰富。半导体技术的发展推动了信息时代，超导研究开辟了能源和运输的新可能。固体物理依然是凝聚态物理中最活跃的领域。
