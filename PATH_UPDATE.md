# 路径更新说明

## 更新内容

将文献上传文件夹从 `.opencode/literature-uploads/` 更改为项目根目录下的 `files/`。

## 为什么更改？

- **更易于访问**：`files/` 在项目根目录，更容易找到和使用
- **更符合直觉**：用户不需要记住 `.opencode` 子目录结构
- **更简洁的路径**：`files/` 比 `.opencode/literature-uploads/` 更简洁

## 使用方法

### Before（旧路径）

```bash
# 旧方式 - 不再使用
cp your-file.md .opencode/literature-uploads/
```

### After（新路径）✅

```bash
# 新方式 - 使用 files/ 文件夹
cp your-file.md files/
```

## 完整工作流程

```bash
# 1. 将文献文件复制到 files/ 文件夹
cp ~/Documents/calculus.md files/
cp ~/Downloads/physics.md files/

# 2. 启动 OpenCode
bun dev

# 3. 切换到 "Literature Organizer" agent（按 Tab）

# 4. 输入命令
整理文献

# 5. 文件自动被整理到：
# - .opencode/literature/math/calculus.md
# - .opencode/literature/physics/physics.md
```

## 目录结构

```
项目根目录/
├── files/                            # 文献上传文件夹（新）
│   ├── README.md                     # 使用说明
│   ├── calculus_basics.md            # 测试文件
│   ├── thermodynamics.md             # 测试文件
│   └── machine_learning_intro.md     # 测试文件
│
├── .opencode/
│   ├── literature/                   # 已整理的文献
│   │   ├── math/
│   │   ├── physics/
│   │   ├── cs/
│   │   ├── engineering/
│   │   └── textbooks/
│   │
│   └── skill/
│       └── literature-organizer/     # 文献整理 skill
│           └── SKILL.md
│
└── 其他文件...
```

## 更新的文件

### 配置文件
- ✅ `.opencode/skill/literature-organizer/SKILL.md`
- ✅ `.opencode/opencode.jsonc`

### 文档文件
- ✅ `QUICK_START.md`
- ✅ `PROJECT_README.md`
- ✅ `LITERATURE_ORGANIZER_GUIDE.md`
- ✅ `AUTO_ORGANIZER_IMPLEMENTATION.md`
- ✅ `TESTING_GUIDE.md`
- ✅ `PATH_UPDATE.md`（本文档）

### 文件夹
- ✅ 创建 `files/` 文件夹
- ✅ 移动测试文件到 `files/`
- ✅ 删除 `.opencode/literature-uploads/` 文件夹

## 测试验证

```bash
# 1. 检查 files/ 文件夹存在
ls files/

# 2. 应该看到测试文件
# - calculus_basics.md
# - thermodynamics.md
# - machine_learning_intro.md
# - README.md

# 3. 启动 OpenCode
bun dev

# 4. 测试整理功能
# 切换到 "Literature Organizer" agent
# 输入：整理文献

# 5. 验证结果
ls .opencode/literature/math/
ls .opencode/literature/physics/
ls .opencode/literature/cs/
```

## 兼容性说明

- ⚠️ **旧路径不再使用**：`.opencode/literature-uploads/` 已删除
- ✅ **新路径完全兼容**：所有功能正常工作
- ✅ **测试文件已迁移**：所有测试文件已移到 `files/`

## 需要帮助？

如果遇到问题：

1. 确认文件在 `files/` 文件夹中
2. 查看 `files/README.md` 了解详细使用方法
3. 查看 `TESTING_GUIDE.md` 了解测试流程
4. 重启 OpenCode：`bun dev`

---

**更新日期**：2025-01-22
**版本**：v1.1
