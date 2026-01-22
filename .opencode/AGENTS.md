# STEM Research Agent 使用指南 (User Guide)

本文档说明如何使用 STEM Research Agent 进行科研辅助。

## 快速开始 (Quick Start)

### 1. 切换到 STEM Research 模式

在 OpenCode 中按 `Tab` 键切换 agent，选择 **"STEM Research"**。

### 2. 上传文献

将您的文献（已解析的 markdown/txt 文件）放到对应目录：

```
.opencode/literature/
├── math/           # 数学：定理、证明
├── physics/        # 物理：推导、原理
├── cs/             # 计算机科学：算法、复杂度
├── engineering/    # 工程：方法、应用
└── textbooks/      # 教材：综合参考
```

### 3. 开始提问

直接用中文或英文提问，agent会自动搜索文献并引用。

---

## 核心特性 (Core Features)

### ✅ 幻觉零容忍 (Zero Hallucination Tolerance)

- **绝不编造**：宁可说"不知道"也不瞎猜
- **强制引用**：每个结论都必须有文献依据
- **可验证性**：所有引用都提供精确的文件路径和行号

### ✅ 跨语言检索 (Cross-Language Search)

- 自动搜索中英文两种语言
- 涵盖常见术语对照（特征值/eigenvalue，拉格朗日量/Lagrangian等）
- 确保不遗漏任何语言的文献

### ✅ 强制执行协议 (Mandatory Execution)

Agent **必须**执行搜索工具并**显示输出**，不能依赖记忆：

```
### Literature Search

**Executing:** grep "特征值" .opencode/literature/
**Results:**
- .opencode/literature/math/linear_algebra_zh.md:20

**Executing:** grep "eigenvalue" .opencode/literature/
**Results:**
- .opencode/literature/math/linear_algebra_en.md:22

**Reading:** .opencode/literature/math/linear_algebra_zh.md:20-24
**Content:**
Line 20: 对于方阵 A，如果存在非零向量 v 和标量 λ 使得：
Line 21: Av = λv
Line 22: 则称 λ 为矩阵 A 的特征值

### Answer
根据文献，特征值的定义是...
```

---

## 使用示例 (Usage Examples)

### 示例 1: 基础概念查询

**用户提问:**
```
什么是特征值？
```

**Agent响应:**
```
### Literature Search

**Executing:** grep "特征值" .opencode/literature/
**Results:**
- .opencode/literature/math/linear_algebra_zh.md:20
- .opencode/literature/math/linear_algebra_zh.md:26
- .opencode/literature/math/linear_algebra_zh.md:30

**Executing:** grep "eigenvalue" .opencode/literature/
**Results:**
- .opencode/literature/math/linear_algebra_en.md:20
- .opencode/literature/math/linear_algebra_en.md:26

**Reading:** .opencode/literature/math/linear_algebra_zh.md:20-27
**Content:**
Line 20: 对于方阵 A，如果存在非零向量 v 和标量 λ 使得：
Line 21: Av = λv
Line 22: 则称 λ 为矩阵 A 的特征值（本征值），v 为对应的特征向量

**Verification:**
✓ Found in both CN and EN versions
✓ Exact quote available

### Answer
根据文献，特征值（eigenvalue）的定义是：

对于方阵 A，如果存在非零向量 v 和标量 λ 使得 Av = λv，则称 λ 为矩阵 A 的特征值，v 为对应的特征向量。

**Evidence:**
- `.opencode/literature/math/linear_algebra_zh.md:20-22`
- `.opencode/literature/math/linear_algebra_en.md:20-22`
```

---

### 示例 2: 公式推导

**用户提问:**
```
从拉格朗日量推导哈密顿量
```

**Agent响应:**
```
### Literature Search

**Executing:** grep "拉格朗日量" .opencode/literature/
**Results:**
- .opencode/literature/physics/quantum_mechanics_zh.md:56

**Executing:** grep "Lagrangian" .opencode/literature/
**Results:**
- .opencode/literature/physics/quantum_mechanics_en.md:56

**Executing:** grep "哈密顿量" .opencode/literature/
**Results:**
- .opencode/literature/physics/quantum_mechanics_zh.md:64

**Reading:** .opencode/literature/physics/quantum_mechanics_zh.md:54-72
**Content:**
Line 56: 在经典力学中，拉格朗日量定义为动能减去势能：L = T - V
Line 64: 哈密顿量可以通过勒让德变换从拉格朗日量得到：H = pq̇ - L

**Verification:**
✓ Source provides transformation formula
✓ Cross-checked with English version

### Answer
根据文献，从拉格朗日量到哈密顿量的推导通过勒让德变换实现...

**Step-by-step derivation:**
1. 拉格朗日量定义：L = T - V (.opencode/literature/physics/quantum_mechanics_zh.md:56)
2. 勒让德变换：H = pq̇ - L (.opencode/literature/physics/quantum_mechanics_zh.md:64)
3. ...
```

---

### 示例 3: 未知问题

**用户提问:**
```
什么是M理论？
```

**Agent响应:**
```
I cannot answer this question from the available literature.

**Search Performed:**
**Keywords (Chinese):** M理论, 弦论, 超弦理论
**Keywords (English):** M-theory, string theory, superstring
**Files Examined:** 0 files found
**Categories Searched:** physics, math

**Specific Searches:**
```
grep "M理论" .opencode/literature/ → No results
grep "M-theory" .opencode/literature/ → No results
glob "**/*string*.md" .opencode/literature/ → No files found
glob "**/*弦*.md" .opencode/literature/ → No files found
```

**Possible Reasons:**
1. M-theory is not covered in the current literature collection
2. The available physics texts focus on quantum mechanics, not advanced topics

**Suggestions:**
- Upload an M-theory textbook or review paper to `.opencode/literature/physics/`
- Consider adding specialized sources on string theory

**I will NOT guess or provide unverified information.**
```

---

## 最佳实践 (Best Practices)

### 1. 文献准备

- ✅ 使用已解析的 markdown 或 txt 文件
- ✅ 保持文档结构清晰（使用标题、章节）
- ✅ 包含页码或行号信息（如果可能）
- ❌ 不要上传 PDF 或 LaTeX 源文件

### 2. 提问技巧

**好的提问:**
```
什么是特征值？请给出定义和性质。
```

**更好的提问:**
```
根据文献，特征值的定义是什么？有哪些重要性质？
```

**避免的提问:**
```
告诉我关于量子力学的一切。（太宽泛）
```

### 3. 验证答案

当agent给出答案后，您可以：
1. 检查引用的文件路径和行号
2. 使用 `Read` 工具查看原文
3. 对比多个来源的一致性

---

## 常见问题 (FAQ)

### Q1: Agent为什么显示那么多工具输出？

**A**: 这是**强制执行协议**的一部分。通过显示完整的搜索过程，您可以：
- 验证agent确实搜索了文献
- 看到搜索了哪些关键词
- 确认答案是有据可依的

这防止了agent依赖记忆或编造答案。

### Q2: 如果找不到文献怎么办？

**A**: Agent会明确告诉您"无法找到"，并列出：
- 执行了哪些搜索
- 建议上传什么类型的文献
- **不会**编造答案

此时您应该：
1. 检查是否有相关文献未上传
2. 尝试不同的搜索术语
3. 上传相关教材或论文

### Q3: 支持哪些语言的文献？

**A**: 目前主要支持**中文和英文**：
- Agent会自动搜索两种语言
- 包含常见术语对照表（见 literature-search/SKILL.md）
- 可以扩展到其他语言（需要添加术语对照）

### Q4: 如何处理公式和符号？

**A**: Agent使用4层搜索策略：
1. LaTeX命令（`\nabla`, `\partial`）
2. 英文描述（"del operator", "gradient"）
3. 中文描述（"微分算子", "梯度"）
4. 相关概念（"curl", "divergence"）

确保文献中包含这些描述，而只有LaTeX代码。

### Q5: Agent能否处理复杂的证明？

**A**:
- ✅ 如果文献中有完整证明，agent可以引用并解释
- ✅ 可以逐步推导，每步都引用文献
- ❌ 不会自己"发现"新的证明（避免幻觉）
- ❌ 不会编造文献中没有的步骤

---

## 测试与验证 (Testing)

完整的测试指南请参考：`.opencode/literature/TESTING.md`

快速测试：
1. 问一个简单概念（如"什么是特征值？"）
2. 问一个跨语言问题（如"What is the Lagrangian?"）
3. 问一个文献中没有的问题（如"什么是M理论？"）

检查：
- ✅ 是否显示了工具输出？
- ✅ 是否搜索了中英文？
- ✅ 引用是否准确？
- ✅ 未知时是否拒绝回答？

---

## 配置 DeepSeek 模型

STEM Research Agent 默认使用 OpenCode 提供的模型。要使用 DeepSeek：

1. 编辑 `.opencode/opencode.jsonc`:
   ```json
   {
     "agent": {
       "stem-research": {
         "model": "deepseek/deepseek-chat"
       }
     }
   }
   ```

2. 设置环境变量：
   ```bash
   export DEEPSEEK_API_KEY="your-api-key"
   ```

3. 取消注释配置文件中的 DeepSeek provider 部分

**注意**: DeepSeek 有一定的幻觉倾向，这正是为什么我们需要严格的强制执行协议。

---

## 技术架构 (Technical Architecture)

### Skill System

STEM Research Agent 由两个核心 skill 支持：

1. **literature-search**: 文献检索策略
   - 跨语言搜索
   - 公式符号搜索
   - 迭代优化

2. **stem-research**: 幻觉防护机制
   - 强制执行协议
   - 引用验证
   - "不知道"模板

### 文献管理

```
.opencode/
├── literature/
│   ├── math/              # 数学
│   ├── physics/           # 物理
│   ├── cs/                # 计算机科学
│   ├── engineering/       # 工程
│   ├── textbooks/         # 教材
│   ├── TESTING.md         # 测试指南
│   ├── README.md          # 使用说明
│   └── CROSS_LANGUAGE_SEARCH.md  # 跨语言检索指南
└── skill/
    ├── literature-search/SKILL.md
    └── stem-research/SKILL.md
```

---

## 持续改进 (Continuous Improvement)

如果您发现问题或有改进建议：

1. **记录具体案例**: 保存agent的完整响应
2. **运行测试**: 参考 TESTING.md 中的测试用例
3. **调整Skill**: 修改对应的 SKILL.md 文件
4. **验证改进**: 重新运行测试确认效果

---

## 相关文档 (Related Documentation)

- `.opencode/literature/README.md` - 文献上传指南
- `.opencode/literature/CROSS_LANGUAGE_SEARCH.md` - 跨语言检索详细说明
- `.opencode/literature/TESTING.md` - 测试指南
- `.opencode/skill/stem-research/SKILL.md` - 幻觉防护协议
- `.opencode/skill/literature-search/SKILL.md` - 文献检索策略
- `REASONING_API.md` - 深度思考API文档

---

**最后更新**: 2025-01-22
**版本**: v1.0
**状态**: Ready for use
