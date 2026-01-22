# 信息熵与热力学
# Information Entropy and Thermodynamics

## 中文部分

### 1. Shannon 熵与信息论基础

信息熵是 Claude Shannon 在 1948 年引入的，量化了随机变量的不确定性，现已成为信息论、统计物理和机器学习的基础概念。

**定义**：离散随机变量 $X$ 取值于 $\{x_1, \ldots, x_n\}$，概率分别为 $p_1, \ldots, p_n$，其 Shannon 熵为
$$H(X) = -\sum_{i=1}^n p_i \log_2 p_i$$

单位为比特（bits）。若用自然对数，单位为 nats。

**性质**：
- $H(X) \geq 0$，等号成立当且仅当某个 $p_i = 1$（确定性）
- 当所有 $p_i = 1/n$ 时最大，$H_{\max} = \log_2 n$
- 熵是凹函数：$H(\lambda X + (1-\lambda)Y) \geq \lambda H(X) + (1-\lambda)H(Y)$

**连续版本**：微分熵（differential entropy）
$$h(X) = -\int_{-\infty}^\infty p(x)\log p(x) dx$$

对于高斯分布 $\mathcal{N}(\mu, \sigma^2)$：
$$h(X) = \frac{1}{2}\log_2(2\pi e \sigma^2) \quad \text{(bits)}$$

### 2. 相对熵与 Kullback-Leibler 散度

**KL 散度**：衡量两个概率分布的不相似性：
$$D_{KL}(P||Q) = \sum_i p_i \log_2 \frac{p_i}{q_i}$$

性质：
- $D_{KL}(P||Q) \geq 0$，等号成立当且仅当 $P = Q$
- 一般非对称：$D_{KL}(P||Q) \neq D_{KL}(Q||P)$
- 与信息论中的相对熵相同

**Gibbs 不等式**：$D_{KL}(P||Q) \geq 0$ 等价于 Shannon 熵的最大值性质。

### 3. 联合熵与互信息

**联合熵**：两个随机变量的联合不确定性：
$$H(X,Y) = -\sum_{i,j} p_{ij}\log_2 p_{ij}$$

**条件熵**：给定 $Y$ 后 $X$ 的剩余不确定性：
$$H(X|Y) = H(X,Y) - H(Y)$$

**互信息**：两个变量之间的相依程度：
$$I(X;Y) = H(X) + H(Y) - H(X,Y) = \sum_{i,j} p_{ij}\log_2\frac{p_{ij}}{p_i q_j}$$

也等于 $D_{KL}(P_{XY}||P_X \times P_Y)$，衡量联合分布与独立分布的偏差。

### 4. 热力学中的 Boltzmann 熵

物理系统的热力学熵与 Shannon 熵的关系深刻而基本。

**Boltzmann 公式**：
$$S = k_B \ln \Omega$$

其中 $\Omega$ 是微观态数（状态数），$k_B$ 是 Boltzmann 常数。

对于在相空间中状态均匀分布的系统，$\Omega = \text{体积}/h^f$（其中 $h$ 是Planck常数，$f$ 是自由度数）。

**概率版本**：若系统以概率 $p_i$ 处于微观态 $i$，则
$$S = -k_B \sum_i p_i \ln p_i$$

这正是 Shannon 熵乘以 $k_B$，单位为焦尔/开尔文。

### 5. 热力学第二定律与熵增原理

**熵增原理**：孤立系统的熵不可能减少：
$$\frac{dS}{dt} \geq 0$$

等号成立当且仅当过程是可逆的。

**非平衡过程的熵变**：对于接触热浴的系统（温度 $T$），总熵变为
$$dS_{\text{total}} = dS_{\text{system}} + \frac{dQ}{T} = dS_{\text{system}} + \frac{\Delta H - TdS_{\text{system}}}{T} = -\frac{dG}{T}$$

其中 $G = H - TS$ 是 Gibbs 自由能。在恒温恒压下，过程自发进行当且仅当 $dG \leq 0$。

### 6. 最大熵原理与指数族

**最大熵原理**：在约束条件下，最可能的分布是熵最大的分布。

**例子**（Lagrange乘数法）：若仅知道期望值 $\mathbb{E}[X] = \mu$ 和 $\mathbb{E}[X^2] = \mu_2$，最大熵分布为高斯分布 $\mathcal{N}(\mu, \mu_2 - \mu^2)$。

**指数族**：满足最大熵原理约束的自然形式为
$$p(x|\theta) = \exp(\theta \cdot T(x) - A(\theta))$$

其中 $T(x)$ 是充分统计量，$A(\theta) = \ln \int \exp(\theta \cdot T(x)) dx$ 是配分函数。

高斯分布、指数分布、Poisson 分布等都属于指数族。

### 7. 信息论在热力学中的应用：Landauer 原理与 Maxwell 妖悖论

**Landauer 原理**：抹除 1 比特信息必然增加环境至少 $k_B T \ln 2$ 的热量。

数学形式：
$$Q \geq k_B T \ln 2$$

其中 $Q$ 是释放的热量，$T$ 是温度。这打破了 Maxwell 妖悖论：处理信息需要热力学代价。

**Maxwell 妖悖论的解决**：Maxwell 妖通过测量和记忆粒子速度来违反第二定律。但一旦妖的"记忆"（储存信息的介质）饱和，必须抹除信息来继续工作，抹除信息的热代价恰好抵消了从系统获得的热。

### 8. 量子熵与Von Neumann 熵

**Von Neumann 熵**：量子系统的密度矩阵 $\rho$ 的熵为
$$S(\rho) = -k_B \text{Tr}(\rho \ln \rho) = -k_B \sum_i p_i \ln p_i$$

其中 $p_i$ 是 $\rho$ 的特征值。

性质：
- 纯态（本征值为 1 和 0）：$S = 0$
- 最大混合态：$S = k_B \ln d$，其中 $d$ 是 Hilbert 空间维数
- 凹性和强子可加性（subadditivity）

**强子可加性**：对于复合系统 $AB$：
$$S(AB) \leq S(A) + S(B)$$

等号成立当 $\rho_{AB} = \rho_A \otimes \rho_B$（不纠缠）。

---

## English Part

### 1. Shannon Entropy and Information Theory

**Definition** (discrete):
$$H(X) = -\sum_{i=1}^n p_i \log_2 p_i$$

Units: bits.

**Properties**:
- $H(X) \geq 0$ with equality iff deterministic
- Maximum when $p_i = 1/n$: $H_{\max} = \log_2 n$
- Concave function

**Differential Entropy**:
$$h(X) = -\int p(x)\log p(x) dx$$

For Gaussian $\mathcal{N}(\mu, \sigma^2)$:
$$h(X) = \frac{1}{2}\log_2(2\pi e \sigma^2)$$

### 2. Relative Entropy and Kullback-Leibler Divergence

**KL Divergence**:
$$D_{KL}(P||Q) = \sum_i p_i \log_2 \frac{p_i}{q_i}$$

Properties:
- $D_{KL}(P||Q) \geq 0$ with equality iff $P = Q$
- Generally asymmetric
- Related to relative entropy

### 3. Joint Entropy and Mutual Information

**Joint Entropy**:
$$H(X,Y) = -\sum_{i,j} p_{ij}\log_2 p_{ij}$$

**Conditional Entropy**:
$$H(X|Y) = H(X,Y) - H(Y)$$

**Mutual Information**:
$$I(X;Y) = H(X) + H(Y) - H(X,Y) = D_{KL}(P_{XY}||P_X \times P_Y)$$

### 4. Boltzmann Entropy in Thermodynamics

**Boltzmann Formula**:
$$S = k_B \ln \Omega$$

where $\Omega$ is number of microstates.

**Probabilistic Version**:
$$S = -k_B \sum_i p_i \ln p_i$$

Equivalently, Shannon entropy times $k_B$, units: J/K.

### 5. Second Law of Thermodynamics

**Entropy Increase Principle**:
$$\frac{dS}{dt} \geq 0$$

Equality for reversible processes.

**For system in thermal bath** (temperature $T$):
$$dS_{\text{total}} = -\frac{dG}{T}$$

where $G = H - TS$ is Gibbs free energy. Process spontaneous iff $dG \leq 0$.

### 6. Maximum Entropy Principle and Exponential Families

**Principle**: Most probable distribution under constraints is maximum entropy.

**Example**: Given $\mathbb{E}[X] = \mu$ only, max entropy is Gaussian with variance as small as possible given constraint.

**Exponential Family**:
$$p(x|\theta) = \exp(\theta \cdot T(x) - A(\theta))$$

Natural form satisfying max entropy principle.

### 7. Landauer's Principle and Maxwell's Demon

**Landauer's Principle**: Erasing 1 bit of information generates at least $k_B T \ln 2$ heat:
$$Q \geq k_B T \ln 2$$

**Resolution of Maxwell's Demon**: Information processing has thermodynamic cost. When demon's memory saturates, erasing information releases heat exactly canceling work extraction.

### 8. Quantum Entropy and Von Neumann Entropy

**Von Neumann Entropy** (density matrix $\rho$):
$$S(\rho) = -k_B \text{Tr}(\rho \ln \rho) = -k_B \sum_i p_i \ln p_i$$

Properties:
- Pure state: $S = 0$
- Maximally mixed: $S = k_B \ln d$
- Concave, subadditive

**Strong Subadditivity** (bipartite):
$$S(AB) \leq S(A) + S(B)$$

Equality iff $\rho_{AB} = \rho_A \otimes \rho_B$ (unentangled).

---

**字数统计**：约2850字
