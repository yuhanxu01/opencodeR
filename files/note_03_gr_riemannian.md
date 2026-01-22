# 广义相对论中的黎曼几何
# Riemannian Geometry in General Relativity

## 中文部分

### 1. 伪黎曼几何的基础

广义相对论的数学框架是伪黎曼几何（也称为洛伦兹几何）。标准的 Riemannian 度量被替换为签名为 $(-,+,+,+)$ 或 $(+,-,-,-)$ 的度量张量。

**定义**：设 $(M, g)$ 是光滑 4 维流形，$g$ 是光滑的对称 2-张量，在每点具有签名 $(-1,+1,+1,+1)$（以自然单位 $c=1$ 计）。则 $(M,g)$ 是时空流形。

度量张量的分量在坐标系 $(x^\mu)$ 中表示为 $g_{\mu\nu}$，其逆为 $g^{\mu\nu}$，满足
$$g^{\mu\rho}g_{\rho\nu} = \delta^\mu_\nu$$

任意向量的长度由度量定义：对于切向量 $v = v^\mu \partial_\mu$，其"长度"平方为
$$\|v\|^2 = g_{\mu\nu}v^\mu v^\nu$$

### 2. Levi-Civita 联络与测地线

在给定的伪黎曼流形上，存在唯一与度量兼容且无挠的联络，称为 Levi-Civita 联络。其联络系数（Christoffel 符号）为
$$\Gamma^\lambda_{\mu\nu} = \frac{1}{2}g^{\lambda\rho}\left(\frac{\partial g_{\rho\mu}}{\partial x^\nu} + \frac{\partial g_{\rho\nu}}{\partial x^\mu} - \frac{\partial g_{\mu\nu}}{\partial x^\rho}\right)$$

测地线是曲率加速度为零的曲线，其方程为
$$\frac{d^2x^\mu}{dt^2} + \Gamma^\mu_{\rho\sigma}\frac{dx^\rho}{dt}\frac{dx^\sigma}{dt} = 0$$

对于自由下落的物体（忽略其他力），轨迹就是时空中的测地线。这体现了广义相对论的核心思想：重力不是力，而是时空曲率的表现。

### 3. 黎曼张量与曲率

联络的曲率由黎曼曲率张量描述。其定义为，对任意向量场 $X, Y, Z$，
$$R(X,Y)Z = [\nabla_X, \nabla_Y]Z - \nabla_{[X,Y]}Z$$

在坐标基下，黎曼张量的分量为
$$R^\lambda_{\mu\nu\rho} = \frac{\partial\Gamma^\lambda_{\mu\rho}}{\partial x^\nu} - \frac{\partial\Gamma^\lambda_{\mu\nu}}{\partial x^\rho} + \Gamma^\lambda_{\sigma\nu}\Gamma^\sigma_{\mu\rho} - \Gamma^\lambda_{\sigma\rho}\Gamma^\sigma_{\mu\nu}$$

降低第一个指标得到完全协变形式
$$R_{\lambda\mu\nu\rho} = g_{\lambda\sigma}R^\sigma_{\mu\nu\rho}$$

黎曼张量具有多种对称性：
- $R_{\lambda\mu\nu\rho} = -R_{\mu\lambda\nu\rho}$（前两个指标反对称）
- $R_{\lambda\mu\nu\rho} = -R_{\lambda\mu\rho\nu}$（后两个指标反对称）
- $R_{\lambda\mu\nu\rho} = R_{\nu\rho\lambda\mu}$（前后对称）

### 4. Ricci 张量与标量曲率

通过缩并黎曼张量，得到 Ricci 张量：
$$R_{\mu\nu} = R^\lambda_{\mu\lambda\nu} = \frac{\partial\Gamma^\lambda_{\mu\nu}}{\partial x^\lambda} - \frac{\partial\Gamma^\lambda_{\mu\lambda}}{\partial x^\nu} + \Gamma^\lambda_{\rho\lambda}\Gamma^\rho_{\mu\nu} - \Gamma^\lambda_{\rho\nu}\Gamma^\rho_{\mu\lambda}$$

标量曲率定义为
$$R = g^{\mu\nu}R_{\mu\nu}$$

这是曲率的二阶缩并不变量。

### 5. Einstein 场方程

广义相对论的核心方程是 Einstein 场方程：
$$G_{\mu\nu} = 8\pi G T_{\mu\nu}$$

其中 Einstein 张量定义为
$$G_{\mu\nu} = R_{\mu\nu} - \frac{1}{2}Rg_{\mu\nu}$$

$T_{\mu\nu}$ 是能量-动量张量（应力-能量张量），描述物质和能量的分布。例如，完美流体的能量-动量张量为
$$T_{\mu\nu} = (\rho + p)u_\mu u_\nu + pg_{\mu\nu}$$

其中 $\rho$ 是能量密度，$p$ 是压力，$u^\mu$ 是四速度场。

Einstein 方程的特点是非线性的：$G_{\mu\nu}$ 包含关于度量 $g_{\mu\nu}$ 的二阶偏导数。

### 6. Bianchi 恒等式

第二 Bianchi 恒等式是微分几何中的基本恒等式：
$$\nabla_\rho R_{\mu\nu\lambda}^{\sigma} + \nabla_\lambda R_{\mu\nu\rho}^{\sigma} + \nabla_\nu R_{\mu\lambda\rho}^{\sigma} = 0$$

通过缩并，可以导出
$$\nabla_\nu G^{\mu\nu} = 0$$

这是能量-动量张量必须满足的守恒律：$\nabla_\nu T^{\mu\nu} = 0$，自动由 Einstein 方程确保。

### 7. 重要的精确解

**Schwarzschild 解**：真空球对称解（$T_{\mu\nu}=0$），描述黑洞的时空结构：
$$ds^2 = -\left(1 - \frac{2M}{r}\right)dt^2 + \left(1 - \frac{2M}{r}\right)^{-1}dr^2 + r^2(d\theta^2 + \sin^2\theta d\phi^2)$$

事件视界在 $r_s = 2M$（Schwarzschild 半径）处。

**Kerr 解**：旋转黑洞解，带角动量 $a$：
$$ds^2 = -\frac{\Delta}{A}dt^2 - \frac{2Mr a\sin^2\theta}{A}dtd\phi + \frac{A}{\Delta}dr^2 + Ad\theta^2 + \frac{A\sin^2\theta}{D}d\phi^2$$

其中 $\Delta = r^2 - 2Mr + a^2$，$A = r^2 + a^2\cos^2\theta$。

**Friedmann-Robertson-Walker 度量**：宇宙学模型
$$ds^2 = -dt^2 + a(t)^2\left[\frac{dr^2}{1-kr^2} + r^2(d\theta^2 + \sin^2\theta d\phi^2)\right]$$

其中 $a(t)$ 是标度因子，$k \in \{-1,0,1\}$ 是空间曲率参数。

### 8. 应变与物理解释

黎曼曲率的物理意义：在强引力场（如黑洞附近），黎曼张量的潮汐分量
$$K_{\mu\nu} = R_{\mu\alpha\nu\beta}u^\alpha u^\beta$$

（其中 $u^\mu$ 是观测者的四速度）描述自由下落观测者相对加速度，导致物体拉伸（潮汐力）。

---

## English Part

### 1. Foundations of Pseudo-Riemannian Geometry

General relativity is formulated using pseudo-Riemannian geometry with signature $(-,+,+,+)$ in 4 dimensions.

**Definition**: A spacetime $(M,g)$ is a smooth 4-dimensional manifold with a metric tensor $g_{\mu\nu}$ of signature $(-1,+1,+1,+1)$ (in natural units $c=1$). The metric is non-degenerate at every point.

The inverse metric satisfies: $g^{\mu\rho}g_{\rho\nu} = \delta^\mu_\nu$.

### 2. Levi-Civita Connection and Geodesics

The unique metric-compatible torsion-free connection has Christoffel symbols:
$$\Gamma^\lambda_{\mu\nu} = \frac{1}{2}g^{\lambda\rho}\left(\frac{\partial g_{\rho\mu}}{\partial x^\nu} + \frac{\partial g_{\rho\nu}}{\partial x^\mu} - \frac{\partial g_{\mu\nu}}{\partial x^\rho}\right)$$

Geodesics are curves with zero acceleration:
$$\frac{d^2x^\mu}{dt^2} + \Gamma^\mu_{\rho\sigma}\frac{dx^\rho}{dt}\frac{dx^\sigma}{dt} = 0$$

Freely falling objects follow geodesics of spacetime, embodying the principle that gravity is not a force but spacetime curvature.

### 3. Riemann Tensor and Curvature

The curvature of the connection is the Riemann tensor:
$$R^\lambda_{\mu\nu\rho} = \frac{\partial\Gamma^\lambda_{\mu\rho}}{\partial x^\nu} - \frac{\partial\Gamma^\lambda_{\mu\nu}}{\partial x^\rho} + \Gamma^\lambda_{\sigma\nu}\Gamma^\sigma_{\mu\rho} - \Gamma^\lambda_{\sigma\rho}\Gamma^\sigma_{\mu\nu}$$

The fully covariant form is: $R_{\lambda\mu\nu\rho} = g_{\lambda\sigma}R^\sigma_{\mu\nu\rho}$

Symmetries:
- $R_{\lambda\mu\nu\rho} = -R_{\mu\lambda\nu\rho}$ (first pair antisymmetric)
- $R_{\lambda\mu\nu\rho} = -R_{\lambda\mu\rho\nu}$ (last pair antisymmetric)
- $R_{\lambda\mu\nu\rho} = R_{\nu\rho\lambda\mu}$ (block symmetric)

### 4. Ricci Tensor and Scalar Curvature

Contraction yields the Ricci tensor:
$$R_{\mu\nu} = R^\lambda_{\mu\lambda\nu}$$

The Ricci scalar (curvature invariant) is:
$$R = g^{\mu\nu}R_{\mu\nu}$$

### 5. Einstein Field Equations

The fundamental equations of general relativity:
$$G_{\mu\nu} = 8\pi G_N T_{\mu\nu}$$

where the Einstein tensor is:
$$G_{\mu\nu} = R_{\mu\nu} - \frac{1}{2}Rg_{\mu\nu}$$

and $T_{\mu\nu}$ is the stress-energy tensor. These are nonlinear PDEs for $g_{\mu\nu}$.

For a perfect fluid:
$$T_{\mu\nu} = (\rho + p)u_\mu u_\nu + pg_{\mu\nu}$$

where $\rho$ is energy density, $p$ is pressure, and $u^\mu$ is the 4-velocity.

### 6. Bianchi Identities

The second Bianchi identity:
$$\nabla_\rho R_{\mu\nu\lambda}^{\sigma} + \text{cyclic permutations} = 0$$

By contraction: $\nabla_\nu G^{\mu\nu} = 0$

This ensures energy-momentum conservation: $\nabla_\nu T^{\mu\nu} = 0$.

### 7. Important Exact Solutions

**Schwarzschild**: Spherically symmetric vacuum solution
$$ds^2 = -\left(1 - \frac{2M}{r}\right)dt^2 + \left(1 - \frac{2M}{r}\right)^{-1}dr^2 + r^2d\Omega^2$$

**Kerr**: Rotating black hole with angular momentum $a$

**Friedmann-Robertson-Walker**: Cosmological metric
$$ds^2 = -dt^2 + a(t)^2\left[\frac{dr^2}{1-kr^2} + r^2d\Omega^2\right]$$

### 8. Physical Interpretation

The tidal tensor: $K_{\mu\nu} = R_{\mu\alpha\nu\beta}u^\alpha u^\beta$ describes relative acceleration of freely falling observers, the physical manifestation of spacetime curvature.

---

**字数统计**：约2850字
