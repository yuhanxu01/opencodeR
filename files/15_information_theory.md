# 信息论基础
## Fundamentals of Information Theory

### 简介 | Introduction

信息论由克劳德·香农在1948年创立，是研究信息的定量度量、存储、传输和处理的数学理论。信息论不仅为现代通信系统奠定了基础，还与热力学、统计力学、密码学、机器学习等多个领域有深刻的联系。信息论提供了一套严谨的数学框架来量化"信息"这个直观概念。

Information theory, founded by Claude Shannon in 1948, is a mathematical theory studying the quantitative measures, storage, transmission, and processing of information. It not only forms the foundation of modern communication systems but also connects deeply with thermodynamics, statistical mechanics, cryptography, and machine learning. It provides a rigorous mathematical framework to quantify the intuitive concept of "information."

### 自信息和信息熵 | Self-Information and Entropy

**自信息**定义为某事件发生所含的信息量。事件 $x$ 发生概率为 $p(x)$ 时，其自信息为：

$$I(x) = -\log_2 p(x) = \log_2\frac{1}{p(x)} \quad \text{(单位：比特)}$$

概率越小，自信息越大。使用以2为底的对数，单位是**比特**（bit）；使用自然对数，单位是**纳特**（nat）。

**香农熵**或**信息熵**是对随机变量 $X$ 平均信息量的度量：

$$H(X) = -\sum_x p(x)\log_2 p(x) = \mathbb{E}[-\log_2 p(X)]$$

对于连续分布 $p(x)$，定义为**微分熵**：

$$H(X) = -\int p(x)\log_2 p(x) dx$$

**熵的性质**：

- 非负性：$H(X) \geq 0$
- 最大值：对于有 $n$ 个等概率结果的情况，$H(X)_{\max} = \log_2 n$
- 可加性：独立变量的联合熵等于各自熵的和

### 联合熵和条件熵 | Joint and Conditional Entropy

两个随机变量 $X$ 和 $Y$ 的**联合熵**：

$$H(X, Y) = -\sum_{x,y} p(x,y)\log_2 p(x,y)$$

**条件熵** $H(Y|X)$ 表示已知 $X$ 后 $Y$ 的平均不确定性：

$$H(Y|X) = -\sum_{x,y} p(x,y)\log_2 p(y|x) = H(X,Y) - H(X)$$

**链式法则**：

$$H(X, Y) = H(X) + H(Y|X)$$

这表明联合熵可以分解为边界熵加条件熵。

### 互信息 | Mutual Information

$X$ 和 $Y$ 的**互信息**测量它们之间的相关程度：

$$I(X; Y) = H(X) - H(X|Y) = H(Y) - H(Y|X) = H(X) + H(Y) - H(X,Y)$$

也可表示为相对熵形式：

$$I(X; Y) = \sum_{x,y} p(x,y)\log_2\frac{p(x,y)}{p(x)p(y)}$$

互信息的性质：

- 非负：$I(X; Y) \geq 0$，等号成立当且仅当 $X$ 和 $Y$ 独立
- 对称：$I(X; Y) = I(Y; X)$
- 最大值：$I(X; Y) \leq \min(H(X), H(Y))$

### 相对熵和KL散度 | Relative Entropy and KL Divergence

相对熵（库尔贝克-莱布勒散度）衡量两个概率分布的差异：

$$D_{KL}(P || Q) = \sum_x p(x)\log_2\frac{p(x)}{q(x)}$$

对于连续分布：

$$D_{KL}(P || Q) = \int p(x)\log_2\frac{p(x)}{q(x)} dx$$

**性质**：

- 非负：$D_{KL}(P || Q) \geq 0$，等号成立当且仅当 $P = Q$（不是对称的）
- 信息不等式：$D_{KL}(P || Q) = H(P, Q) - H(P)$，其中 $H(P, Q)$ 是交叉熵

相对熵经常用于衡量模型与真实分布的差异，在机器学习中广泛应用。

### 信道容量 | Channel Capacity

通信信道由**转移概率** $p(y|x)$ 描述，表示发送 $x$ 时接收 $y$ 的概率。

**互信息的定义**在通信中表示通道能传输的最大信息量：

$$I(X; Y) = H(Y) - H(Y|X)$$

**信道容量** $C$ 是通道能可靠传输的最大信息速率：

$$C = \max_{p(x)} I(X; Y)$$

对于二进制对称信道（BSC），错误概率为 $p_e$：

$$C_{BSC} = 1 - H(p_e) = 1 + p_e\log_2 p_e + (1-p_e)\log_2(1-p_e)$$

当 $p_e = 0$ 时，$C = 1$ 比特；当 $p_e = 0.5$ 时，$C = 0$（无用信道）。

### 香农定理 | Shannon Theorems

**无噪声编码定理**（第一定理）：对于熵为 $H(X)$ 的信息源，最优编码的平均码长不能小于 $H(X)$，但可以任意接近 $H(X)$。

这解释了为什么数据压缩的极限就是信息熵。

**有噪声信道编码定理**（第二定理）：在一个容量为 $C$ 的信道上，如果信息速率 $R < C$，则存在编码方案能以任意小的错误率传输信息；反之如果 $R > C$，则无论何种编码都会有非零的错误率。

$$R < C \Rightarrow \text{arbitrarily low error rate}$$

### 信息的热力学本质 | Thermodynamic Nature of Information

信息与熵的关系深刻而微妙。**兰迪耳悖论**表明：在计算过程中消除信息（删除比特）必然产生热量。

**信息热力学定律**：

$$Q \geq k_B T \ln 2 \quad \text{per bit erased}$$

信息和熵的联系体现在**吉布斯熵**上。在统计力学中：

$$S = -k_B\sum_i p_i\ln p_i = k_B H_{nat}(X)$$

其中 $H_{nat}$ 是以自然对数为基的熵。

### 数据压缩 | Data Compression

**无损压缩**的目标是在不丢失信息的前提下减少数据量。

**香农-范诺编码**：根据符号概率分配不等长码字，概率高的符号分配短码字。

**哈夫曼编码**：构造最优二进制树，平均码长等于熵。

**霍夫曼编码算法**：反复合并概率最小的两个符号，直到完成编码树的构造。

**无失真压缩的极限**：平均码长不能小于信息熵：

$$L \geq H(X)$$

**有损压缩**允许一定的信息丢失以换取更高的压缩率。**率-失真理论**描述了压缩率与失真之间的权衡。

### 编码论 | Coding Theory

**纠错码**用于在噪声信道上可靠传输。

**汉明码**：加入校验比特检测并纠正单比特错误。

**循环码**：利用多项式的性质构造码字。

**码率** $R = k/n$，其中 $k$ 是信息比特数，$n$ 是码字长度。

**最小距离** $d$ 决定纠错能力。能纠正 $t$ 个错误的必要条件是 $d \geq 2t + 1$。

**香农界**给出了在给定码率和最小距离下最大码字数的上界。

### 密码学中的信息论 | Information Theory in Cryptography

**完全保密**：加密后的密文不含关于明文的任何信息。

**一次一密（One-time Pad）**：用与明文长度相同的随机密钥加密，满足完全保密。密钥长度必须至少等于明文长度：

$$H(key) \geq H(plaintext)$$

**密钥空间的大小**决定了暴力破解的困难程度。对于 $n$ 比特密钥，平均需要 $2^{n-1}$ 次尝试。

### 总结 | Conclusion

信息论以概率论和数学为基础，建立了关于信息的严格理论。从量化信息的概念开始，香农开创了一个新的学科。信息论的应用涵盖编码、通信、密码、机器学习等众多领域。信息与能量、熵的联系表明信息不仅是抽象的数学概念，更是物理现实的基本特性。在信息时代，信息论的重要性与日俱增。
