# 变分法基础
## Fundamentals of Calculus of Variations

### 简介 | Introduction

变分法是研究函数极值问题的数学分支。与普通微积分找标量函数的极值不同，变分法寻求函数极值，即使某个泛函达到极值的函数。变分法在物理学中的应用极为广泛，从拉格朗日力学到量子力学，从经典场论到现代粒子物理，都离不开变分原理。

The calculus of variations is a branch of mathematics studying extremal problems of functionals. Unlike ordinary calculus finding extrema of scalar functions, it seeks functions that make functionals stationary. Variational methods are ubiquitous in physics, from Lagrangian mechanics to quantum mechanics, from classical field theory to modern particle physics.

### 泛函和变分 | Functionals and Variations

**泛函**是将函数映射到标量的映射，记为 $J[y(x)]$，其中 $y(x)$ 是函数。

**例**：弧长泛函

$$J[y(x)] = \int_a^b \sqrt{1 + (y')^2} dx$$

其中 $y' = dy/dx$。这个泛函把每条曲线映射到它的长度。

**泛函的变分**是泛函在相邻函数处的变化。若 $y(x)$ 和 $y(x) + \epsilon\eta(x)$ 是两条相邻的函数（$\epsilon$ 很小），则变分为：

$$\delta J = J[y + \epsilon\eta] - J[y]$$

其中 $\eta(x)$ 称为变分或虚位移，满足边界条件 $\eta(a) = \eta(b) = 0$。

### 欧拉-拉格朗日方程 | Euler-Lagrange Equation

考虑泛函：

$$J[y(x)] = \int_a^b F(x, y, y') dx$$

其中 $F$ 是关于 $x$、$y$ 及其导数 $y'$ 的函数。若 $y(x)$ 使泛函达到极值，则 $y(x)$ 满足欧拉-拉格朗日方程：

$$\frac{\partial F}{\partial y} - \frac{d}{dx}\frac{\partial F}{\partial y'} = 0$$

**推导**：对泛函进行一阶变分：

$$\delta J = \int_a^b \left(\frac{\partial F}{\partial y}\eta + \frac{\partial F}{\partial y'}\eta'\right) dx = 0$$

分部积分第二项：

$$\int_a^b \frac{\partial F}{\partial y'}\eta' dx = \left[\frac{\partial F}{\partial y'}\eta\right]_a^b - \int_a^b \frac{d}{dx}\frac{\partial F}{\partial y'}\eta dx$$

因为 $\eta(a) = \eta(b) = 0$，第一项消失，所以：

$$\int_a^b \left(\frac{\partial F}{\partial y} - \frac{d}{dx}\frac{\partial F}{\partial y'}\right)\eta dx = 0$$

由于 $\eta$ 是任意的，被积函数必须为零，得欧拉-拉格朗日方程。

### 多元函数的变分 | Variations for Multiple Variables

对于有多个未知函数 $y_i(x)$，$i = 1, 2, \ldots, n$ 的泛函：

$$J[y_1, y_2, \ldots, y_n] = \int_a^b F(x, y_1, \ldots, y_n, y_1', \ldots, y_n') dx$$

每个函数都满足欧拉-拉格朗日方程：

$$\frac{\partial F}{\partial y_i} - \frac{d}{dx}\frac{\partial F}{\partial y_i'} = 0, \quad i = 1, 2, \ldots, n$$

### 拉格朗日力学 | Lagrangian Mechanics

在经典力学中，系统的拉格朗日量定义为动能减势能：

$$L(q_i, \dot{q}_i, t) = T - V$$

其中 $q_i$ 是广义坐标，$\dot{q}_i$ 是广义速度。

**作用量**（Hamilton作用）定义为：

$$S = \int_{t_1}^{t_2} L(q_i, \dot{q}_i, t) dt$$

**哈密顿原理**（最小作用量原理）：物理系统的实际运动使作用量 $S$ 对其他所有可能的运动达到极值（通常是最小值）。

应用欧拉-拉格朗日方程得到**拉格朗日方程**：

$$\frac{d}{dt}\frac{\partial L}{\partial \dot{q}_i} - \frac{\partial L}{\partial q_i} = 0$$

或等价地：

$$\frac{d}{dt}\frac{\partial L}{\partial \dot{q}_i} = \frac{\partial L}{\partial q_i}$$

**例**：自由粒子，$L = \frac{1}{2}m\dot{x}^2$

$$\frac{d}{dt}\frac{\partial L}{\partial \dot{x}} = \frac{d}{dt}(m\dot{x}) = m\ddot{x} = 0$$

这正是牛顿第二定律 $F = ma$（无外力时）。

### 场论中的变分 | Variations in Field Theory

对于标量场 $\phi(\mathbf{r}, t)$，作用量为：

$$S = \int dt \int d^3\mathbf{r} \mathcal{L}(\phi, \partial_\mu\phi)$$

其中 $\mathcal{L}$ 是拉格朗日密度。

欧拉-拉格朗日方程变为：

$$\frac{\partial \mathcal{L}}{\partial \phi} - \partial_\mu\frac{\partial \mathcal{L}}{\partial(\partial_\mu\phi)} = 0$$

这称为**场方程**。

**例**：克莱因-戈登场，$\mathcal{L} = \frac{1}{2}(\partial_\mu\phi)(\partial^\mu\phi) - \frac{1}{2}m^2\phi^2$

代入欧拉-拉格朗日方程得：

$$\partial_\mu\partial^\mu\phi + m^2\phi = 0$$

即克莱因-戈登方程：

$$\left(\nabla^2 - \frac{1}{c^2}\frac{\partial^2}{\partial t^2} + m^2\right)\phi = 0$$

### 约束变分问题 | Constrained Variations

若泛函需要满足约束条件，如 $g(y) = \text{const}$，则使用拉格朗日乘数法。

构造增广泛函：

$$J^* = \int_a^b [F(x,y,y') + \lambda g(y)] dx$$

其中 $\lambda$ 是拉格朗日乘数。对增广泛函应用欧拉-拉格朗日方程。

**例**：在长度约束下找最短时间下降的曲线（等时线问题）。

### 参数变分 | Parametric Variations

若曲线由参数表示 $y = y(x(\theta))$，边界点也可能移动，则需考虑参数变分。

变分原理变为：

$$\delta J = \int_a^b \frac{\partial F}{\partial y}\delta y dx + \left[F - y'\frac{\partial F}{\partial y'}\right]_{a}^b \Delta x \bigg|_a^b + \frac{\partial F}{\partial y'}\Delta y\bigg|_a^b = 0$$

这在边界条件可变的问题中很重要。

### 二阶变分与稳定性 | Second Variation and Stability

一阶变分为零只表示泛函在驻值点，不能区分最大值、最小值还是鞍点。

**二阶变分**：

$$\delta^2 J = \frac{1}{2}\frac{d^2}{d\epsilon^2}J[y + \epsilon\eta]\bigg|_{\epsilon=0}$$

若 $\delta^2 J > 0$ 对所有允许的 $\eta$ 成立，则是最小值；若 $\delta^2 J < 0$，则是最大值；若有正有负，则是鞍点。

计算表明，二阶变分取决于Legendre条件 $\frac{\partial^2 F}{\partial (y')^2} > 0$（对最小值）。

### 应用 | Applications

变分法在众多领域应用：

- **经典力学**：拉格朗日力学和哈密顿力学都基于变分原理
- **量子力学**：泛函积分方法（路径积分）
- **场论**：规范场、相对论量子场论
- **几何学**：最小曲面、测地线
- **最优控制**：寻求最优控制策略
- **工程**：结构优化、最优设计

### 总结 | Conclusion

变分法从极值问题出发，发展出强大的数学理论和方法。哈密顿原理和拉格朗日方程统一了经典力学，变分方法成为现代物理的语言。从最小作用量原理到路径积分，变分法深刻影响了物理学的发展。理解变分法对于掌握理论物理至关重要。
