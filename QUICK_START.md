# 快速开始指南

## 安装与配置

### 1. 安装依赖

```bash
cd /Users/renqing/Downloads/opencode-research
bun install
```

### 2. （可选）配置 DeepSeek API

如果你想使用 DeepSeek 模型：

```bash
# 设置环境变量
export DEEPSEEK_API_KEY="your-api-key-here"

# 或添加到 ~/.zshrc
echo 'export DEEPSEEK_API_KEY="your-api-key-here"' >> ~/.zshrc
source ~/.zshrc
```

**注意**：不配置也能使用，会使用 OpenCode 默认模型。

## 使用流程

### 方式 1：添加文献并整理（推荐）

#### 步骤 1: 添加文献文件

将你的文献文件（markdown格式）复制到上传文件夹：

```bash
cp your-literature.md files/
```

**可以一次添加多个文件！**

#### 步骤 2: 启动并整理

```bash
# 启动 OpenCode
bun dev
```

启动后：
1. 按 **Tab** 键切换 agent
2. 选择 **"Literature Organizer"**
3. 输入：`整理文献`

Agent 会自动：
- ✅ 识别文件内容（数学/物理/CS/工程/教材）
- ✅ 创建对应的子文件夹
- ✅ 移动文件到正确位置
- ✅ 生成整理报告

#### 步骤 3: 开始研究

切换到 **"STEM Research"** agent，开始提问！

### 方式 2：手动添加文献

```bash
# 创建学科文件夹
mkdir -p .opencode/literature/math
mkdir -p .opencode/literature/physics
mkdir -p .opencode/literature/cs

# 手动移动文件
mv your-math-file.md .opencode/literature/math/
mv your-physics-file.md .opencode/literature/physics/
```

## 示例：完整工作流程

```bash
# 1. 准备3个文献文件
cp calculus.md files/
cp thermodynamics.md files/
cp machine_learning.md .opencode/literature-upsloads/

# 2. 启动 OpenCode
bun dev

# 3. 在 OpenCode 中：
#    - 按 Tab 切换到 "Literature Organizer"
#    - 输入 "整理文献"
#    - 等待自动整理完成

# 4. 切换到 "STEM Research" agent
# 5. 开始提问：
#    - "什么是微积分基本定理？"
#    - "解释热力学第二定律"
#    - "什么是机器学习中的过拟合？"
```

## 主要功能

### 📚 文献管理

- **自动整理**：自动识别学科并分类
- **手动管理**：也可以手动放置文件
- **多格式支持**：Markdown、纯文本
- **中英文支持**：跨语言检索

### 🔍 零幻觉搜索

- **强制引用**：所有答案必须引用文献
- **显示工具输出**：显示 grep/glob/read 的实际输出
- **不知道就说不知道**：绝不编造

### 🎯 学科覆盖

- **数学** (math)：定理、证明、代数、几何
- **物理** (physics)：力学、量子、电磁、热力学
- **计算机** (cs)：算法、数据结构、机器学习
- **工程** (engineering)：控制、信号、系统
- **教材** (textbooks)：综合性教材

## 测试你的设置

### 测试文献整理

```bash
# 查看测试文件
ls files/
# 应该看到：calculus_basics.md, thermodynamics.md, machine_learning_intro.md

# 启动 OpenCode
bun dev

# 切换到 "Literature Organizer" agent
# 输入：整理文献
```

### 测试文献搜索

整理完成后，切换到 "STEM Research" agent：

```
# 测试 1：基础检索
什么是特征值？

# 测试 2：跨语言检索
What is thermodynamics?

# 测试 3：未知问题（必须说不知道）
什么是超弦理论的M理论层面？
```

## 常用命令

```bash
# 启动 OpenCode
bun dev

# 查看已整理的文献
find .opencode/literature/ -name "*.md"

# 查看待整理的文件
ls files/

# 手动移动文件
mv file.md .opencode/literature/[category]/
```

## 目录结构

```
项目根目录/
├── files/                   # 文献上传文件夹（待整理）
│   ├── README.md            # 使用说明
│   └── *.md                 # 待整理的文献文件
│
├── .opencode/
│   ├── literature/          # 已整理的文献（可搜索）
│   │   ├── math/
│   │   ├── physics/
│   │   ├── cs/
│   │   ├── engineering/
│   │   └── textbooks/
│   │
│   ├── skill/
│   │   ├── stem-research/       # 研究助手
│   │   ├── literature-search/   # 文献搜索
│   │   └── literature-organizer/ # 文献整理
│   │
│   └── opencode.jsonc           # 配置文件
│
└── 文档文件...
```

## 文档

- **详细测试指南**：查看 `TESTING_GUIDE.md`
- **文献整理指南**：查看 `LITERATURE_ORGANIZER_GUIDE.md`
- **实现总结**：查看 `IMPLEMENTATION_SUMMARY.md`

## 需要帮助？

如果遇到问题：

1. 检查文件是否在 `files/` 文件夹
2. 确认文件编码为 UTF-8
3. 重启 OpenCode：`bun dev`
4. 重新选择 agent（按 Tab）

---

**版本**：v1.0
**更新**：2025-01-22
