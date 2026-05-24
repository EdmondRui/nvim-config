# Neovim 最佳实践配置指南

## 文件结构

```
~/.config/nvim/
├── init.lua                  # 入口
└── lua/
    ├── config/
    │   ├── options.lua       # 全局设置
    │   ├── keymaps.lua       # 快捷键
    │   └── autocmds.lua      # 自动命令
    └── plugins/
        ├── core.lua          # 主题、状态栏、which-key
        ├── editor.lua        # Telescope, Treesitter, nvim-cmp, Oil
        ├── lsp.lua           # Mason + lspconfig + conform
        └── git.lua           # fugitive + gitsigns
```

## 安装方法

### 首次使用

1. 确保已安装 Neovim >= 0.9
2. 将配置放到 `~/.config/nvim/`
3. 打开 Neovim，lazy.nvim 和所有插件会自动安装
4. 重启 Neovim 即可正常使用

### 手动安装插件

```vim
:Lazy
```

按 `I` 安装所有插件，按 `U` 更新插件。

## 核心插件

| 插件 | 说明 |
|------|------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | 插件管理器，支持懒加载 |
| [catppuccin](https://github.com/catppuccin/nvim) | 主题（mocha 口味） |
| [lualine](https://github.com/nvim-lualine/lualine.nvim) | 状态栏 |
| [which-key](https://github.com/folke/which-key.nvim) | 快捷键提示 |
| [telescope](https://github.com/nvim-telescope/telescope.nvim) | 模糊搜索 |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | 语法高亮与分析 |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | 代码补全 |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | 代码片段 |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | 文件树（类编辑器） |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP 安装管理器 |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP 客户端配置 |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | 格式化 |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | 智能注释 |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git 操作 |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git 行内标记 |

## 快捷键一览

### 通用

| 按键 | 功能 |
|------|------|
| `<Space>` | Leader 键 |
| `<Space>w` | 保存文件 |
| `<Space>q` | 关闭当前窗口 |
| `<Space>bd` | 关闭当前 Buffer |
| `<Tab>` / `<S-Tab>` | 切换 Buffer |

### 窗口管理

| 按键 | 功能 |
|------|------|
| `<C-h/j/k/l>` | 切换到左/下/上/右窗口 |
| `<Space>wv` | 垂直分割 |
| `<Space>ws` | 水平分割 |
| `<Space>wd` | 关闭当前窗口 |

### 文件搜索（Telescope）

| 按键 | 功能 |
|------|------|
| `<Space>ff` | 搜索文件 |
| `<Space>fg` | 全文搜索（grep，需要ripgrep支持） |
| `<Space>fb` | 切换 Buffer |
| `<Space>fh` | 搜索帮助文档 |
| `<Space>f.` | 最近打开的文件 |

### LSP

| 按键 | 功能 |
|------|------|
| `gd` | 跳转到定义 |
| `gi` | 跳转到实现 |
| `gr` | 查看引用 |
| `K` | 悬浮显示文档 |
| `<Space>rn` | 重命名 |
| `<Space>ca` | Code Action |
| `<Space>d` | 显示诊断信息 |
| `[d` / `]d` | 上一个/下一个诊断 |
| `<Space>f` | 格式化代码 |

### 文件树（Oil）

| 按键 | 功能 |
|------|------|
| `<Space>e` | 打开文件树 |

### Git

| 按键 | 功能 |
|------|------|
| `<Space>gg` | Git 状态 |
| `<Space>gc` | Git 提交 |
| `<Space>gp` | Git 推送 |
| `<Space>gl` | Git 日志 |
| `<Space>hs` | 暂存当前块 |
| `<Space>hr` | 重置当前块 |
| `<Space>hp` | 预览当前块 |
| `]c` / `[c` | 下一个/上一个变更 |

### 注释

| 按键 | 功能 |
|------|------|
| `gcc` | 注释/取消注释当前行 |
| `gbc` | 注释/取消注释选中块 |

### 补全

| 按键 | 功能 |
|------|------|
| `<C-Space>` | 手动触发补全 |
| `<C-b>` / `<C-f>` | 滚动文档 |
| `<C-e>` | 取消补全 |
| `<Tab>` | 选择下一项 |

## 全局设置

| 设置 | 值 | 说明 |
|------|-----|------|
| `tabstop` | 2 | 缩进宽度 |
| `shiftwidth` | 2 | 缩进宽度 |
| `expandtab` | true | 用空格代替 Tab |
| `number` + `relativenumber` | true | 混合行号 |
| `scrolloff` | 8 | 光标上下留白 |
| `undofile` | true | 持久化撤销历史 |
| `swapfile` / `backup` | false | 关闭交换/备份文件 |

Go/Rust 文件自动使用 4 空格缩进。

## 自动命令

| 触发时机 | 行为 |
|----------|------|
| 打开文件 | 回到上次关闭时的光标位置 |
| 保存文件 | 自动创建不存在的目录 |
| TextYankPost | 高亮被复制的文本（200ms） |
| FileType go/rust | 自动切换 4 空格缩进 |

## 预装 LSP / 格式化工具

**LSP 服务器：** lua_ls, pyright, gopls, rust_analyzer, ts_ls
**格式化工具：** stylua, black, isort, prettier, gofmt, goimports, rustfmt

可通过 Mason 安装更多：`:Mason`

## 常见操作

| 需求 | 操作 |
|------|------|
| 安装新插件 | 在 `lua/plugins/` 下添加文件，重启后自动安装 |
| 更新所有插件 | `:Lazy update` |
| 查看快捷键 | `:WhichKey` |
| 安装新 LSP | `:Mason` 搜索并安装 |
| 查看 LSP 信息 | `:LspInfo` |
| 搜索帮助 | `<Space>fh` |
