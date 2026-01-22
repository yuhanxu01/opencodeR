# OpenCodeR Research Features - 快速参考卡片 🚀

## ⚡ 一键安装

```bash
# 安装到当前项目
./install-research-features.sh

# 安装到全局 Claude Code
./install-research-features.sh --global

# 预览（推荐第一次）
./install-research-features.sh --dry-run

# 验证安装
./verify-installation.sh
```

---

## 📚 核心功能速查

### 1. STEM Research Agent（零幻觉研究助手）

**何时使用:** 需要准确的 STEM 领域答案时

**特点:**
- ✅ 强制文献引用
- ✅ 显示所有搜索过程
- ✅ 诚实的"不知道"
- ✅ 精确行号引用

**示例:**
```
Q: "What is the eigenvalue decomposition theorem?"

A: [Detailed answer with exact citations]

**Sources:**
- `.opencode/literature/math/linear_algebra_en.md:45` - "theorem statement..."
```

### 2. Literature Search（跨语言文献搜索）

**何时使用:** 搜索中英文文献时

**特点:**
- ✅ 自动双语搜索
- ✅ 47+ 术语对照
- ✅ 数学符号搜索
- ✅ 多策略搜索

**示例:**
```
# 中文查询 → 自动英文搜索
"找拉格朗日量" → searches: 拉格朗日, Lagrangian, Lagrange

# 英文查询 → 自动中文搜索
"eigenvalue" → searches: eigenvalue, 特征值, 本征值
```

### 3. Literature Organizer（自动文献整理）

**何时使用:** 批量上传文献需要分类时

**特点:**
- ✅ 智能分类（5 类）
- ✅ 中英文关键词
- ✅ 自动移动文件
- ✅ 生成整理报告

**使用:**
```bash
# 1. 上传文件
mkdir files/
cp *.md files/

# 2. 启动整理
切换到 "Literature Organizer" agent
输入: "整理文献" 或 "organize literature"

# 3. 查看报告
📊 Math: 5 files
📊 Physics: 7 files
📊 CS: 3 files
```

---

## 🗂️ 目录结构

```
.opencode/
├── opencode.jsonc              # 主配置
├── AGENTS.md                   # 使用指南
│
├── skill/                      # 技能定义
│   ├── stem-research/          # 零幻觉协议（8540B）
│   ├── literature-search/      # 跨语言搜索（8533B）
│   ├── literature-organizer/   # 自动整理（7850B）
│   └── bun-file-io/            # 文件 I/O
│
├── literature/                 # 文献库
│   ├── README.md               # 使用说明
│   ├── TESTING.md              # 测试用例
│   ├── CROSS_LANGUAGE_SEARCH.md # 搜索指南
│   ├── math/                   # 数学
│   ├── physics/                # 物理
│   ├── cs/                     # 计算机科学
│   ├── engineering/            # 工程
│   └── textbooks/              # 教材
│
└── tool/                       # 自定义工具
    ├── github-pr-search.ts
    └── github-triage.ts
```

---

## 🔧 配置速查

### opencode.jsonc 关键配置

```jsonc
{
  // Provider 配置
  "provider": {
    "opencode": {},
    "deepseek": {}
  },

  // Agent 配置
  "agent": {
    "general": {
      "model": "deepseek/deepseek-reasoner",
      "mode": "subagent"
    },
    "stem-research": {
      "mode": "primary",
      "temperature": 0.1
    },
    "literature-organizer": {
      "mode": "primary",
      "temperature": 0.1
    }
  },

  // MCP 配置（可选）
  "mcp": {
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.com/mcp"
    }
  }
}
```

---

## 🎯 常用命令

### 安装和验证
```bash
./install-research-features.sh          # 安装
./install-research-features.sh --global # 全局安装
./verify-installation.sh                # 验证
```

### 文献管理
```bash
# 上传文献
cp paper.md .opencode/literature/math/
cp paper.md .opencode/literature/physics/

# 批量整理
mkdir files/ && cp *.md files/
# 然后使用 Literature Organizer agent
```

### 检查安装
```bash
# 检查 Skills
ls -la .opencode/skill/

# 检查文献库
ls -la .opencode/literature/

# 检查配置
cat .opencode/opencode.jsonc | grep -A 5 "agent"
```

---

## 🧪 快速测试

### Test 1: 基础搜索
```
Q: "What is an eigenvalue?"
Expected: 答案 + 文献引用（文件名:行号）
```

### Test 2: 跨语言搜索
```
Q: "什么是特征值？"
Expected: 中英文文献都搜索 + 显示搜索过程
```

### Test 3: 未知问题
```
Q: "Explain string theory"
Expected: "I cannot answer..." + 显示所有搜索尝试
```

### Test 4: 文献整理
```
mkdir files/
echo "# Linear Algebra" > files/test.md
切换到 Literature Organizer
输入: "整理文献"
Expected: 自动分类到 math/
```

---

## 📖 术语对照速查

| 中文 | English | 领域 |
|------|---------|------|
| 拉格朗日量 | Lagrangian | 物理 |
| 哈密顿量 | Hamiltonian | 物理 |
| 特征值 | eigenvalue | 数学 |
| 本征值 | eigenvalue | 数学 |
| 特征向量 | eigenvector | 数学 |
| 薛定谔方程 | Schrödinger equation | 物理 |
| 傅里叶变换 | Fourier transform | 数学 |
| 拉普拉斯变换 | Laplace transform | 数学 |
| 算法复杂度 | algorithm complexity | CS |
| 数据结构 | data structure | CS |
| 量子力学 | quantum mechanics | 物理 |
| 线性代数 | linear algebra | 数学 |

**完整列表:** `.opencode/skill/literature-search/SKILL.md`

---

## 🔍 数学符号搜索

| 符号 | 搜索关键词 |
|------|-----------|
| ∇ | nabla, gradient, 梯度 |
| ∂ | partial, 偏导数 |
| ∫ | integral, 积分 |
| λ | lambda, eigenvalue, 特征值 |
| ψ | psi, wave function, 波函数 |
| ∑ | sum, summation, 求和 |
| ∏ | product, 乘积 |
| ℏ | h-bar, reduced Planck, 约化普朗克常数 |

**完整列表:** `.opencode/literature/CROSS_LANGUAGE_SEARCH.md`

---

## 🚨 故障排除速查

### 问题：Agent 不显示
```bash
# 检查配置
cat .opencode/opencode.jsonc | grep "agent"

# 重启 Claude Code
```

### 问题：搜索无结果
```bash
# 检查文献库
ls -la .opencode/literature/*/

# 检查文件格式（必须 .md）
find .opencode/literature/ -name "*.md"
```

### 问题：配置冲突
```bash
# 查看备份
ls -la .opencode_backup_*/

# 手动合并
cat .opencode/opencode.jsonc.original
cat .opencode/opencode.jsonc.research
```

### 问题：权限错误
```bash
chmod -R u+w .opencode/
```

---

## 📚 完整文档索引

| 文档 | 用途 |
|------|------|
| **QUICK_REFERENCE.md** | 本文档 - 快速参考 |
| **FEATURE_CHECKLIST.md** | 功能清单 - 查看所有功能 |
| **INSTALLATION_GUIDE.md** | 安装指南 - 详细安装步骤 |
| **.opencode/AGENTS.md** | Agent 指南 - 使用说明 |
| **.opencode/literature/README.md** | 文献库说明 |
| **.opencode/literature/TESTING.md** | 测试用例 |
| **.opencode/literature/CROSS_LANGUAGE_SEARCH.md** | 搜索指南 |
| **.opencode/skill/*/SKILL.md** | Skill 详细规范 |

---

## 💡 最佳实践

### ✅ DO
- 首次安装使用 `--dry-run` 预览
- 定期备份配置文件
- 使用中英文双语关键词搜索
- 按学科分类存储文献
- 查看搜索输出调整策略

### ❌ DON'T
- 不要直接覆盖现有配置
- 不要跳过验证步骤
- 不要忽略备份
- 不要混合不同学科文献
- 不要假设单一语言搜索足够

---

## 🎉 开始使用

```bash
# 1. 安装
./install-research-features.sh

# 2. 验证
./verify-installation.sh

# 3. 上传文献
cp your_papers/*.md .opencode/literature/math/

# 4. 测试
# 启动 Claude Code → Tab 切换 → STEM Research → 提问

# 5. 享受零幻觉研究！ 🚀
```

---

## 🔗 快速链接

- **脚本:** `install-research-features.sh`, `verify-installation.sh`
- **配置:** `.opencode/opencode.jsonc`
- **文献库:** `.opencode/literature/`
- **Skills:** `.opencode/skill/`
- **文档:** 见上方索引

---

**提示:** 将此文档加入书签，随时查阅！📌
