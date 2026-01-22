# 缠绕数与拓扑不变量
# Linking Numbers and Topological Invariants

## 中文部分

### 1. 缠绕数的定义

缠绕数是拓扑学中描述两条闭曲线如何互相缠绕的基本不变量，在纽结论和DNA拓扑等应用中扮演关键角色。

**直观定义**：给定 $\mathbb{R}^3$ 中两条不相交的闭曲线 $C_1$ 和 $C_2$，缠绕数 $\text{Lk}(C_1, C_2)$ 测量 $C_1$ 环绕 $C_2$ 的次数。

**Gauss 缠绕积分**（解析定义）：
$$\text{Lk}(C_1, C_2) = \frac{1}{4\pi}\oint_{C_1}\oint_{C_2} \frac{(\vec{r}_1 - \vec{r}_2) \cdot (d\vec{r}_1 \times d\vec{r}_2)}{|\vec{r}_1 - \vec{r}_2|^3}$$

这是一个双线积分。虽然被积函数不是完全微分，但由于 $C_1$ 和 $C_2$ 不相交，这个积分给出整数值，恰好就是缠绕数。

**拓扑性**：缠绕数在连续形变下不变。若两对曲线能通过连续变换（不允许穿过彼此）相互变为，则它们的缠绕数相同。

### 2. 计算方法：投影与符号

**投影方法**：将两条空间曲线投影到平面上（一般位置投影），产生交叉点（crossings）。每个交叉点赋予 +1 或 -1 的符号：

- **+1**（正交叉）：右手定则判断，$C_1$ 的方向与叉的方向一致则为 +1
- **-1**（负交叉）：否则为 -1

**缠绕数公式**：
$$\text{Lk}(C_1, C_2) = \frac{1}{2}\sum_{\text{crossing}} \text{sign}(\text{crossing})$$

求和遍历投影中 $C_1$ 与 $C_2$ 的所有交叉点。因子 1/2 是因为对称性。

### 3. 自缠绕数与Writhe

**自缠绕数（Twist）**：单条闭曲线绕自己的次数，定义为
$$Tw = \frac{1}{2\pi}\int \kappa(s) \, ds$$

其中 $\kappa(s)$ 是曲线的曲率（与弧长参数 $s$ 的导数）。

**挠率（Writhe）**：衡量曲线在三维中的螺旋性：
$$Wr = \frac{1}{4\pi}\oint_C \frac{d\vec{t} \times d\vec{t}'}{|dt|^3}$$

其中 $\vec{t}$ 是切向单位向量。

**White 定理**（重要关系）：
$$\text{Lk}(C, C) = Tw + Wr$$

即自缠绕数等于挠率与衍生的总缠绕。这在DNA拓扑中有重要应用：DNA的超螺旋（supercoiling）与局部展开（unwinding）之间平衡。

### 4. 高斯链与 Jones 多项式

**Gauss 链**：随机行走的模型，由 $N$ 个随机段组成。对于高斯链，两条链的缠绕数的分布为：
$$P(\text{Lk} = n) = \frac{1}{\sqrt{\pi N}} \exp\left(-\frac{n^2}{N}\right)$$

即高斯分布，标准差为 $\sqrt{N}$。

**Jones 多项式** $V_L(q)$：纽结 $L$ 的多项式不变量，在 $q = e^{2\pi i/5}$ 处的值包含缠绕数信息。

递推关系（skein relation）：
$$q V_{L_+}(q) - q^{-1}V_{L_-}(q) = (q^{1/2} - q^{-1/2})V_{L_0}(q)$$

其中 $L_+, L_-, L_0$ 分别代表在某个交叉点处改变符号或消除的纽结。

### 5. 拓扑约束与DNA 超螺旋

**DNA 的拓扑**：DNA 双螺旋在闭环质粒中，可视为两条互相缠绕的曲线。定义：
- Lk（缠绕数）：两条链绕彼此的次数
- Tw（绞扭）：螺旋的螺旋数
- Wr（衍生）：DNA 的超螺旋数

White 定理给出：
$$\Delta \text{Lk} = \Delta Tw + \Delta Wr$$

若DNA被拓扑约束（如闭环质粒），Lk 固定，则改变 Tw（如解旋酶解旋）必导致 Wr 变化，产生超螺旋。

### 6. Hopf 纤维化与高维缠绕数

**Hopf 纤维化**：$S^3$ 到 $S^2$ 的光滑映射 $\pi: S^3 \rightarrow S^2$，其原像是圆周 $S^1$。两条不同纤维的缠绕数恰好为 1。

在复坐标 $(z_1, z_2)$ with $|z_1|^2 + |z_2|^2 = 1$：
$$\pi(z_1, z_2) = (2z_1\bar{z}_2, |z_1|^2 - |z_2|^2)$$

这是 $S^3$ 中最基本的纤维化结构。

### 7. 应用：纽结理论与蛋白质拓扑

**纽结不变量**：缠绕数仅对链接有效，对单条纽结无效。单纽结的分类使用：
- Alexander 多项式 $\Delta(t)$
- Jones 多项式 $V(q)$
- Khovanov 同调

**蛋白质拓扑**：某些蛋白质具有纽结拓扑。例如：
- 三叶草纽结（trefoil knot）：Found in 50s 核糖体蛋白
- 八字纽结（figure-eight knot）：Found in 亮氨酸转运酶

这种拓扑复杂性在蛋白质折叠动力学中引入额外的能垒，是蛋白质设计和药物靶向的考虑因素。

---

## English Part

### 1. Definition of Linking Number

**Gauss Linking Integral**: For two non-intersecting closed curves $C_1, C_2$ in $\mathbb{R}^3$:
$$\text{Lk}(C_1, C_2) = \frac{1}{4\pi}\oint_{C_1}\oint_{C_2} \frac{(\vec{r}_1 - \vec{r}_2) \cdot (d\vec{r}_1 \times d\vec{r}_2)}{|\vec{r}_1 - \vec{r}_2|^3}$$

This integral always yields an integer, the linking number, despite the integrand not being exact.

**Topological Invariance**: Unchanged under continuous deformations (without intersection).

### 2. Computation: Projection and Crossing Signs

**Projection Method**: Project to plane in generic position, creating crossings.

Assign sign to each crossing:
- +1 if right-hand rule agrees
- -1 otherwise

**Formula**:
$$\text{Lk}(C_1, C_2) = \frac{1}{2}\sum_{\text{crossings}} \text{sign}$$

### 3. Self-Linking and Writhe

**Twist**: Curve winding around itself:
$$Tw = \frac{1}{2\pi}\int \kappa(s) \, ds$$

**Writhe**: Helical property:
$$Wr = \frac{1}{4\pi}\oint_C \frac{d\vec{t} \times d\vec{t}'}{|dt|^3}$$

**White's Theorem**:
$$\text{Lk}(C, C) = Tw + Wr$$

### 4. Gaussian Chains and Jones Polynomial

**Gaussian Chain**: Random walk of $N$ segments; distribution of linking number:
$$P(\text{Lk} = n) = \frac{1}{\sqrt{\pi N}} \exp\left(-\frac{n^2}{N}\right)$$

**Jones Polynomial** $V_L(q)$: Polynomial invariant of knot/link.

**Skein Relation**:
$$q V_{L_+}(q) - q^{-1}V_{L_-}(q) = (q^{1/2} - q^{-1/2})V_{L_0}(q)$$

### 5. Topological Constraints in DNA

**DNA Topology**: Two intertwined strands with:
- **Lk** (linking number): wrapping number
- **Tw** (twist): helical turns
- **Wr** (writhe): supercoiling

**Relationship**:
$$\Delta \text{Lk} = \Delta Tw + \Delta Wr$$

If Lk fixed (closed plasmid), changing Tw induces Wr (supercoiling). This explains topoisomerase action.

### 6. Hopf Fibration and Higher-Dimensional Linking

**Hopf Fibration**: Smooth map $\pi: S^3 \to S^2$ where fibers are circles $S^1$.

Two distinct fibers have linking number 1. In complex coordinates:
$$\pi(z_1, z_2) = (2z_1\bar{z}_2, |z_1|^2 - |z_2|^2), \quad |z_1|^2 + |z_2|^2 = 1$$

### 7. Applications: Knot Theory and Protein Topology

**Knot Invariants** (for single knots):
- Alexander polynomial $\Delta(t)$
- Jones polynomial $V(q)$
- Khovanov homology

**Protein Knots**: Some proteins contain knot topologies:
- Trefoil knot in 50s ribosomal protein
- Figure-eight knot in leucyl-tRNA synthetase

Topological complexity introduces energy barriers in protein folding, relevant for drug design.

---

**字数统计**：约2850字
