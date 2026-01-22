# 统计力学基础
## Fundamentals of Statistical Mechanics

### 简介 | Introduction

统计力学是用统计方法从微观状态出发推导宏观物理规律的学科。它建立了微观世界（原子、分子）和宏观世界（热力学量、物体性质）之间的联系。统计力学解释了为什么由大量粒子组成的系统会表现出确定性的热力学规律，是现代物理学最重要的基础理论之一。

Statistical mechanics derives macroscopic physical laws from microscopic states using statistical methods. It connects the microscopic world (atoms, molecules) with the macroscopic world (thermodynamic quantities, material properties). It explains why systems of vast numbers of particles exhibit deterministic thermodynamic behavior. It is one of the most important foundational theories in modern physics.

### 基本概念 | Basic Concepts

**微观状态**：系统中所有粒子的位置和动量的完整描述。对于 $N$ 个粒子的系统，需要 $6N$ 个坐标（三维位置和速度）。

**宏观状态**：系统的热力学描述，如温度、压强、体积等。一个宏观状态对应许多微观状态。

**相空间**：所有可能微观状态构成的 $6N$ 维空间。

**相轨迹**：系统在相空间中随时间演化的轨迹。

**遍历假说**：在足够长的时间内，系统在相空间中将访问与给定能量对应的所有点。这使得时间平均等于集合平均。

### 等概率原理和统计系综 | Principle of Equal Probability and Ensembles

**等概率原理**：孤立系统的每个微观状态出现的概率相等。

**统计系综**：许多全同系统的集合，每个系统处于不同的微观状态但有相同的宏观约束条件。

主要的统计系综有三种：

**微正则系综** (Microcanonical Ensemble)：孤立系统，能量 $E$、体积 $V$、粒子数 $N$ 都固定。对应实验中的孤立体系。

**正则系综** (Canonical Ensemble)：与温度为 $T$ 的热浴接触，$T$、$V$、$N$ 固定，$E$ 可变。对应大多数实验情况。

**巨正则系综** (Grand Canonical Ensemble)：与温度为 $T$、化学势为 $\mu$ 的环境接触，$T$、$V$、$\mu$ 固定，$E$ 和 $N$ 可变。用于开放系统。

### 微正则系综和熵 | Microcanonical Ensemble and Entropy

对于孤立系统，状态数（微观状态的个数）为 $\Omega(E)$。

**玻尔兹曼熵公式**：

$$S = k_B \ln\Omega(E)$$

这个公式连接了微观和宏观，解释了为什么孤立系统的熵会增加——系统趋向于占据更多的微观状态。

**温度定义**：

$$\frac{1}{T} = \frac{\partial S}{\partial E}\bigg|_{V,N} = k_B\frac{\partial\ln\Omega}{\partial E}\bigg|_{V,N}$$

### 正则系综和配分函数 | Canonical Ensemble and Partition Function

在与温度为 $T$ 的热浴平衡的系统中，微观状态 $i$ 的出现概率为：

$$P_i = \frac{e^{-\beta E_i}}{Z}$$

其中 $\beta = 1/(k_B T)$，$Z$ 是**配分函数**：

$$Z = \sum_i e^{-\beta E_i}$$

所有热力学量都可从配分函数导出：

**平均能量**：

$$\langle E \rangle = -\frac{\partial\ln Z}{\partial\beta}\bigg|_{V,N} = k_B T^2\frac{\partial\ln Z}{\partial T}\bigg|_{V,N}$$

**自由能**：

$$F = -k_B T\ln Z$$

**熵**：

$$S = k_B\ln Z + k_B T\frac{\partial\ln Z}{\partial T}\bigg|_{V,N}$$

**压强**：

$$P = k_B T\frac{\partial\ln Z}{\partial V}\bigg|_{T,N}$$

### 巨正则系综 | Grand Canonical Ensemble

在变粒子数系统中，微观状态 $(N, i)$ 的概率为：

$$P_{N,i} = \frac{e^{-\beta(E_{N,i} - \mu N)}}{\Xi}$$

其中 $\mu$ 是化学势，**巨配分函数**为：

$$\Xi = \sum_N \sum_i e^{-\beta(E_{N,i} - \mu N)}$$

平均粒子数：

$$\langle N \rangle = k_B T\frac{\partial\ln\Xi}{\partial\mu}\bigg|_{T,V}$$

### 理想气体的统计力学 | Statistical Mechanics of Ideal Gas

对于 $N$ 个无相互作用的粒子，单粒子配分函数为：

$$z = \frac{V}{\lambda^3}$$

其中 $\lambda = \sqrt{2\pi\hbar^2/(m k_B T)}$ 是**热德布罗意波长**。

系统配分函数（不考虑粒子全同性）：

$$Z_N = \frac{z^N}{N!}$$

由此导出：

**状态方程**：$PV = Nk_B T$（理想气体定律）

**内能**：$U = \frac{f}{2}Nk_B T$（其中 $f$ 是自由度数）

**热容**：$C_V = \frac{f}{2}Nk_B$

### 量子统计 | Quantum Statistics

在量子力学中，全同粒子遵循统计规律。

**费米-狄拉克分布**（费米子，半整数自旋）：

$$f_F(E) = \frac{1}{e^{\beta(E - \mu)} + 1}$$

**玻色-爱因斯坦分布**（玻色子，整数自旋）：

$$f_B(E) = \frac{1}{e^{\beta(E - \mu)} - 1}$$

在高温或低密度极限，两者都趋向经典的**麦克斯韦-玻尔兹曼分布**：

$$f_{MB}(E) = e^{\beta(\mu - E)}$$

### 强度涨落和临界现象 | Fluctuations and Critical Phenomena

在有限系统中，物理量不是严格固定的，而是围绕平均值涨落。

**能量涨落**：

$$(\Delta E)^2 = \langle E^2 \rangle - \langle E \rangle^2 = k_B T^2 C_V$$

相对涨落：$\frac{\Delta E}{\langle E \rangle} \propto \frac{1}{\sqrt{N}}$，N 很大时涨落可以忽略。

**临界点附近**，涨落变得巨大，系统的行为变得非常敏感。这导致**临界指数**的出现。

**费城平-沃默定律**（Fluctuation-dissipation theorem）：涨落和响应之间有深刻的关系。

### 相变 | Phase Transitions

**一阶相变**：在相变点，热力学势有跳跃，存在潜热。如液体-气体相变。

**二阶相变**：热力学势连续，但其导数有跳跃。如磁性相变。

**兰德劳理论**：用序参数 $\eta$ 描述相变。

$$F = F_0 + \frac{1}{2}a(T - T_c)\eta^2 + \frac{1}{4}b\eta^4 + \cdots$$

在 $T < T_c$，系统通过 $\eta \neq 0$ 降低自由能。

**对称性破缺**：高温时系统具有高对称性（$\eta = 0$），低温时对称性破缺（$\eta \neq 0$）。

### 应用 | Applications

统计力学的应用遍布物理学各个领域：

- **热力学**：从微观推导热力学第一、二定律
- **凝聚态物理**：解释材料的热学、电学、磁学性质
- **量子统计**：解释金属中电子的性质、液氦的超流性
- **宇宙学**：早期宇宙的物质状态
- **信息论**：熵和信息的关系
- **生物学**：蛋白质折叠、生物分子动力学

### 总结 | Conclusion

统计力学通过建立微观和宏观之间的桥梁，将整个物理学统一为一个整体。它不仅解释了热力学现象的微观本质，还为研究复杂系统提供了强大的工具。从分子动力学模拟到相变理论，从量子统计到临界现象，统计力学的应用范围不断扩大。理解统计力学是理解现代物理学的关键。
