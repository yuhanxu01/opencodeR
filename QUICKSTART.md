# OpenResearch Web UI - 快速开始指南

## 📖 概述

这个项目为 Claude Code 提供了一个现代化的 Web 界面，具有以下优势:

### ✨ 为什么选择 Web UI?

相比 Claude Code 原生的 TUI（终端界面），Web UI 提供:

1. **🎨 更直观的可视化**
   - 现代化的设计语言
   - 清晰的视觉层次
   - 流畅的动画效果

2. **🚀 更强大的功能**
   - Toast 通知系统（替代 alert）
   - 会话持久化（刷新后保留）
   - 批量操作支持
   - 平滑滚动

3. **💻 更好的用户体验**
   - 鼠标友好的界面
   - 键盘快捷键支持
   - 即时视觉反馈
   - 响应式设计

4. **🔄 完全兼容**
   - 与 TUI 并存，随时切换
   - 使用相同的后端 API
   - 无需额外配置

## 🚀 一键安装

### 步骤 1: 下载安装脚本

如果你还没有这个仓库，先克隆它:

```bash
git clone https://github.com/your-username/opencodeR.git
cd opencodeR
```

### 步骤 2: 运行安装脚本

```bash
./install-webui.sh
```

安装程序会:
1. ✅ 检查系统依赖
2. ✅ 自动查找 Claude Code 安装路径
3. ✅ 备份现有文件
4. ✅ 复制 Web UI 文件
5. ✅ 配置路由
6. ✅ 创建启动脚本

### 步骤 3: 启动 Web UI

```bash
./start-webui.sh
```

或者，如果你已经在 Claude Code 目录中:

```bash
cd packages/opencode
bun run dev  # 或 npm run dev
```

### 步骤 4: 访问界面

打开浏览器，访问:

- **Web UI**: http://localhost:4096/webui
- **TUI**: http://localhost:4096 (原终端界面仍然可用)

## 🎯 功能对比

| 功能 | TUI | Web UI |
|------|-----|--------|
| 会话管理 | ✅ | ✅ |
| 消息发送 | ✅ | ✅ |
| Markdown 渲染 | ✅ | ✅ |
| 工具可视化 | ✅ | ✅✅ (更直观) |
| 批量操作 | ❌ | ✅ |
| 会话持久化 | ❌ | ✅ |
| Toast 通知 | ❌ | ✅ |
| 平滑滚动 | ❌ | ✅ |
| 快捷键 | ✅ | ✅ |
| 鼠标操作 | ❌ | ✅ |
| 视觉效果 | 基础 | 现代化 |

## 📂 目录结构

安装后的目录结构:

```
claude-code/
├── packages/
│   └── opencode/
│       ├── webui/                    # Web UI 文件 (新增)
│       │   ├── static/
│       │   │   ├── css/
│       │   │   │   └── style.css    # 样式文件 (746 行)
│       │   │   └── js/
│       │   │       └── app.js       # 应用逻辑 (585 行)
│       │   └── templates/
│       │       ├── index.html       # 主页
│       │       └── base.html        # 基础模板
│       └── src/
│           └── server/
│               └── routes/
│                   └── webui.ts     # Web UI 路由 (新增)
├── start-webui.sh                   # 启动脚本 (新增)
├── uninstall-webui.sh               # 卸载脚本 (新增)
└── WEBUI-README.md                  # 使用文档 (新增)
```

## 🎨 界面预览

### 欢迎屏幕
```
╔════════════════════════════════════════╗
║                                        ║
║            [OpenResearch]              ║
║                                        ║
║     Welcome to OpenResearch           ║
║                                        ║
║   Your AI-powered research assistant  ║
║                                        ║
╚════════════════════════════════════════╝
```

### 聊天界面
```
┌─ 侧边栏 ─────┬─ 主聊天区 ────────┬─ 执行计划 ─┐
│              │                    │            │
│ [+] 新建     │  你: Hello         │ □ 任务 1   │
│ [☰] 选择     │  ↳ (蓝色气泡)     │ ✓ 任务 2   │
│              │                    │ □ 任务 3   │
│ ● 会话 1     │  AI: Hi there!    │            │
│   会话 2     │  ↳ (灰色气泡)     │            │
│   会话 3     │                    │            │
│              │  [工具: Read]      │            │
│              │  ↳ 展开查看详情   │            │
│              │                    │            │
│ [⚙] 设置     │  [输入框...] [↑]  │            │
└──────────────┴────────────────────┴────────────┘
```

## 💡 使用技巧

### 1. 快速创建会话
- 快捷键: 点击 `+` 按钮
- 自动保存到 localStorage
- 刷新页面后自动恢复

### 2. 批量删除会话
1. 点击 `☰` 进入选择模式
2. 勾选要删除的会话
3. 点击 "Delete Selected"
4. 确认删除

### 3. 查看工具详情
- 点击工具卡片展开/收起
- 查看参数、输出、错误信息
- 状态一目了然（运行中/成功/失败）

### 4. 使用快捷键
- `Enter` - 发送消息
- `Shift + Enter` - 换行
- 输入框自动扩展

### 5. 配置 API
1. 点击左下角 "⚙ Settings"
2. 输入 DeepSeek API 密钥
3. 密钥必须以 `sk-` 开头
4. 保存后立即生效

## 🔧 自定义配置

### 修改服务器端口

编辑 `packages/opencode/src/cli/network.ts`:

```typescript
const DEFAULT_PORT = 4096; // 改为你想要的端口
```

### 修改主题颜色

编辑 `packages/opencode/webui/static/css/style.css`:

```css
:root {
    --accent: #3b82f6;  /* 改为你喜欢的颜色 */
}
```

### 修改 Markdown 渲染选项

编辑 `packages/opencode/webui/static/js/app.js`:

```javascript
marked.setOptions({
    breaks: true,      // 单行换行
    gfm: true,         // GitHub Flavored Markdown
    // 更多选项...
});
```

## 🐛 常见问题

### Q: 安装后无法访问 Web UI?

**A:** 检查以下几点:
1. 确保服务器正在运行: `./start-webui.sh`
2. 检查端口是否被占用: `lsof -i :4096`
3. 查看控制台日志是否有错误

### Q: 消息发送失败?

**A:** 可能的原因:
1. API 密钥未配置或无效
2. 网络连接问题
3. 后端服务未运行

打开浏览器控制台 (F12) 查看详细错误信息。

### Q: 会话持久化不工作?

**A:** 检查:
1. 浏览器是否禁用了 localStorage
2. 是否使用了隐身模式
3. 清除浏览器缓存后重试

### Q: 如何同时使用 TUI 和 Web UI?

**A:** 两个界面可以同时使用:
- TUI: http://localhost:4096
- Web UI: http://localhost:4096/webui

它们共享相同的后端，会话是同步的。

### Q: 如何卸载 Web UI?

**A:** 运行卸载脚本:

```bash
./uninstall-webui.sh
```

这会删除所有 Web UI 相关文件，但保留备份。

## 📊 性能优化建议

### 1. 使用 Bun 而不是 npm
Bun 比 npm 快 10-20 倍:

```bash
# 安装 Bun
curl -fsSL https://bun.sh/install | bash

# 使用 Bun 启动
bun run dev
```

### 2. 启用浏览器缓存
Web UI 已经配置了静态资源缓存，确保浏览器缓存未被禁用。

### 3. 减少不必要的重新渲染
Web UI 使用了状态缓存 (`lastRenderedState`)，避免不必要的 DOM 更新。

## 🔄 更新

### 获取最新版本

```bash
cd opencodeR
git pull origin main
./install-webui.sh  # 重新安装
```

### 手动更新

如果只想更新特定文件:

```bash
# 更新样式
cp openresearch/web/static/css/style.css \
   packages/opencode/webui/static/css/

# 更新脚本
cp openresearch/web/static/js/app.js \
   packages/opencode/webui/static/js/

# 更新模板
cp openresearch/web/templates/web/index.html \
   packages/opencode/webui/templates/
```

## 🤝 贡献

欢迎贡献代码和建议！

### 报告问题
在 GitHub 上创建 Issue，请包含:
- 浏览器版本
- 错误信息
- 重现步骤

### 提交改进
1. Fork 这个仓库
2. 创建功能分支: `git checkout -b feature/amazing`
3. 提交更改: `git commit -m 'Add amazing feature'`
4. 推送分支: `git push origin feature/amazing`
5. 创建 Pull Request

## 📄 许可证

与 Claude Code 相同的许可证

## 🙏 致谢

- Claude Code 团队
- marked.js 项目
- 所有贡献者

---

**Happy coding! 🎉**

如有问题，请查看 `WEBUI-README.md` 或创建 Issue。
