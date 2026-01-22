# OpenCodeR Research Features - 安装指南

## 🎯 快速开始

### 一键安装（推荐）

```bash
# 1. 安装到当前项目
./install-research-features.sh

# 2. 安装到全局 Claude Code 配置
./install-research-features.sh --global

# 3. 预览安装内容（不做实际更改）
./install-research-features.sh --dry-run
```

---

## 📋 安装内容清单

安装脚本会将以下 research 定制功能移植到你的本地 Claude Code：

### 1. Skills（技能定义）✨

| Skill | 文件大小 | 功能描述 |
|-------|---------|---------|
| **stem-research** | 8540 字节 | STEM 研究助手，零幻觉容忍协议 |
| **literature-search** | 8533 字节 | 跨语言文献搜索（中英文） |
| **literature-organizer** | 7850 字节 | 自动文献分类和整理 |
| **bun-file-io** | - | 文件 I/O 操作 |

**安装位置:** `.opencode/skill/`

### 2. 文献库结构 📚

```
.opencode/literature/
├── README.md                    # 使用说明
├── TESTING.md                   # 6 个核心测试用例
├── CROSS_LANGUAGE_SEARCH.md     # 跨语言搜索指南
├── math/                        # 数学文献
│   ├── linear_algebra_en.md
│   ├── linear_algebra_zh.md
│   └── example_linear_algebra.md
├── physics/                     # 物理文献
│   ├── quantum_mechanics_en.md
│   └── quantum_mechanics_zh.md
├── cs/                          # 计算机科学
├── engineering/                 # 工程
└── textbooks/                   # 教材
```

### 3. 配置文件 ⚙️

| 文件 | 说明 |
|------|------|
| `opencode.jsonc` | 主配置（会与现有配置合并） |
| `AGENTS.md` | Agent 使用指南 |

**核心配置内容:**

```jsonc
{
  "provider": {
    "opencode": {},
    "deepseek": {}
  },
  "mcp": {
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.com/mcp"
    }
  },
  "agent": {
    "general": {
      "name": "General Reasoning",
      "mode": "subagent",
      "model": "deepseek/deepseek-reasoner"
    },
    "stem-research": {
      "name": "STEM Research",
      "mode": "primary",
      "temperature": 0.1,
      "prompt": "You are a STEM research assistant..."
    },
    "literature-organizer": {
      "name": "Literature Organizer",
      "mode": "primary",
      "temperature": 0.1,
      "prompt": "You are a literature organizer..."
    }
  }
}
```

### 4. 自定义工具 🔧

| 工具 | 功能 |
|------|------|
| `github-pr-search.ts` | 搜索 GitHub PR |
| `github-triage.ts` | 自动分类 GitHub Issues |

---

## 🚀 详细安装步骤

### 方案 A: 安装到当前项目（推荐）

适用于：为特定项目添加 research 功能

```bash
# 1. 进入你的项目目录
cd /path/to/your/project

# 2. 运行安装脚本
/path/to/opencodeR/install-research-features.sh

# 或者复制脚本到项目目录
cp /path/to/opencodeR/install-research-features.sh .
./install-research-features.sh
```

**安装位置:** `/path/to/your/project/.opencode/`

### 方案 B: 安装到全局配置

适用于：所有项目共享 research 功能

```bash
./install-research-features.sh --global
```

**安装位置:** `~/.config/opencode/`

### 方案 C: 安装到指定目录

```bash
./install-research-features.sh --target /custom/path/.opencode
```

---

## 🔧 安装选项

### 完整选项列表

```bash
./install-research-features.sh [OPTIONS]

选项:
  --target PATH       目标 .opencode 目录（默认：当前项目）
  --global            安装到全局 Claude Code 配置（~/.config/opencode）
  --backup            安装前创建备份（默认：是）
  --no-backup         跳过备份（不推荐）
  --dry-run           预览安装内容，不做实际更改
  --help              显示帮助信息
```

### 常用命令示例

```bash
# 预览安装（推荐第一次使用）
./install-research-features.sh --dry-run

# 正常安装（带备份）
./install-research-features.sh

# 安装到全局（带备份）
./install-research-features.sh --global

# 快速安装（不备份，不推荐）
./install-research-features.sh --no-backup
```

---

## ⚙️ 安装后配置

### 1. 配置合并（如果需要）

如果你已有 `opencode.jsonc` 配置，安装脚本会创建：

- `opencode.jsonc.original` - 你的原始配置
- `opencode.jsonc.research` - research 功能配置

**手动合并步骤:**

1. 打开两个配置文件
2. 将 `opencode.jsonc.research` 中的以下部分合并到原始配置：

```jsonc
{
  // 1. 添加 provider 配置
  "provider": {
    "opencode": { "options": {} },
    "deepseek": { "options": {} }
  },

  // 2. 添加 agent 配置
  "agent": {
    "general": {
      "name": "General Reasoning",
      "mode": "subagent",
      "model": "deepseek/deepseek-reasoner"
    },
    "stem-research": { /* ... */ },
    "literature-organizer": { /* ... */ }
  },

  // 3. 添加 MCP 配置（可选）
  "mcp": {
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.com/mcp"
    }
  }
}
```

3. 保存并删除临时文件

### 2. 上传文献

```bash
# 进入 literature 目录
cd .opencode/literature/

# 按学科分类添加文献
cp your_paper.md math/          # 数学文献
cp your_paper.md physics/       # 物理文献
cp your_paper.md cs/            # CS 文献
cp your_paper.md engineering/   # 工程文献
cp your_paper.md textbooks/     # 教材
```

### 3. 环境变量（可选）

如果使用 GitHub 工具，需要设置：

```bash
export GITHUB_TOKEN="your_github_token"
```

---

## 🧪 测试安装

### 方法 1: 使用测试用例

```bash
# 1. 启动 Claude Code
cd your-project
opencode  # 或 bun dev

# 2. 切换到 STEM Research agent
# 按 Tab 键，选择 "STEM Research"

# 3. 运行测试查询（从 TESTING.md）
```

**测试查询示例:**

```
# Test 1: 基础事实检索
"What is an eigenvalue?"

# Test 2: 跨语言检索
"什么是特征值？" (What is eigenvalue?)

# Test 3: 公式搜索
"Find the formula for eigenvalue decomposition"

# Test 4: 深度推导
"Derive the eigenvalue equation from the linear transformation definition"

# Test 5: 未知问题处理
"Explain string theory in quantum mechanics"
```

### 方法 2: 测试文献整理

```bash
# 1. 创建测试文件夹
mkdir files/

# 2. 添加测试文献
cp some_papers.md files/

# 3. 启动 Claude Code 并切换到 Literature Organizer agent

# 4. 输入命令
"整理文献" 或 "organize literature"

# 5. 检查文件是否被正确分类到 .opencode/literature/[category]/
```

---

## 📊 验证安装

### 检查清单

```bash
# 1. 验证 Skills 安装
ls -la .opencode/skill/
# 应该看到: stem-research, literature-search, literature-organizer, bun-file-io

# 2. 验证文献库结构
ls -la .opencode/literature/
# 应该看到: math, physics, cs, engineering, textbooks, README.md, TESTING.md

# 3. 验证配置文件
cat .opencode/opencode.jsonc
# 应该包含 agent, provider, mcp 配置

# 4. 验证文档
ls -la .opencode/*.md
# 应该看到: AGENTS.md

# 5. 验证工具（如果存在）
ls -la .opencode/tool/
# 应该看到: github-pr-search.ts, github-triage.ts
```

### 验证脚本

```bash
#!/bin/bash
# verify-installation.sh

echo "Verifying OpenCodeR research features installation..."

checks=0
passed=0

# Check skills
if [ -d ".opencode/skill/stem-research" ]; then
    echo "✓ STEM Research skill installed"
    ((passed++))
fi
((checks++))

if [ -d ".opencode/skill/literature-search" ]; then
    echo "✓ Literature Search skill installed"
    ((passed++))
fi
((checks++))

if [ -d ".opencode/skill/literature-organizer" ]; then
    echo "✓ Literature Organizer skill installed"
    ((passed++))
fi
((checks++))

# Check literature library
if [ -d ".opencode/literature" ]; then
    echo "✓ Literature library installed"
    ((passed++))
fi
((checks++))

# Check configuration
if [ -f ".opencode/opencode.jsonc" ]; then
    echo "✓ Configuration file exists"
    ((passed++))
fi
((checks++))

# Check documentation
if [ -f ".opencode/AGENTS.md" ]; then
    echo "✓ Agent guide installed"
    ((passed++))
fi
((checks++))

echo ""
echo "Installation verification: $passed/$checks checks passed"

if [ $passed -eq $checks ]; then
    echo "✓ All features installed successfully!"
    exit 0
else
    echo "⚠ Some features may not be installed correctly"
    exit 1
fi
```

---

## 🎓 使用指南

### 核心工作流程

#### 1. STEM Research Agent

**用途:** 回答 STEM 领域问题，确保零幻觉

```
# 启动 Claude Code
opencode

# 切换到 STEM Research (Tab 键)

# 提问
"What is the eigenvalue decomposition theorem?"

# Agent 会:
1. 搜索 .opencode/literature/ 中的文献
2. 使用 Grep/Glob/Read 工具
3. 显示所有搜索过程和结果
4. 提供带精确引用的答案
```

**回答格式:**
```
[Answer with specific technical details]

**Sources:**
- `.opencode/literature/math/linear_algebra_en.md:45` - "An eigenvalue λ of a matrix A..."
- `.opencode/literature/math/linear_algebra_zh.md:78` - "特征值λ是矩阵A的..."
```

#### 2. Literature Search Skill

**用途:** 跨语言文献搜索

```
# 中文查询 → 自动英文搜索
"找拉格朗日量相关的内容"

# 搜索过程:
grep "拉格朗日" .opencode/literature/       # Chinese
grep "Lagrangian" .opencode/literature/     # English
grep "Lagrange" .opencode/literature/       # Alternative

# 英文查询 → 自动中文搜索
"Find content about eigenvalues"

# 搜索过程:
grep "eigenvalue" .opencode/literature/     # English
grep "特征值" .opencode/literature/          # Chinese
grep "本征值" .opencode/literature/          # Alternative
```

#### 3. Literature Organizer Agent

**用途:** 自动整理上传的文献

```
# 1. 准备文件
mkdir files/
cp your_papers/*.md files/

# 2. 启动整理
切换到 "Literature Organizer" agent
输入: "整理文献" 或 "organize literature"

# 3. 自动流程
- 读取每个文件前 100 行
- 统计关键词频次
- 确定学科分类
- 移动文件到对应目录
- 生成整理报告

# 4. 报告示例
📊 Literature Organization Complete

Total Files: 15
✓ Math: 5 files (linear_algebra.md, calculus.md, ...)
✓ Physics: 7 files (quantum.md, mechanics.md, ...)
✓ CS: 3 files (algorithms.md, data_structures.md, ...)
```

---

## 🔍 高级功能

### 1. DeepSeek Reasoner 集成

**配置:**
```jsonc
"agent": {
  "general": {
    "name": "General Reasoning",
    "mode": "subagent",
    "model": "deepseek/deepseek-reasoner"
  }
}
```

**使用:**
- 自动用于复杂推理任务
- 可手动触发深度思考模式

### 2. MCP 服务器集成

**配置:**
```jsonc
"mcp": {
  "context7": {
    "type": "remote",
    "url": "https://mcp.context7.com/mcp"
  }
}
```

**功能:**
- 远程工具调用
- 扩展 Agent 能力
- 动态工具注册

### 3. 多语言术语对照

**内置术语对:**
| 中文 | English | 领域 |
|------|---------|------|
| 拉格朗日量 | Lagrangian | 物理 |
| 哈密顿量 | Hamiltonian | 物理 |
| 特征值 | eigenvalue | 数学 |
| 特征向量 | eigenvector | 数学 |
| 薛定谔方程 | Schrödinger equation | 物理 |
| 傅里叶变换 | Fourier transform | 数学 |
| 算法复杂度 | algorithm complexity | CS |

**查看完整列表:**
```bash
cat .opencode/skill/literature-search/SKILL.md
```

---

## 🛠️ 故障排除

### 问题 1: 配置文件冲突

**症状:** 安装后 Agent 不出现

**解决:**
```bash
# 检查配置文件
cat .opencode/opencode.jsonc

# 确保包含 agent 配置
# 如果不包含，手动合并 .research 文件
```

### 问题 2: 文献搜索无结果

**症状:** Agent 找不到文献

**解决:**
```bash
# 1. 检查文献库
ls -la .opencode/literature/*/

# 2. 确认文件格式（必须是 .md）
find .opencode/literature/ -name "*.md"

# 3. 检查 skill 是否安装
ls -la .opencode/skill/stem-research/SKILL.md
```

### 问题 3: Agent 不切换

**症状:** Tab 键无法切换到新 Agent

**解决:**
```bash
# 1. 重启 Claude Code
# 2. 检查配置
cat .opencode/opencode.jsonc | grep -A 5 "agent"

# 3. 确认 mode 设置
# stem-research 和 literature-organizer 应该是 "mode": "primary"
```

### 问题 4: 权限错误

**症状:** 无法创建文件或目录

**解决:**
```bash
# 检查权限
ls -la .opencode/

# 修复权限
chmod -R u+w .opencode/
```

---

## 📚 相关文档

### 安装相关
- **INSTALLATION_GUIDE.md** (本文档) - 安装指南
- **FEATURE_CHECKLIST.md** - 功能清单
- **install-research-features.sh** - 安装脚本

### 使用相关
- **.opencode/AGENTS.md** - Agent 使用指南
- **.opencode/literature/README.md** - 文献库说明
- **.opencode/literature/TESTING.md** - 测试用例
- **.opencode/literature/CROSS_LANGUAGE_SEARCH.md** - 搜索指南

### Skill 文档
- **.opencode/skill/stem-research/SKILL.md** - 零幻觉协议
- **.opencode/skill/literature-search/SKILL.md** - 搜索策略
- **.opencode/skill/literature-organizer/SKILL.md** - 整理流程

### 项目文档
- **PROJECT_README.md** - 项目总览
- **QUICK_START.md** - 快速开始
- **IMPLEMENTATION_SUMMARY.md** - 技术实现

---

## 🚀 快速参考

### 一键命令

```bash
# 安装（当前项目）
./install-research-features.sh

# 安装（全局）
./install-research-features.sh --global

# 预览
./install-research-features.sh --dry-run

# 验证
bash verify-installation.sh

# 测试
# 启动 Claude Code → Tab 切换 → STEM Research → 提问
```

### 目录结构

```
.opencode/
├── opencode.jsonc              # 主配置
├── AGENTS.md                   # 使用指南
├── skill/                      # Skills
│   ├── stem-research/
│   ├── literature-search/
│   ├── literature-organizer/
│   └── bun-file-io/
├── literature/                 # 文献库
│   ├── README.md
│   ├── TESTING.md
│   ├── CROSS_LANGUAGE_SEARCH.md
│   ├── math/
│   ├── physics/
│   ├── cs/
│   ├── engineering/
│   └── textbooks/
└── tool/                       # 自定义工具
    ├── github-pr-search.ts
    └── github-triage.ts
```

---

## 💡 最佳实践

1. **首次安装**
   - 使用 `--dry-run` 预览
   - 检查现有配置
   - 创建备份（默认行为）

2. **文献管理**
   - 按学科分类存储
   - 使用描述性文件名
   - 定期整理和更新

3. **搜索优化**
   - 使用中英文双语关键词
   - 尝试多种术语变体
   - 查看搜索输出调整策略

4. **配置管理**
   - 保留原始配置备份
   - 逐步合并新配置
   - 测试后再提交

---

## 🎉 完成！

安装完成后，你将拥有：

✅ 零幻觉 STEM 研究系统
✅ 中英文跨语言文献搜索
✅ 自动文献分类和整理
✅ DeepSeek Reasoner 深度推理
✅ MCP 协议扩展能力
✅ 完整的文档和测试用例

开始你的零幻觉科研之旅吧！🚀
