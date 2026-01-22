# OpenCode STEM Research Agent

基于 OpenCode 的零幻觉 STEM 科研辅助系统。

## 核心特性

### 🎯 零 hallucination（零幻觉）

- **强制引用**：所有技术答案必须引用文献来源
- **显示工具输出**：grep/glob/read 的实际输出全部展示
- **不知道就说不知道**：绝不编造答案

### 📚 智能文献管理

- **自动整理**：将文献文件放到上传文件夹，系统自动识别学科并归类
- **跨语言检索**：支持中英文双语搜索
- **多学科支持**：数学、物理、计算机、工程、教材

### 🔍 精确检索

- **多策略搜索**：关键词搜索、文件名模式、内容深度读取
- **公式符号搜索**：LaTeX、英文、中文三种表示
- **交叉验证**：多源验证，确保准确性

## 快速开始

### 1. 安装依赖

```bash
cd /Users/renqing/Downloads/opencode-research
bun install
```

### 2. 添加文献

将你的文献文件复制到上传文件夹：

```bash
cp your-literature.md files/
```

### 3. 自动整理

```bash
bun dev
```

启动后：
1. 按 **Tab** 键切换 agent
2. 选择 **"Literature Organizer"**
3. 输入：`整理文献`

系统会自动识别学科并归类文件。

### 4. 开始研究

切换到 **"STEM Research"** agent，开始提问！

```
什么是特征值？
What is thermodynamics?
从薛定谔方程推导能量本征值问题
```

## 文献自动整理功能

这是本系统的**核心功能**之一：

### 传统方式 ❌

```bash
# 需要手动创建文件夹
mkdir -p .opencode/literature/math
mkdir -p .opencode/literature/physics

# 需要手动判断学科
# 需要手动移动文件
mv file.md .opencode/literature/math/
```

### 自动方式 ✅

```bash
# 只需复制到上传文件夹
cp *.md files/

# 让 AI 自动识别和整理
# 在 OpenCode 中切换到 Literature Organizer
# 输入：整理文献
```

### 自动分类示例

| 文件名 | 识别关键词 | 自动归类 |
|--------|-----------|---------|
| `calculus_basics.md` | 导数, 积分, 极限, 微积分 | `math/` |
| `thermodynamics.md` | energy, entropy, temperature, heat | `physics/` |
| `machine_learning_intro.md` | algorithm, complexity, data structure | `cs/` |

## 工作流程

```
┌─────────────────┐
│ 1. 收集文献文件 │
└────────┬────────┘
         ↓
┌─────────────────────┐
│ 2. 复制到上传文件夹 │
│ files/              │
└────────┬────────────┘
         ↓
┌────────────────────┐
│ 3. 自动整理文献    │
│ Literature Organizer│
└────────┬────────────┘
         ↓
┌──────────────────────┐
│ 4. 文献已分类        │
│ literature/[category]│
└────────┬──────────────┘
         ↓
┌────────────────────┐
│ 5. 开始研究查询    │
│ STEM Research Agent│
└────────────────────┘
```

## 项目结构

```
项目根目录/
├── files/                   # 文献上传文件夹（待整理）
│   ├── README.md            # 使用说明
│   └── *.md                 # 待整理的文献文件
│
├── .opencode/
│   ├── literature/          # 已整理的文献（可搜索）
│   │   ├── math/           # 数学文献
│   │   ├── physics/        # 物理文献
│   │   ├── cs/             # 计算机文献
│   │   ├── engineering/    # 工程文献
│   │   └── textbooks/      # 教材
│   │
│   ├── skill/              # 技能定义
│   │   ├── stem-research/  # 研究助手
│   │   ├── literature-search/  # 文献搜索
│   │   └── literature-organizer/  # 文献整理
│   │
│   └── opencode.jsonc      # 配置文件
│
├── QUICK_START.md          # 快速开始指南
├── PROJECT_README.md       # 项目说明
├── TESTING_GUIDE.md        # 测试指南
└── 其他文档...
```

## 两个 Agent

### 1. STEM Research（研究助手）

**用途**：查询文献、推导公式、解释概念

**特点**：
- 零幻觉：所有答案必须有文献依据
- 跨语言：自动搜索中英文文献
- 精确引用：显示文件路径和行号

**示例**：
```
User: 什么是特征值？
Agent: [执行 grep "特征值"] [执行 grep "eigenvalue"]
      [读取相关文件]
      根据文献 linear_algebra_zh.md:20-22，特征值的定义是...
```

### 2. Literature Organizer（文献整理）🆕

**用途**：自动整理文献到正确的学科文件夹

**特点**：
- 智能分类：根据内容关键词自动识别学科
- 批量处理：一次整理多个文件
- 详细报告：显示整理过程和结果

**示例**：
```
User: 整理文献
Agent: [扫描上传文件夹]
      [分析每个文件的内容]
      [识别学科：math, physics, cs...]
      [移动文件到对应位置]
      ✓ 已整理 3 个文件
```

## 文档

- **快速开始**：[QUICK_START.md](./QUICK_START.md)
- **测试指南**：[TESTING_GUIDE.md](./TESTING_GUIDE.md)
- **文献整理指南**：[LITERATURE_ORGANIZER_GUIDE.md](./LITERATURE_ORGANIZER_GUIDE.md)
- **实现总结**：[IMPLEMENTATION_SUMMARY.md](./IMPLEMENTATION_SUMMARY.md)

## 技术栈

- **OpenCode**：开源 AI 编码助手框架
- **DeepSeek**：推荐的大语言模型（可配置）
- **Skill System**：OpenCode 的技能插件系统
- **Bash Tools**：grep, glob, read 等文件操作工具

## 适用场景

✅ **学术研究**：查阅文献、推导公式、验证概念
✅ **学习辅助**：理解定理、解析例题、交叉参考
✅ **论文写作**：查找引用、验证说法、确保准确性
✅ **知识管理**：整理笔记、建立知识图谱

## 核心原则

### 零幻觉容忍度

**核心原则**：准确性 > 有用性

- ❌ 不允许猜测或推测
- ❌ 不允许使用常识作为依据
- ❌ 不允许模糊表述（"一般来说"）
- ✅ 必须引用具体文献
- ✅ 必须显示工具输出
- ✅ 不知道就说不知道

### 反幻觉机制

1. **强制工具使用**：必须使用 grep/glob/read
2. **显示工具输出**：不能只说"我搜索了"，必须展示搜索结果
3. **精确定位**：必须提供文件路径和行号
4. **交叉验证**：多个文献来源交叉验证

## 安装与配置

详见 [QUICK_START.md](./QUICK_START.md)

## 测试

详见 [TESTING_GUIDE.md](./TESTING_GUIDE.md)

## 贡献

欢迎贡献！

可以改进的方向：
- 更精确的文献分类算法
- 更多学科的覆盖（化学、生物等）
- 知识图谱构建
- PDF 文献解析
- 自动摘要生成

## 许可证

MIT License

## 致谢

基于 [OpenCode](https://github.com/anomalyco/opencode) 构建

---

**版本**：v1.0
**更新**：2025-01-22
**作者**：OpenCode Research Team
