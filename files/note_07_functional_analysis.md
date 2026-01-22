# 泛函分析与希尔伯特空间
# Functional Analysis and Hilbert Spaces

## 中文部分

### 1. Hilbert 空间的定义与结构

Hilbert 空间是量子力学的数学基础，也是现代分析的核心工具。

**定义**：Hilbert 空间 $H$ 是满足以下条件的复向量空间：
1. 具有内积 $\langle \cdot, \cdot \rangle: H \times H \rightarrow \mathbb{C}$，满足
   - 共轭对称性：$\langle x,y \rangle = \overline{\langle y,x \rangle}$
   - 线性性：$\langle ax+by, z \rangle = a\langle x,z \rangle + b\langle y,z \rangle$
   - 正定性：$\langle x,x \rangle \geq 0$，等号成立当且仅当 $x=0$

2. 诱导范数 $\|x\| = \sqrt{\langle x,x \rangle}$

3. 在范数下完备（Cauchy 列收敛）

**例子**：
- $\ell^2(\mathbb{N})$：平方可和的复数列，$\langle (a_n), (b_n) \rangle = \sum_{n=1}^\infty \overline{a_n}b_n$
- $L^2(\mathbb{R})$：平方可积的函数，$\langle f,g \rangle = \int_{-\infty}^\infty f(x)\overline{g(x)}dx$
- 有限维：$\mathbb{C}^n$

### 2. 正交性与 Riesz 表示定理

**正交投影定理**：设 $M$ 是 Hilbert 空间 $H$ 的闭凸子集，对任意 $x \in H$，存在唯一的 $m \in M$ 使得
$$\|x - m\| = \min_{y \in M}\|x - y\|$$

设 $V$ 是 $H$ 的闭子空间，则 $H = V \oplus V^\perp$，其中 $V^\perp = \{x \in H: \langle x, v \rangle = 0 \forall v \in V\}$。

正交投影算子 $P_V: H \rightarrow V$ 由 $P_V x = \text{arg}\min_{v \in V}\|x-v\|$ 定义，满足 $P_V^2 = P_V = P_V^*$。

**Riesz 表示定理**：设 $\phi: H \rightarrow \mathbb{C}$ 是连续线性泛函，则存在唯一的 $y \in H$ 使得
$$\phi(x) = \langle x, y \rangle \quad \forall x \in H$$

且 $\|\phi\| = \|y\|$（泛函的范数等于表示元的范数）。

这个定理说明 $H^* \cong H$（对偶空间同构于空间本身），这是 Hilbert 空间相对于 Banach 空间的特殊性。

### 3. 正交基与 Fourier 级数

**可数正交基**：称序列 $\{e_n\}_{n=1}^\infty$ 是 Hilbert 空间的正交基，若：
1. 正交性：$\langle e_i, e_j \rangle = \delta_{ij}$（Kronecker delta）
2. 完备性：线性张成稠密于 $H$

对于任意 $x \in H$，Fourier 展开：
$$x = \sum_{n=1}^\infty c_n e_n, \quad c_n = \langle x, e_n \rangle$$

这个级数在 Hilbert 空间范数意义下收敛。

**Parseval 恒等式**：
$$\|x\|^2 = \sum_{n=1}^\infty |c_n|^2 = \sum_{n=1}^\infty |\langle x, e_n \rangle|^2$$

**例子**：$L^2([0, 2\pi])$ 中的标准正交基是
$$e_n(x) = \frac{1}{\sqrt{2\pi}}e^{inx}, \quad n \in \mathbb{Z}$$

对应的 Fourier 级数是古典的三角级数。

### 4. 线性算子与算子范数

**定义**：设 $H, K$ 是 Hilbert 空间，$T: H \rightarrow K$ 是线性映射。$T$ 的算子范数为
$$\|T\| = \sup_{x \neq 0} \frac{\|Tx\|}{|x\|} = \sup_{\|x\|=1}\|Tx\|$$

有界线性算子是范数有限的算子。所有有界线性算子的空间 $B(H)$ 在算子范数下构成 Banach 空间。

**共轭算子**：若 $T: H \rightarrow K$ 有界，其共轭算子 $T^*: K \rightarrow H$ 定义为
$$\langle Tx, y \rangle_K = \langle x, T^* y \rangle_H$$

满足 $T^{**} = T$（在 Hilbert 空间中），$\|T^*\| = \|T\|$，$(ST)^* = T^*S^*$。

### 5. 谱理论与自伴算子

**自伴算子**：若 $T^* = T$，则称 $T$ 是自伴的（或 Hermitian）。

量子力学中，可观测量对应自伴算子，其实部谱对应测量值。

**谱集定义**：
- 点谱（特征值）：$\lambda \in \sigma_p(T)$ 若 $\exists x \neq 0, Tx = \lambda x$
- 剩余谱：$\sigma_r(T)$
- 连续谱：$\sigma_c(T)$
- 总谱：$\sigma(T) = \sigma_p(T) \cup \sigma_r(T) \cup \sigma_c(T)$

**谱定理**：对有界自伴算子 $T$，存在投影值测度 $E$ 使得
$$T = \int_{\sigma(T)} \lambda \, dE(\lambda)$$

对无界自伴算子，类似的积分表示仍然成立。

### 6. 紧算子与 Fredholm 理论

**紧算子**：若 $T: H \rightarrow H$ 的像中任意有界序列包含收敛子列，则称 $T$ 是紧的。

**例子**：Volterra 积分算子 $(Tf)(x) = \int_0^x K(x,y)f(y)dy$，其中核 $K$ 连续。

**Fredholm 理论**：对紧算子 $K$，考虑方程
$$x - Kx = y$$

1. 若齐次方程 $x = Kx$ 只有零解，则原方程对任意 $y$ 有唯一解
2. 若齐次方程有 $n$ 个线性独立解，则原方程有解当且仅当 $y$ 满足 $n$ 个正交条件

这是有限维线性代数的推广。

### 7. 广义函数与分布

**分布空间 $\mathcal{D}'$**：将普通函数空间 $\mathcal{D}$ 的对偶空间作为分布空间，包含：
- 普通函数（嵌入为分布）
- Dirac δ 函数：$\langle \delta, \phi \rangle = \phi(0)$
- 导数：广义意义的函数导数总是存在的

**Sobolev 空间 $H^k(\mathbb{R}^n)$**：定义为
$$H^k = \{f \in L^2: D^\alpha f \in L^2 \text{ for } |\alpha| \leq k\}$$

其中导数在分布意义下理解。内积为
$$\langle f, g \rangle_{H^k} = \sum_{|\alpha| \leq k} \langle D^\alpha f, D^\alpha g \rangle_{L^2}$$

Sobolev 空间是现代 PDE 理论的基础。

---

## English Part

### 1. Definition and Structure of Hilbert Spaces

A Hilbert space is a complete inner product space.

**Definition**: $H$ is a complex vector space with inner product $\langle \cdot, \cdot \rangle$ satisfying:
- Conjugate symmetry: $\langle x,y \rangle = \overline{\langle y,x \rangle}$
- Linearity in second argument
- Positive definiteness: $\langle x,x \rangle > 0$ for $x \neq 0$

with induced norm $\|x\| = \sqrt{\langle x,x \rangle}$ and completeness.

**Examples**:
- $\ell^2(\mathbb{N})$: square-summable sequences
- $L^2(\mathbb{R})$: square-integrable functions
- $\mathbb{C}^n$

### 2. Orthogonality and Riesz Representation

**Orthogonal Projection Theorem**: Every closed convex set has a unique closest point. For closed subspace $V$:
$$H = V \oplus V^\perp$$

**Riesz Representation Theorem**: Every continuous linear functional $\phi: H \to \mathbb{C}$ has unique representation:
$$\phi(x) = \langle x, y \rangle$$

for some $y \in H$. Thus $H^* \cong H$.

### 3. Orthonormal Bases and Fourier Series

Orthonormal sequence $\{e_n\}$ is a basis if $\text{span}\{e_n\}$ is dense.

For any $x \in H$:
$$x = \sum_{n=1}^\infty \langle x, e_n \rangle e_n$$

**Parseval Identity**:
$$\|x\|^2 = \sum_{n=1}^\infty |\langle x, e_n \rangle|^2$$

**Example**: In $L^2([0,2\pi])$, the basis is:
$$e_n(x) = \frac{1}{\sqrt{2\pi}}e^{inx}$$

### 4. Linear Operators and Operator Norms

**Definition**: The operator norm is:
$$\|T\| = \sup_{\|x\|=1}\|Tx\|$$

**Adjoint Operator**: $T^*$ satisfies:
$$\langle Tx, y \rangle = \langle x, T^*y \rangle$$

Properties: $T^{**} = T$, $\|T^*\| = \|T\|$, $(ST)^* = T^*S^*$.

### 5. Spectral Theory and Self-Adjoint Operators

**Self-adjoint**: $T^* = T$. In quantum mechanics, observables are self-adjoint operators.

**Spectrum**: $\sigma(T) = \sigma_p(T) \cup \sigma_c(T) \cup \sigma_r(T)$
- Point spectrum: eigenvalues
- Continuous spectrum
- Residual spectrum

**Spectral Theorem**: Every bounded self-adjoint operator admits spectral decomposition:
$$T = \int_{\sigma(T)} \lambda \, dE(\lambda)$$

### 6. Compact Operators and Fredholm Theory

**Compact Operator**: Continuous image of bounded sets is relatively compact.

**Fredholm Alternative**: For compact $K$, the equation $x - Kx = y$:
- Either has unique solution for all $y$
- Or homogeneous equation has $n$ linearly independent solutions, and solution exists iff $y$ is orthogonal to these

### 7. Distributions and Sobolev Spaces

**Distributions**: Elements of $\mathcal{D}'$, dual of test functions.

**Dirac delta**: $\langle \delta, \phi \rangle = \phi(0)$

**Sobolev Space** $H^k(\mathbb{R}^n)$:
$$H^k = \{f \in L^2: D^\alpha f \in L^2 \text{ for } |\alpha| \leq k\}$$

Foundation of modern PDE theory.

---

**字数统计**：约2850字
