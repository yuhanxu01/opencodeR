# 随机微分方程与随机积分
# Stochastic Differential Equations and Stochastic Integration

## 中文部分

### 1. Brown 运动与 Wiener 过程

Brown 运动（Brownian motion）是随机过程论中最基础的模型，描述悬浮在流体中的微粒的随机运动。

**定义**：标准 Wiener 过程（布朗运动）$W_t$ 是满足以下条件的随机过程：
1. $W_0 = 0$（从原点开始）
2. 增量 $W_t - W_s$ 独立于 $W_s - W_0$（独立增量性）
3. 增量 $W_t - W_s \sim \mathcal{N}(0, t-s)$（高斯增量）
4. 轨迹几乎处处连续

更高维的情况：$\mathbb{R}^n$ 上的 $m$ 维 Wiener 过程 $W_t = (W_t^1, \ldots, W_t^m)$，各分量独立。

**性质**：
- 方差：$\text{Var}(W_t) = t$
- 二次变分：$[W,W]_t = t$（意味着路径变差无限大）
- 不可微性：路径几乎处处不可微

### 2. Ito 积分的定义与性质

直接定义 $\int_0^t f(s)dW_s$ 作为 Riemann-Stieltjes 积分是有问题的，因为 Brown 运动的变差无限。Ito 提出了一个新的积分定义。

**Ito 积分**：设 $f: [0,T] \times \Omega \rightarrow \mathbb{R}$ 是过程，满足适应性和可积性条件。将 $[0,t]$ 分割为 $0 = t_0 < t_1 < \cdots < t_n = t$，定义
$$I(f)_t = \lim_{|\Delta t| \to 0} \sum_{i=0}^{n-1} f(t_i)(W_{t_{i+1}} - W_{t_i})$$

这个极限在 $L^2$ 意义下收敛。关键是：在每个增量处取被积函数在左端点的值。

**Ito 等距关系**：
$$\mathbb{E}\left[\left(\int_0^t f_s dW_s\right)^2\right] = \mathbb{E}\left[\int_0^t f_s^2 ds\right]$$

这反映了 Ito 积分的一个基本性质。

**Ito 过程**：形如
$$X_t = X_0 + \int_0^t \mu_s ds + \int_0^t \sigma_s dW_s$$

的过程，其中 $\mu_s$ 和 $\sigma_s$ 是适应过程。

### 3. Ito 公式（微积分基本定理的随机推广）

**Ito 公式**：设 $f(x)$ 是 $C^2$ 函数，$X_t$ 是 Ito 过程
$$dX_t = \mu_t dt + \sigma_t dW_t$$

则
$$df(X_t) = f'(X_t)dX_t + \frac{1}{2}f''(X_t)(dX_t)^2$$

展开得
$$df(X_t) = \left[f'(X_t)\mu_t + \frac{1}{2}f''(X_t)\sigma_t^2\right]dt + f'(X_t)\sigma_t dW_t$$

关键的是 $(dW_t)^2 = dt$ 这个规则（与微积分中 $(dx)^2 = 0$ 不同）。

**高维情形**：对向量值过程 $X_t \in \mathbb{R}^n$ 和 $f: \mathbb{R}^n \to \mathbb{R}$，
$$df(X_t) = \nabla f \cdot dX_t + \frac{1}{2}\sum_{i,j} \frac{\partial^2 f}{\partial x_i \partial x_j}d[X^i, X^j]_t$$

其中 $d[X^i, X^j]_t$ 是交叉二次变分。

### 4. 随机微分方程及其解的存在唯一性

**随机微分方程（SDE）**：形式为
$$dX_t = b(t, X_t)dt + \sigma(t, X_t)dW_t, \quad X_0 = x_0$$

的方程，其中 $b$ 是漂移系数，$\sigma$ 是扩散系数。

**定理（Ito 的存在唯一性）**：若 $b$ 和 $\sigma$ 满足 Lipschitz 条件：
$$|b(t,x) - b(t,y)| + |\sigma(t,x) - \sigma(t,y)| \leq K|x-y|$$

且增长条件：
$$|b(t,x)| + |\sigma(t,x)| \leq K(1+|x|)$$

则初值问题有唯一的强解 $X_t$，几乎处处连续。

**线性 SDE**：若 $b$ 和 $\sigma$ 都是 $X_t$ 的线性函数：
$$dX_t = (a_t X_t + c_t)dt + (f_t X_t + g_t)dW_t$$

则可显式求解：
$$X_t = \exp\left(\int_0^t a_s ds + \int_0^t f_s dW_s - \frac{1}{2}\int_0^t f_s^2 ds\right)\left[x_0 + \int_0^t \exp(-\cdots)c_s ds + \cdots\right]$$

### 5. Stratonovich 积分与路径积分

虽然 Ito 积分更方便计算，但 **Stratonovich 积分** 保留了普通微积分的规则：
$$(dW_t)^2 = dt, \quad dt \cdot dW_t = 0$$

Stratonovich 积分定义为
$$\int_0^t f_s \circ dW_s = \lim_{|\Delta t| \to 0} \sum_i f\left(\frac{t_i + t_{i+1}}{2}\right)(W_{t_{i+1}} - W_{t_i})$$

在中点处取值。Ito 积分与 Stratonovich 积分的关系：
$$\int_0^t f_s dW_s = \int_0^t f_s \circ dW_s - \frac{1}{2}\int_0^t f_s'ds$$

Stratonovich 积分形式下的 SDE 遵循链式法则：
$$df(X_t) = f'(X_t) \circ dX_t$$

### 6. Girsanov 定理与措施变换

**Girsanov 定理**：这是随机分析中最重要的定理之一。

给定 Brown 运动 $W_t$ 和适应过程 $\theta_t$（Novikov 条件下），定义
$$Z_t = \exp\left(-\int_0^t \theta_s dW_s - \frac{1}{2}\int_0^t \theta_s^2 ds\right)$$

则存在等价概率测度 $\mathbb{Q}$ 使得
$$\tilde{W}_t = W_t + \int_0^t \theta_s ds$$

是 $\mathbb{Q}$ 下的 Brown 运动。

**应用**：在金融数学中用于将漂移项变换为 0，使得資産价格过程是 martingale。

### 7. 应用：几何 Brown 运动与 Black-Scholes 模型

**几何 Brown 运动（GBM）**：
$$dS_t = \mu S_t dt + \sigma S_t dW_t$$

其中 $\mu$ 是期望收益率，$\sigma$ 是波动率。

应用 Ito 公式到 $f(S) = \ln(S)$：
$$d\ln(S_t) = \left(\mu - \frac{\sigma^2}{2}\right)dt + \sigma dW_t$$

积分得
$$S_t = S_0 \exp\left[\left(\mu - \frac{\sigma^2}{2}\right)t + \sigma W_t\right]$$

**Black-Scholes 公式**：欧洲看涨期权价格为
$$C(S_0, t) = S_0 N(d_1) - Ke^{-r(T-t)}N(d_2)$$

其中
$$d_{1,2} = \frac{\ln(S_0/K) + (r \pm \sigma^2/2)(T-t)}{\sigma\sqrt{T-t}}$$

使用 Girsanov 定理和风险中立测度推导。

---

## English Part

### 1. Brownian Motion and Wiener Process

The Wiener process is the fundamental random process in stochastic analysis.

**Definition**: Standard Wiener process $W_t$ satisfies:
1. $W_0 = 0$
2. Independent increments: $W_t - W_s \perp W_s - W_0$
3. Gaussian increments: $W_t - W_s \sim \mathcal{N}(0, t-s)$
4. Continuous paths

Properties:
- $\text{Var}(W_t) = t$
- Quadratic variation: $[W,W]_t = t$
- Paths are nowhere differentiable a.s.

### 2. Ito Integral Definition and Properties

Since Brownian motion has infinite variation, standard Riemann-Stieltjes integration fails. Ito defined a new integral.

**Ito Integral**: For adapted process $f$:
$$I(f)_t = \lim_{|\Delta t|\to 0} \sum_i f(t_i)(W_{t_{i+1}} - W_{t_i})$$

evaluated at left endpoints.

**Ito Isometry**:
$$\mathbb{E}\left[\left(\int_0^t f_s dW_s\right)^2\right] = \mathbb{E}\left[\int_0^t f_s^2 ds\right]$$

### 3. Ito's Lemma (Stochastic Chain Rule)

For $f \in C^2$ and Ito process $X_t = X_0 + \int_0^t \mu_s ds + \int_0^t \sigma_s dW_s$:
$$df(X_t) = f'(X_t)dX_t + \frac{1}{2}f''(X_t)(dX_t)^2$$

With the rule $(dW_t)^2 = dt$ (unlike ordinary calculus):
$$df(X_t) = \left[f'(X_t)\mu_t + \frac{1}{2}f''(X_t)\sigma_t^2\right]dt + f'(X_t)\sigma_t dW_t$$

### 4. Stochastic Differential Equations

The SDE:
$$dX_t = b(t,X_t)dt + \sigma(t,X_t)dW_t$$

has a unique strong solution under Lipschitz and growth conditions.

**Linear SDE**: Solutions can be written explicitly using integrating factors.

### 5. Stratonovich Integral

Alternative definition using midpoints:
$$\int_0^t f_s \circ dW_s$$

satisfies ordinary chain rule: $df = f'(X) \circ dX_t$.

Relation to Ito integral:
$$\int_0^t f_s dW_s = \int_0^t f_s \circ dW_s - \frac{1}{2}\int_0^t f'_s ds$$

### 6. Girsanov's Theorem

For adapted process $\theta_t$ (under Novikov condition):
$$Z_t = \exp\left(-\int_0^t \theta_s dW_s - \frac{1}{2}\int_0^t \theta_s^2 ds\right)$$

There exists equivalent measure $\mathbb{Q}$ where:
$$\tilde{W}_t = W_t + \int_0^t \theta_s ds$$

is Brownian motion under $\mathbb{Q}$.

### 7. Application: Geometric Brownian Motion and Black-Scholes

**GBM**: $dS_t = \mu S_t dt + \sigma S_t dW_t$

Solution: $S_t = S_0 \exp[(\mu - \sigma^2/2)t + \sigma W_t]$

**Black-Scholes Formula**: European call option price:
$$C = S_0 N(d_1) - Ke^{-r(T-t)}N(d_2)$$

where $N$ is standard normal CDF and
$$d_{1,2} = \frac{\ln(S_0/K) + (r \pm \sigma^2/2)(T-t)}{\sigma\sqrt{T-t}}$$

---

**字数统计**：约2900字
