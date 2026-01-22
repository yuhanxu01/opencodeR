# 文献自动整理功能使用指南

## 功能概述

新增了**文献自动整理功能**，让你只需将文献文件放到临时文件夹，系统就会自动识别学科并归类到正确位置。

## 快速开始（3步）

### 步骤 1: 上传文献文件

将你的 markdown 文件复制到临时文件夹：

```bash
cp your-literature-file.md files/
```

**支持多文件**：可以一次放多个文件

### 步骤 2: 启动 OpenCode

```bash
cd /Users/renqing/Downloads/opencode-research
bun dev
```

等待终端界面出现。

### 步骤 3: 切换到文献整理 Agent

1. 按 **Tab** 键
2. 选择 **"Literature Organizer"**
3. 输入：`整理文献` 或 `organize literature`

## 自动分类逻辑

系统会根据文件内容的关键词自动判断学科：

| 学科 | 中英文关键词示例 |
|------|------------------|
| **数学** | theorem, proof, matrix, vector, 定理, 证明, 矩阵, 向量 |
| **物理** | quantum, mechanics, energy, wave, 量子, 力学, 能量, 波 |
| **计算机** | algorithm, complexity, data structure, 算法, 复杂度, 数据结构 |
| **工程** | circuit, control, system, 电路, 控制, 系统 |
| **教材** | introduction, textbook, tutorial, 教材, 导论, 教程 |

## 完整示例

### 场景：添加3个新文献

```bash
# 1. 将文件复制到上传文件夹
cp calculus.md files/
cp thermodynamics.md files/
cp machine_learning.md files/

# 2. 启动 OpenCode
bun dev

# 3. 切换到 Literature Organizer agent（按 Tab）

# 4. 输入命令
整理文献
```

### Agent 会输出类似：

```
## Organizing Literature Files

### Step 1: Scanning upload folder...
Found 3 files:
- calculus_basics.md
- thermodynamics.md
- machine_learning_intro.md

### Step 2: Analyzing files...

**Analyzing**: calculus_basics.md
Reading first 100 lines...
Keywords found: 导数, 积分, 极限, 微积分, 函数, 定理
Category: **math**
Confidence: **High**

**Analyzing**: thermodynamics.md
Reading first 100 lines...
Keywords found: thermodynamics, energy, entropy, temperature, heat
Category: **physics**
Confidence: **High**

**Analyzing**: machine_learning_intro.md
Reading first 100 lines...
Keywords found: machine learning, algorithm, data structure, 教材, 导论
Category: **cs**
Confidence: **High**

### Step 3: Creating directories...
✓ All directories exist

### Step 4: Moving files...
Executing: mv files/calculus_basics.md .opencode/literature/math/
✓ Moved successfully

Executing: mv files/thermodynamics.md .opencode/literature/physics/
✓ Moved successfully

Executing: mv files/machine_learning_intro.md .opencode/literature/cs/
✓ Moved successfully

## Literature Organization Report

**Files Organized:** 3 files

### Summary:
- Math: 1 files
- Physics: 1 files
- CS: 1 files
- Engineering: 0 files
- Textbooks: 0 files

✅ All files organized successfully!
```

## 文件结构

整理后的目录结构：

```
.opencode/
├── literature/                    # 已整理的文献（可被 STEM Research 搜索）
│   ├── math/
│   │   ├── linear_algebra_zh.md
│   │   ├── linear_algebra_en.md
│   │   └── calculus_basics.md         ← 新添加
│   ├── physics/
│   │   ├── quantum_mechanics_zh.md
│   │   ├── quantum_mechanics_en.md
│   │   └── thermodynamics.md          ← 新添加
│   ├── cs/
│   │   └── machine_learning_intro.md  ← 新添加
│   ├── engineering/
│   └── textbooks/
│
└── files/            # 临时上传文件夹（应为空）
    └── README.md
```

## 使用技巧

### ✅ 最佳实践

1. **使用 Markdown 格式**：推荐 `.md` 格式，易于阅读和搜索
2. **UTF-8 编码**：确保文件使用 UTF-8 编码，支持中英文
3. **描述性文件名**：例如 `calculus_basics.md` 而不是 `file1.md`
4. **批量上传**：可以一次放多个文件，agent 会批量处理
5. **备份重要文件**：虽然很安全，但建议备份原始文件

### ⚠️ 注意事项

1. **文件会被移动**：文件从 `files/` 移动到 `literature/`，原文件夹变空
2. **UTF-8 编码**：如果不是 UTF-8，可能会出现乱码
3. **需要重启**：添加新文献后，建议重启 OpenCode 让索引更新

### 🔄 工作流程建议

```
1. 收集文献 → 2. 放到 uploads → 3. 自动整理 → 4. 使用 STEM Research 查询
   (准备阶段)    (上传阶段)       (整理阶段)          (使用阶段)
```

## 故障排除

### 问题 1: Agent 说找不到文件

**原因**：文件不在 `files/` 文件夹

**解决**：
```bash
# 检查文件位置
ls -la files/

# 移动文件到正确位置
mv your-file.md files/
```

### 问题 2: 分类错误

**原因**：文件内容关键词模糊

**解决**：手动移动到正确位置
```bash
# 假设被错误分类到 math，应该在 physics
mv .opencode/literature/math/your-file.md .opencode/literature/physics/
```

### 问题 3: Agent 没有显示工具输出

**原因**：Skill 文件没有正确加载

**解决**：
1. 重启 OpenCode：`bun dev`
2. 重新选择 "Literature Organizer" agent
3. 确认 prompt 包含 "Show ALL bash commands and outputs"

### 问题 4: 文件名包含特殊字符

**原因**：文件名有空格或特殊字符

**解决**：重命名文件
```bash
# 不好的文件名
"My File (1).md"

# 好的文件名
my_file_1.md
```

## 高级用法

### 手动整理

如果你想手动控制分类：

```bash
# 数学文献
mv file.md .opencode/literature/math/

# 物理文献
mv file.md .opencode/literature/physics/

# 计算机文献
mv file.md .opencode/literature/cs/

# 工程文献
mv file.md .opencode/literature/engineering/

# 教材
mv file.md .opencode/literature/textbooks/
```

### 查看已整理的文献

```bash
# 查看所有文献
find .opencode/literature/ -name "*.md" -type f

# 查看特定学科
ls .opencode/literature/math/
ls .opencode/literature/physics/
ls .opencode/literature/cs/
```

## 下一步

整理完文献后：

1. ✅ 切换到 **"STEM Research"** agent
2. ✅ 开始提问研究问题
3. ✅ Agent 会自动搜索并引用文献

**示例问题**：
```
# 使用刚才整理的文献
什么是微积分基本定理？
热力学第二定律是什么？
机器学习中的过拟合问题如何解决？
```

## 配置文件位置

- **Skill 文件**：`.opencode/skill/literature-organizer/SKILL.md`
- **Agent 配置**：`.opencode/opencode.jsonc` 中的 `literature-organizer` 部分
- **上传文件夹**：`files/`
- **文献文件夹**：`.opencode/literature/`

---

**版本**：v1.0
**更新日期**：2025-01-22
