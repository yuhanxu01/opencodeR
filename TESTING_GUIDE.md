# 如何测试 STEM Research Agent

完整测试指南 - 2025-01-22

---

## 准备工作（5分钟）

### 步骤 1: 检查文献文件

确认你已经上传了示例文献：

```bash
ls -la .opencode/literature/
```

**期望看到**：
- ✅ math/linear_algebra_zh.md
- ✅ math/linear_algebra_en.md
- ✅ physics/quantum_mechanics_zh.md
- ✅ physics/quantum_mechanics_en.md
- ✅ README.md
- ✅ TESTING.md
- ✅ CROSS_LANGUAGE_SEARCH.md

如果没有这些文件，先上传测试文献。

---

### 步骤 2: （可选）配置 DeepSeek

如果你想使用 DeepSeek 模型：

```bash
# 设置环境变量
export DEEPSEEK_API_KEY="your-actual-api-key-here"

# 或者添加到 ~/.zshrc 或 ~/.bashrc
echo 'export DEEPSEEK_API_KEY="your-actual-api-key-here"' >> ~/.zshrc
source ~/.zshrc
```

然后编辑 `.opencode/opencode.jsonc`：

1. 取消注释 DeepSeek provider（第12-18行）
2. 取消注释 stem-research 的 model 配置（第38行）

**注意**：如果不配置，会使用 OpenCode 默认模型，同样可以测试。

---

### 步骤 3: 验证 Skill 文件

确认skill文件存在：

```bash
ls -la .opencode/skill/stem-research/SKILL.md
ls -la .opencode/skill/literature-search/SKILL.md
ls -la .opencode/skill/literature-organizer/SKILL.md
```

**期望看到**：三个文件都存在，且包含我们刚才添加的内容。

---

### 步骤 3.5: 测试文献自动整理功能（新功能）🆕

这是新增的自动整理功能测试。

#### 3.5.1 检查测试文件

```bash
ls -la files/
```

**期望看到**：
- ✅ calculus_basics.md（微积分基础）
- ✅ thermodynamics.md（热力学）
- ✅ machine_learning_intro.md（机器学习导论）
- ✅ README.md

如果没有这些文件，说明已经被整理过了。可以复制测试文件：

```bash
# 从已整理的文献中复制回来用于测试
cp .opencode/literature/math/calculus_basics.md files/ 2>/dev/null || echo "文件不存在"
cp .opencode/literature/physics/thermodynamics.md files/ 2>/dev/null || echo "文件不存在"
cp .opencode/literature/cs/machine_learning_intro.md files/ 2>/dev/null || echo "文件不存在"
```

#### 3.5.2 测试文献整理

在 OpenCode 中：

1. 按 **Tab** 键
2. 选择 **"Literature Organizer"** agent
3. 输入：`整理文献` 或 `organize literature`

**✅ 期望行为**：

1. **扫描上传文件夹**
   ```
   Found 3 files:
   - calculus_basics.md
   - thermodynamics.md
   - machine_learning_intro.md
   ```

2. **分析文件内容**
   - calculus_basics.md：识别为 **math**（关键词：导数, 积分, 极限）
   - thermodynamics.md：识别为 **physics**（关键词：energy, entropy, temperature）
   - machine_learning_intro.md：识别为 **cs**（关键词：algorithm, machine learning）

3. **显示 bash 命令**
   ```
   Executing: mv files/calculus_basics.md .opencode/literature/math/
   ✓ Moved successfully
   ```

4. **生成整理报告**
   ```
   ## Literature Organization Report
   **Files Organized:** 3 files
   - Math: 1 files
   - Physics: 1 files
   - CS: 1 files
   ```

**❌ 失败标志**：
- 没有显示文件分析过程
- 分类错误（例如微积分被分到 physics）
- 没有执行 mv 命令
- 文件没有移动到正确位置

**验证结果**：

```bash
# 检查上传文件夹应该为空
ls files/
# 应该只有 README.md

# 检查文件是否移动到正确位置
ls .opencode/literature/math/calculus_basics.md
ls .opencode/literature/physics/thermodynamics.md
ls .opencode/literature/cs/machine_learning_intro.md
```

**记录结果**：
```
[ ] 通过 - 文件正确分类和移动
[ ] 失败 - （具体问题：_____________）
```

---

## 启动测试（2分钟）

### 步骤 4: 启动 OpenCode

```bash
cd /Users/renqing/Downloads/opencode-research
bun dev
```

**等待**：看到终端界面出现，显示 "OpenCode" logo。

---

### 步骤 5: 切换到 STEM Research Agent

在 OpenCode 界面中：

1. 按 **`Tab`** 键
2. 在 agent 列表中找到 **"STEM Research"**
3. 用方向键选择，按 **Enter** 确认

**验证**：界面应该显示当前 agent 是 "STEM Research"。

---

## 运行测试用例（15分钟）

### 测试 1: 基础事实检索

**输入**：
```
什么是特征值？
```

**✅ 期望行为**：
- 显示 `grep "特征值"` 的执行和结果
- 显示 `grep "eigenvalue"` 的执行和结果
- 读取文件并显示具体行号
- 引用 `.opencode/literature/math/linear_algebra_zh.md:20-22`

**❌ 失败标志**：
- 没有显示 grep 输出
- 直接给出答案而不用工具
- 引用的行号不正确

**记录结果**：
```
[ ] 通过 - 显示了完整搜索过程
[ ] 失败 - （具体问题：_____________）
```

---

### 测试 2: 跨语言检索

**输入**：
```
What is the Lagrangian?
```

**✅ 期望行为**：
- 搜索 "Lagrangian", "Lagrange"
- 搜索 "拉格朗日量", "拉格朗日"
- 引用 `.opencode/literature/physics/quantum_mechanics_zh.md:56-60`
- 提供中英文双语引用（如果都有）

**❌ 失败标志**：
- 只搜索英文不搜索中文（或反之）
- 没有显示多个搜索尝试

**记录结果**：
```
[ ] 通过 - 双语搜索
[ ] 失败 - （具体问题：_____________）
```

---

### 测试 3: 未知问题（关键测试）

**输入**：
```
什么是超弦理论的M理论层面？
```

**✅ 期望行为**：
- 执行多个搜索（都失败）
- **明确说** "I cannot answer this question from the available literature"
- 显示所有失败的搜索尝试：
  ```
  grep "超弦理论" → No results
  grep "string theory" → No results
  glob "**/*string*.md" → No files found
  ```
- **绝不**编造答案或给出模糊的"一般性介绍"

**❌ 失败标志**：
- 给出了一个答案（即使是正确的）
- 没有显示搜索过程
- 说"可能是"或"一般来说"

**记录结果**：
```
[ ] 通过 - 明确说不知道
[ ] 失败 - （具体问题：_____________）
```

**这是最重要的测试！** 如果这一项失败，说明幻觉防护不够强。

---

### 测试 4: 公式推导

**输入**：
```
从薛定谔方程推导能量本征值问题
```

**✅ 期望行为**：
- 搜索 "薛定谔方程", "Schrodinger equation"
- 搜索 "本征值", "eigenvalue"
- 读取 `quantum_mechanics_zh.md` 相关章节
- **逐步推导**，每步都引用文献
- 不跳过中间步骤

**❌ 失败标志**：
- 直接给出最终结果
- 推导步骤没有文献依据
- 跳过验证直接回答

**记录结果**：
```
[ ] 通过 - 逐步推导并有引用
[ ] 失败 - （具体问题：_____________）
```

---

### 测试 5: 数学符号搜索

**输入**：
```
查找包含哈密顿算符的文献
```

**✅ 期望行为**：
- 搜索多个变体：
  - LaTeX: `\\hat{H}`, `H`
  - 英文: "Hamiltonian operator", "Hamiltonian"
  - 中文: "哈密顿算符", "哈密顿量"
- 找到 `quantum_mechanics_zh.md:22-28`
- 显示所有搜索尝试

**❌ 失败标志**：
- 只搜索一个关键词
- 找不到或找到不完整

**记录结果**：
```
[ ] 通过 - 多层搜索
[ ] 失败 - （具体问题：_____________）
```

---

### 测试 6: 交叉验证

**输入**：
```
特征值和本征值是同一个概念吗？
```

**✅ 期望行为**：
- 搜索 "特征值" 和 "本征值"
- 验证两个词在文献中的含义
- 明确说明："根据文献，这两个词指的是同一概念"
- 如果文献不一致，明确指出差异

**❌ 失败标志**：
- 随意选择其中一个
- 没有验证文献

**记录结果**：
```
[ ] 通过 - 交叉验证
[ ] 失败 - （具体问题：_____________）
```

---

### 测试 7: 新整理文献检索（自动整理功能验证）🆕

**前提条件**：需要先完成"步骤 3.5"的文献自动整理测试

**输入**：
```
什么是微积分基本定理？
```

**✅ 期望行为**：
- 搜索 "微积分基本定理", "fundamental theorem of calculus"
- 找到刚才自动整理的 `calculus_basics.md`
- 引用 `.opencode/literature/math/calculus_basics.md:[行号]`
- 引用正确内容

**输入 2**：
```
What is the second law of thermodynamics?
```

**✅ 期望行为**：
- 搜索 "热力学第二定律", "second law of thermodynamics"
- 找到 `thermodynamics.md`
- 引用 `.opencode/literature/physics/thermodynamics.md:[行号]`

**输入 3**：
```
机器学习中的过拟合问题如何解决？
```

**✅ 期望行为**：
- 搜索 "过拟合", "overfitting"
- 找到 `machine_learning_intro.md`
- 引用 `.opencode/literature/cs/machine_learning_intro.md:[行号]`
- 提供文献中的解决方案

**❌ 失败标志**：
- 找不到刚才整理的文献
- 说"无法找到相关文献"
- 引用的文件路径不正确

**记录结果**：
```
[ ] 通过 - 新整理的文献可以被正确检索
[ ] 失败 - （具体问题：_____________）
```

**这个测试验证了自动整理功能是否正常工作！**

---

## 判定标准

### ✅ 测试通过的条件

**必需满足**（零妥协）：
1. ✅ 所有响应都显示工具输出（grep/glob/read）
2. ✅ 所有搜索都包含中英文双语
3. ✅ 所有引用都包含精确的文件路径和行号
4. ✅ 未知问题**必须**明确说"不知道"（绝不编造）
5. ✅ 没有"假装搜索"的行为（必须显示actual output）

### ⚠️ 部分通过

- 某些测试通过，某些失败
- 记录具体哪些失败，为什么失败

### ❌ 测试失败

- 3个或以上测试失败
- 或者测试3（未知问题）失败

---

## 常见问题诊断

### 问题 1: Agent 不显示工具输出

**症状**：直接给出答案，没有 grep/glob/read 的输出

**可能原因**：
- Skill 文件没有正确加载
- Prompt 不够强制

**解决方案**：
1. 检查 `.opencode/skill/stem-research/SKILL.md` 是否包含 "MANDATORY Execution Protocol" 部分
2. 重启 OpenCode (`bun dev`)
3. 重新选择 STEM Research agent

---

### 问题 2: 只搜索单语

**症状**：只搜索中文或只搜索英文

**可能原因**：
- literature-search skill 没有被调用
- 跨语言协议没有被强调

**解决方案**：
1. 在提问时明确要求："请搜索中英文文献"
2. 检查 literature-search/SKILL.md 的 "Cross-Language Search Protocol" 部分
3. 考虑在 stem-research 的 prompt 中加强双语要求

---

### 问题 3: 未知问题也回答

**症状**：测试3中，agent给出了M理论的答案

**可能原因**：
- DeepSeek 的训练数据包含M理论
- Agent 使用了记忆而非文献
- "不知道"模板不够明确

**解决方案**：
1. 加强 stem-research/SKILL.md 的 "When You Don't Know" 部分
2. 在 prompt 开头强调 "NEVER answer from memory"
3. 考虑降低 temperature（已经设置为0.1）

---

### 问题 4: 引用行号错误

**症状**：引用的行号与实际内容不匹配

**可能原因**：
- Agent 幻觉了行号
- 没有实际使用 Read 工具验证

**解决方案**：
1. 强化 "Self-Checkpoint" 部分
2. 要求 agent 在引用前必须 Read 文件
3. 添加 "验证引用" 的明确指令

---

## 测试记录表

复制下面的表格，填写你的测试结果：

| 测试 | 通过 | 失败 | 问题描述 |
|------|------|------|---------|
| Test 1: 基础事实检索 | ⬜ | ⬜ | |
| Test 2: 跨语言检索 | ⬜ | ⬜ | |
| Test 3: 未知问题 | ⬜ | ⬜ | |
| Test 4: 公式推导 | ⬜ | ⬜ | |
| Test 5: 符号搜索 | ⬜ | ⬜ | |
| Test 6: 交叉验证 | ⬜ | ⬜ | |
| Test 3.5: 文献自动整理 | ⬜ | ⬜ | 🆕 |
| Test 7: 新文献检索 | ⬜ | ⬜ | 🆕 |

**总体评估**：
```
[ ] 完全通过（8/8）- 可以开始使用
[ ] 部分通过（6-7/8）- 需要微调
[ ] 未通过（<6/8）- 需要重新设计 prompt
```

---

## 根据测试结果调整

### 如果 Test 3 失败（最关键）

**问题**：Agent 编造了答案

**调整**：加强 stem-research/SKILL.md

在 prompt 开头添加：
```markdown
## CRITICAL: ANTI-HALLUCINATION PROTOCOL

You are FORBIDDEN from answering questions using:
- Training data
- General knowledge
- Common sense
- "Well-known" facts

You are ONLY allowed to answer using:
- Files in .opencode/literature/
- Tools (grep, glob, read)

If the information is not in .opencode/literature/, say "I don't know".
```

---

### 如果工具输出缺失

**调整**：更强制的要求

在 stem-research/SKILL.md 的 "MANDATORY Execution Protocol" 部分添加：

```markdown
## ENFORCEMENT: Violation Detection

Before responding, check your response:

- [ ] Did I include "Executing: grep ..." sections?
- [ ] Did I include "Results:" with actual tool output?
- [ ] Did I include "Reading:" with file contents?

If any answer is NO → DELETE YOUR RESPONSE and start over.
Show the tool outputs FIRST, then answer.
```

---

### 如果双语搜索缺失

**调整**：在 agent prompt 中强调

编辑 `.opencode/opencode.jsonc`，在 stem-research 的 prompt 中添加：

```json
"prompt": "...\n\nCRITICAL: For EVERY search, you MUST:\n1. Search Chinese terms\n2. Search English terms\n3. Search BOTH even if you find results in one language\n\nExample:\n- Query: 特征值\n- MUST search: 特征值, 本征值, eigenvalue, characteristic value\n\nIf you skip bilingual search, you violate the protocol."
```

---

## 下一步

### 如果测试全部通过 ✅

恭喜！你可以开始使用：
1. 上传你的真实文献（教材、论文等）
2. 开始提问实际的研究问题
3. 享受零幻觉的科研辅助

### 如果部分测试失败 ⚠️

1. 记录具体失败模式
2. 参考"常见问题诊断"调整
3. 重新测试
4. 如果问题持续，告诉我具体情况

---

## 需要帮助？

如果测试中遇到问题，请提供：

1. **具体问题**：哪个测试失败了？
2. **Agent 的完整响应**：复制粘贴 agent 的输出
3. **使用的模型**：DeepSeek 还是其他？
4. **错误信息**：如果有报错

我会帮你诊断和修复。

---

**最后更新**: 2025-01-22
**版本**: v1.0
