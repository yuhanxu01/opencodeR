# 规范论与标准模型
# Gauge Theory and the Standard Model

## 中文部分

### 1. 规范论的基本框架

规范论是现代粒子物理学的数学基础，将相互作用解释为某个李群的局域对称性的结果。

**基本原理**：从全局对称性到局域对称性。若物理系统在李群 $G$ 的全局作用下不变，我们要求它也在 $G$ 的局域（坐标依赖）作用下不变：
$$\psi(x) \rightarrow g(x)\psi(x), \quad g(x) \in G$$

这个要求导入了相互作用的必要性——引入规范场。

**规范变换**：设 $\psi$ 是物质场，规范群为 $G$。在规范变换 $U(x) \in G$ 下：
$$\psi(x) \rightarrow U(x)\psi(x)$$

为了保持作用量不变，必须引入规范场 $A_\mu(x)$ 和协变导数：
$$D_\mu = \partial_\mu - igA_\mu$$

其中 $A_\mu = A_\mu^a T^a$，$T^a$ 是李代数生成元，$g$ 是耦合常数。

规范场在变换下变为：
$$A_\mu \rightarrow U A_\mu U^\dagger - \frac{i}{g}(\partial_\mu U)U^\dagger$$

### 2. Yang-Mills 作用量与场方程

**Yang-Mills 作用量**（欧几里得签名）：
$$S_{YM} = \int d^4x \text{Tr}(F_{\mu\nu}F^{\mu\nu})$$

其中场强张量（曲率）为
$$F_{\mu\nu} = \partial_\mu A_\nu - \partial_\nu A_\mu - ig[A_\mu, A_\nu]$$

最后一项是非线性项，反映了非阿贝尔规范论的特性。

对应的运动方程（Yang-Mills 方程）为：
$$D_\mu F^{\mu\nu} = \partial_\mu F^{\mu\nu} - ig[A_\mu, F^{\mu\nu}] = 0$$

对阿贝尔群 $G = U(1)$（电磁学），括号消失，退化为 Maxwell 方程。

### 3. 标准模型的规范结构

粒子物理标准模型的规范群为
$$G_{SM} = SU(3)_C \times SU(2)_L \times U(1)_Y$$

其中：
- $SU(3)_C$：强相互作用（色动力学，QCD）
- $SU(2)_L$：弱相互作用（左手费米子）
- $U(1)_Y$：超荷（hypercharge）

**粒子内容**：
- 夸克（3 代）：每代 2 个左手 Weyl 旋量
- 轻子（3 代）：电子、缪子、τ 子及相应的中微子
- 规范玻色子：胶子（8 个，$SU(3)$），W、Z、光子（$SU(2) \times U(1)$）

### 4. 电弱理论与 Higgs 机制

电弱理论统一了电磁和弱相互作用。在高能极限，电磁和弱相互作用统一为 $SU(2) \times U(1)$ 规范理论。

然而，实验观察到 W 和 Z 玻色子有质量，而光子无质量。直接在 Lagrangian 中加入质量项会破坏规范不变性。解决这个问题的方法是 **Higgs 机制**。

**Higgs 场**：引入一个 $SU(2)$ 的二重态复标量场
$$\Phi = \begin{pmatrix} \phi^+ \\ \phi^0 \end{pmatrix}$$

其势能为
$$V(\Phi) = \mu^2(\Phi^\dagger\Phi) + \lambda(\Phi^\dagger\Phi)^2$$

当 $\mu^2 < 0$ 时，产生自发对称破缺。真空期望值
$$\langle\Phi\rangle = \begin{pmatrix} 0 \\ v/\sqrt{2} \end{pmatrix}, \quad v = \sqrt{-\mu^2/\lambda}$$

不变于小的 $SU(2)$ 变换，而是不变于 $U(1)_{em}$（电磁）。这导致：
- W、Z 玻色子获得质量 $m_W = gv/2$，$m_Z = m_W/\cos\theta_W$
- 光子保持无质量
- 留下一个物理的 Higgs 粒子，质量约 125 GeV

### 5. 夸克和轻子的质量与混合

**CKM 矩阵**：描述不同代夸克的弱相互作用混合：
$$V_{CKM} = \begin{pmatrix} V_{ud} & V_{us} & V_{ub} \\ V_{cd} & V_{cs} & V_{cb} \\ V_{td} & V_{ts} & V_{tb} \end{pmatrix}$$

这是一个 $3 \times 3$ 幺正矩阵，包含 3 个混合角和 1 个 CP 破缺相位。

**夸克质量矩阵**：由于 $SU(2) \times U(1)$ 对称性禁止质量项，质量来自于与 Higgs 的 Yukawa 耦合：
$$\mathcal{L}_{Yukawa} = y_{ij}\bar{q}_{L,i}\Phi d_{R,j} + \text{h.c.}$$

其中 $y_{ij}$ 是 Yukawa 矩阵。对角化后得到物理质量本征态。

### 6. 强相互作用与 QCD

**量子色动力学（QCD）**：$SU(3)_C$ 规范论。

夸克带三种"色"电荷（红、绿、蓝），而胶子带色-反色对。强耦合常数：
$$\alpha_s(Q^2) = \frac{g_s^2}{4\pi} = \frac{12\pi}{(33 - 2n_f)\ln(Q^2/\Lambda_{QCD}^2)}$$

其中 $n_f$ 是活跃夸克数，$\Lambda_{QCD} \sim 200$ MeV 是 QCD 能标。

关键特性：
- **渐近自由**：在高能（小距离）时，耦合减弱
- **色禁闭**：在低能（大距离）时，夸克和胶子被禁闭在强子内
- **非微扰效应**：在低能有重要的非微扰贡献

### 7. 对称破缺与 CP 破缺

标准模型中的 CP（电荷-宇偶）破缺来自于：
1. **CKM 矩阵中的相位**：在弱衰变中引入
2. **强 CP 问题**：QCD 中强相互作用似乎遵守 CP，但没有根本理由

Cabibbo-Kobayashi-Maskawa (CKM) 矩阵中的 Jarlskog 不变量：
$$J_{CP} = \text{Im}(V_{ud}V_{cb}V_{ub}^*V_{cd}^*) \sim 3 \times 10^{-5}$$

量化了 CP 破缺强度。

---

## English Part

### 1. Fundamental Principles of Gauge Theory

Gauge theory is the mathematical foundation of modern particle physics, interpreting interactions as consequences of local symmetry under a Lie group $G$.

**Core Principle**: Upgrade global symmetry to local symmetry. If $\psi(x) \rightarrow g(x)\psi(x)$ must hold for $g(x) \in G$, we need gauge fields.

**Gauge Covariance**: Introduce gauge field $A_\mu$ and covariant derivative:
$$D_\mu = \partial_\mu - igA_\mu$$

Under $U(x) \in G$:
$$A_\mu \rightarrow U A_\mu U^\dagger - \frac{i}{g}(\partial_\mu U)U^\dagger$$

### 2. Yang-Mills Action and Field Equations

**Yang-Mills Action**:
$$S = \int d^4x \frac{1}{4g^2}\text{Tr}(F_{\mu\nu}F^{\mu\nu})$$

where the field strength is:
$$F_{\mu\nu} = \frac{i}{g}[D_\mu, D_\nu] = \partial_\mu A_\nu - \partial_\nu A_\mu - ig[A_\mu, A_\nu]$$

The classical equation of motion:
$$D_\mu F^{\mu\nu} = 0$$

### 3. Standard Model Gauge Structure

The Standard Model gauge group:
$$G_{SM} = SU(3)_C \times SU(2)_L \times U(1)_Y$$

- $SU(3)_C$: Strong interactions (QCD)
- $SU(2)_L$: Weak interactions (left-handed fermions)
- $U(1)_Y$: Hypercharge

### 4. Electroweak Theory and Higgs Mechanism

Without Higgs mechanism, W and Z bosons would be massless (protected by gauge symmetry). The Higgs field:
$$\Phi = \begin{pmatrix} \phi^+ \\ \phi^0 \end{pmatrix}$$

has potential:
$$V(\Phi) = \mu^2(\Phi^\dagger\Phi) + \lambda(\Phi^\dagger\Phi)^2$$

For $\mu^2 < 0$, spontaneous symmetry breaking occurs:
$$\langle\Phi\rangle = \begin{pmatrix} 0 \\ v/\sqrt{2} \end{pmatrix}$$

This gives:
- $m_W = gv/2$
- $m_Z = m_W/\cos\theta_W$ (where $\theta_W$ is Weinberg angle)
- Massless photon
- Physical Higgs boson

### 5. Quark and Lepton Masses

**CKM Matrix**: Describes quark mixing in weak interactions:
$$V_{CKM} = \begin{pmatrix} V_{ud} & V_{us} & V_{ub} \\ V_{cd} & V_{cs} & V_{cb} \\ V_{td} & V_{ts} & V_{tb} \end{pmatrix}$$

A 3×3 unitary matrix with 3 mixing angles and 1 CP-violating phase.

**Yukawa Coupling**: Masses come from:
$$\mathcal{L}_{Yukawa} = y_{ij}\bar{q}_{L,i}\Phi d_{R,j}$$

Diagonalizing gives physical mass eigenstates.

### 6. Strong Interactions and QCD

**Quantum Chromodynamics**: $SU(3)_C$ gauge theory.

Running coupling:
$$\alpha_s(Q^2) = \frac{12\pi}{(33 - 2n_f)\ln(Q^2/\Lambda_{QCD}^2)}$$

Key features:
- **Asymptotic freedom**: Coupling weakens at high energy
- **Color confinement**: Quarks bound in hadrons at low energy

### 7. CP Violation

CP breaking in Standard Model from:
1. **CKM phase**: In weak decays
2. **Strong CP problem**: QCD appears CP-conserving

The Jarlskog invariant quantifies CP violation:
$$J_{CP} \sim 3 \times 10^{-5}$$

---

**字数统计**：约2850字
