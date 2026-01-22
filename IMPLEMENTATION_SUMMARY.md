# STEM Research Agent 幻觉防护实施总结

## 实施时间
2025-01-22

## 实施目标

在原有基础上强化"验证循环的强制执行"，确保：
1. Agent **必须**使用搜索工具（不能依赖记忆）
2. Agent **必须**显示工具输出（可验证性）
3. Agent **必须**引用确切文本（零幻觉）
4. Agent **必须**搜索中英文双语（完整覆盖）

---

## 修改的文件清单

### 1. `.opencode/skill/stem-research/SKILL.md`

**新增内容：强制执行协议 (MANDATORY Execution Protocol)**

**关键改进：**
- ✅ 明确要求"必须使用工具并显示输出"
- ✅ 提供具体的响应模板（5步流程）
- ✅ 对比"禁止的"vs"要求的"响应风格
- ✅ 添加"自我检查点"（Self-Checkpoint）
- ✅ 强化"不知道"模板（显示所有搜索尝试）

**示例：**
```
##### Step 1: Execute Grep Tool (MANDATORY)
You MUST use the Grep tool and SHOW its results

##### Step 2: Execute Glob Tool (MANDATORY)
##### Step 3: Execute Read Tool (MANDATORY)
##### Step 4: Cross-Verification (MANDATORY)
##### Step 5: Formulate Answer (ONLY after Steps 1-4)
```

**为什么重要：**
- DeepSeek有幻觉倾向，可能"假装"搜索
- 强制要求显示工具输出使过程可验证
- 用户可以看到agent确实执行了搜索

---

### 2. `.opencode/skill/literature-search/SKILL.md`

**新增内容：数学公式和符号搜索协议**

**关键改进：**
- ✅ 4层搜索策略（LaTeX → 英文 → 中文 → 相关概念）
- ✅ 常见符号映射表（∇, ∂, ∫, λ, ψ等）
- ✅ 方程搜索策略（按名称、按术语、按相关概念）
- ✅ 完整的搜索示例（薛定谔方程）
- ✅ 算法搜索模式（按名称、复杂度、数据结构）

**示例：**
```
#### Symbol Search Protocol
Level 1: LaTeX Command Search - grep "\\\\nabla"
Level 2: Plain English Description - grep "del operator"
Level 3: Chinese Description - grep "微分算子"
Level 4: Contextual Terms - grep "gradient", "curl"
```

**为什么重要：**
- 数学内容可能以多种形式表示
- 仅搜索LaTeX会遗漏描述性文本
- 4层搜索确保完整覆盖

---

### 3. `.opencode/literature/TESTING.md` （新建）

**内容：完整的测试指南**

**包含：**
- ✅ 6个核心测试用例
  - Test 1: 基础事实检索
  - Test 2: 跨语言检索
  - Test 3: 未知问题（必须说不知道）
  - Test 4: 公式推导
  - Test 5: 数学符号搜索
  - Test 6: 多源交叉验证
- ✅ 每个测试的期望行为和错误示例
- ✅ 常见失败模式及解决方案
- ✅ 性能基准（准确率100%，时间预期）

**示例测试：**
```
### Test 3: 未知问题
**输入:** "什么是超弦理论的M理论层面？"
**期望:**
- ✅ 执行多个搜索
- ✅ 显示所有搜索结果（即使为空）
- ❌ 绝不编造答案
```

**为什么重要：**
- 提供客观的验证标准
- 可以反复测试确保功能正常
- 帮助发现regression

---

### 4. `.opencode/AGENTS.md`

**重写：完整的用户使用指南**

**内容：**
- ✅ 快速开始（3步）
- ✅ 核心特性说明（幻觉零容忍、跨语言、强制执行）
- ✅ 3个详细的使用示例
- ✅ 最佳实践（文献准备、提问技巧、验证答案）
- ✅ FAQ（5个常见问题）
- ✅ 配置DeepSeek指南
- ✅ 技术架构说明

**为什么重要：**
- 用户理解agent的工作原理
- 知道如何正确使用
- 明白为什么会看到很多工具输出

---

## 核心改进原理

### 问题：DeepSeek幻觉

DeepSeek模型可能：
- 依赖训练数据而非实际文献
- "假装"执行搜索（说"我搜索了"但实际没有）
- 编造文献引用（幻觉）

### 解决方案：强制执行协议

通过prompt engineering让LLM：
1. **必须调用工具**：在prompt中明确要求使用Grep/Glob/Read
2. **必须显示输出**：要求展示工具的actual output
3. **提供明确模板**：给出具体的响应格式
4. **自我验证**：在回答前完成检查清单

### 为什么不是代码层面的强制？

- ❌ 需要修改OpenCode核心（违反"不影响原功能"）
- ❌ 增加系统复杂度
- ✅ Prompt engineering足够有效
- ✅ 模块化，易于调整
- ✅ 保持OpenCode兼容性

---

## 验证方法

### 快速验证（5分钟）

1. 启动OpenCode：`bun dev`
2. 切换到STEM Research agent（按Tab）
3. 测试3个问题：

```bash
# Test 1: 简单概念
"什么是特征值？"
# 期望：看到grep输出，引用linear_algebra_zh.md:20

# Test 2: 跨语言
"What is the Lagrangian?"
# 期望：搜索Lagrangian和拉格朗日量，引用quantum_mechanics

# Test 3: 未知问题
"什么是M理论？"
# 期望：明确说"无法找到"，显示所有失败的搜索
```

### 完整验证

参考 `.opencode/literature/TESTING.md` 运行全部6个测试用例。

---

## 关键设计决策

### 1. 为什么显示所有工具输出？

**决定**：要求agent显示完整的grep/glob/read输出

**理由**：
- ✅ 用户可以验证过程
- ✅ 防止agent"假装"搜索
- ✅ 提供audit trail
- ❌ 响应变长（可接受）

### 2. 为什么必须双语搜索？

**决定**：强制要求搜索中英文两种语言

**理由**：
- ✅ 文献可能包含中英文混合
- ✅ 同一概念在不同语言中有不同表述
- ✅ 确保不遗漏任何文献
- ❌ 搜索时间稍长（可接受，并行执行）

### 3. 为什么宁可说"不知道"？

**决定**：找不到文献时明确说明，绝不猜测

**理由**：
- ✅ 科研场景要求零容忍
- ✅ 幻觉比"不知道"更危险
- ✅ 用户可以上传更多文献
- ✅ 建立信任（诚实比聪明重要）

### 4. 为什么用skill而不是修改核心？

**决定**：通过SKILL.md文件实现功能

**理由**：
- ✅ 模块化设计
- ✅ 易于调整和优化
- ✅ 不影响OpenCode原有功能
- ✅ 可随时启用/停用
- ✅ 符合你"作为mod额外内容"的要求

---

## 使用流程

### 用户侧

1. 上传文献到 `.opencode/literature/`
2. 切换到STEM Research agent
3. 提问（中英文均可）
4. 查看响应（包含完整搜索过程）
5. 验证引用（检查文件路径和行号）

### Agent侧（强制执行）

1. **必须**使用Grep搜索中文术语
2. **必须**使用Grep搜索英文术语
3. **必须**使用Glob查找文件
4. **必须**使用Read读取文件
5. **必须**显示上述所有输出
6. **必须**引用确切的行号
7. **必须**验证文献一致性
8. **只有以上都完成**才给出答案

---

## 当前状态

### ✅ 已完成

1. **强制执行协议**：stem-research/SKILL.md
2. **公式符号搜索**：literature-search/SKILL.md
3. **测试指南**：TESTING.md
4. **使用文档**：AGENTS.md
5. **跨语言检索**：CROSS_LANGUAGE_SEARCH.md
6. **文献管理**：literature/README.md
7. **深度思考API**：REASONING_API.md

### ⚠️ 待验证

- 实际测试agent是否遵循协议
- 观察是否有其他失败模式
- 根据测试结果调整prompt

### 🔮 未来可能优化

1. **渐进式检索**：按成本递增的搜索策略（grep → glob → read → reasoning）
2. **文献质量分级**：在文献头部添加元数据（type, level, reliability）
3. **推理与文献结合**：创建新skill将深度思考API与文献检索结合
4. **自动翻译**：使用MCP server自动翻译术语（目前依赖静态对照表）

---

## 成功标准

### 必须满足（零妥协）

- [ ] 搜索准确率100%（Test 1, 2, 4, 5, 6）
- [ ] 未知问题拒绝率100%（Test 3）
- [ ] 所有响应包含工具输出
- [ ] 所有引用包含精确行号
- [ ] 所有搜索包含中英文双语

### 性能指标

- 简单查询 < 5秒
- 复杂推导 < 30秒
- 未知问题 < 10秒

### 用户体验

- 过程透明（可见搜索步骤）
- 结果可信（可验证引用）
- 响应诚实（不知道就说不知道）

---

## 后续建议

### 立即行动

1. **运行测试**：使用TESTING.md中的6个测试用例
2. **观察行为**：记录agent的实际响应
3. **识别问题**：找出与期望的差距
4. **调整prompt**：根据问题修改SKILL.md

### 短期优化（1周内）

1. 如果发现新的失败模式，添加到TESTING.md
2. 如果某些类型的搜索经常失败，优化literature-search/SKILL.md
3. 收集用户反馈，更新AGENTS.md的FAQ

### 中期优化（1月内）

1. 实现渐进式检索策略
2. 添加文献质量元数据
3. 考虑集成自动翻译MCP服务

### 长期愿景

1. 支持更多语言（日语、德语、法语等）
2. 支持图像文献（图表、公式图片OCR）
3. 支持文献自动分类
4. 支持引用关系图谱

---

## 文件修改总览

| 文件 | 状态 | 修改类型 | 行数变化 |
|------|------|---------|---------|
| `.opencode/skill/stem-research/SKILL.md` | ✅ 已修改 | 新增强制执行协议 | +120行 |
| `.opencode/skill/literature-search/SKILL.md` | ✅ 已修改 | 新增公式搜索协议 | +160行 |
| `.opencode/literature/TESTING.md` | ✅ 新建 | 测试指南 | +400行 |
| `.opencode/AGENTS.md` | ✅ 重写 | 用户指南 | +380行 |

**总计**：4个文件，约1060行新增/修改内容

---

## 技术亮点

### 1. Prompt Engineering而非代码修改

通过精心设计的prompt实现强制执行，无需修改OpenCode核心代码。

### 2. 模块化设计

每个skill独立，易于启用/停用/调整。

### 3. 可验证性

所有搜索过程可见，用户可以审计agent的行为。

### 4. 跨语言支持

中英文双语自动检索，未来可扩展到更多语言。

### 5. 零容忍策略

科研场景的特殊要求，宁可不知道也不瞎猜。

---

## 总结

本次实施聚焦于**"验证循环的强制执行"**，通过prompt engineering确保：

1. **必须用工具**：不能依赖记忆
2. **必须显示过程**：可验证性
3. **必须双语搜索**：完整覆盖
4. **必须引用确切文本**：零幻觉

这些改进不需要修改OpenCode核心代码，完全通过skill系统实现，保持了模块化和可扩展性。

现在可以进行实际测试，验证agent是否遵循这些协议。根据测试结果，可以进一步优化prompt。

---

**实施者**: Claude (Sonnet 4.5)
**日期**: 2025-01-22
**版本**: v1.0
**状态**: Ready for testing
