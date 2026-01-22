# 电磁学基础
## Fundamentals of Electromagnetism

### 简介 | Introduction

电磁学描述电荷、电流和磁场之间的相互作用，是现代物理和技术的基础。从简单的静电力到复杂的电磁波，从发电机到光学，电磁学的应用无所不在。麦克斯韦方程组统一了电学和磁学，揭示了光的电磁本质。

Electromagnetism describes the interactions between charges, currents, and magnetic fields, forming the foundation of modern physics and technology. From simple electrostatic forces to complex electromagnetic waves, from generators to optics, electromagnetism is ubiquitous. Maxwell's equations unified electricity and magnetism, revealing the electromagnetic nature of light.

### 库仑定律和电场 | Coulomb's Law and Electric Field

两个点电荷之间的静电力为：

The electrostatic force between two point charges is:

$$F = k\frac{|q_1 q_2|}{r^2} = \frac{1}{4\pi\epsilon_0}\frac{|q_1 q_2|}{r^2}$$

其中 $k = 8.99 \times 10^9$ N·m²/C²，$\epsilon_0 = 8.85 \times 10^{-12}$ F/m 是真空介电常数。

The electric field created by charge $q$ at distance $r$ is:

$$\mathbf{E} = \frac{1}{4\pi\epsilon_0}\frac{q}{r^2}\hat{r}$$

电场是矢量，指向正电荷指向外侧，指向负电荷指向内侧。

### 高斯定律 | Gauss's Law

高斯定律是库仑定律的积分形式，是麦克斯韦方程的第一个方程：

Gauss's law is the integral form of Coulomb's law and the first Maxwell equation:

$$\oint_S \mathbf{E} \cdot d\mathbf{A} = \frac{Q_{enc}}{\epsilon_0}$$

或微分形式：

In differential form:

$$\nabla \cdot \mathbf{E} = \frac{\rho}{\epsilon_0}$$

其中 $\rho$ 是电荷密度。这个定律表明电场的源是电荷。

This law states that electric charges are sources of the electric field.

### 电势和电势能 | Electric Potential and Potential Energy

电势定义为单位正电荷的电势能：

Electric potential is defined as the potential energy per unit positive charge:

$$V = \frac{U}{q} = -\int_\infty^r E \, dx$$

对于点电荷 $q$：

For a point charge $q$:

$$V = \frac{1}{4\pi\epsilon_0}\frac{q}{r}$$

电场与电势的关系为：

The relationship between electric field and potential is:

$$\mathbf{E} = -\nabla V$$

### 磁场和安培定律 | Magnetic Field and Ampère's Law

载流直导线周围产生的磁场为：

The magnetic field around a current-carrying straight wire is:

$$B = \frac{\mu_0 I}{2\pi r}$$

其中 $\mu_0 = 4\pi \times 10^{-7}$ H/m 是真空磁导率。

安培定律的积分形式为：

Ampère's law in integral form is:

$$\oint_C \mathbf{B} \cdot d\mathbf{l} = \mu_0 I_{enc}$$

微分形式为：

The differential form is:

$$\nabla \times \mathbf{B} = \mu_0\mathbf{J}$$

其中 $\mathbf{J}$ 是电流密度。

### 洛伦兹力 | Lorentz Force

运动的电荷在电磁场中受到洛伦兹力：

A moving charge in an electromagnetic field experiences the Lorentz force:

$$\mathbf{F} = q(\mathbf{E} + \mathbf{v} \times \mathbf{B})$$

这个力是电场力和磁场力的矢量和。磁场力总是垂直于速度，不做功。

The magnetic force is always perpendicular to velocity and does no work.

### 电磁感应和法拉第定律 | Electromagnetic Induction and Faraday's Law

变化的磁通会产生电场，这就是法拉第定律：

Changing magnetic flux induces an electric field, described by Faraday's law:

$$\mathcal{E} = -\frac{d\Phi_B}{dt}$$

其中 $\Phi_B = \oint \mathbf{B} \cdot d\mathbf{A}$ 是磁通量。

微分形式为：

The differential form is:

$$\nabla \times \mathbf{E} = -\frac{\partial \mathbf{B}}{\partial t}$$

这个定律是发电机、变压器等设备的理论基础。

### 麦克斯韦方程组 | Maxwell's Equations

麦克斯韦方程组统一了电学和磁学：

Maxwell's equations unify electricity and magnetism:

1. **高斯定律**：$\nabla \cdot \mathbf{E} = \frac{\rho}{\epsilon_0}$

2. **无磁单极**：$\nabla \cdot \mathbf{B} = 0$

3. **法拉第定律**：$\nabla \times \mathbf{E} = -\frac{\partial \mathbf{B}}{\partial t}$

4. **安培-麦克斯韦定律**：$\nabla \times \mathbf{B} = \mu_0\mathbf{J} + \mu_0\epsilon_0\frac{\partial \mathbf{E}}{\partial t}$

第四个方程中的 $\mu_0\epsilon_0\frac{\partial \mathbf{E}}{\partial t}$ 项是麦克斯韦添加的位移电流项，它预言了电磁波的存在。

The displacement current term predicts the existence of electromagnetic waves.

### 电磁波 | Electromagnetic Waves

在无源区域（$\rho = 0$，$\mathbf{J} = 0$），麦克斯韦方程导出波动方程：

In source-free regions, Maxwell's equations lead to wave equations:

$$\nabla^2\mathbf{E} = \mu_0\epsilon_0\frac{\partial^2\mathbf{E}}{\partial t^2}$$

$$\nabla^2\mathbf{B} = \mu_0\epsilon_0\frac{\partial^2\mathbf{B}}{\partial t^2}$$

波速为：

The wave speed is:

$$c = \frac{1}{\sqrt{\mu_0\epsilon_0}} = 3 \times 10^8 \text{ m/s}$$

这正是光速！这表明光是电磁波。

This is exactly the speed of light, showing that light is an electromagnetic wave.

平面电磁波的解为：

The plane wave solution is:

$$\mathbf{E}(\mathbf{r},t) = \mathbf{E}_0 \cos(\mathbf{k} \cdot \mathbf{r} - \omega t)$$

$$\mathbf{B}(\mathbf{r},t) = \frac{1}{c}\hat{k} \times \mathbf{E}(\mathbf{r},t)$$

### 能量和动量 | Energy and Momentum

电磁场的能量密度为：

The energy density of the electromagnetic field is:

$$u = \frac{1}{2}\left(\epsilon_0 E^2 + \frac{1}{\mu_0}B^2\right)$$

能量流密度由坡印廷矢量给出：

The energy flux density is given by the Poynting vector:

$$\mathbf{S} = \frac{1}{\mu_0}\mathbf{E} \times \mathbf{B}$$

电磁波也携带动量，辐射压强与光强成正比。

### 总结 | Conclusion

电磁学从库仑定律和磁场的实验观察出发，经过法拉第和麦克斯韦的工作，最终形成了完整的理论体系。麦克斯韦方程组的优美和预测力展示了物理学的深刻统一性。电磁学的发展不仅深化了我们对自然的理解，也推动了无线通信、电力、电子等技术的发展。
