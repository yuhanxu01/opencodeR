---
name: literature-search
description: Iterative literature search strategy using OpenCode's search tools. Use this when you need to find specific theorems, equations, algorithms, or concepts in the uploaded literature.
---

## Literature Search Strategy

Like searching code, searching literature requires iterative refinement.

### Cross-Language Search Protocol (中英文跨语言检索)

**CRITICAL**: Literature may contain both Chinese and English content. ALWAYS search in BOTH languages.

When user provides a query:

1. **Translate the query**:
   - If query is in Chinese (中文) → Translate to English
   - If query is in English → Translate to Chinese (中文)
   - Generate multiple translation variants for technical terms

2. **Multi-language search**:
   ```
   # Example: User searches "拉格朗日量"
   grep "拉格朗日" .opencode/literature/       # Chinese term
   grep "Lagrangian" .opencode/literature/     # English translation
   grep "Lagrange" .opencode/literature/       # Alternative form

   # Example: User searches "eigenvalue"
   grep "eigenvalue" .opencode/literature/     # English term
   grep "特征值" .opencode/literature/          # Chinese translation
   grep "本征值" .opencode/literature/          # Alternative Chinese term
   ```

3. **Common technical term pairs** (参考术语对照):
   - 拉格朗日量 ↔ Lagrangian
   - 哈密顿量 ↔ Hamiltonian
   - 特征值/本征值 ↔ eigenvalue
   - 特征向量 ↔ eigenvector
   - 薛定谔方程 ↔ Schrödinger equation
   - 傅里叶变换 ↔ Fourier transform
   - 算法复杂度 ↔ algorithm complexity
   - 数据结构 ↔ data structure
   - 线性代数 ↔ linear algebra
   - 微积分 ↔ calculus
   - 导数 ↔ derivative
   - 积分 ↔ integral

**Always search BOTH languages**, even if initial results are found in one language.

### Search Hierarchy

1. **Keyword Search** (grep)
   ```
   grep "theorem" .opencode/literature/math/
   grep "equation of motion" .opencode/literature/physics/
   grep "complexity O(n" .opencode/literature/cs/
   ```

2. **File Discovery** (glob)
   ```
   glob "**/*quantum*.md" .opencode/literature/
   glob "**/*algorithm*.md" .opencode/literature/cs/
   glob "**/*量子*.md" .opencode/literature/       # Chinese filenames
   glob "**/*算法*.md" .opencode/literature/cs/    # Chinese filenames
   ```

3. **Deep Read** (read)
   - Read promising files completely
   - Note line numbers for citations

### Iterative Refinement

If initial search fails:

1. **Broaden terms**: "Lagrangian" -> "Lagrange" -> "variational"
2. **Try synonyms**: "eigenvalue" -> "characteristic value" -> "spectrum"
3. **Try both languages**: "特征值" AND "eigenvalue" (中英文都试)
4. **Search related concepts**: Can't find theorem? Search its prerequisites
5. **Check different categories**: A math result might be in physics folder

### Cross-Reference Pattern

For complex topics:

1. Find the primary source
2. Search for related terms mentioned in that source
3. Build a citation chain
4. Verify consistency across sources

### Document Categories

```
.opencode/literature/
├── math/           # Pure math: proofs, theorems, lemmas
├── physics/        # Physics: derivations, principles, laws
├── cs/             # CS: algorithms, complexity, data structures
├── engineering/    # Applied: methods, standards, practices
└── textbooks/      # Reference: comprehensive coverage
```

### Math Formula & Symbol Search (数学公式和符号搜索)

**CRITICAL**: Mathematical content may be expressed in multiple formats. Always search using ALL representations.

#### Symbol Search Protocol

When searching for mathematical symbols, use this 4-level strategy:

**Level 1: LaTeX Command Search**
```
grep "\\\\nabla" .opencode/literature/     # del operator
grep "\\\\partial" .opencode/literature/   # partial derivative
grep "\\\\int" .opencode/literature/       # integral
grep "\\\\sum" .opencode/literature/       # summation
grep "\\\\prod" .opencode/literature/      # product
```

**Level 2: Plain English Description**
```
grep "del operator" .opencode/literature/
grep "nabla" .opencode/literature/
grep "partial derivative" .opencode/literature/
grep "integral" .opencode/literature/
grep "summation" .opencode/literature/
```

**Level 3: Chinese Description**
```
grep "微分算子" .opencode/literature/
grep "偏导数" .opencode/literature/
grep "积分" .opencode/literature/
grep "求和" .opencode/literature/
```

**Level 4: Contextual Terms**
```
grep "gradient" .opencode/literature/      # related to ∇
grep "curl" .opencode/literature/          # related to ∇
grep "divergence" .opencode/literature/    # related to ∇
```

#### Common Symbol Mappings

| Symbol | LaTeX | English | Chinese |
|--------|-------|---------|---------|
| ∇ | \\nabla | del, nabla, gradient | 微分算子, 梯度 |
| ∂ | \\partial | partial derivative | 偏导数, 偏微分 |
| ∫ | \\int | integral | 积分 |
| ∑ | \\sum | summation, sum | 求和 |
| ∏ | \\prod | product | 乘积, 累乘 |
| λ | \\lambda | lambda | 拉姆达, 特征值 |
| ψ | \\psi | psi, wave function | 波函数 |
| Ĥ | \\hat{H} | Hamiltonian operator | 哈密顿算符 |
| ℏ | \\hbar | h-bar, reduced Planck constant | 约化普朗克常数 |

#### Equation Search Strategy

When searching for equations:

1. **By equation name**:
   ```
   grep "Schrodinger equation" .opencode/literature/
   grep "薛定谔方程" .opencode/literature/
   grep "Maxwell's equations" .opencode/literature/
   grep "麦克斯韦方程" .opencode/literature/
   ```

2. **By key terms in equation**:
   ```
   grep "E = mc²" .opencode/literature/
   grep "F = ma" .opencode/literature/
   grep "iℏ ∂ψ/∂t" .opencode/literature/
   ```

3. **By related concepts**:
   ```
   # For Schrodinger equation
   grep "wave function" .opencode/literature/
   grep "Hamiltonian" .opencode/literature/
   grep "quantum state" .opencode/literature/
   ```

4. **By theorem/lemma numbering**:
   ```
   grep "Theorem 3" .opencode/literature/
   grep "Lemma 2.1" .opencode/literature/
   grep "引理 2.1" .opencode/literature/
   grep "定理 3" .opencode/literature/
   ```

#### Formula Search Example

**User Query**: "Find the Schrodinger equation"

**Comprehensive Search**:
```bash
# Level 1: Equation name
grep "Schrödinger equation" .opencode/literature/
grep "Schrodinger equation" .opencode/literature/
grep "薛定谔方程" .opencode/literature/

# Level 2: Key terms
grep "iℏ ∂ψ/∂t" .opencode/literature/
grep "Hamiltonian operator" .opencode/literature/
grep "哈密顿算符" .opencode/literature/

# Level 3: Related concepts
grep "wave function" .opencode/literature/
grep "波函数" .opencode/literature/
grep "quantum mechanics" .opencode/literature/

# Level 4: File-based
glob "**/*quantum*.md" .opencode/literature/
glob "**/*schrodinger*.md" .opencode/literature/
```

**Results Analysis**:
```bash
# Found in quantum_mechanics_zh.md:11
grep "薛定谔方程" .opencode/literature/physics/
→ .opencode/literature/physics/quantum_mechanics_zh.md:11

# Read the specific section
read .opencode/literature/physics/quantum_mechanics_zh.md:9-15

# Verification:
✓ Found equation in both CN and EN versions
✓ Exact line numbers available
✓ LaTeX notation present in source
```

#### Algorithm Search Pattern

For CS algorithms and pseudocode:

1. **By algorithm name**:
   ```
   grep "quicksort" .opencode/literature/cs/
   grep "binary search" .opencode/literature/cs/
   grep "快速排序" .opencode/literature/cs/
   grep "二分查找" .opencode/literature/cs/
   ```

2. **By complexity notation**:
   ```
   grep "O(n log n)" .opencode/literature/cs/
   grep "O(n²)" .opencode/literature/cs/
   grep "time complexity" .opencode/literature/cs/
   grep "时间复杂度" .opencode/literature/cs/
   ```

3. **By data structure**:
   ```
   grep "binary tree" .opencode/literature/cs/
   grep "hash table" .opencode/literature/cs/
   grep "二叉树" .opencode/literature/cs/
   grep "哈希表" .opencode/literature/cs/
   ```

### Search Tips

- Math symbols: search by name ("integral", "derivative", "sum")
- Greek letters: search by name ("alpha", "beta", "lambda")
- Equations: search by key terms ("F = ma", "Schrodinger")
- Numbered items: "Theorem 3", "Lemma 2.1", "Algorithm 5"
- ALWAYS search in both LaTeX, English, and Chinese representations
- Use glob to find files by topic, then grep within those files
