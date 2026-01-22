# 流体力学基础
## Fundamentals of Fluid Mechanics

### 简介 | Introduction

流体力学是研究流体（液体和气体）的运动和平衡的学科。从微观尺度的分子运动到宏观尺度的天气系统，从工程应用的管道流动到地球物理的洋流，流体力学的应用无处不在。流体力学既有深刻的数学理论，也有丰富的物理现象，是理论和应用结合最紧密的学科之一。

Fluid mechanics studies the motion and equilibrium of fluids (liquids and gases). From molecular-scale motion to weather systems, from pipeline flow engineering to geophysical ocean currents, fluid mechanics is everywhere. It combines deep mathematical theory with rich physical phenomena, making it one of the most theory-and-practice integrated disciplines.

### 流体的性质 | Properties of Fluids

**流体**是无固定形状、会流动的物质。液体有固定体积，气体无固定体积。

**密度**定义为单位体积的质量：

$$\rho = \frac{dm}{dV}$$

**粘度**衡量流体的粘性（流动阻力）。**动力粘度** $\mu$ 定义为：

$$\tau = \mu\frac{dv}{dy}$$

其中 $\tau$ 是剪切应力，$dv/dy$ 是速度梯度。

**运动粘度**定义为：

$$\nu = \frac{\mu}{\rho}$$

**压缩性**由体积模量 $K$ 描述：

$$K = -V\frac{\partial P}{\partial V}$$

对于液体，$K$ 很大（难以压缩）；对于气体，$K$ 较小（易于压缩）。

### 流体静力学 | Fluid Statics

流体不受剪切应力时处于静止状态。

**帕斯卡定律**：压力在静流体中各处相等（在同一水平面上）。

压强随深度变化的**静压分布方程**：

$$\frac{dP}{dz} = -\rho g$$

积分得：

$$P(z) = P_0 - \rho gz$$

其中 $P_0$ 是表面压力，$z$ 是深度（向下为正）。

**阿基米德原理**：浸入流体中的物体受到向上的浮力，大小等于排开流体的重量：

$$F_B = \rho g V_{displaced}$$

### 连续方程 | Continuity Equation

描述流体质量守恒。考虑流体元素：

$$\frac{\partial \rho}{\partial t} + \nabla \cdot (\rho\mathbf{v}) = 0$$

对于不可压缩流体（$\rho = \text{const}$）：

$$\nabla \cdot \mathbf{v} = 0$$

或展开为：

$$\frac{\partial u}{\partial x} + \frac{\partial v}{\partial y} + \frac{\partial w}{\partial z} = 0$$

其中 $u, v, w$ 是速度分量。

**体积流量守恒**：在不可压缩流体的管道中：

$$Q = A_1 v_1 = A_2 v_2$$

其中 $A$ 是截面积，$v$ 是平均速度。

### 伯努利方程 | Bernoulli Equation

沿着流线，对于理想（无粘性）、不可压缩流体，机械能守恒：

$$P + \frac{1}{2}\rho v^2 + \rho gh = \text{const}$$

或除以 $\rho g$：

$$\frac{P}{\rho g} + \frac{v^2}{2g} + h = \text{const}$$

三项分别称为**压头**、**速度头**和**位置头**。

伯努利方程表明：速度越大，压强越小。这解释了许多现象，如飞机机翼产生升力。

### 欧拉方程和纳维-斯托克斯方程 | Euler and Navier-Stokes Equations

**欧拉方程**（无粘流体）：

$$\rho\frac{D\mathbf{v}}{Dt} = -\nabla P + \rho\mathbf{g}$$

其中 $\frac{D}{Dt}$ 是**物质导数**：

$$\frac{D}{Dt} = \frac{\partial}{\partial t} + \mathbf{v} \cdot \nabla$$

**纳维-斯托克斯方程**（粘性流体）：

$$\rho\frac{D\mathbf{v}}{Dt} = -\nabla P + \mu\nabla^2\mathbf{v} + \rho\mathbf{g}$$

或向量形式：

$$\rho\left(\frac{\partial\mathbf{v}}{\partial t} + \mathbf{v} \cdot \nabla\mathbf{v}\right) = -\nabla P + \mu\nabla^2\mathbf{v} + \mathbf{f}$$

纳维-斯托克斯方程是流体力学的基本方程，但一般情况下求解困难。

### 层流和湍流 | Laminar and Turbulent Flow

流动形式由**雷诺数**决定：

$$Re = \frac{\rho vd}{\mu} = \frac{vd}{\nu}$$

其中 $d$ 是特征长度（如管径）。

**层流**（$Re$ 小）：流体分层流动，各层相对滑动，无混合。

**湍流**（$Re$ 大）：流动混乱，有涡旋和随机脉动。

过渡发生在某个临界雷诺数，如圆管中约为 $Re \approx 2300$。

### 阻力和升力 | Drag and Lift

物体在流体中运动时受到阻力，由**阻力系数** $C_d$ 描述：

$$F_d = \frac{1}{2}\rho v^2 A C_d$$

其中 $A$ 是参考面积。

对于球体，$Re$ 小时（斯托克斯定律）：

$$F_d = 6\pi\mu rv$$

对于平板，湍流边界层的阻力系数约为 $C_d \approx 0.003$。

**升力**由伯努利效应和库塔循环定律产生：

$$F_L = \frac{1}{2}\rho v^2 A C_L$$

升力系数 $C_L$ 取决于物体形状和攻角。

### 流线和涡度 | Streamlines and Vorticity

**流线**是在某一时刻与速度矢量相切的曲线，流体沿流线流动。

**涡线**是与涡度矢量相切的曲线。

**涡度**定义为速度场的旋度：

$$\boldsymbol{\omega} = \nabla \times \mathbf{v}$$

**涡量方程**描述涡度的演化：

$$\frac{D\boldsymbol{\omega}}{Dt} = (\boldsymbol{\omega} \cdot \nabla)\mathbf{v} + \nu\nabla^2\boldsymbol{\omega}$$

对于无粘流体，若初始无涡（$\boldsymbol{\omega} = 0$），则始终无涡，流动为**势流**。

### 势流理论 | Potential Flow

对于无粘、无旋流动，可以定义**速度势** $\phi$：

$$\mathbf{v} = \nabla\phi$$

由连续方程：

$$\nabla \cdot \mathbf{v} = \nabla^2\phi = 0$$

即**拉普拉斯方程**。

对于二维不可压缩流，也可引入**流函数** $\psi$：

$$u = \frac{\partial\psi}{\partial y}, \quad v = -\frac{\partial\psi}{\partial x}$$

速度势和流函数满足**柯西-黎曼方程**，因此可以用复势 $f(z) = \phi + i\psi$ 分析平面流动。

### 边界层 | Boundary Layer

在高雷诺数流动中，物体表面附近存在一个薄的**边界层**，其中速度从零（无滑条件）迅速变化到主流速度。

**普朗特边界层方程**：

$$u\frac{\partial u}{\partial x} + v\frac{\partial u}{\partial y} = -\frac{1}{\rho}\frac{dP}{dx} + \nu\frac{\partial^2 u}{\partial y^2}$$

边界层厚度 $\delta$ 约为：

$$\delta \sim \sqrt{\frac{\nu x}{v_\infty}}$$

其中 $v_\infty$ 是主流速度。

### 应用 | Applications

流体力学应用广泛：

- **工程**：管道设计、泵和风机、飞行器设计
- **气象**：天气预报、龙卷风研究
- **地球科学**：海洋环流、地下水流动
- **生物**：血液循环、呼吸气流
- **工业**：燃烧、混合、热交换

### 总结 | Conclusion

流体力学从连续体假设出发，通过守恒律（质量、动量、能量）建立了流体运动的基本方程。从简单的伯努利方程到复杂的纳维-斯托克斯方程，流体力学理论逐步深化。数值求解技术（计算流体力学）的发展大大拓展了应用范围。流体力学依然是工程和科学研究中最重要的工具之一。
