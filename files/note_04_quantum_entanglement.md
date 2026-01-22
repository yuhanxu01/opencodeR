# 量子纠缠与量子信息论
# Quantum Entanglement and Quantum Information Theory

## 中文部分

### 1. 量子纠缠的定义与本质

量子纠缠是量子力学最非直观且最具威力的现象。它违反了局域实在论（Bell 不等式），在量子信息论中扮演中心角色。

**定义**：设 $H_A \otimes H_B$ 是两个量子系统 $A$ 和 $B$ 的复合 Hilbert 空间。状态 $|\psi\rangle_{AB} \in H_A \otimes H_B$ 称为可分的（separable），若存在分解
$$|\psi\rangle_{AB} = |\phi\rangle_A \otimes |\chi\rangle_B$$

否则称为纠缠态（entangled state）。

对于纯态，更精确的刻画使用 Schmidt 分解：任意双分体纯态可写成
$$|\psi\rangle_{AB} = \sum_{i=1}^r \sqrt{\lambda_i} |u_i\rangle_A \otimes |v_i\rangle_B$$

其中 $\{|u_i\rangle_A\}$ 和 $\{|v_i\rangle_B\}$ 分别是 $A$ 和 $B$ 的正交基，$\lambda_i \geq 0$ 满足 $\sum_i \lambda_i = 1$，$r$ 称为 Schmidt 秩。

### 2. 纠缠熵与可分性判别

**纠缠熵（Von Neumann 熵）**：给定态 $|\psi\rangle_{AB}$，对 $A$ 系统求偏迹得到约化密度矩阵
$$\rho_A = \text{Tr}_B(|\psi\rangle\langle\psi|_{AB})$$

纠缠熵定义为
$$S(A) = -\text{Tr}(\rho_A \log_2 \rho_A) = -\sum_i \lambda_i \log_2 \lambda_i$$

其中 $\lambda_i$ 是 $\rho_A$ 的特征值。$S(A) = 0$ 当且仅当状态是可分的。

**最大纠缠态**：如果 Schmidt 秩为 $r = 2$ 且 $\lambda_1 = \lambda_2 = 1/2$，则 $S(A) = 1$ bit，这是最大纠缠。例如，Bell 态
$$|\Phi^+\rangle = \frac{1}{\sqrt{2}}(|00\rangle + |11\rangle)$$

完全纠缠，熵为最大。

**可分性判别法**：
1. **PPT 判别法（Peres-Horodecki）**：密度矩阵 $\rho_{AB}$ 的部分转置 $\rho_{AB}^{T_B}$ 若有负特征值，则 $\rho_{AB}$ 是纠缠的。
2. **纠缠见证**：正线性泛函 $W$ 满足 $\langle\psi|W|\psi\rangle \geq 0$ 对所有可分态，但对某些纠缠态给出负值。

### 3. Bell 不等式与局域隐变量理论

**Bell 定理**：在假设局域性和实在性的前提下，不存在与量子力学的所有预测相一致的隐变量模型。

考虑 CHSH（Clauser-Horne-Shimony-Holt）不等式：
$$\langle A_0 B_0 \rangle + \langle A_0 B_1 \rangle + \langle A_1 B_0 \rangle - \langle A_1 B_1 \rangle \leq 2$$

其中角括号表示期望值。对任何局域隐变量模型，上式恒成立。

然而，对最大纠缠态 $|\Phi^+\rangle$，若选择适当的可观测 $A_0, A_1, B_0, B_1$（即旋转角度），左边可达 $2\sqrt{2} \approx 2.828$，违反不等式。

### 4. 量子信息的基本定理

**无克隆定理（No-Cloning Theorem）**：不存在物理过程能完美地复制任意未知量子态。

证明：设存在幺正变换 $U$ 使得
$$U(|\psi\rangle|\text{blank}\rangle) = |\psi\rangle|\psi\rangle$$

对任意 $|\psi\rangle$ 成立。考虑两个不同的正交态 $|\psi_1\rangle, |\psi_2\rangle$，内积 $\langle\psi_1|\psi_2\rangle = 0$。则
$$\langle\psi_1\psi_1|U^\dagger U|\psi_2\psi_2\rangle = \langle\psi_1|\psi_2\rangle\langle\psi_1|\psi_2\rangle = 0$$

但左边也等于 $\langle\psi_1|\psi_2\rangle = 0$，这对所有正交态成立，导致矛盾。

**量子通道容量**：量子通道 $\mathcal{E}: \rho \mapsto \mathcal{E}(\rho)$ 的通道容量（能传输量子信息的最大速率）为
$$C = \max_{\rho} [S(\mathcal{E}(\rho)) - S(\mathcal{E}_{\text{out}}(\rho))]$$

其中 $S$ 是 Von Neumann 熵。

### 5. 量子纠缠蒸馏与纠缠净化

**纠缠蒸馏**：从许多弱纠缠态中提取少量高度纠缠态（如 Bell 态）的过程。

设初始态为 $\rho^{\otimes n}$（多份相同副本），经过局部操作和经典通讯（LOCC），可产生 $\rho_{\text{target}}^{\otimes m}$。可蒸馏纠缠定义为
$$E_D(\rho) = \inf\left\{\frac{m}{n}: \text{可从 } \rho^{\otimes n} \text{ 蒸馏出 } \Phi^+^{\otimes m}\right\}$$

其中 $|\Phi^+\rangle = \frac{1}{\sqrt{2}}(|00\rangle+|11\rangle)$ 是 Bell 态。

**相关结果**：对于双分体纯态，蒸馏纠缠等于纠缠熵：$E_D(|\psi\rangle) = S(A)$。

### 6. 量子密钥分发（QKD）

**BB84 协议**：Bennet-Brassard 1984 提出的无条件安全量子密钥分发方案。

步骤：
1. Alice 生成随机比特串 $b$ 和随机基向 $\theta$（$0°$ 或 $45°$）
2. Alice 按基向 $\theta$ 编码比特到偏振态，发送给 Bob
3. Bob 随机选择基向测量
4. 公开讨论（经典通道）哪些基向匹配
5. 匹配的测量结果构成密钥

安全性来自于：若 Eve（窃听者）试图测量，则必然引入错误被检测到。量子物理学（测量造成坍塌）天然保证了安全性。

### 7. 量子纠缠在量子计算中的角色

量子计算的速度优势来自于纠缠和叠加的结合。对于 $n$ 个量子比特系统，状态空间维数为 $2^n$，但 $O(n)$ 个幺正门和测量可以处理指数大的态空间。

Shor 算法（整数因子分解）利用量子傅里叶变换和纠缠，实现了从 $\exp(\sqrt[3]{N})$ 到 $\text{poly}(\log N)$ 的指数加速。Grover 搜索算法在无序数据库搜索中提供 $\sqrt{N}$ 加速。

---

## English Part

### 1. Definition and Essence of Quantum Entanglement

Quantum entanglement is the most counterintuitive and powerful phenomenon in quantum mechanics. It violates local realism (Bell inequalities) and plays a central role in quantum information theory.

**Definition**: A state $|\psi\rangle_{AB} \in H_A \otimes H_B$ is separable if:
$$|\psi\rangle_{AB} = |\phi\rangle_A \otimes |\chi\rangle_B$$

Otherwise it is entangled.

**Schmidt Decomposition**: Any pure bipartite state admits:
$$|\psi\rangle_{AB} = \sum_{i=1}^r \sqrt{\lambda_i} |u_i\rangle_A \otimes |v_i\rangle_B$$

where $\lambda_i$ are Schmidt coefficients, $r$ is the Schmidt rank.

### 2. Entanglement Entropy and Separability

**Von Neumann Entropy**: For reduced density matrix $\rho_A = \text{Tr}_B(|\psi\rangle\langle\psi|)$:
$$S(A) = -\sum_i \lambda_i \log_2 \lambda_i$$

$S(A) = 0$ iff the state is separable. Maximal entanglement gives $S(A) = 1$ bit for bipartite systems.

**Bell States**: Maximally entangled 2-qubit states:
$$|\Phi^+\rangle = \frac{1}{\sqrt{2}}(|00\rangle + |11\rangle)$$

**Separability Tests**:
- PPT (Partial Transpose) criterion
- Entanglement witnesses

### 3. Bell Inequalities

**CHSH Inequality**:
$$\langle A_0 B_0 \rangle + \langle A_0 B_1 \rangle + \langle A_1 B_0 \rangle - \langle A_1 B_1 \rangle \leq 2$$

Local hidden variable models satisfy this. Quantum mechanics can violate it, achieving $2\sqrt{2}$ with appropriate measurements on maximally entangled states.

### 4. Fundamental Theorems

**No-Cloning Theorem**: No unitary operation can perfectly copy arbitrary unknown quantum states.

**Channel Capacity**: The quantum capacity of a channel $\mathcal{E}$ is:
$$C = \max_{\rho} [S(\mathcal{E}(\rho)) - S(\mathcal{E}_{\text{out}}(\rho))]$$

where $S$ is von Neumann entropy.

### 5. Entanglement Distillation and Purification

**Distillable Entanglement**: Measure of extractable Bell pairs from many weakly entangled copies:
$$E_D(\rho) = \lim_{n\to\infty}\inf\left\{\frac{m}{n}\right\}$$

For pure states: $E_D(|\psi\rangle) = S(A)$ (entanglement entropy).

### 6. Quantum Key Distribution (QKD)

**BB84 Protocol**: Unconditionally secure key distribution using quantum states.
1. Alice encodes random bits in random bases (0° or 45°)
2. Bob measures in random bases
3. Compare bases classically, discard mismatches
4. Result is secure key

Security guaranteed by quantum mechanics: eavesdropping is detectable.

### 7. Entanglement in Quantum Computing

Quantum speedup comes from entanglement combined with superposition. An $n$-qubit state spans $2^n$-dimensional space, yet $O(n)$ gates can manipulate exponentially large state spaces.

**Shor's Algorithm**: Integer factorization with exponential speedup from $\exp(\sqrt[3]{N})$ to $\text{poly}(\log N)$.

**Grover's Algorithm**: Unstructured search with $\sqrt{N}$ speedup.

---

**字数统计**：约2900字
