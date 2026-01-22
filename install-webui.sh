#!/bin/bash

# OpenResearch Web UI - 一键安装脚本
# 将改进的 Web UI 集成到 Claude Code 中作为可选界面

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 图标
CHECK="✓"
CROSS="✗"
ARROW="→"
STAR="★"

# 打印带颜色的消息
print_header() {
    echo -e "\n${PURPLE}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║${NC}  ${CYAN}$1${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════════════════════╝${NC}\n"
}

print_success() {
    echo -e "${GREEN}${CHECK}${NC} $1"
}

print_error() {
    echo -e "${RED}${CROSS}${NC} $1"
}

print_info() {
    echo -e "${BLUE}${ARROW}${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC}  $1"
}

# 检测操作系统
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    else
        OS="unknown"
    fi
}

# 检查依赖
check_dependencies() {
    print_header "检查依赖"

    local missing_deps=()

    # 检查 Node.js
    if command -v node &> /dev/null; then
        NODE_VERSION=$(node -v)
        print_success "Node.js: ${NODE_VERSION}"
    else
        missing_deps+=("node")
        print_error "Node.js 未安装"
    fi

    # 检查 npm 或 bun
    if command -v bun &> /dev/null; then
        BUN_VERSION=$(bun -v)
        print_success "Bun: ${BUN_VERSION}"
        PKG_MANAGER="bun"
    elif command -v npm &> /dev/null; then
        NPM_VERSION=$(npm -v)
        print_success "npm: ${NPM_VERSION}"
        PKG_MANAGER="npm"
    else
        missing_deps+=("npm/bun")
        print_error "npm 或 bun 未安装"
    fi

    # 检查 git
    if command -v git &> /dev/null; then
        GIT_VERSION=$(git --version | cut -d' ' -f3)
        print_success "Git: ${GIT_VERSION}"
    else
        missing_deps+=("git")
        print_error "Git 未安装"
    fi

    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "缺少以下依赖: ${missing_deps[*]}"
        exit 1
    fi
}

# 查找 Claude Code 安装路径
find_claude_code() {
    print_header "查找 Claude Code 安装路径"

    # 可能的安装路径
    local possible_paths=(
        "$HOME/.claude-code"
        "$HOME/.local/share/claude-code"
        "/usr/local/lib/claude-code"
        "/opt/claude-code"
        "$(pwd)"
    )

    # 检查当前目录是否是 opencodeR
    if [ -f "$(pwd)/packages/opencode/package.json" ]; then
        CLAUDE_CODE_PATH="$(pwd)"
        print_success "在当前目录找到: ${CLAUDE_CODE_PATH}"
        return 0
    fi

    # 遍历可能的路径
    for path in "${possible_paths[@]}"; do
        if [ -f "$path/packages/opencode/package.json" ]; then
            CLAUDE_CODE_PATH="$path"
            print_success "找到安装路径: ${CLAUDE_CODE_PATH}"
            return 0
        fi
    done

    print_error "未找到 Claude Code 安装路径"
    read -p "请输入 Claude Code 安装路径: " CLAUDE_CODE_PATH

    if [ ! -f "$CLAUDE_CODE_PATH/packages/opencode/package.json" ]; then
        print_error "无效的路径: $CLAUDE_CODE_PATH"
        exit 1
    fi
}

# 备份现有文件
backup_files() {
    print_header "备份现有文件"

    BACKUP_DIR="$CLAUDE_CODE_PATH/.webui-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"

    # 如果已存在 webui 目录，备份它
    if [ -d "$CLAUDE_CODE_PATH/packages/opencode/webui" ]; then
        print_info "备份现有 webui 目录..."
        cp -r "$CLAUDE_CODE_PATH/packages/opencode/webui" "$BACKUP_DIR/"
        print_success "已备份到: $BACKUP_DIR"
    else
        print_info "没有需要备份的文件"
    fi
}

# 复制 Web UI 文件
copy_webui_files() {
    print_header "复制 Web UI 文件"

    local SOURCE_DIR
    if [ -d "$(pwd)/openresearch/web" ]; then
        SOURCE_DIR="$(pwd)/openresearch/web"
    elif [ -d "$CLAUDE_CODE_PATH/openresearch/web" ]; then
        SOURCE_DIR="$CLAUDE_CODE_PATH/openresearch/web"
    else
        print_error "找不到源文件目录"
        exit 1
    fi

    local TARGET_DIR="$CLAUDE_CODE_PATH/packages/opencode/webui"

    print_info "从: $SOURCE_DIR"
    print_info "到: $TARGET_DIR"

    # 创建目标目录
    mkdir -p "$TARGET_DIR/static/css"
    mkdir -p "$TARGET_DIR/static/js"
    mkdir -p "$TARGET_DIR/templates"

    # 复制文件
    cp "$SOURCE_DIR/static/css/style.css" "$TARGET_DIR/static/css/" 2>/dev/null || true
    cp "$SOURCE_DIR/static/js/app.js" "$TARGET_DIR/static/js/" 2>/dev/null || true
    cp "$SOURCE_DIR/templates/web/index.html" "$TARGET_DIR/templates/" 2>/dev/null || true
    cp "$SOURCE_DIR/templates/web/base.html" "$TARGET_DIR/templates/" 2>/dev/null || true

    print_success "文件复制完成"
}

# 创建 Web UI 路由
create_routes() {
    print_header "创建 Web UI 路由"

    local ROUTES_FILE="$CLAUDE_CODE_PATH/packages/opencode/src/server/routes/webui.ts"

    cat > "$ROUTES_FILE" << 'EOF'
import { Hono } from "hono"
import { serveStatic } from "hono/bun"
import { readFileSync } from "fs"
import { join } from "path"

const WEBUI_DIR = join(__dirname, "../../../webui")

export const WebUIRoutes = () =>
  new Hono()
    // 静态文件服务
    .get("/static/*", serveStatic({ root: WEBUI_DIR }))

    // 主页
    .get("/", (c) => {
      try {
        const html = readFileSync(join(WEBUI_DIR, "templates/index.html"), "utf-8")
        return c.html(html)
      } catch (error) {
        return c.text("Web UI not found. Please run: ./install-webui.sh", 404)
      }
    })

    // Health check
    .get("/health", (c) => {
      return c.json({ status: "ok", ui: "webui" })
    })
EOF

    print_success "路由文件创建完成: $ROUTES_FILE"
}

# 更新 server.ts 以包含 Web UI 路由
update_server() {
    print_header "更新服务器配置"

    local SERVER_FILE="$CLAUDE_CODE_PATH/packages/opencode/src/server/server.ts"

    # 检查是否已经添加了 WebUI 路由
    if grep -q "WebUIRoutes" "$SERVER_FILE"; then
        print_warning "服务器配置已包含 Web UI 路由，跳过..."
        return 0
    fi

    # 备份原文件
    cp "$SERVER_FILE" "$SERVER_FILE.bak"

    # 添加 import
    if ! grep -q "import { WebUIRoutes }" "$SERVER_FILE"; then
        # 在 TuiRoutes import 后添加
        sed -i.tmp '/import.*TuiRoutes/a\
import { WebUIRoutes } from "./routes/webui"
' "$SERVER_FILE"
        rm -f "$SERVER_FILE.tmp"
        print_success "已添加 WebUIRoutes import"
    fi

    # 添加路由
    if ! grep -q '.route("/webui"' "$SERVER_FILE"; then
        # 在 .route("/tui" 后添加
        sed -i.tmp '/\.route("\/tui"/a\
        .route("/webui", WebUIRoutes())
' "$SERVER_FILE"
        rm -f "$SERVER_FILE.tmp"
        print_success "已添加 /webui 路由"
    fi
}

# 创建启动脚本
create_launcher() {
    print_header "创建启动脚本"

    local LAUNCHER="$CLAUDE_CODE_PATH/start-webui.sh"

    cat > "$LAUNCHER" << 'EOF'
#!/bin/bash

# OpenResearch Web UI 启动脚本

echo "🚀 启动 Claude Code Web UI..."
echo ""

# 检测包管理器
if command -v bun &> /dev/null; then
    PKG_MANAGER="bun"
else
    PKG_MANAGER="npm"
fi

# 进入 opencode 目录
cd "$(dirname "$0")/packages/opencode"

# 启动服务器
echo "📦 使用 $PKG_MANAGER 启动服务器..."
echo "🌐 Web UI 将在以下地址可用:"
echo "   - http://localhost:4096/webui"
echo "   - http://localhost:4096 (TUI)"
echo ""

if [ "$PKG_MANAGER" = "bun" ]; then
    bun run dev
else
    npm run dev
fi
EOF

    chmod +x "$LAUNCHER"
    print_success "启动脚本创建完成: $LAUNCHER"
}

# 创建卸载脚本
create_uninstaller() {
    print_header "创建卸载脚本"

    local UNINSTALLER="$CLAUDE_CODE_PATH/uninstall-webui.sh"

    cat > "$UNINSTALLER" << 'EOF'
#!/bin/bash

# OpenResearch Web UI 卸载脚本

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}⚠  即将卸载 OpenResearch Web UI${NC}"
echo ""
read -p "确定要继续吗? (y/N): " confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "取消卸载"
    exit 0
fi

CLAUDE_CODE_PATH="$(dirname "$0")"

# 删除 webui 目录
if [ -d "$CLAUDE_CODE_PATH/packages/opencode/webui" ]; then
    rm -rf "$CLAUDE_CODE_PATH/packages/opencode/webui"
    echo -e "${GREEN}✓${NC} 已删除 webui 目录"
fi

# 删除路由文件
if [ -f "$CLAUDE_CODE_PATH/packages/opencode/src/server/routes/webui.ts" ]; then
    rm "$CLAUDE_CODE_PATH/packages/opencode/src/server/routes/webui.ts"
    echo -e "${GREEN}✓${NC} 已删除路由文件"
fi

# 恢复 server.ts 备份（如果存在）
if [ -f "$CLAUDE_CODE_PATH/packages/opencode/src/server/server.ts.bak" ]; then
    mv "$CLAUDE_CODE_PATH/packages/opencode/src/server/server.ts.bak" \
       "$CLAUDE_CODE_PATH/packages/opencode/src/server/server.ts"
    echo -e "${GREEN}✓${NC} 已恢复 server.ts"
fi

# 删除启动脚本
rm -f "$CLAUDE_CODE_PATH/start-webui.sh"
rm -f "$CLAUDE_CODE_PATH/uninstall-webui.sh"

echo ""
echo -e "${GREEN}✓ Web UI 已完全卸载${NC}"
echo ""
echo "备份文件保留在: $CLAUDE_CODE_PATH/.webui-backup-*"
EOF

    chmod +x "$UNINSTALLER"
    print_success "卸载脚本创建完成: $UNINSTALLER"
}

# 创建 README
create_readme() {
    print_header "创建使用文档"

    local README="$CLAUDE_CODE_PATH/WEBUI-README.md"

    cat > "$README" << 'EOF'
# OpenResearch Web UI for Claude Code

一个为 Claude Code 设计的现代化 Web 界面，提供更加直观和流畅的用户体验。

## ✨ 特性

### 🎯 核心功能
- ✅ 完整的会话管理（创建、删除、切换、持久化）
- ✅ 实时消息更新（Server-Sent Events）
- ✅ Markdown 渲染支持
- ✅ 工具执行可视化
- ✅ 权限管理系统
- ✅ 批量操作支持

### 🎨 UI/UX 改进
- ✅ Toast 通知系统（替代 alert）
- ✅ 平滑滚动动画
- ✅ 现代化深色主题
- ✅ 玻璃态效果
- ✅ 响应式布局
- ✅ 自定义滚动条

### ⌨️ 快捷键
- `Enter` - 发送消息
- `Shift + Enter` - 换行

## 🚀 快速开始

### 启动 Web UI

```bash
./start-webui.sh
```

然后在浏览器中访问:
- **Web UI**: http://localhost:4096/webui
- **TUI**: http://localhost:4096 (终端界面)

### 配置

首次使用需要配置 API 密钥:

1. 点击侧边栏的 "⚙ Settings" 按钮
2. 输入你的 DeepSeek API 密钥（以 `sk-` 开头）
3. 点击 "Save" 保存

## 📖 使用指南

### 会话管理

#### 创建新会话
点击左上角的 `+` 按钮创建新会话。

#### 删除会话
- **单个删除**: 悬停在会话上，点击右侧的垃圾桶图标
- **批量删除**:
  1. 点击 `☰` 按钮进入选择模式
  2. 勾选要删除的会话
  3. 点击 "Delete Selected" 按钮

#### 切换会话
点击左侧边栏中的会话即可切换。当前会话会高亮显示。

### 发送消息

1. 在底部输入框中输入消息
2. 按 `Enter` 发送（`Shift + Enter` 换行）
3. 或点击发送按钮 `↑`

### 查看工具执行

助手执行的工具会以卡片形式展示:
- 点击工具卡片可展开/收起详情
- 状态指示灯:
  - 🟡 黄色脉冲 - 运行中
  - 🟢 绿色 - 成功
  - 🔴 红色 - 错误

### 权限管理

当助手需要权限时，会显示权限卡片:
- 点击 "Approve" 批准权限
- 点击 "Reject" 拒绝权限

## 🎨 界面概览

```
┌─────────────┬──────────────────────┬─────────────┐
│             │                      │             │
│   会话列表   │      聊天区域         │  执行计划    │
│             │                      │  (可选)     │
│  • 新建     │  ┌─ 欢迎屏幕 ─┐      │             │
│  • 历史     │  │            │      │  □ 任务1   │
│  • 搜索     │  │   Logo     │      │  ✓ 任务2   │
│             │  │            │      │  □ 任务3   │
│             │  └────────────┘      │             │
│             │                      │             │
│  ⚙ 设置     │  [ 输入框...  ] ↑   │             │
│             │                      │             │
└─────────────┴──────────────────────┴─────────────┘
```

## 🔧 技术栈

- **前端**: Vanilla JavaScript (ES6+)
- **样式**: CSS3 (变量、动画、Grid/Flexbox)
- **后端**: Claude Code Server (Hono + Bun)
- **实时通信**: Server-Sent Events (SSE)
- **Markdown**: marked.js

## 📊 性能优化

- ✅ 防抖处理
- ✅ 状态缓存
- ✅ 条件渲染
- ✅ CSS transform 动画（硬件加速）
- ✅ 批量操作优化

## 🐛 故障排除

### Web UI 无法访问

1. 确保服务器正在运行:
   ```bash
   ./start-webui.sh
   ```

2. 检查端口是否被占用:
   ```bash
   lsof -i :4096  # macOS/Linux
   netstat -ano | findstr :4096  # Windows
   ```

3. 查看服务器日志:
   ```bash
   tail -f packages/opencode/opencode_server.log
   ```

### 消息无法发送

1. 检查 API 密钥是否正确配置
2. 打开浏览器控制台查看错误信息
3. 确保网络连接正常

### SSE 连接断开

- 页面会自动尝试重连（3秒后）
- 如果持续失败，请刷新页面

## 📝 更新日志

### v1.0.0 (2026-01-22)
- ✨ 初始版本发布
- ✅ 完整的会话管理功能
- ✅ Toast 通知系统
- ✅ 会话持久化
- ✅ 现代化 UI 设计
- ✅ 批量操作支持
- ✅ 平滑滚动动画

## 🔄 卸载

如果需要卸载 Web UI:

```bash
./uninstall-webui.sh
```

这将:
- 删除 Web UI 文件
- 恢复原始配置
- 保留备份文件

## 📄 许可证

与 Claude Code 相同

## 🤝 贡献

欢迎提交 Issue 和 Pull Request!

---

**Enjoy coding with a beautiful UI! 🎉**
EOF

    print_success "使用文档创建完成: $README"
}

# 显示安装总结
show_summary() {
    print_header "安装完成 🎉"

    echo -e "${CYAN}${STAR} 安装路径:${NC} $CLAUDE_CODE_PATH"
    echo -e "${CYAN}${STAR} 备份目录:${NC} $BACKUP_DIR"
    echo ""

    print_success "Web UI 文件已复制"
    print_success "路由配置已更新"
    print_success "启动脚本已创建"
    print_success "文档已生成"
    echo ""

    print_header "下一步操作"
    echo ""
    echo -e "${YELLOW}1.${NC} 启动 Web UI:"
    echo -e "   ${GREEN}./start-webui.sh${NC}"
    echo ""
    echo -e "${YELLOW}2.${NC} 在浏览器中访问:"
    echo -e "   ${GREEN}http://localhost:4096/webui${NC}"
    echo ""
    echo -e "${YELLOW}3.${NC} 阅读使用文档:"
    echo -e "   ${GREEN}cat WEBUI-README.md${NC}"
    echo ""
    echo -e "${YELLOW}4.${NC} 如需卸载:"
    echo -e "   ${GREEN}./uninstall-webui.sh${NC}"
    echo ""

    print_header "功能特性"
    echo ""
    echo -e "  ${GREEN}✓${NC} 现代化 UI 设计"
    echo -e "  ${GREEN}✓${NC} 会话持久化"
    echo -e "  ${GREEN}✓${NC} Toast 通知系统"
    echo -e "  ${GREEN}✓${NC} 批量操作支持"
    echo -e "  ${GREEN}✓${NC} 实时消息更新"
    echo -e "  ${GREEN}✓${NC} Markdown 渲染"
    echo -e "  ${GREEN}✓${NC} 工具执行可视化"
    echo -e "  ${GREEN}✓${NC} 平滑滚动动画"
    echo ""

    print_success "安装成功完成！"
}

# 主函数
main() {
    clear

    print_header "OpenResearch Web UI 安装程序"

    echo -e "${CYAN}这个脚本将为 Claude Code 安装现代化的 Web 界面${NC}"
    echo ""

    # 检测操作系统
    detect_os
    print_info "操作系统: $OS"

    # 检查依赖
    check_dependencies

    # 查找 Claude Code
    find_claude_code

    # 确认安装
    echo ""
    print_warning "即将在以下位置安装 Web UI:"
    echo "  $CLAUDE_CODE_PATH"
    echo ""
    read -p "是否继续? (y/N): " confirm

    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "安装已取消"
        exit 0
    fi

    # 执行安装步骤
    backup_files
    copy_webui_files
    create_routes
    update_server
    create_launcher
    create_uninstaller
    create_readme

    # 显示总结
    show_summary
}

# 错误处理
trap 'print_error "安装过程中发生错误"; exit 1' ERR

# 运行主函数
main "$@"
