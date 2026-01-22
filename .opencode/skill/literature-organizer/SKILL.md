---
name: literature-organizer
description: Automatically organize literature files into appropriate categories (math/physics/cs/engineering/textbooks). Use this when users upload new literature files to files/
---

## Literature Organization Protocol

You are an automated literature organizer. Your task is to analyze literature files in the upload folder and move them to appropriate categories.

### When to Use This Skill

Trigger this skill when:
- User says "整理文献" or "organize literature"
- User says "整理上传的文件" or "organize uploads"
- User asks to "处理文献文件" or "process literature"
- There are files in `files/` that need organization

### Organization Workflow

#### Step 1: List Upload Files

First, check what files are in the upload folder:

```bash
ls -la files/
```

List ALL `.md` and `.txt` files found.

**If no files found**, report: "No files to organize in files/"

#### Step 2: Analyze Each File

For each file, use the `Read` tool to examine the **first 100 lines** to understand the content.

Look for keywords to determine the category:

**Math Keywords:**
- English: theorem, proof, lemma, matrix, vector, algebra, calculus, derivative, integral, eigenvalue, linear, space, topology, geometry
- Chinese: 定理, 证明, 引理, 矩阵, 向量, 代数, 微积分, 导数, 积分, 特征值, 线性, 空间, 拓扑, 几何

**Physics Keywords:**
- English: quantum, mechanics, wave, energy, particle, field, relativity, thermodynamics, electromagnetism, optics, hamiltonian, lagrangian, schrodinger
- Chinese: 量子, 力学, 波, 能量, 粒子, 场, 相对论, 热力学, 电磁, 光学, 哈密顿, 拉格朗日, 薛定谔

**CS Keywords:**
- English: algorithm, complexity, data structure, programming, code, software, machine learning, artificial intelligence, database, network, optimization
- Chinese: 算法, 复杂度, 数据结构, 编程, 代码, 软件, 机器学习, 人工智能, 数据库, 网络, 优化

**Engineering Keywords:**
- English: circuit, control, system, signal, processing, electrical, mechanical, civil, engineering, design, analysis
- Chinese: 电路, 控制, 系统, 信号, 处理, 电气, 机械, 土木, 工程, 设计, 分析

**Textbook Keywords:**
- English: introduction, textbook, comprehensive, tutorial, course, fundamentals, basics, guide, reference
- Chinese: 教材, 导论, 教程, 课程, 基础, 入门, 指南, 参考, 课本

#### Step 3: Create Target Directories (if needed)

For each identified category, ensure the target directory exists:

```bash
mkdir -p .opencode/literature/math/
mkdir -p .opencode/literature/physics/
mkdir -p .opencode/literature/cs/
mkdir -p .opencode/literature/engineering/
mkdir -p .opencode/literature/textbooks/
```

#### Step 4: Move Files

For each file, use `mv` command to move to the appropriate directory:

```bash
mv files/filename.md .opencode/literature/[category]/
```

Example:
```bash
mv files/linear_algebra.md .opencode/literature/math/
mv files/quantum_mechanics.md .opencode/literature/physics/
```

#### Step 5: Generate Report

After organizing all files, provide a detailed report in this format:

```
## Literature Organization Report

**Files Organized:** [X] files

### Details:

1. **[filename.md]** → `[category]/`
   - **Reasoning:** Found keywords: [keyword1], [keyword2], [keyword3]
   - **Confidence:** [High/Medium/Low]

2. **[filename.md]** → `[category]/`
   - **Reasoning:** Found keywords: [keyword1], [keyword2]
   - **Confidence:** [High/Medium/Low]

### Summary:
- Math: [X] files
- Physics: [X] files
- CS: [X] files
- Engineering: [X] files
- Textbooks: [X] files

**All files have been moved to .opencode/literature/[category]/**
```

### Handling Edge Cases

#### Multiple Categories Detected

If a file could belong to multiple categories:

1. **Primary heuristic**: Choose the category with the most keyword matches
2. **Secondary heuristic**: If it's a textbook/introductory material, prefer `textbooks/`
3. **Tertiary heuristic**: Ask user for clarification if confidence is low

Example response:
```
**Ambiguous Category**: [filename.md]

**Detected:**
- Math keywords: theorem, proof, algebra (3 matches)
- Physics keywords: mechanics, energy (2 matches)

**Decision**: Moving to `math/` (higher keyword count)
**Confidence**: Medium

If this is incorrect, please manually move to: .opencode/literature/physics/
```

#### Unable to Categorize

If no clear keywords are found:

```
**Uncategorized**: [filename.md]

**Action**: Moving to `textbooks/` as default
**Reason**: Could not determine specific category
**Suggestion**: Please manually review and move to appropriate category
```

### Verification Steps

After moving files, verify success:

```bash
# Check uploads folder is empty
ls files/

# Verify files in target locations
find .opencode/literature/ -name "*.md" -type f
```

### Important Notes

- ⚠️ **DESTRUCTIVE OPERATION**: Files are MOVED, not copied
- ⚠️ **BACKUP RECOMMENDED**: Advise user to backup originals if needed
- ✅ **SAFE**: This operation only affects `files/` and `.opencode/literature/`
- ✅ **REVERSIBLE**: User can manually move files back if needed

### Example Full Workflow

**User Input**: "整理文献"

**Your Response**:

```
## Organizing Literature Files

### Step 1: Scanning upload folder...
Found 3 files:
- linear_algebra.md
- quantum_mechanics_zh.md
- algorithms_course.md

### Step 2: Analyzing files...

**Analyzing**: linear_algebra.md
Reading first 100 lines...
Keywords found: matrix, vector, eigenvalue, linear algebra, theorem
Category: **math**
Confidence: **High**

**Analyzing**: quantum_mechanics_zh.md
Reading first 100 lines...
Keywords found: 量子, 力学, 波函数, 哈密顿, 薛定谔方程
Category: **physics**
Confidence: **High**

**Analyzing**: algorithms_course.md
Reading first 100 lines...
Keywords found: algorithm, complexity, data structure, tutorial, course
Category: **cs**
Confidence: **High**

### Step 3: Creating directories...
✓ .opencode/literature/math/ exists
✓ .opencode/literature/physics/ exists
✓ .opencode/literature/cs/ exists

### Step 4: Moving files...
Executing: mv files/linear_algebra.md .opencode/literature/math/
✓ Moved successfully

Executing: mv files/quantum_mechanics_zh.md .opencode/literature/physics/
✓ Moved successfully

Executing: mv files/algorithms_course.md .opencode/literature/cs/
✓ Moved successfully

### Step 5: Verifying...
✓ Upload folder is now empty
✓ All files moved successfully

## Literature Organization Report

**Files Organized:** 3 files

### Details:

1. **linear_algebra.md** → `math/`
   - **Reasoning:** Found keywords: matrix, vector, eigenvalue, linear algebra, theorem
   - **Confidence:** High

2. **quantum_mechanics_zh.md** → `physics/`
   - **Reasoning:** Found keywords: 量子, 力学, 波函数, 哈密顿, 薛定谔方程
   - **Confidence:** High

3. **algorithms_course.md** → `cs/`
   - **Reasoning:** Found keywords: algorithm, complexity, data structure, tutorial, course
   - **Confidence:** High

### Summary:
- Math: 1 files
- Physics: 1 files
- CS: 1 files
- Engineering: 0 files
- Textbooks: 0 files

✅ **All files have been organized successfully!**

You can now use the STEM Research agent to search and query these literature files.
```

### Prohibited Behaviors

- ❌ DO NOT copy files (only move)
- ❌ DO NOT modify file contents
- ❌ DO NOT delete files without moving them
- ❌ DO NOT categorize files outside of `files/`
- ❌ DO NOT ask user for each file (batch process all files)

### Required Tools

For this task, you will primarily use:
- `Bash` tool: for ls, mkdir, mv commands
- `Read` tool: for analyzing file contents
- `Glob` tool: for finding files (optional)

**CRITICAL**: Always show the actual bash commands executed and their outputs.
