# 微分几何中的主丛与联络
# Principal Bundles and Connections in Differential Geometry

## 中文部分

### 1. 主丛的基本定义

主丛是微分几何中的核心概念，它提供了描述对称性和规范变换的统一框架。给定李群 $G$ 和光滑流形 $M$，主 $G$-丛 $\pi: P \rightarrow M$ 是一个光滑纤维丛，满足以下条件：

**定义**：设 $P$ 是光滑流形，$M$ 是基空间，$\pi: P \rightarrow M$ 是光滑的满射。如果存在 $G$ 在 $P$ 右边的自由真作用，使得：
- 轨道恰好是 $\pi$ 的纤维
- 局部上，$P$ 可以写成 $U \times G$ 的形式

则称 $\pi: P \rightarrow M$ 为主 $G$-丛。

最基本的例子是 $M = S^1$，$P = \mathbb{R}$，$G = \mathbb{Z}$，由 $n \cdot x = x + 2\pi n$ 定义作用。另一个重要例子是球面丛：$S^{n-1} \rightarrow \mathbb{R}^n \setminus \{0\} \rightarrow \mathbb{RP}^{n-1}$。

### 2. 联络的几何意义

联络是主丛上的关键结构，它允许我们在纤维之间进行"平行传输"。联络可以通过若干等价的方式定义。

**定义（联络的逐点定义）**：主 $G$-丛 $\pi: P \rightarrow M$ 上的联络是 $P$ 的切空间 $TP$ 的一个分解：
$$TP = VP \oplus HP$$

其中 $VP$ 是竖直子丛（与纤维方向相切），$HP$ 是水平子丛，满足：
- $\dim(HP) = \dim(M)$
- $R_g^* HP = HP$（在右作用下不变）

这里 $R_g: P \rightarrow P$ 是右乘映射 $R_g(p) = pg$。

**联络形式**：对于主丛 $\pi: P \rightarrow M$，取定一个基点，设其纤维为 $F \cong G$。联络可以用李代数值的 1-形式 $\omega \in \Omega^1(P, \mathfrak{g})$ 表示，其中 $\mathfrak{g}$ 是 $G$ 的李代数，满足：
1. $R_g^* \omega = \text{Ad}_{g^{-1}} \circ \omega$
2. 对于基本向量场 $X^* = \frac{d}{dt}|_{t=0} \exp(tX)$（$X \in \mathfrak{g}$），有 $\omega(X^*) = X$

联络形式 $\omega$ 将每个切向量分解为水平和竖直分量。

### 3. 曲率与结构方程

联络的几何性质由其曲率 $\Omega$ 刻画，这是一个 2-形式：
$$\Omega = d\omega + \frac{1}{2}[\omega, \omega]$$

这称为结构方程或 Cartan 方程。$[\cdot, \cdot]$ 是李括号，提升到形式的楔积上。

**Bianchi 恒等式**：曲率满足
$$D\Omega = d\Omega + [\omega, \Omega] = 0$$

这是微分几何中的基本恒等式。

对于规范群 $G = U(1)$（电磁学的情形），$\mathfrak{g} \cong \mathbb{R}$，$\omega$ 就是通常的电磁势 $A_\mu dx^\mu$，而 $\Omega = dA = F_{\mu\nu}dx^\mu \wedge dx^\nu$ 是电磁场张量。

### 4. 平行传输与协变导数

给定光滑路径 $\gamma: [0,1] \rightarrow M$，可以将点 $p \in P_{\gamma(0)}$ 沿 $\gamma$ 平行传输到 $P_{\gamma(1)}$。具体地，存在唯一的水平提升 $\tilde{\gamma}: [0,1] \rightarrow P$ 满足：
- $\pi \circ \tilde{\gamma} = \gamma$
- $\tilde{\gamma}(0) = p$
- $\dot{\tilde{\gamma}}(t)$ 始终在 $H_{\tilde{\gamma}(t)}P$ 中

平行传输诱导出纤维间的微分同胚，这是理解联络的直观方式。

对于向量丛 $E \rightarrow M$（关联丛），联络定义了协变导数 $\nabla$：对任意截面 $s \in \Gamma(E)$ 和向量场 $X \in \mathfrak{X}(M)$，
$$\nabla_X s$$
满足莱布尼茨律和 $\mathbb{R}$-线性性。

### 5. 规范变换与规范不变性

选择 $P$ 的局部截面 $s: U \rightarrow P$（定义在 $M$ 的开集上），联络形式的限制 $A = s^*\omega$ 称为规范势。不同的截面选择对应不同的规范，它们通过规范变换 $g: U \rightarrow G$ 相关联：
$$A' = g^{-1}Ag + g^{-1}dg$$

这是规范论中的基本变换关系。曲率 2-形式在规范变换下变为：
$$\Omega' = g^{-1}\Omega g$$

这反映了曲率是规范协变的。

### 6. 特殊例子：Yang-Mills 论

在 4 维时空中，以 $G = SU(2)$ 为规范群的 Yang-Mills 理论的作用量为：
$$S_{YM} = -\frac{1}{4g^2}\int_M \text{Tr}(F \wedge *F)$$

其中 $F$ 是曲率 2-形式，$*$ 是 Hodge 星算子，$g$ 是耦合常数。这个作用量在规范变换和时空坐标变换下都是不变的，体现了量子色动力学（QCD）的数学基础。

---

## English Part

### 1. Fundamental Definition of Principal Bundles

Principal bundles are central structures in differential geometry, providing a unified framework for describing symmetries and gauge transformations. Given a Lie group $G$ and a smooth manifold $M$, a principal $G$-bundle $\pi: P \rightarrow M$ is a smooth fiber bundle satisfying specific conditions related to the right action of $G$ on $P$.

**Definition**: A principal $G$-bundle consists of:
- A smooth manifold $P$ (total space)
- A smooth surjection $\pi: P \rightarrow M$ (projection)
- A smooth free and proper right action of $G$ on $P$ such that orbits coincide with fibers of $\pi$
- Local triviality: for each $x \in M$, there exists a neighborhood $U$ and a diffeomorphism $\phi: \pi^{-1}(U) \rightarrow U \times G$

The structure group $G$ acts on the fibers, and locally the bundle looks like $U \times G$.

### 2. Connections and Their Geometric Meaning

A connection on a principal $G$-bundle allows us to compare tangent spaces at different points by "transporting" information along paths. The connection is fundamental for defining parallel transport and covariant derivatives.

**Definition**: A connection on $P$ is a $\mathfrak{g}$-valued 1-form $\omega \in \Omega^1(P, \mathfrak{g})$ satisfying:
1. $R_g^* \omega = \text{Ad}_{g^{-1}} \circ \omega$ (right equivariance)
2. For fundamental vector fields $X^* \in \mathfrak{X}(P)$, we have $\omega(X^*) = X$

The connection decomposes the tangent bundle as $TP = VP \oplus HP$, where:
- $VP = \ker(d\pi)$ is the vertical subbundle (tangent to fibers)
- $HP = \ker(\omega)$ is the horizontal subbundle (connection distribution)

### 3. Curvature and Structure Equations

The curvature of a connection is the $\mathfrak{g}$-valued 2-form:
$$\Omega = d\omega + \frac{1}{2}[\omega, \omega] \in \Omega^2(P, \mathfrak{g})$$

This is the Cartan structure equation. The curvature satisfies the Bianchi identity:
$$D\Omega = d\Omega + [\omega, \Omega] = 0$$

For electromagnetism with $G = U(1)$, the connection form $\omega = A_\mu dx^\mu$ is the electromagnetic potential, and $\Omega = F_{\mu\nu}dx^\mu \wedge dx^\nu$ is the electromagnetic field strength tensor.

### 4. Parallel Transport and Covariant Derivatives

For a smooth path $\gamma: [0,1] \rightarrow M$, there exists a unique horizontal lift $\tilde{\gamma}: [0,1] \rightarrow P$ satisfying:
- $\pi(\tilde{\gamma}(t)) = \gamma(t)$
- $\dot{\tilde{\gamma}}(t) \in H_{\tilde{\gamma}(t)}P$ (horizontal tangent space)

This defines parallel transport $T_\gamma: P_{\gamma(0)} \rightarrow P_{\gamma(1)}$, a diffeomorphism of fibers.

For associated vector bundles $E = P \times_G V$, the connection induces a covariant derivative $\nabla$ on sections:
$$\nabla: \Gamma(E) \rightarrow \Gamma(T^*M \otimes E)$$

### 5. Gauge Transformations

By choosing local sections of $P$, we obtain local gauge potentials. Different choices are related by gauge transformations $g: U \rightarrow G$:
$$A' = g^{-1}Ag + g^{-1}dg$$

The curvature transforms as $\Omega' = g^{-1}\Omega g$, showing gauge covariance.

### 6. Yang-Mills Theory

The Yang-Mills action on 4-dimensional spacetime with gauge group $G$ is:
$$S = -\frac{1}{4g^2}\int_M \text{Tr}(F \wedge *F) = -\frac{1}{4g^2}\int_M d^4x \sqrt{g} F_{\mu\nu}F^{\mu\nu}$$

This action is invariant under gauge transformations and describes the dynamics of non-abelian gauge fields, fundamental to the Standard Model and QCD.

---

**字数统计**：约2800字
