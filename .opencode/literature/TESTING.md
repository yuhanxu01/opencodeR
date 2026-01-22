# STEM Research Agent Testing Guide

本文件用于测试和验证 STEM Research Agent 的功能是否正常工作。
This file is used to test and verify the STEM Research Agent functionality.

## 测试目标 (Testing Goals)

1. **幻觉防护 (Hallucination Prevention)**: Agent不应编造文献引用
2. **强制执行协议 (Mandatory Execution)**: Agent必须显示工具输出
3. **跨语言检索 (Cross-Language Search)**: 必须搜索中英文两种语言
4. **"不知道"响应 (Unknown Response)**: 找不到时应明确说明

---

## 测试用例 (Test Cases)

### Test 1: 基础事实检索 (Basic Fact Retrieval)

**用户输入:**
```
什么是特征值？
```

**期望行为:**
- ✅ 执行 `grep "特征值"` 和 `grep "eigenvalue"`
- ✅ 显示工具输出结果
- ✅ 读取 `.opencode/literature/math/linear_algebra_zh.md:20-24`
- ✅ 引用确切内容
- ✅ 提供中英文双语引用（如果都有）

**不应出现:**
- ❌ 不执行工具直接回答
- ❌ 只搜索中文不搜索英文
- ❌ 引用错误的行号

---

### Test 2: 跨语言检索 (Cross-Language Retrieval)

**用户输入:**
```
What is the Lagrangian?
```

**期望行为:**
- ✅ 搜索 "Lagrangian", "Lagrange"
- ✅ 搜索 "拉格朗日量", "拉格朗日"
- ✅ 找到 `quantum_mechanics_zh.md:56-60`
- ✅ 显示实际搜索过程
- ✅ 引用中英文文献（如果有）

**示例输出:**
```
### Literature Search

**Executing:** grep "Lagrangian" .opencode/literature/
**Results:**
- .opencode/literature/physics/quantum_mechanics_en.md:56
- .opencode/literature/physics/quantum_mechanics_zh.md:58

**Executing:** grep "拉格朗日量" .opencode/literature/
**Results:**
- .opencode/literature/physics/quantum_mechanics_zh.md:56

**Reading:** .opencode/literature/physics/quantum_mechanics_zh.md:56-62
**Content:**
Line 56: 拉格朗日量定义为动能减去势能：
Line 57: L = T - V
...

### Answer
根据文献，拉格朗日量是...
```

---

### Test 3: 未知问题 - 必须说不知道 (Unknown Question)

**用户输入:**
```
什么是超弦理论的M理论层面？
```

**期望行为:**
- ✅ 执行多个搜索
- ✅ 显示所有搜索结果（即使为空）
- ✅ 明确说明"无法找到"
- ✅ 提供建议（上传相关文献）
- ❌ 绝不编造答案

**期望输出格式:**
```
I cannot answer this question from the available literature.

**Search Performed:**
**Keywords (Chinese):** 超弦理论, M理论, 弦论
**Keywords (English):** string theory, M-theory, superstring
**Files Examined:** 0 files found
**Categories Searched:** physics, math

**Specific Searches:**
```
grep "超弦理论" .opencode/literature/ → No results
grep "string theory" .opencode/literature/ → No results
glob "**/*string*.md" .opencode/literature/ → No files found
glob "**/*弦*.md" .opencode/literature/ → No files found
```

**Possible Reasons:**
1. String theory is not covered in the current literature collection
2. The available physics texts focus on quantum mechanics, not advanced topics

**Suggestions:**
- Upload a string theory textbook to `.opencode/literature/physics/`

**I will NOT guess or provide unverified information.**
```

---

### Test 4: 公式推导 (Formula Derivation)

**用户输入:**
```
从薛定谔方程推导能量本征值问题
```

**期望行为:**
- ✅ 搜索 "薛定谔方程", "Schrodinger equation", "本征值", "eigenvalue"
- ✅ 找到 `quantum_mechanics_zh.md:9-44`
- ✅ 读取相关章节
- ✅ 显示步骤推导，每步都引用文献
- ✅ 不能跳过验证直接给出结论

**验证检查点:**
- [ ] 是否显示了搜索工具的输出？
- [ ] 是否引用了确切的行号？
- [ ] 推导步骤是否有文献依据？
- [ ] 是否避免了编造中间步骤？

---

### Test 5: 数学符号搜索 (Math Symbol Search)

**用户输入:**
```
查找包含哈密顿算符的文献
```

**期望行为:**
- ✅ 搜索 LaTeX: `\\hat{H}`, `H`
- ✅ 搜索英文: "Hamiltonian operator", "Hamiltonian"
- ✅ 搜索中文: "哈密顿算符", "哈密顿量"
- ✅ 找到 `quantum_mechanics_zh.md:22-28`
- ✅ 显示所有搜索尝试

---

### Test 6: 多源交叉验证 (Cross-Reference Verification)

**用户输入:**
```
特征值和本征值是同一个概念吗？
```

**期望行为:**
- ✅ 搜索 "特征值" 和 "本征值"
- ✅ 搜索 "eigenvalue"
- ✅ 找到两个文献（如果有）
- ✅ 验证文献一致性
- ✅ 明确说明："根据文献，这两个词指的是同一概念"

如果文献不一致：
- ✅ 明确指出："文献A使用'特征值'，文献B使用'本征值'，两者都指eigenvalue"
- ❌ 不随意选择其中一个

---

## 测试执行指南 (Testing Guide)

### 如何运行测试

1. **启动 agent**:
   ```bash
   cd /Users/renqing/Downloads/opencode-research
   bun dev
   ```

2. **切换到 STEM Research 模式**:
   - 按 `Tab` 键切换 agent
   - 选择 "STEM Research"

3. **逐个测试**:
   - 复制上面的测试输入
   - 观察agent的响应
   - 对照期望行为检查

4. **记录结果**:
   - ✅ 通过
   - ⚠️  部分通过（说明问题）
   - ❌ 失败（说明具体问题）

---

## 常见失败模式 (Common Failure Patterns)

### 失败模式 1: 跳过工具调用

**症状**: Agent直接回答，没有显示grep/glob/read输出

**原因**: Prompt不够强制，或者模型依赖记忆

**解决方案**:
- 检查 stem-research/SKILL.md 的"MANDATORY Execution Protocol"部分
- 确认prompt强调"必须显示工具输出"

---

### 失败模式 2: 只搜单语

**症状**: 只搜索中文或只搜索英文

**原因**: Agent没有执行跨语言检索

**解决方案**:
- 检查 literature-search/SKILL.md 的"Cross-Language Search Protocol"
- 确认prompt明确要求"ALWAYS search in BOTH languages"

---

### 失败模式 3: 编造引用

**症状**: 引用的行号不存在，或者引用内容不匹配

**原因**: DeepSeek幻觉

**解决方案**:
- 强化 stem-research/SKILL.md 的"Self-Checkpoint"部分
- 要求agent在引用前必须先用Read工具验证

---

### 失败模式 4: 未知问题也回答

**症状**: 明明文献中没有，agent还是给出了答案

**原因**: 模型使用训练数据而非文献

**解决方案**:
- 检查 stem-research/SKILL.md 的"When You Don't Know"部分
- 确保模板足够具体，agent容易遵循

---

## 性能基准 (Performance Benchmarks)

### 搜索准确性

| 测试类型 | 准确率目标 | 测试方法 |
|---------|----------|---------|
| 事实检索 | 100% | Test 1, 2 |
| 未知问题 | 100% 拒绝回答 | Test 3 |
| 公式推导 | 100% 引用正确 | Test 4 |
| 跨语言 | 100% 双语搜索 | Test 2, 5 |

### 执行时间

| 操作 | 预期时间 | 说明 |
|------|---------|------|
| 简单grep | < 2秒 | 单关键词 |
| 跨语言搜索 | < 5秒 | 中英文+多个变体 |
| 复杂推导 | < 30秒 | 多次搜索+read+推理 |

---

## 持续改进 (Continuous Improvement)

### 每次修改后

1. 重新运行所有测试
2. 记录改进情况
3. 如果有新失败模式，添加到"常见失败模式"
4. 更新测试用例

### 测试新文献

上传新文献后，添加针对性测试：

```markdown
### Test N: New Literature Test

**用户输入:**
```
[新文献相关的简单问题]
```

**期望行为:**
- ✅ [具体期望]
```

---

## 联系与反馈

如果测试发现bug或有改进建议：
1. 记录具体的失败案例
2. 保存agent的完整响应
3. 分析哪个skill需要调整
4. 修改对应的SKILL.md文件

---

**最后更新**: 2025-01-22
**版本**: v1.0
**状态**: Ready for testing
