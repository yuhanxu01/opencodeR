# 量子力学基础
## Fundamentals of Quantum Mechanics

### 简介 | Introduction

量子力学是描述微观世界的物理学理论，统治着原子、分子和亚原子粒子的行为。与经典力学不同，量子力学引入了概率、不确定性和波粒二象性等革命性概念。

Quantum mechanics is the physical theory that describes the microscopic world, governing the behavior of atoms, molecules, and subatomic particles. Unlike classical mechanics, quantum mechanics introduces revolutionary concepts such as probability, uncertainty, and wave-particle duality.

### 波函数 | Wave Function

量子系统的完整状态由波函数 $\Psi(\mathbf{r},t)$ 描述，它是复值函数。波函数的物理意义由玻恩诠释给出：

The complete state of a quantum system is described by the wave function $\Psi(\mathbf{r},t)$, a complex-valued function. The physical meaning of the wave function is given by the Born interpretation:

$$|\Psi(\mathbf{r},t)|^2 d^3\mathbf{r} = \text{在位置}\,\mathbf{r}\,\text{附近体积}\,d^3\mathbf{r}\,\text{内找到粒子的概率}$$

The probability density is $\rho(\mathbf{r},t) = |\Psi(\mathbf{r},t)|^2$，归一化条件为：

Normalization condition:

$$\int_{-\infty}^{\infty} |\Psi(\mathbf{r},t)|^2 d^3\mathbf{r} = 1$$

### 薛定谔方程 | Schrödinger Equation

时间相关的薛定谔方程是量子力学的基本方程：

The time-dependent Schrödinger equation is the fundamental equation of quantum mechanics:

$$i\hbar \frac{\partial \Psi(\mathbf{r},t)}{\partial t} = \hat{H}\Psi(\mathbf{r},t)$$

其中 $\hat{H}$ 是哈密顿算符（能量算符），通常形式为：

Where $\hat{H}$ is the Hamiltonian operator:

$$\hat{H} = -\frac{\hbar^2}{2m}\nabla^2 + V(\mathbf{r},t)$$

对于定态（能量不随时间变化），时间无关的薛定谔方程为：

For stationary states, the time-independent Schrödinger equation is:

$$\hat{H}\Psi(\mathbf{r}) = E\Psi(\mathbf{r})$$

这是一个本征值方程，$E$ 是可能的能量本征值。This is an eigenvalue equation; $E$ represents the possible energy eigenvalues.

### 不确定性原理 | Uncertainty Principle

海森堡不确定性原理是量子力学的基本原理之一：

Heisenberg's uncertainty principle is one of the fundamental principles of quantum mechanics:

$$\Delta x \cdot \Delta p \geq \frac{\hbar}{2}$$

这表明位置和动量不能同时被精确确定。类似的关系也适用于能量和时间：

This states that position and momentum cannot both be precisely determined simultaneously. A similar relation applies to energy and time:

$$\Delta E \cdot \Delta t \geq \frac{\hbar}{2}$$

不确定性的出现源于波函数的本质，而非测量的局限性。这是物理世界的基本特性。

The uncertainty arises from the fundamental nature of the wave function, not limitations of measurement. It's a fundamental characteristic of physical reality.

### 算符和可观测量 | Operators and Observables

在量子力学中，每个可观测物理量（如位置、动量、能量）对应一个线性算符。若 $\Psi$ 是算符 $\hat{A}$ 的本征函数：

In quantum mechanics, each observable physical quantity corresponds to a linear operator. If $\Psi$ is an eigenfunction of operator $\hat{A}$:

$$\hat{A}\Psi = a\Psi$$

则 $a$ 是本征值，代表测量结果。

Then $a$ is the eigenvalue, representing the measurement result.

常见算符包括：

Common operators include:

$$\hat{x} = x, \quad \hat{p} = -i\hbar\frac{\partial}{\partial x}, \quad \hat{L}_z = -i\hbar\frac{\partial}{\partial \phi}$$

### 角动量 | Angular Momentum

轨道角动量由以下定义：

Orbital angular momentum is defined as:

$$\hat{\mathbf{L}} = \hat{\mathbf{r}} \times \hat{\mathbf{p}} = -i\hbar(\mathbf{r} \times \nabla)$$

在球坐标中，角动量的平方和 $z$ 分量可以同时对角化：

In spherical coordinates, the square of angular momentum and its z-component can be simultaneously diagonalized:

$$\hat{L}^2 Y_{\ell m}(\theta,\phi) = \hbar^2 \ell(\ell+1) Y_{\ell m}(\theta,\phi)$$

$$\hat{L}_z Y_{\ell m}(\theta,\phi) = \hbar m Y_{\ell m}(\theta,\phi)$$

其中 $\ell = 0, 1, 2, \ldots$ 和 $m = -\ell, -\ell+1, \ldots, \ell$。

### 简谐振子 | Quantum Harmonic Oscillator

一维量子简谐振子的势为 $V(x) = \frac{1}{2}m\omega^2 x^2$，其能级为：

For the 1D quantum harmonic oscillator with potential $V(x) = \frac{1}{2}m\omega^2 x^2$, the energy levels are:

$$E_n = \hbar\omega\left(n + \frac{1}{2}\right), \quad n = 0, 1, 2, \ldots$$

基态波函数为：

The ground state wave function is:

$$\Psi_0(x) = \left(\frac{m\omega}{\pi\hbar}\right)^{1/4} \exp\left(-\frac{m\omega x^2}{2\hbar}\right)$$

值得注意的是，即使在基态（$n=0$），粒子也有非零的零点能 $E_0 = \frac{1}{2}\hbar\omega$，这是量子效应的直接结果。

### 自旋 | Spin

电子等粒子具有内禀角动量称为自旋。对于自旋1/2粒子（如电子），自旋算符 $\hat{S}_i$ 满足：

Particles like electrons possess an intrinsic angular momentum called spin. For spin-1/2 particles like electrons, spin operators satisfy:

$$[\hat{S}_i, \hat{S}_j] = i\hbar\epsilon_{ijk}\hat{S}_k$$

自旋沿任意方向的测量结果只能是 $\pm\frac{\hbar}{2}$。

Measurement of spin along any direction yields only $\pm\frac{\hbar}{2}$.

### 总结 | Conclusion

量子力学通过波函数、薛定谔方程和算符理论，提供了对微观世界的完整描述。其预言与实验观测的惊人一致性使其成为人类最成功的物理理论之一。量子力学的理解对于现代科技的发展至关重要。
