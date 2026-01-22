# 跨语言文献检索指南 (Cross-Language Literature Search Guide)

## 概述 (Overview)

本系统支持中英文跨语言文献检索，确保无论您使用哪种语言搜索，都能找到所有相关的中文和英文文献。

This system supports cross-language literature search between Chinese and English, ensuring you can find all relevant documents regardless of the query language.

## 工作原理 (How It Works)

### 自动翻译搜索 (Automatic Translation Search)

当您进行检索时，系统会：
1. 识别您的查询语言
2. 自动翻译到另一种语言
3. 同时使用两种语言的关键词搜索
4. 合并并返回所有相关结果

When you search, the system will:
1. Detect your query language
2. Automatically translate to the other language
3. Search using keywords in both languages
4. Merge and return all relevant results

## 使用示例 (Usage Examples)

### 示例1：中文查询 (Example 1: Chinese Query)

**用户输入**: "搜索拉格朗日量的定义"

**系统执行**:
```bash
# 中文搜索
grep "拉格朗日" .opencode/literature/

# 英文搜索（自动翻译）
grep "Lagrangian" .opencode/literature/
grep "Lagrange" .opencode/literature/

# 文件名搜索
glob "**/*拉格朗日*.md" .opencode/literature/
glob "**/*lagrange*.md" .opencode/literature/
```

**结果**: 返回所有包含"拉格朗日量"或"Lagrangian"的中英文文档

---

### 示例2：英文查询 (Example 2: English Query)

**User Input**: "Search for eigenvalue decomposition"

**System Executes**:
```bash
# English search
grep "eigenvalue" .opencode/literature/
grep "eigenvector" .opencode/literature/

# Chinese search (automatic translation)
grep "特征值" .opencode/literature/
grep "本征值" .opencode/literature/
grep "特征向量" .opencode/literature/

# Filename search
glob "**/*eigen*.md" .opencode/literature/
glob "**/*特征*.md" .opencode/literature/
```

**Result**: Returns all documents containing "eigenvalue" or "特征值" in both languages

---

## 常用术语对照表 (Common Technical Term Pairs)

### 数学 (Mathematics)
| 中文 | English |
|------|---------|
| 线性代数 | Linear Algebra |
| 特征值 / 本征值 | Eigenvalue |
| 特征向量 | Eigenvector |
| 矩阵 | Matrix |
| 行列式 | Determinant |
| 微积分 | Calculus |
| 导数 | Derivative |
| 积分 | Integral |
| 微分方程 | Differential Equation |
| 傅里叶变换 | Fourier Transform |
| 拉普拉斯变换 | Laplace Transform |

### 物理 (Physics)
| 中文 | English |
|------|---------|
| 拉格朗日量 | Lagrangian |
| 哈密顿量 | Hamiltonian |
| 薛定谔方程 | Schrödinger Equation |
| 波函数 | Wave Function |
| 量子力学 | Quantum Mechanics |
| 经典力学 | Classical Mechanics |
| 电磁学 | Electromagnetism |
| 麦克斯韦方程 | Maxwell's Equations |
| 相对论 | Relativity |
| 能量守恒 | Energy Conservation |

### 计算机科学 (Computer Science)
| 中文 | English |
|------|---------|
| 算法 | Algorithm |
| 数据结构 | Data Structure |
| 复杂度 | Complexity |
| 时间复杂度 | Time Complexity |
| 空间复杂度 | Space Complexity |
| 排序算法 | Sorting Algorithm |
| 搜索算法 | Search Algorithm |
| 动态规划 | Dynamic Programming |
| 贪心算法 | Greedy Algorithm |
| 图论 | Graph Theory |
| 二叉树 | Binary Tree |
| 哈希表 | Hash Table |

### 工程 (Engineering)
| 中文 | English |
|------|---------|
| 信号处理 | Signal Processing |
| 控制系统 | Control System |
| 反馈回路 | Feedback Loop |
| 滤波器 | Filter |
| 傅里叶分析 | Fourier Analysis |
| 传递函数 | Transfer Function |

---

## 最佳实践 (Best Practices)

### 1. 扩展搜索词 (Expand Search Terms)

如果初次搜索结果不足，尝试：
- 使用同义词 (Use synonyms)
- 使用缩写和全称 (Use abbreviations and full names)
- 使用相关概念 (Use related concepts)

**示例**:
```
"特征值" → "本征值" → "eigenvalue" → "characteristic value"
"FFT" → "Fast Fourier Transform" → "快速傅里叶变换"
```

### 2. 文件名搜索 (Filename Search)

不要忘记通过文件名搜索：
```bash
glob "**/*quantum*.md"    # English
glob "**/*量子*.md"       # Chinese
```

### 3. 多类别搜索 (Multi-Category Search)

相同概念可能出现在不同类别中：
```bash
grep "Fourier" .opencode/literature/math/
grep "Fourier" .opencode/literature/physics/
grep "Fourier" .opencode/literature/engineering/
```

---

## 技术实现 (Technical Implementation)

### 搜索流程 (Search Workflow)

```
用户查询 (User Query)
    ↓
检测语言 (Detect Language)
    ↓
翻译关键词 (Translate Keywords)
    ↓
生成搜索变体 (Generate Search Variants)
    ↓
并行搜索 (Parallel Search)
    ├─ 中文关键词 (Chinese keywords)
    ├─ 英文关键词 (English keywords)
    ├─ 同义词 (Synonyms)
    └─ 相关术语 (Related terms)
    ↓
合并去重 (Merge & Deduplicate)
    ↓
按相关度排序 (Sort by Relevance)
    ↓
返回结果 (Return Results)
```

### 集成到现有技能 (Integration with Existing Skills)

- **literature-search**: 自动执行双语搜索
- **stem-research**: 要求所有引用必须经过双语验证
- **explore agent**: 支持跨语言代码和文档探索

---

## 常见问题 (FAQ)

### Q1: 我需要手动翻译查询吗？
**A**: 不需要。系统会自动翻译并搜索两种语言。

### Q1: Do I need to manually translate my queries?
**A**: No. The system automatically translates and searches in both languages.

---

### Q2: 如果术语有多个翻译怎么办？
**A**: 系统会尝试所有常见的翻译变体。例如"eigenvalue"会搜索"特征值"和"本征值"。

### Q2: What if a term has multiple translations?
**A**: The system will try all common translation variants. For example, "eigenvalue" searches for both "特征值" and "本征值".

---

### Q3: 搜索会变慢吗？
**A**: 虽然执行了更多搜索，但由于并行执行，总体速度影响很小。

### Q3: Will search become slower?
**A**: Although more searches are executed, the overall speed impact is minimal due to parallel execution.

---

## 扩展术语表 (Extending the Term List)

如果您发现缺少某些术语对照，请将其添加到：
`literature-search/SKILL.md` 的术语对照部分

If you find missing term pairs, add them to the term pairs section in:
`literature-search/SKILL.md`

---

## 示例工作流 (Example Workflow)

```bash
# 用户问题 (User Question)
"什么是哈密顿算符？"

# Agent执行 (Agent Executes)
1. grep "哈密顿" .opencode/literature/        # 中文
2. grep "Hamilton" .opencode/literature/       # 英文
3. grep "Hamiltonian" .opencode/literature/    # 英文变体
4. glob "**/*哈密顿*.md"                       # 中文文件
5. glob "**/*hamilton*.md"                     # 英文文件
6. read [找到的文件]                           # 深度阅读

# 返回结果 (Return Result)
哈密顿算符（Hamiltonian operator）是...

**来源 (Sources)**:
- `.opencode/literature/physics/quantum_mechanics_zh.md:42` - "哈密顿算符定义..."
- `.opencode/literature/physics/quantum_mechanics_en.md:38` - "The Hamiltonian operator..."
```

---

## 总结 (Summary)

✅ **自动双语搜索** - 无需手动翻译
✅ **完整覆盖** - 不会遗漏任何语言的文献
✅ **智能匹配** - 支持同义词和变体
✅ **并行执行** - 高效快速
✅ **准确引用** - 提供精确的文件路径和行号

✅ **Automatic bilingual search** - No manual translation needed
✅ **Complete coverage** - Won't miss documents in any language
✅ **Smart matching** - Supports synonyms and variants
✅ **Parallel execution** - Efficient and fast
✅ **Accurate citations** - Provides exact file paths and line numbers
