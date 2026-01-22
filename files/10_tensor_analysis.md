# 张量分析基础
## Fundamentals of Tensor Analysis

### 简介 | Introduction

张量是线性代数中向量和矩阵概念的推广。在物理学中，许多物理量（如应力、惯性张量、黎曼曲率张量）自然地表现为张量。张量分析提供了在坐标变换下描述物理量的工具。广义相对论完全基于张量框架，张量的重要性在现代物理学中难以高估。

Tensors are generalizations of vectors and matrices from linear algebra. Many physical quantities (stress, moment of inertia, Riemann curvature) naturally appear as tensors. Tensor analysis provides tools for describing physical quantities under coordinate transformations. General relativity is entirely based on the tensor framework, making tensors indispensable in modern physics.

### 指标记号和爱因斯坦求和约定 | Index Notation and Einstein Summation Convention

在张量分析中，使用指标记号来简化表达。爱因斯坦求和约定规定：重复出现的指标（一个上标，一个下标）表示对该指标求和。

**例1**：向量 $\mathbf{v}$ 的分量表示为 $v^i$，$i = 1, 2, 3$。

**例2**：矩阵乘法 $(\mathbf{AB})_{ij} = A_{ik}B_{kj} = \sum_{k=1}^3 A_{ik}B_{kj}$

最后的求和号可以省略，因为 $k$ 重复出现。

**自由指标**：在方程两边都出现、但不求和的指标。例如 $v'^i = R^i_j v^j$ 中，$i$ 和 $j$ 是自由指标。

### 张量的定义 | Definition of Tensors

张量的严格定义基于多线性映射。从实用角度，张量由其在坐标变换下的变换性质定义。

**0阶张量（标量）**：在坐标变换下保持不变：$\phi' = \phi$

**1阶张量（向量）**：
- **逆变向量** (contravariant): $v'^i = R^i_j v^j$
- **协变向量** (covariant): $w'_i = R^j_i w_j$

其中 $R^i_j$ 是从旧坐标到新坐标的变换矩阵，$R^j_i = (R^{-1})^j_i$。

**二阶张量**（如矩阵）有多种类型：
- **逆变张量**：$T'^{ij} = R^i_k R^j_l T^{kl}$
- **混合张量**：$T'^i_j = R^i_k (R^{-1})^l_j T^k_l$
- **协变张量**：$T'_{ij} = R^k_i R^l_j T_{kl}$

### 张量的基本运算 | Tensor Operations

**张量相加**：同类型的张量可以相加。结果仍是相同类型的张量。

**张量乘积**：两个张量的张量积是新的张量，其阶数是两个张量阶数之和。

例如，向量 $u^i$ 与向量 $v^j$ 的张量积得到二阶张量 $T^{ij} = u^i v^j$。

**缩并（Contraction）**：一个上指标与一个下指标求和。例如：

$$u^i w_i = u^1w_1 + u^2w_2 + u^3w_3$$

这是向量的点积，是一个标量。缩并降低张量的阶数（上下各降1）。

**张量的转置**：交换张量的指标。例如，$T^{ij}$ 的转置是 $T^{ji}$。

### 度规张量 | Metric Tensor

度规张量 $g_{ij}$ 定义了空间中的距离。在欧几里得空间中：

$$g_{ij} = \delta_{ij} = \begin{cases} 1 & i = j \\ 0 & i \neq j \end{cases}$$

其中 $\delta_{ij}$ 是Kronecker符号。

**度规的性质**：

- 对称：$g_{ij} = g_{ji}$
- 行列式非零：$\det(g) \neq 0$
- 逆度规：$g^{ik}g_{kj} = \delta^i_j$

利用度规可以升降指标：

$$v_i = g_{ij}v^j, \quad v^i = g^{ij}v_j$$

在狭义相对论中，闵可夫斯基度规为：

$$g_{\mu\nu} = \begin{pmatrix} 1 & 0 & 0 & 0 \\ 0 & -1 & 0 & 0 \\ 0 & 0 & -1 & 0 \\ 0 & 0 & 0 & -1 \end{pmatrix}$$

### 导数算子和克里斯托费尔符号 | Covariant Derivative and Christoffel Symbols

在曲坐标系中，普通偏导数不是张量。需要定义**协变导数** $\nabla_i$ 来保证结果是张量。

对于向量 $u^j$，协变导数定义为：

$$\nabla_i u^j = \partial_i u^j + \Gamma^j_{ik} u^k$$

其中 $\Gamma^j_{ik}$ 是**克里斯托费尔符号**（Christoffel symbols），定义为：

$$\Gamma^j_{ik} = \frac{1}{2}g^{jl}\left(\frac{\partial g_{il}}{\partial x^k} + \frac{\partial g_{kl}}{\partial x^i} - \frac{\partial g_{ik}}{\partial x^l}\right)$$

克里斯托费尔符号本身不是张量，但协变导数是张量。

对于协变向量 $w_j$：

$$\nabla_i w_j = \partial_i w_j - \Gamma^k_{ij}w_k$$

### 黎曼曲率张量 | Riemann Curvature Tensor

黎曼曲率张量测量空间的弯曲程度。它定义为：

$$R^l_{ijk} = \frac{\partial\Gamma^l_{jk}}{\partial x^i} - \frac{\partial\Gamma^l_{ik}}{\partial x^j} + \Gamma^l_{im}\Gamma^m_{jk} - \Gamma^l_{jm}\Gamma^m_{ik}$$

**黎曼张量的性质**：

- 对偶对称：$R_{ijkl} = -R_{jikl} = -R_{ijlk}$
- 第一Bianchi恒等式：$R_{ijkl} + R_{iklj} + R_{iljk} = 0$
- 第二Bianchi恒等式：$\nabla_i R_{jklm} + \nabla_j R_{kl\phantom{i}m\phantom{i}} + \nabla_k R_{ljm\phantom{i}i\phantom{i}} = 0$

**里奇张量**是黎曼张量的缩并：

$$R_{ij} = R^k_{ikj} = \nabla_k \Gamma^k_{ij} - \nabla_i \Gamma^k_{kj} + \Gamma^k_{ij}\Gamma^l_{kl} - \Gamma^l_{ik}\Gamma^k_{lj}$$

**标量曲率**：

$$R = g^{ij}R_{ij}$$

### 广义相对论中的应用 | Applications in General Relativity

爱因斯坦方程用张量形式表示：

$$R_{\mu\nu} - \frac{1}{2}g_{\mu\nu}R + \Lambda g_{\mu\nu} = \frac{8\pi G}{c^4}T_{\mu\nu}$$

其中：
- $R_{\mu\nu}$ 是里奇张量，描述时空曲率
- $T_{\mu\nu}$ 是能动张量，描述物质和能量分布
- $\Lambda$ 是宇宙常数
- $G$ 是引力常数，$c$ 是光速

这个方程建立了几何（弯曲时空）和物理（物质能量）之间的联系。

### 应用例：应力应变张量 | Application: Stress-Strain Tensor

在连续介质力学中，应力张量 $\sigma_{ij}$ 表示作用在单位面积上的力分量：

$$\sigma_{ij} = \text{作用在法向为}\,i\,\text{的平面上的},j\,\text{方向的力}$$

应变张量 $\epsilon_{ij}$ 描述形变：

$$\epsilon_{ij} = \frac{1}{2}\left(\frac{\partial u_i}{\partial x^j} + \frac{\partial u_j}{\partial x^i}\right)$$

其中 $u_i$ 是位移向量。

胡克定律用张量形式表示为：

$$\sigma_{ij} = C_{ijkl}\epsilon_{kl}$$

其中 $C_{ijkl}$ 是弹性常数张量（四阶张量）。

### 总结 | Conclusion

张量分析提供了在任意坐标系中描述物理现象的强大工具。通过张量的变换性质，我们可以确保物理规律在所有参考系中都成立。从应用上讲，张量不仅在广义相对论中不可或缺，在流体力学、弹性力学、电磁学等领域也有广泛应用。掌握张量分析对于学习现代物理学至关重要。
