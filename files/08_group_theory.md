# 群论基础
## Fundamentals of Group Theory

### 简介 | Introduction

群论是代数学的重要分支，研究具有特定运算结构的集合。群论在物理学中有深刻的应用，特别是在对称性分析和量子力学中。从分子的对称操作到基本粒子的规范对称性，群论提供了理解自然界对称性的数学框架。

Group theory is an important branch of algebra studying sets with specific operational structures. It has profound applications in physics, particularly in symmetry analysis and quantum mechanics. From molecular symmetry operations to gauge symmetries of fundamental particles, group theory provides a mathematical framework for understanding nature's symmetries.

### 群的定义 | Definition of a Group

群 $(G, \circ)$ 是一个集合 $G$ 配备一个二元运算 $\circ$，满足以下四个性质：

A group $(G, \circ)$ is a set $G$ with a binary operation $\circ$ satisfying:

**1. 封闭性**（Closure）：对任意 $a, b \in G$，$a \circ b \in G$

**2. 结合律**（Associativity）：对任意 $a, b, c \in G$，$(a \circ b) \circ c = a \circ (b \circ c)$

**3. 幺元**（Identity element）：存在 $e \in G$，对任意 $a \in G$，$a \circ e = e \circ a = a$

**4. 逆元**（Inverse element）：对任意 $a \in G$，存在 $a^{-1} \in G$，使得 $a \circ a^{-1} = a^{-1} \circ a = e$

若群还满足交换律 $a \circ b = b \circ a$，称为**阿贝尔群**（Abel group）或交换群。

群的阶 $|G|$ 是其元素的个数。

### 常见的群 | Common Groups

**整数加法群** $(\mathbb{Z}, +)$：所有整数在加法下构成无限交换群。

**有限循环群** $\mathbb{Z}_n$：$\{0, 1, \ldots, n-1\}$ 在模 $n$ 加法下构成的有限交换群，阶为 $n$。

**对称群** $S_n$：$n$ 个元素的所有排列在函数复合下构成的群，阶为 $n!$。对于 $n \geq 3$，$S_n$ 是非交换群。

**旋转群** $SO(3)$：三维空间的所有旋转在复合下构成的群，描述刚体旋转。

**酉群** $U(n)$：$n \times n$ 酉矩阵在矩阵乘法下的群，在量子力学中描述对称变换。

**格路普** $GL(n, \mathbb{R})$：$n \times n$ 可逆实矩阵在矩阵乘法下的群。

### 子群 | Subgroups

若群 $H$ 是群 $G$ 的子集，且 $H$ 在 $G$ 的运算下也构成群，则 $H$ 是 $G$ 的子群，记为 $H \leq G$。

子群的判定定理：非空子集 $H$ 是 $G$ 的子群当且仅当对任意 $a, b \in H$，有 $ab^{-1} \in H$。

**拉格朗日定理**（Lagrange's Theorem）：有限群 $G$ 的子群的阶必整除 $G$ 的阶：

$$|H| \mid |G|$$

### 群的生成元 | Generators

如果群 $G$ 的每个元素都可以表示为某些元素（称为生成元）的幂的乘积，则称这些元素生成了 $G$。

对于循环群，只需一个生成元 $g$：

$$G = \{e, g, g^2, \ldots, g^{n-1}\}$$

其中 $g^n = e$，$n$ 是群的阶。

### 群的同态和同构 | Homomorphisms and Isomorphisms

**群同态**是保持群运算的映射。若 $f: G \to H$ 满足：

$$f(ab) = f(a)f(b) \quad \forall a, b \in G$$

则 $f$ 是群同态。

**群同构**是双射的同态。若存在同构 $f: G \to H$，则群 $G$ 和 $H$ 同构，记为 $G \cong H$。

**第一同构定理**：如果 $f: G \to H$ 是群同态，则：

$$G/\ker(f) \cong \text{Im}(f)$$

其中 $\ker(f) = \{g \in G | f(g) = e_H\}$ 是 $f$ 的核。

### 陪集和正规子群 | Cosets and Normal Subgroups

对于子群 $H$ 和元素 $g \in G$，左陪集定义为：

$$gH = \{gh | h \in H\}$$

**拉格朗日定理的推广**：$G$ 可以分解为 $H$ 的不相交陪集的并：

$$G = g_1H \cup g_2H \cup \cdots \cup g_kH$$

其中 $k = |G|/|H|$ 是陪集个数。

**正规子群**是满足 $gH = Hg$ 的子群，记为 $H \triangleleft G$。对正规子群，可以定义商群 $G/H$，其元素是陪集，运算定义为 $(aH)(bH) = (ab)H$。

### 直积 | Direct Products

两个群 $G$ 和 $H$ 的直积 $G \times H$ 是以 $(g, h)$ 为元素、运算为 $(g_1, h_1)(g_2, h_2) = (g_1g_2, h_1h_2)$ 的群。

若 $|G| = m$，$|H| = n$，且 $\gcd(m,n) = 1$，则 $G \times H$ 是循环群当且仅当 $G$ 和 $H$ 都是循环群。

### 对称性和物理应用 | Symmetry and Physical Applications

在物理中，对称性由群来描述。例如：

**晶体对称性**：晶体的点群描述其几何对称性，空间群描述平移和旋转对称性。

**分子对称**：分子的点群标记其对称操作（旋转、反演等）。这在分子光谱学中确定允许的跃迁很重要。

**基本粒子物理**：

标准模型使用规范群 $SU(3) \times SU(2) \times U(1)$ 描述强、弱和电磁相互作用。

洛伦兹群 $SO(3,1)$ 描述狭义相对论的对称性。

**表示论**：群的表示是群元素到矩阵的映射，保持群的乘法结构。在量子力学中，对称变换由群的表示给出。

### 李群 | Lie Groups

李群是具有光滑微分流形结构的群。连续对称性由李群描述。

**旋转群** $SO(3)$ 是三维实正交矩阵的特殊正交群，参数化为三个欧拉角。

**酉群** $U(1)$ 是 $e^{i\theta}$ 的集合，描述电磁学中的规范对称性。

**李代数**是李群的线性化，由生成元和对易关系定义。例如 $SO(3)$ 的李代数 $\mathfrak{so}(3)$ 由三个角动量算符生成：

$$[L_i, L_j] = i\hbar\epsilon_{ijk}L_k$$

### 总结 | Conclusion

群论提供了描述对称性的严格数学框架。无论是离散对称性还是连续对称性，群论都给出了统一的语言。在现代物理学中，从凝聚态物理到基本粒子物理，从相对论到量子场论，群论无处不在。理解群论对于深入掌握物理学的对称性原理至关重要。
