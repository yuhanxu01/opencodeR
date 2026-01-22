# 对称性破缺与凝聚态物理
# Symmetry Breaking and Condensed Matter Physics

## 中文部分

### 1. 对称性破缺的基本概念

对称性破缺是现代物理学最深刻的概念之一，解释为何有序的物质态（如晶体、磁体）出现，尽管基本的物理定律对称。

**自发对称性破缺（SSB）**：系统的基态不具有Hamiltonian的完整对称性。例如，虽然电磁相互作用在旋转对称下不变，但铁磁体的磁化方向破坏了旋转对称。

**Goldstone 定理**：若连续对称群 $G$ 被自发破缺为子群 $H$，存在 $\dim(G/H)$ 个无质量的标量场，称为 Goldstone 玻色子。例如：
- 旋转群 $O(3)$ 破缺为 $O(2)$：破缺产生 1 个 Goldstone 模式
- 晶体对称性破缺：声子（phonon）作为 Goldstone 模式

### 2. Landau 有序参数理论

**有序参数 $m$**：描述有序相与无序相的区别。在相变点 $T_c$ 处，有序参数从零连续增长（二阶相变）或跳跃（一阶相变）。

**Ising 模型**：最简单的例子。自旋变量 $\sigma_i = \pm 1$。平均磁化 $m = \langle \sigma \rangle$ 作为有序参数：
- $T > T_c$：$m = 0$（无序相）
- $T < T_c$：$m \neq 0$（有序相）

关键观察：虽然 Hamiltonian 在 $\sigma_i \to -\sigma_i$ 对称，但热力学极限中基态破缺此对称（选择 $m > 0$ 或 $m < 0$）。

**自由能展开**（平均场理论）：
$$F(T,m) = F_0 - \frac{a(T_c - T)}{2}m^2 + \frac{b}{4}m^4 + \cdots$$

最小化 $\partial F/\partial m = 0$ 给出：
- $T > T_c$：$m = 0$ 稳定
- $T < T_c$：$m = \pm\sqrt{a(T - T_c)/b}$ 稳定

###  3. 临界现象与 Ising 模型

**临界点附近的标度律**：在 $T \to T_c$ 时，诸多物理量发散或趋于零，遵循幂律：
$$m \sim |T - T_c|^\beta, \quad \chi \sim |T - T_c|^{-\gamma}, \quad \xi \sim |T - T_c|^{-\nu}$$

其中 $\beta, \gamma, \nu$ 是临界指数，对于 Ising 模型（3D）为：
$$\beta \approx 0.325, \quad \gamma \approx 1.24, \quad \nu \approx 0.63$$

**普遍类（Universality Classes）**：具有相同临界指数的不同系统属于同一普遍类。例如，Ising、Heisenberg 和 XY 模型各属不同类。

**重整化群（RG）**：通过粗粒化（coarse-graining）分析，揭示临界点处系统的尺度不变性。RG 流方程：
$$\frac{d\lambda_i}{d\ln s} = \beta_i(\lambda_j)$$

其中 $s$ 是尺度参数，$\lambda_i$ 是耦合常数。固定点 $\beta_i^* = 0$ 对应临界点。

### 4. Higgs 机制与规范对称性破缺

**规范对称性破缺**：不同于普通对称性，规范对称性破缺涉及新物理——Goldstone 玻色子被吸收进规范场，赋予其质量。

**Abelian 情形**（$U(1)$ 规范）：考虑复标量场 $\phi$ 和规范场 $A_\mu$：
$$\mathcal{L} = |D_\mu \phi|^2 - V(\phi), \quad V(\phi) = \mu^2|\phi|^2 + \lambda|\phi|^4$$

当 $\mu^2 < 0$ 时，基态为 $|\langle\phi\rangle| = v/\sqrt{2}$。局域 $U(1)$ 变换仍是对称，但物理的 Goldstone 模式被吸收，规范场获得质量 $m_A = gv$。

这正是 Higgs 机制，标准模型中 W、Z 玻色子质量的来源。

### 5. 超导与Bogoliubov 变换

**超导的成对机制**：自由电子在 Fermi 面附近形成 Cooper 对。虽然单个电子在费米面上，成对状态的绑定能为负（因为吸引相互作用），形成能隙。

**BCS 理论**的基本假设：配对哈密顿量
$$H = \sum_k \epsilon_k c_k^\dagger c_k + \sum_{k,k'} V_{kk'} c_k^\dagger c_{-k}^\dagger c_{-k'} c_{k'}$$

基态具有 $\langle c_k^\dagger c_{-k}^\dagger \rangle = \Delta$ 的配对相关。

**Bogoliubov 变换**：定义新的准粒子算子：
$$\gamma_k = u_k c_k + v_k c_{-k}^\dagger$$

在新表示中，Hamiltonian 对角化，准粒子激发能为
$$E_k = \sqrt{\epsilon_k^2 + \Delta^2}$$

存在能隙 $\Delta$（超导能隙），阻止低能激发，导致零电阻。

### 6. 拓扑序与分数量子Hall 效应

**拓扑序**：不是由对称性破缺（长程序）描述，而是由基态简并性和拓扑不变量表征的有序态。

**分数量子Hall 效应**（FQHE）：二维电子气在强磁场中，filling factor $\nu = n/m$ 时（$n < m$ 互质），观察到 Hall 电导的平台：
$$\sigma_{xy} = \frac{\nu e^2}{h}$$

完全分数化表明了新型量子态。

**Laughlin 波函数**（$\nu = 1/m$）：
$$\Psi(\{z_i\}) = \prod_{i<j}(z_i - z_j)^m \exp\left(-\sum_i |z_i|^2/4\right)$$

其中 $z_i = x_i + iy_i$ 是第 $i$ 个电子的复坐标。这个多体波函数展现了强量子关联和集体行为。

### 7. 拓扑缺陷与涡旋

**拓扑缺陷**：受对称性保护的非平凡有限能量配置，如：
- **涡旋（Vortex）**：XY 模型中，位相绕某点旋转 $2\pi n$
- **孤子（Soliton）**：一维KdV 方程中的孤立波
- **单极子（Monopole）**：Y-M 理论中的磁单极

**涡旋的能量**：核心处能量密度最高，外侧指数衰减：
$$E_{\text{core}} \sim (K/a^2) \ln(R/a)$$

其中 $K$ 是刚度，$a$ 是核心大小，$R$ 是系统大小。

### 8. 现代进展：Kitaev 模型与拓扑量子计算

**Kitaev 蜂窝模型**：二维格子中 Ising 自旋，相互作用沿三个方向，Hamiltonian：
$$H = -J\sum_{\text{stars}} \prod_i \sigma_i^z - h\sum_{\text{plaquettes}} \prod_i \sigma_i^x$$

具有拓扑序，基态 4 重简并，对应 4 个 Majorana 零模。

**应用**：构造拓扑量子比特，其中量子信息存储于拓扑缺陷，自然抵抗局部环境干扰，为容错量子计算的关键。

---

## English Part

### 1. Fundamentals of Symmetry Breaking

**Spontaneous Symmetry Breaking (SSB)**: Ground state lacks full symmetry of Hamiltonian.

**Goldstone's Theorem**: If continuous symmetry group $G$ breaks to subgroup $H$, existence of $\dim(G/H)$ massless scalar fields (Goldstone bosons).

Examples:
- $O(3) \to O(2)$: one Goldstone mode
- Crystalline symmetry breaking: phonons

### 2. Landau Order Parameter Theory

**Order Parameter** $m$: Distinguishes ordered from disordered phases.

**Ising Model**: $m = \langle \sigma \rangle$:
- $T > T_c$: $m = 0$ (disordered)
- $T < T_c$: $m \neq 0$ (ordered)

**Free Energy Expansion**:
$$F(T,m) = F_0 - \frac{a(T_c - T)}{2}m^2 + \frac{b}{4}m^4$$

Minimization: $\partial F/\partial m = 0$ gives transition.

### 3. Critical Phenomena and Universality

**Scaling Laws** near $T_c$:
$$m \sim |T-T_c|^\beta, \quad \chi \sim |T-T_c|^{-\gamma}, \quad \xi \sim |T-T_c|^{-\nu}$$

**Critical Exponents** (3D Ising):
$$\beta \approx 0.325, \quad \gamma \approx 1.24, \quad \nu \approx 0.63$$

**Universality Classes**: Different systems with same critical exponents.

**Renormalization Group**:
$$\frac{d\lambda_i}{d\ln s} = \beta_i(\lambda_j)$$

Fixed points correspond to critical points.

### 4. Higgs Mechanism and Gauge Symmetry Breaking

**Gauge SSB** (different from ordinary): Goldstone boson absorbed into gauge field, giving it mass.

**$U(1)$ Case**:
$$\mathcal{L} = |D_\mu \phi|^2 - V(\phi)$$

For $\mu^2 < 0$, $|\langle\phi\rangle| = v/\sqrt{2}$. Gauge field acquires mass: $m_A = gv$.

In Standard Model: $W, Z$ boson masses.

### 5. Superconductivity and Bogoliubov Transformation

**Pairing Mechanism**: Cooper pairs near Fermi surface; binding energy negative due to attractive interaction.

**BCS Hamiltonian**:
$$H = \sum_k \epsilon_k c_k^\dagger c_k + \sum_{kk'} V_{kk'} c_k^\dagger c_{-k}^\dagger c_{-k'} c_{k'}$$

**Bogoliubov Transformation**:
$$\gamma_k = u_k c_k + v_k c_{-k}^\dagger$$

Quasiparticle excitation energy:
$$E_k = \sqrt{\epsilon_k^2 + \Delta^2}$$

Energy gap $\Delta$ prevents low-energy excitations, causing zero resistance.

### 6. Topological Order and Fractional QHE

**Topological Order**: Characterized by ground state degeneracy and topological invariants, not by symmetry breaking.

**Fractional Quantum Hall** ($\nu = 1/m$):
$$\sigma_{xy} = \frac{\nu e^2}{h}$$

**Laughlin Wavefunction**:
$$\Psi(\{z_i\}) = \prod_{i<j}(z_i - z_j)^m \exp\left(-\sum_i |z_i|^2/4\right)$$

### 7. Topological Defects and Vortices

**Topological Defects**: Non-trivial finite-energy configurations:
- Vortex: winding $2\pi n$
- Soliton: localized wave solution
- Monopole: magnetic monopole

### 8. Modern Development: Kitaev Model and Topological QC

**Kitaev Honeycomb Model**: 2D spins with direction-dependent interactions. Topological order, 4-fold ground state degeneracy, Majorana zero modes.

**Application**: Topological qubits for fault-tolerant quantum computation.

---

**字数统计**：约2850字
