# 界面动力学与相变
# Interface Dynamics and Phase Transitions

## 中文部分

### 1. 界面张力与表面能

界面动力学描述不同相之间边界的演化，在凝聚态物理、流体力学和材料科学中至关重要。

**表面张力**：定义为单位面积增加所需的能量：
$$\gamma = \frac{\partial E}{\partial A}\bigg|_{T,P,N}$$

其中 $E$ 是总自由能。在热力学中，表面张力引入额外的化学势项。对于球形液滴，内外压差（Young-Laplace 公式）为：
$$\Delta P = P_{\text{in}} - P_{\text{out}} = \frac{2\gamma}{R}$$

其中 $R$ 是半径。这解释了小液滴为什么压力更高。

**界面宽度**：虽然看似尖锐，但界面实际上有有限宽度，物理量从一相平缓过渡到另一相，特征长度为 $\xi$（界面厚度），通常与关联长度 $\xi_c \sim (T_c - T)^{-\nu}$ 相关，其中 $\nu \approx 0.63$ 是 Ising 模型的临界指数。

### 2. Cahn-Hilliard 方程与有序参数动力学

**有序参数**：描述相的区别。例如，在 Ising 模型中，有序参数 $m$ 是自旋平均值。

**Cahn-Hilliard 方程**：
$$\frac{\partial \phi}{\partial t} = M\nabla^2 \mu$$

其中 $\phi(\vec{r}, t)$ 是局域有序参数（如浓度），$M$ 是迁移率，$\mu$ 是化学势：
$$\mu = \frac{\delta F}{\delta \phi} = f'(\phi) - K\nabla^2\phi$$

其中 $F = \int [f(\phi) + \frac{K}{2}(\nabla\phi)^2] d^3r$ 是自由能泛函，$f(\phi)$ 是局域项（如双井势），$K$ 控制梯度能。

这个方程描述了液相分离（spinodal decomposition）过程中，浓度域逐渐增大且数量减少的过程。

### 3. Allen-Cahn 方程与界面传播

**Allen-Cahn 方程**（过阻尼极限）：
$$\frac{\partial u}{\partial t} = -\frac{\delta F}{\delta u} = -\nabla^2 u + f'(u)$$

其中 $F = \int [\frac{1}{4}(1-u^2)^2 + \frac{\epsilon^2}{2}(\nabla u)^2] d^3r$，$u$ 是有序参数（$u = \pm 1$ 对应两个相）。

**行波解**（Traveling wave）：存在以常数速度 $v$ 传播的解：
$$u(\vec{r}, t) = U(\xi), \quad \xi = n \cdot \vec{r} - vt$$

其中 $n$ 是界面法向单位向量。速度由动力学和热力学决定：
$$v \sim M \cdot \Delta f$$

其中 $M$ 是迁移系数，$\Delta f$ 是两相自由能差。

### 4. 结晶与树枝晶生长

**Stefan 问题**：描述固液界面处热量扩散与潜热释放的耦合过程。

在界面处，热流密度平衡潜热释放：
$$\rho L v_n = k_s (\nabla T_s)_n - k_l (\nabla T_l)_n$$

其中 $\rho$ 是密度，$L$ 是潜热，$v_n$ 是界面法向速度，$k_s, k_l$ 是固液导热率，下标 $s, l$ 表示固相和液相。

**Mullins-Sekerka 不稳定性**：平坦界面在过冷时不稳定，产生周期波纹。线性稳定性分析给出增长率：
$$\sigma(k) = \frac{v_p k^2}{1 + k^2 L^2}$$

其中 $v_p$ 是驱动速度，$L$ 是毛细长度。短波长模式增长，导致界面变得粗糙。

**树枝晶动力学**：快速凝固产生分支结构（树枝晶），其形状由尖端的动力学确定：
$$v = \frac{4\sigma}{|\rho|^2 m(Pc)}$$

其中 $\sigma$ 是表面张力，$Pc$ 是 Péclet 数。

### 5. 动力学相变与非平衡临界点

在外部驱动下，系统可能显示与平衡相变不同的行为。

**动力学Ising模型**（Glauber 动力学）：旋转以概率翻转：
$$P(\text{flip}) = \frac{1}{1 + \exp(2\beta\Delta E)}$$

其中 $\beta = 1/k_B T$，$\Delta E$ 是翻转的能量变化。

**非平衡相变**（如吸收相变）：以反应 $A \to \emptyset$ 为例，单个粒子以固定速率消失，聚合 $A + A \to A$ 相互作用。在一维中存在吸收相变：低活动性下无生存状态（吸收相），高活动性下有活跃相。

**Binder 参数**：用于判断相变：
$$U = 1 - \frac{\langle m^4 \rangle}{3\langle m^2 \rangle^2}$$

其中 $m$ 是有序参数。平衡态中 $U \to 2/3$（高温）或 $U \to 0$（低温）。

### 6. 界面噪声与Kardar-Parisi-Zhang方程

**界面粗糙化**：界面高度 $h(\vec{r}, t)$ 由随机力和确定性演化驱动：
$$\frac{\partial h}{\partial t} = \nu \nabla^2 h + \frac{\lambda}{2}(\nabla h)^2 + \eta(\vec{r}, t)$$

这是 **Kardar-Parisi-Zhang（KPZ）方程**，其中：
- $\nu$ 是粘性系数
- $\lambda$ 是非线性系数（来自体积守恒）
- $\eta$ 是高斯白噪声

**粗糙度指数** $\alpha$：界面高度涨落 $\langle h^2 \rangle \sim L^{2\alpha}$，其中 $L$ 是系统大小。

**临界指数**：KPZ 方程给出 $\alpha = 1/2, \beta = 1/3, z = 3/2$，其中 $z$ 是动态指数。这些指数在许多物理系统中都观察到，显示普遍类（universality class）。

### 7. 膜波纹与流体界面

**重力毛细波**：液体表面的波动结合了表面张力和重力效应。色散关系：
$$\omega(k) = \sqrt{(gk + \gamma k^3/\rho)\tanh(kh)}$$

其中 $g$ 是重力加速度，$h$ 是液体深度。

- **短波**（$k$ 大）：由毛细力主导，$\omega \sim k^{3/2}$
- **长波**（$k$ 小）：由重力主导，$\omega \sim \sqrt{gk}$

**Rayleigh-Taylor 不稳定性**：密重液体压在密轻液体上时界面不稳定，气泡上升。增长率为
$$\gamma = \sqrt{Ag}$$

其中 $A$ 是密度比。

---

## English Part

### 1. Surface Tension and Interfacial Energy

**Surface Tension** (definition):
$$\gamma = \frac{\partial E}{\partial A}\bigg|_{T,P,N}$$

**Young-Laplace Pressure** (spherical droplet):
$$\Delta P = \frac{2\gamma}{R}$$

Higher pressure in smaller droplets due to curvature.

### 2. Cahn-Hilliard Equation

**Free Energy Functional**:
$$F[\phi] = \int [f(\phi) + \frac{K}{2}(\nabla\phi)^2] d^3r$$

**Evolution Equation**:
$$\frac{\partial \phi}{\partial t} = M\nabla^2 \mu, \quad \mu = f'(\phi) - K\nabla^2\phi$$

Describes phase separation (spinodal decomposition).

### 3. Allen-Cahn Equation

**Equation**:
$$\frac{\partial u}{\partial t} = -\nabla^2 u + f'(u)$$

**Traveling Wave**: Interface propagates with constant velocity:
$$v \sim M \cdot \Delta f$$

### 4. Crystallization and Dendritic Growth

**Stefan Problem**: Coupled heat diffusion and latent heat release at solid-liquid interface:
$$\rho L v_n = k_s (\nabla T_s)_n - k_l (\nabla T_l)_n$$

**Mullins-Sekerka Instability**: Flat interface unstable under supercooling, producing ripples:
$$\sigma(k) = \frac{v_p k^2}{1 + k^2 L^2}$$

### 5. Dynamic Phase Transitions

**Glauber Dynamics** (Ising model):
$$P(\text{flip}) = \frac{1}{1 + \exp(2\beta\Delta E)}$$

**Non-equilibrium Critical Points**: Systems under external drive show different transitions from equilibrium.

**Binder Parameter**:
$$U = 1 - \frac{\langle m^4 \rangle}{3\langle m^2 \rangle^2}$$

### 6. Interface Roughening and KPZ Equation

**Kardar-Parisi-Zhang (KPZ) Equation**:
$$\frac{\partial h}{\partial t} = \nu \nabla^2 h + \frac{\lambda}{2}(\nabla h)^2 + \eta(\vec{r}, t)$$

**Roughness Exponent**: $\langle h^2 \rangle \sim L^{2\alpha}$ where $\alpha = 1/2$ for KPZ.

**Universality Classes**: Critical exponents $\alpha = 1/2, \beta = 1/3, z = 3/2$ observed in many physical systems.

### 7. Surface Waves and Fluid Interfaces

**Gravity-Capillary Waves** (dispersion relation):
$$\omega(k) = \sqrt{(gk + \gamma k^3/\rho)\tanh(kh)}$$

- Short waves: capillary-dominated, $\omega \sim k^{3/2}$
- Long waves: gravity-dominated, $\omega \sim \sqrt{gk}$

**Rayleigh-Taylor Instability**: Dense fluid above light fluid unstable:
$$\gamma_{\text{growth}} = \sqrt{Ag}$$

---

**字数统计**：约2850字
