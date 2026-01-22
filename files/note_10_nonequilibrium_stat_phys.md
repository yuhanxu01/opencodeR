# 非平衡态统计物理
# Non-equilibrium Statistical Physics

## 中文部分

### 1. 非平衡过程与 Boltzmann 方程

平衡统计物理描述系统在热力学平衡状态，而非平衡统计物理研究系统逐步趋向平衡的动力学过程。

**Boltzmann 方程**：描述稀薄气体中粒子速度分布 $f(\vec{r}, \vec{v}, t)$ 的演化：
$$\frac{\partial f}{\partial t} + \vec{v} \cdot \nabla_r f + \vec{F} \cdot \nabla_v f = C[f]$$

其中左边三项分别是时间演化、空间对流和力的作用，右边 $C[f]$ 是碰撞积分：
$$C[f] = \int \sigma(\Omega) v_{\text{rel}} [f(\vec{v}_1')f(\vec{v}_2') - f(\vec{v}_1)f(\vec{v}_2)] d^3v_2 d\Omega$$

其中 $\sigma(\Omega)$ 是散射截面，积分遍历所有初末态和散射角。

**H-定理**（Boltzmann, 1872）：定义熵泛函
$$H(t) = \int f(\vec{r}, \vec{v}, t) \ln f(\vec{r}, \vec{v}, t) d^3r d^3v$$

则 $dH/dt \leq 0$，即 $H$ 单调不增。等号成立当且仅当 $f$ 是平衡分布。这是 Boltzmann 对"时间箭头"问题的数学解答。

### 2. 松弛时间与线性响应理论

**linear response regime**：当系统偏离平衡仅很小的程度时，系统的响应与偏离量成正比。

考虑加上微小外场 $h(t)$ 后的动力学：
$$\dot{\langle A \rangle}(t) = -\gamma(\langle A \rangle(t) - A_0) + \chi h(t)$$

其中 $\gamma$ 是松弛率，$\chi$ 是响应系数。解为
$$\langle A \rangle(t) - A_0 = \chi \int_0^t e^{-\gamma(t-t')}h(t')dt' = \int_0^t \phi(t-t')h(t')dt'$$

线性响应函数为 $\phi(t) = \chi e^{-\gamma t} \Theta(t)$，其中 $\Theta$ 是阶跃函数。

**涨落-耗散定理**（Fluctuation-Dissipation Theorem）：关联平衡时的涨落与外场作用下的耗散：
$$\phi(t) = \frac{1}{k_B T}\langle \delta A(t)\delta A(0) \rangle$$

其中 $\delta A = A - \langle A \rangle$ 是涨落，$\langle \cdots \rangle$ 是平衡时的期望。这建立了平衡涨落与非平衡响应的深刻联系。

### 3. Fokker-Planck 方程与Smoluchowski 极限

对于过阻尼系统（高粘性、粒子快速失去动量），考虑位置 $\vec{r}(t)$ 的概率分布 $P(\vec{r}, t)$。

**Fokker-Planck 方程**：
$$\frac{\partial P}{\partial t} = -\nabla \cdot (\vec{v}_D P) + D\nabla^2 P$$

其中 $\vec{v}_D$ 是确定性漂移速度，$D$ 是扩散系数。对于力场 $\vec{F} = -\nabla U(\vec{r})$：
$$\vec{v}_D = -\frac{\nabla U}{m\gamma}$$

其中 $m$ 是质量，$\gamma$ 是摩擦系数。

**Smoluchowski 方程**（极限 $\gamma \to \infty$）：
$$\frac{\partial P}{\partial t} = \nabla \cdot \left(\frac{\nabla U}{k_B T}P\right) + D\nabla^2 P$$

这描述了胶体粒子在粘性流体中的运动。平衡分布为
$$P_{eq}(\vec{r}) \propto \exp\left(-\frac{U(\vec{r})}{k_B T}\right)$$

即 Boltzmann 分布。

### 4. 跨越理论与 Kramers 问题

**活化过程**：粒子从势能井 A 跨越势垒到达势能井 B。

设势能函数 $U(\vec{r})$ 在 A、B 处各有极小值，中间有鞍点（过渡态）。在高势垒极限 $U_B - U_A \gg k_B T$，平均逃逸时间（均首通时间）为：

**Kramers 公式**：
$$\tau = \frac{2\pi}{\omega_A\omega_B} \sqrt{\frac{m}{\pi D}} \exp\left(\frac{U_B - U_A}{k_B T}\right)$$

其中 $\omega_A, \omega_B$ 是两个势阱处的虚频。指数因子 $\exp(E_a/k_B T)$ 给出了 Arrhenius 活化律。

### 5. 非平衡相变与临界现象

在非平衡系统中，也存在相变，但常常不同于平衡相变。

**反应-扩散系统**：考虑反应 $A \rightarrow B$ 和 $A + A \rightarrow A$。在一维中，此系统在 $d_A = d_B$ 时存在非平衡临界点。

**活性物质**（self-propelled particles）：颗粒自主运动（如游动的细菌），在无外场下组织成有序或无序的集体状态。这是一个活跃的研究领域。

**Ising 模型的非平衡动力学**：在均匀磁场中，系统不能到达热力学平衡（磁场作为外驱动）。演化遵循如 Glauber 动力学等规则，显示与平衡不同的动力学临界指数。

### 6. 大偏差理论与 Jarzynski 等式

**大偏差函数** $I(x)$：描述系统访问某不可能状态的概率指数衰减：
$$P(X \approx x) \sim \exp(-NI(x))$$

其中 $N$ 是系统大小。Contraction Principle：若某量为 $X$ 的函数，其大偏差也可由 $I(x)$ 确定。

**Jarzynski 等式**：在拉伸蛋白质等过程中，从非平衡工作分布可以精确计算平衡自由能变化：
$$\Delta F = -k_B T \ln \langle \exp(-W/k_B T) \rangle_{\text{nonequilibrium}}$$

其中 $W$ 是外力做的功，括号表示非平衡实验的统计平均。

### 7. Green-Kubo 公式与输运系数

**Green-Kubo 关系**：关联平衡时的涨落与非平衡输运系数。

粘度与速度涨落相关：
$$\eta = \frac{V}{k_B T}\int_0^\infty \langle \Pi_{xy}(t)\Pi_{xy}(0) \rangle dt$$

其中 $\Pi_{xy}$ 是应力张量分量，积分从平衡相关函数。

热导率：
$$\kappa = \frac{1}{3Vk_B T^2}\int_0^\infty \langle \vec{J}_q(t) \cdot \vec{J}_q(0) \rangle dt$$

其中 $\vec{J}_q$ 是热流。这些公式将易于计算的平衡相关函数与难以直接测量的输运系数联系起来。

---

## English Part

### 1. Non-equilibrium Processes and Boltzmann Equation

**Boltzmann Equation**: Describes evolution of velocity distribution $f(\vec{r}, \vec{v}, t)$ in a dilute gas:
$$\frac{\partial f}{\partial t} + \vec{v} \cdot \nabla_r f + \vec{F} \cdot \nabla_v f = C[f]$$

**H-Theorem** (Boltzmann, 1872): Entropy:
$$H(t) = \int f \ln f \, d^3r d^3v$$

satisfies $dH/dt \leq 0$, with equality iff $f$ is equilibrium distribution. This explains the "arrow of time" from microscopic reversibility.

### 2. Relaxation Time and Linear Response Theory

For small perturbations from equilibrium:
$$\dot{\langle A \rangle} = -\gamma(\langle A \rangle - A_0) + \chi h(t)$$

Response function: $\phi(t) = \chi e^{-\gamma t}$

**Fluctuation-Dissipation Theorem**:
$$\phi(t) = \frac{1}{k_B T}\langle \delta A(t)\delta A(0) \rangle$$

Relates equilibrium fluctuations to non-equilibrium response.

### 3. Fokker-Planck Equation and Smoluchowski Limit

**Fokker-Planck Equation**:
$$\frac{\partial P}{\partial t} = -\nabla \cdot (\vec{v}_D P) + D\nabla^2 P$$

**Smoluchowski Equation** (high friction limit):
$$\frac{\partial P}{\partial t} = \nabla \cdot \left(\frac{\nabla U}{k_B T}P\right) + D\nabla^2 P$$

Equilibrium: $P_{eq} \propto \exp(-U/k_B T)$

### 4. Barrier Crossing and Kramers Problem

**Kramers Formula**: Mean first passage time over barrier $U_B - U_A$:
$$\tau = \frac{2\pi}{\omega_A\omega_B} \sqrt{\frac{m}{\pi D}} \exp\left(\frac{U_B - U_A}{k_B T}\right)$$

Gives Arrhenius activation law.

### 5. Non-equilibrium Phase Transitions

**Reaction-diffusion systems**: $A \to B$ and $A + A \to A$ show non-equilibrium critical points.

**Active Matter**: Self-propelled particles organize into ordered/disordered phases.

**Non-equilibrium Ising dynamics**: Under external drive, different critical exponents from equilibrium.

### 6. Large Deviations and Jarzynski Equality

**Large Deviations Function**: $P(X \approx x) \sim \exp(-NI(x))$

**Jarzynski Equality**:
$$\Delta F = -k_B T \ln \langle \exp(-W/k_B T) \rangle_{\text{neq}}$$

Exact relation between non-equilibrium work and equilibrium free energy change.

### 7. Green-Kubo Relations and Transport Coefficients

**Viscosity**:
$$\eta = \frac{V}{k_B T}\int_0^\infty \langle \Pi_{xy}(t)\Pi_{xy}(0) \rangle dt$$

**Thermal Conductivity**:
$$\kappa = \frac{1}{3Vk_B T^2}\int_0^\infty \langle \vec{J}_q(t) \cdot \vec{J}_q(0) \rangle dt$$

Connect equilibrium correlations to non-equilibrium transport coefficients.

---

**字数统计**：约2850字
