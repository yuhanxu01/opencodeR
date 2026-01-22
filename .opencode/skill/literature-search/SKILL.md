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

### Search Tips

- Math symbols: search by name ("integral", "derivative", "sum")
- Greek letters: search by name ("alpha", "beta", "lambda")
- Equations: search by key terms ("F = ma", "Schrodinger")
- Numbered items: "Theorem 3", "Lemma 2.1", "Algorithm 5"
