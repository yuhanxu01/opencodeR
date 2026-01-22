# 光学原理
## Principles of Optics

### 简介 | Introduction

光学是研究光的产生、传播和与物质相互作用的科学。光既表现出波的性质，也表现出粒子的性质——这就是波粒二象性。从透镜和反射镜的几何光学到衍射和干涉的波动光学，再到光子和激光的量子光学，光学涉及物理学的多个层次。

Optics is the science studying the generation, propagation, and interaction of light with matter. Light exhibits both wave and particle properties—the wave-particle duality. From geometric optics of lenses and mirrors to wave optics of diffraction and interference, and quantum optics of photons and lasers, optics spans multiple levels of physics.

### 几何光学基础 | Fundamentals of Geometric Optics

**反射定律**：入射角等于反射角，入射光、反射光和法线在同一平面内。

**折射定律（斯涅尔定律）**：

$$n_1\sin\theta_1 = n_2\sin\theta_2$$

其中 $n$ 是折射率，$\theta$ 是与法线的夹角。

折射率 $n$ 是材料对光速的影响：

$$n = \frac{c}{v}$$

其中 $c$ 是真空中光速，$v$ 是材料中光速。

**全内反射**：当光从光学密度大的介质进入光学密度小的介质时，若入射角大于临界角 $\theta_c = \arcsin(n_2/n_1)$，就会发生全内反射。

### 透镜和镜面 | Lenses and Mirrors

**透镜方程**：

$$\frac{1}{f} = \frac{1}{s} + \frac{1}{s'}$$

其中 $f$ 是焦距，$s$ 是物距，$s'$ 是像距。

**镜面方程**与透镜方程形式相同。

**放大倍数**：

$$m = -\frac{s'}{s} = \frac{h'}{h}$$

其中 $h$ 和 $h'$ 分别是物和像的高度。

凸透镜（正透镜）的焦距为正，凹透镜（负透镜）的焦距为负。

**透镜制造者公式**：

$$\frac{1}{f} = (n-1)\left(\frac{1}{R_1} - \frac{1}{R_2}\right)$$

其中 $R_1$ 和 $R_2$ 是两个曲面的曲率半径。

### 波动光学基础 | Wave Optics Basics

光是电磁波，其传播可用波动方程描述。光波的基本参数包括：

Light is an electromagnetic wave. Its propagation is described by the wave equation with parameters:

**波长** $\lambda$、**频率** $\nu$、**周期** $T = 1/\nu$ 和**波速** $v$：

$$v = \lambda\nu$$

在真空中 $v = c$。

**振幅**和**相位**也是重要参数。单色平面波可写成：

$$E(x,t) = E_0\cos(kx - \omega t + \phi)$$

其中波数 $k = 2\pi/\lambda = \omega/c$，角频率 $\omega = 2\pi\nu$，$\phi$ 是初相位。

### 干涉 | Interference

当两列相干光相遇时会发生干涉。光程差为 $\Delta L$ 时：

When two coherent light waves meet, interference occurs. With optical path difference $\Delta L$:

**相长干涉**（加强）：$\Delta L = m\lambda$，$m = 0, 1, 2, \ldots$

**相消干涉**（减弱）：$\Delta L = (m + \frac{1}{2})\lambda$，$m = 0, 1, 2, \ldots$

**杨氏双缝干涉**：两条狭缝充当相干光源。在屏幕上距中心距离 $y$ 的位置，明纹出现在：

$$y_m = \frac{m\lambda L}{d}$$

其中 $L$ 是狭缝到屏幕的距离，$d$ 是两狭缝间距。

相邻亮纹间距为：

$$\Delta y = \frac{\lambda L}{d}$$

### 衍射 | Diffraction

光与物体边缘或孔口相互作用时会发生衍射，表现为光的弯曲。

**单缝衍射**：宽度为 $a$ 的单缝的第 $m$ 阶暗纹出现在角度 $\theta$ 处，满足：

$$a\sin\theta = m\lambda, \quad m = 1, 2, 3, \ldots$$

中心亮纹的宽度为：

$$w = \frac{2\lambda L}{a}$$

其中 $L$ 是缝到屏幕的距离。

**多缝衍射（光栅）**：光栅常数为 $d$ 的光栅在角度 $\theta$ 处产生亮纹，满足光栅方程：

$$d\sin\theta = m\lambda, \quad m = 0, 1, 2, \ldots$$

光栅是分光仪和分光计的核心组件。

### 偏振 | Polarization

光波是横波，其电矢量的振动方向称为偏振方向。

**线偏振光**：电矢量始终在一个固定方向上。

**圆偏振光**：电矢量的端点描绘出圆形轨迹。

**椭圆偏振光**：电矢量的端点描绘出椭圆轨迹。

**马吕斯定律**：线偏振光经过偏振片后，透射光强为：

$$I = I_0\cos^2\theta$$

其中 $\theta$ 是入射光与偏振片偏振方向的夹角。

**布鲁斯特角**：光从介质1入射到介质2，当入射角为 $\theta_B$ 时，反射光为完全线偏振：

$$\tan\theta_B = \frac{n_2}{n_1}$$

### 光的色散和吸收 | Dispersion and Absorption

**色散**是折射率随波长变化的现象。正常色散 ($dn/d\lambda < 0$) 意味着较短波长光的折射率更大。

**柯西公式**描述色散：

$$n(\lambda) = A + \frac{B}{\lambda^2} + \frac{C}{\lambda^4} + \cdots$$

**吸收**是光在介质中传播时强度衰减的现象，遵循比尔-兰伯特定律：

$$I = I_0 e^{-\alpha x}$$

其中 $\alpha$ 是吸收系数。

### 光的量子性质 | Quantum Nature of Light

光由光子组成，每个光子的能量为：

$$E = h\nu = \hbar\omega$$

其中 $h = 6.626 \times 10^{-34}$ J·s 是普朗克常数，$\hbar = h/(2\pi)$。

光子的动量为：

$$p = \frac{E}{c} = \frac{h}{\lambda}$$

这就是德布罗意关系，表明粒子和波具有对偶性。

**光电效应**：光照射金属时释放电子。爱因斯坦的光电方程为：

$$h\nu = \Phi + K_{max}$$

其中 $\Phi$ 是逸出功，$K_{max}$ 是光电子的最大动能。

### 激光 | Lasers

激光（Light Amplification by Stimulated Emission of Radiation）利用受激发射放大相干光。

**受激发射过程**：原子在光子刺激下放出与刺激光相同的光子（相位相同、方向相同、偏振相同）。

激光的特点：

- **相干性**：高时间和空间相干性
- **单色性**：频谱宽度极窄
- **方向性**：发散角小
- **亮度**：极高的能量密度

激光三个必要条件：工作物质、泵浦源、光学谐振腔。

### 总结 | Conclusion

光学从宏观的几何光学出发，通过波动光学描述光的干涉衍射，再上升到量子光学的光子图像。这种多层次的描述反映了光物质本质的复杂性。现代光学技术包括纤维光学、非线性光学、量子光学等，在通信、医疗、工业等领域有广泛应用。
