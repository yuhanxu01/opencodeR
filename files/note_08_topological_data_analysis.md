# 拓扑数据分析
# Topological Data Analysis

## 中文部分

### 1. 持续同调的基本概念

拓扑数据分析（TDA）是利用代数拓扑和计算拓扑学来分析数据的方法。其核心是持续同调（persistent homology），能识别数据的拓扑特征在多个尺度上的出现与消失。

**Vietoris-Rips 复形**：给定点云 $X = \{p_1, \ldots, p_n\} \subset \mathbb{R}^d$ 和参数 $\epsilon > 0$，Vietoris-Rips 复形定义为：
$$VR_\epsilon(X) = \{S \subseteq X: d(p_i, p_j) \leq \epsilon \text{ for all } p_i, p_j \in S\}$$

其中 $d$ 是欧几里得距离。这产生了一个单纯复形链：
$$\emptyset \subset VR_{\epsilon_1}(X) \subset VR_{\epsilon_2}(X) \subset \cdots$$

当 $\epsilon$ 增加时。

**Čech 复形**：另一种常见的复形是 Čech 复形，定义为
$$\check{C}_\epsilon(X) = \{S \subseteq X: \bigcap_{p \in S}B_\epsilon(p) \neq \emptyset\}$$

其中 $B_\epsilon(p)$ 是中心为 $p$、半径为 $\epsilon$ 的球。

### 2. 单纯复形与链复形

**单纯形**：$k$ 维单纯形是 $k+1$ 个点的凸包，记为 $[v_0, \ldots, v_k]$。

**单纯复形**：单纯形的集合 $K$，满足：
1. 若 $\sigma \in K$ 且 $\tau$ 是 $\sigma$ 的面（任意顶点子集的凸包），则 $\tau \in K$
2. 若 $\sigma, \tau \in K$，则 $\sigma \cap \tau$ 是空或两者的面

**链群与边界算子**：定义 $k$ 链群 $C_k(K)$ 为 $k$ 维单纯形的形式和：
$$c_k = \sum_{i} a_i \sigma_i^{(k)}, \quad a_i \in \mathbb{Z}_2 \text{ or } \mathbb{F}_2$$

边界算子 $\partial_k: C_k(K) \rightarrow C_{k-1}(K)$ 定义为移除一个顶点：
$$\partial_k[\sigma_0, \ldots, \sigma_k] = \sum_{i=0}^k (-1)^i [\sigma_0, \ldots, \hat{\sigma}_i, \ldots, \sigma_k]$$

其中 $\hat{\sigma}_i$ 表示省略该顶点。关键性质：$\partial_{k-1} \circ \partial_k = 0$。

### 3. 同调群与 Betti 数

通过边界算子的核与像，定义同调群：
$$H_k(K) = \ker(\partial_k) / \text{im}(\partial_{k+1})$$

$k$ 链中的元素若在 $\ker(\partial_k)$ 中称为 $k$-圈（不存在边界），若在 $\text{im}(\partial_{k+1})$ 中称为 $k$-边（本身是某个 $k+1$ 链的边界）。

**Betti 数**：同调群的秩
$$\beta_k = \text{rank}(H_k(K))$$

直观含义：
- $\beta_0$：连通分量个数
- $\beta_1$：独立循环个数（"孔洞"）
- $\beta_2$：独立的"空腔"个数

**Euler 特征**：
$$\chi(K) = \sum_k (-1)^k \beta_k$$

### 4. 持续同调与长度模

**持续同调**：对于单纯复形的过滤：
$$K_0 \subseteq K_1 \subseteq \cdots \subseteq K_n$$

对每个 $\epsilon_i$ 有包含映射 $f_i: K_i \rightarrow K_{i+1}$ 诱导同调的映射：
$$H_k(K_i) \rightarrow H_k(K_{i+1})$$

追踪某个同调类何时产生（出现）、何时消失（合并为零）。

**持续图与重数**：将这个信息编码为点集合 $\{(b_i, d_i)\}$，其中 $b_i$ 是出现时间，$d_i$ 是消失时间。点 $(b, d)$ 到对角线 $b = d$ 的距离 $d - b$ 称为持续性（persistence），量化了特征的"强度"。

### 5. 计算复杂性与算法

**计算同调的关键步骤**：
1. **降低矩阵形式**：将边界算子表示为矩阵，行对应 $k$ 链，列对应 $(k-1)$ 链
2. **Smith 正规形式**：通过行列初等变换化为对角形式
3. **读出拓扑信息**：非零对角元素个数是该维度的秩

关键复杂性：Smith 正规形式计算的最坏情况为 $O(n^3)$。

**高效算法**：
- **Persistent cohomology**：在上同调中计算，通常更快
- **标准算法**：首先从最高维开始减少秩
- **矩阵约简**：只跟踪必要的列，显著降低时间复杂性

### 6. 映射圆柱与诱导同态

**映射圆柱**：给定映射 $f: X \rightarrow Y$，其映射圆柱定义为：
$$M_f = \frac{(X \times [0,1]) \sqcup Y}{(x, 1) \sim f(x)}$$

拓扑上，$M_f$ 回缩变形到 $Y$（保留了关于 $f$ 的信息）。

这在 TDA 中用于比较两个数据集的拓扑。

### 7. 应用：数据形状识别与聚类

**持续图的稳定性**：如果点云 $X$ 扰动为 $X'$（Hausdorff 距离小），则对应持续图 $D(X)$ 和 $D(X')$ 的 Bottleneck 距离也小。这保证了方法的鲁棒性。

**距离定义**：
$$d_{B}(D(X), D(X')) = \inf_{\gamma} \max_{(b,d) \in D(X)} \|(b,d) - \gamma(b,d)\|_\infty$$

其中下确界遍历所有一一对应。

**应用范例**：
1. **图像识别**：将图像像素作为点云，其持续图特征识别形状
2. **蛋白质分析**：蛋白质 3D 结构的拓扑分析，预测功能
3. **时间序列分析**：延时嵌入后的拓扑结构分析

**机器学习整合**：持续图可作为特征输入到分类器（SVM、神经网络等），或使用 persistence landscape（将持续图转换为函数）进行统计分析。

---

## English Part

### 1. Persistent Homology Fundamentals

Topological Data Analysis (TDA) uses algebraic topology to analyze point clouds, with persistent homology as the core tool.

**Vietoris-Rips Complex**: For point cloud $X$ and parameter $\epsilon$:
$$VR_\epsilon(X) = \{S \subseteq X: d(p_i, p_j) \leq \epsilon \text{ for all } p_i, p_j \in S\}$$

This creates a filtration: $VR_{\epsilon_1} \subseteq VR_{\epsilon_2} \subseteq \cdots$

**Čech Complex**: Alternative construction:
$$\check{C}_\epsilon(X) = \{S \subseteq X: \bigcap_{p \in S}B_\epsilon(p) \neq \emptyset\}$$

### 2. Simplicial Complexes and Chain Complexes

**Simplex**: $k$-simplex is convex hull of $k+1$ points.

**Simplicial Complex**: Collection $K$ of simplices closed under taking faces.

**Chain Groups**: $C_k(K)$ = formal sums of $k$-simplices. Boundary operator:
$$\partial_k[\sigma_0, \ldots, \sigma_k] = \sum_{i=0}^k (-1)^i [\sigma_0, \ldots, \hat{\sigma}_i, \ldots, \sigma_k]$$

Key: $\partial_k \circ \partial_{k+1} = 0$.

### 3. Homology and Betti Numbers

**Homology Groups**:
$$H_k(K) = \ker(\partial_k) / \text{im}(\partial_{k+1})$$

**Betti Numbers**: $\beta_k = \text{rank}(H_k)$
- $\beta_0$: connected components
- $\beta_1$: independent loops
- $\beta_2$: voids

**Euler Characteristic**: $\chi = \sum_k (-1)^k \beta_k$

### 4. Persistent Homology and Lifetime Modules

For filtration $K_0 \subseteq K_1 \subseteq \cdots$, track when homology classes appear (birth) and disappear (death).

**Persistence Diagram**: Points $(b_i, d_i)$ where persistence is $d_i - b_i$.

Distance to diagonal $y = x$ quantifies feature strength.

### 5. Computational Complexity

**Smith Normal Form**: Reduce boundary matrices to diagonal form to read off ranks.

Worst case: $O(n^3)$. Optimized algorithms use:
- Persistent cohomology (faster)
- Matrix reduction (lower time complexity)

### 6. Mapping Cylinder

For map $f: X \to Y$:
$$M_f = \frac{(X \times [0,1]) \sqcup Y}{(x,1) \sim f(x)}$$

Used to compare topologies of two datasets.

### 7. Applications

**Stability**: If point cloud $X$ perturbed to $X'$ (small Hausdorff distance), persistence diagrams $D(X)$ and $D(X')$ are close in bottleneck distance.

**Bottleneck Distance**:
$$d_B(D(X), D(X')) = \inf_\gamma \max_{(b,d) \in D(X)} \|(b,d) - \gamma(b,d)\|_\infty$$

**Applications**:
- Image recognition from point clouds
- Protein structure analysis
- Time series topological features

Integration with machine learning: use persistence diagrams as features for classifiers or convert to persistence landscapes.

---

**字数统计**：约2850字
