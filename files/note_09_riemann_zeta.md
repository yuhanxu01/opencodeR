# 黎曼ζ函数与解析数论
# Riemann Zeta Function and Analytic Number Theory

## 中文部分

### 1. 黎曼ζ函数的定义与解析延拓

黎曼ζ函数是数学中最重要的特殊函数之一，它将数论和复分析紧密相连。

**定义**：对 $\Re(s) > 1$，黎曼ζ函数定义为
$$\zeta(s) = \sum_{n=1}^\infty \frac{1}{n^s}$$

或等价的 Euler 无穷乘积：
$$\zeta(s) = \prod_{p \text{ prime}} \frac{1}{1 - p^{-s}}$$

后者展示了ζ函数与素数分布的深刻联系——每个正整数的素因子分解对应乘积中的一个项。

**解析延拓**：虽然上述级数只在 $\Re(s) > 1$ 收敛，但ζ函数可以唯一地解析延拓到整个复平面，除了 $s=1$ 处的简单极点。

关键的函数方程（由 Riemann 发现）：
$$\zeta(s) = 2^s \pi^{s-1} \sin\left(\frac{\pi s}{2}\right) \Gamma(1-s) \zeta(1-s)$$

其中 $\Gamma(s)$ 是 Gamma 函数。这个对称性表明ζ函数关于点 $s = 1/2$ 具有某种对偶性。

### 2. 平凡零点与非平凡零点

**平凡零点**：从函数方程，$\zeta(s)$ 在 $s = -2, -4, -6, \ldots$（负偶数）处有零点，由 $\sin(\pi s/2)$ 的零点给出。

**非平凡零点**：所有已知的非平凡零点都位于临界带 $0 < \Re(s) < 1$ 中。

**黎曼假设**（未解决的 Millennium 问题）：
$$\text{所有的非平凡零点满足 } \Re(s) = \frac{1}{2}$$

即所有非平凡零点都在临界线 $s = 1/2 + it$ 上。这是数学中最著名的未解决问题。

已知的结果：已计算出至少 $10^{13}$ 个零点，全部在临界线上。

### 3. ζ函数与素数定理

**素数计数函数**：定义 $\pi(x)$ 为不超过 $x$ 的素数个数。

**素数定理**（Hadamard, de la Vallée Poussin, 1896）：
$$\pi(x) \sim \frac{x}{\ln x}, \quad \text{或更精确地} \quad \pi(x) = \text{Li}(x) + O(x e^{-c\sqrt{\ln x}})$$

其中 $\text{Li}(x) = \int_2^x \frac{dt}{\ln t}$ 是对数积分。

**Riemann 的显式公式**：
$$\psi(x) = x - \sum_\rho \frac{x^\rho}{\rho} - \ln(2\pi) - \frac{1}{2}\ln(1 - x^{-2})$$

其中 $\psi(x) = \sum_{p^k \leq x}\ln p$ 是 Chebyshev 函数，和式遍历所有非平凡零点 $\rho = 1/2 + i\gamma$。

这个公式说明：素数的分布由ζ函数的零点决定！黎曼假设等价于
$$\pi(x) = \text{Li}(x) + O(x^{1/2 + \epsilon})$$

即素数分布与对数积分的偏差非常小。

### 4. Dirichlet L-函数与字符

**Dirichlet 字符**：模 $q$ 的 Dirichlet 字符 $\chi$ 是从 $\mathbb{Z}/q\mathbb{Z}$ 到 $\mathbb{C}^*$ 的乘法字符，满足
$$\chi(ab) = \chi(a)\chi(b), \quad \chi(n) = 0 \text{ if } \gcd(n,q) > 1$$

**Dirichlet L-函数**：
$$L(s, \chi) = \sum_{n=1}^\infty \frac{\chi(n)}{n^s} = \prod_p \frac{1}{1 - \chi(p)p^{-s}}$$

推广了Riemann ζ函数。

**Dirichlet 定理**（素数在等差数列中的分布）：对 $\gcd(a,q) = 1$，
$$\#\{p \leq x: p \equiv a \pmod{q}\} \sim \frac{\pi(x)}{\phi(q)}$$

其中 $\phi$ 是欧拉函数。这个定理完全由 Dirichlet L-函数的非平凡零点的位置决定。

### 5. Perron 公式与积分表示

**Perron 公式**：
$$\pi(x) = \frac{1}{2\pi i}\int_{c-i\infty}^{c+i\infty} \frac{\ln\zeta(s)}{s}ds + \text{修正项}$$

其中 $c > 1$，积分沿着垂直线。通过向左移动积分轮廓收集ζ函数的极点和零点的贡献。

这种技术被称为**复分析方法**，是解析数论的强大工具。

### 6. 临界带与零点分布

**零点密度估计**：设 $N(T)$ 为虚部 $0 < \Im(\rho) < T$ 的非平凡零点个数，则
$$N(T) = \frac{T}{2\pi}\ln\frac{T}{2\pi e} + O(\ln T)$$

这表明零点随 $T$ 对数增长地变得越来越密集。

**Montgomery 的配对相关猜想**：关于零点间距的统计分布，与随机矩阵理论相关。

### 7. Dedekind ζ函数与数论应用

**代数数论中的推广**：对数域 $K$，其 Dedekind ζ函数为
$$\zeta_K(s) = \prod_{\mathfrak{p}} \frac{1}{1 - N(\mathfrak{p})^{-s}}$$

其中乘积遍历所有非零理想 $\mathfrak{p}$，$N(\mathfrak{p})$ 是理想的范数。

**函数方程**（Hecke）：
$$\zeta_K(s) = \zeta_K(1-s) \cdot (\text{因子})$$

推广了Riemann的函数方程。

**类数公式**：
$$\lim_{s \to 1} (s-1)\zeta_K(s) = \frac{2^{r_1}(2\pi)^{r_2}h R}{w\sqrt{|d_K|}}$$

其中 $h$ 是类数，$R$ 是规范子，$w$ 是单位根个数，$d_K$ 是判别式。这连接了ζ函数的行为与数域的深刻数论性质。

---

## English Part

### 1. Definition and Analytic Continuation

**Definition** ($\Re(s) > 1$):
$$\zeta(s) = \sum_{n=1}^\infty \frac{1}{n^s} = \prod_{p \text{ prime}} \frac{1}{1 - p^{-s}}$$

The Euler product reveals the deep connection between $\zeta(s)$ and prime distributions.

**Analytic Continuation**: $\zeta(s)$ extends uniquely to $\mathbb{C} \setminus \{1\}$.

**Functional Equation** (Riemann):
$$\zeta(s) = 2^s \pi^{s-1} \sin\left(\frac{\pi s}{2}\right) \Gamma(1-s) \zeta(1-s)$$

### 2. Trivial and Non-Trivial Zeros

**Trivial Zeros**: At $s = -2, -4, -6, \ldots$ (negative even integers).

**Non-trivial Zeros**: In critical strip $0 < \Re(s) < 1$.

**Riemann Hypothesis**: All non-trivial zeros lie on the critical line:
$$\Re(s) = \frac{1}{2}$$

Over $10^{13}$ zeros computed; all lie on the critical line. This is the most famous unsolved problem in mathematics.

### 3. ζ-Function and Prime Number Theorem

**Prime Counting Function**: $\pi(x)$ = number of primes $\leq x$.

**Prime Number Theorem** (Hadamard, de la Vallée Poussin, 1896):
$$\pi(x) \sim \frac{x}{\ln x}$$

More precisely:
$$\pi(x) = \text{Li}(x) + O(x e^{-c\sqrt{\ln x}})$$

**Riemann's Explicit Formula**:
$$\psi(x) = x - \sum_\rho \frac{x^\rho}{\rho} - \ln(2\pi) - \frac{1}{2}\ln(1 - x^{-2})$$

where $\psi(x) = \sum_{p^k \leq x}\ln p$ is Chebyshev function, sum over non-trivial zeros $\rho$.

This shows: **prime distribution is determined by $\zeta$-zeros!**

### 4. Dirichlet L-Functions and Characters

**Dirichlet Character** (mod $q$): Multiplicative character $\chi: \mathbb{Z}/q\mathbb{Z} \to \mathbb{C}^*$.

**Dirichlet L-Function**:
$$L(s, \chi) = \sum_{n=1}^\infty \frac{\chi(n)}{n^s} = \prod_p \frac{1}{1 - \chi(p)p^{-s}}$$

**Dirichlet's Theorem** (Primes in arithmetic progressions): For $\gcd(a,q) = 1$:
$$\#\{p \leq x: p \equiv a \pmod{q}\} \sim \frac{\pi(x)}{\phi(q)}$$

### 5. Perron's Formula and Integral Representations

**Perron's Formula**:
$$\pi(x) = \frac{1}{2\pi i}\int_{c-i\infty}^{c+i\infty} \frac{\ln\zeta(s)}{s}ds + \text{correction}$$

where $c > 1$. Shift contour left to collect residues from poles and zeros of $\zeta(s)$.

This **contour shifting technique** is a powerful tool of analytic number theory.

### 6. Critical Strip and Zero Distribution

**Zero Density Estimate**: $N(T)$ = number of zeros with $0 < \Im(\rho) < T$:
$$N(T) = \frac{T}{2\pi}\ln\frac{T}{2\pi e} + O(\ln T)$$

Zeros become logarithmically denser as $\Im$ increases.

**Montgomery's Pair Correlation Conjecture**: On statistical spacing of zeros; related to random matrix theory.

### 7. Dedekind ζ-Function and Applications

**Algebraic Number Theory**: For number field $K$:
$$\zeta_K(s) = \prod_{\mathfrak{p}} \frac{1}{1 - N(\mathfrak{p})^{-s}}$$

**Functional Equation** (Hecke): Generalization of Riemann's equation.

**Class Number Formula**:
$$\lim_{s \to 1} (s-1)\zeta_K(s) = \frac{2^{r_1}(2\pi)^{r_2}h R}{w\sqrt{|d_K|}}$$

Connects $\zeta_K$ behavior to class number $h$ and regulator $R$, linking analytical and arithmetical properties.

---

**字数统计**：约2900字
