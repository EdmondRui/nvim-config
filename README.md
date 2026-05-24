# moonvim

这是一个通过 `NVIM_APPNAME=moonvim` 运行的独立 Neovim 配置。

## 结构

```text
init.lua
lua/
  config/
    options.lua
    keymaps.lua
    autocmds.lua
  plugins/
    editor.lua
    treesitter.lua
    ui.lua
    git.lua
    help.lua
  util.lua
```

## 核心特性

- `lazy.nvim` 自动引导
- `catppuccin` 主题，当前使用 `mocha`
- `telescope.nvim` 文件与内容搜索
- `nvim-treesitter` 语法解析，使用 `main` 分支的新 API
- `nvim-cmp` + `LuaSnip` 补全
- `oil.nvim` 文件管理
- `gitsigns.nvim` Git 变更标记
- `lualine.nvim` 状态栏
- `which-key.nvim` 快捷键提示
- `Comment.nvim` 注释切换
- `lazygit.nvim` Git UI

## 主要快捷键

### 通用

- `<Space>`: leader
- `<Space>w`: 保存
- `<Space>q`: 退出当前窗口
- `<Space>bd`: 关闭 buffer
- `<Tab>` / `<S-Tab>`: 切换 buffer

### 窗口

- `<C-h/j/k/l>`: 切换窗口
- `<Space>wv`: 垂直分屏
- `<Space>ws`: 水平分屏
- `<Space>wd`: 关闭窗口

### 搜索

- `<Space>ff`: 查找文件
- `<Space>fg`: 全文搜索
- `<Space>fb`: buffer 列表
- `<Space>fh`: 帮助标签
- `<Space>f.`: 最近文件

### Git

- `<Space>gg`: LazyGit
- `<Space>gc`: Git commits
- `<Space>gs`: Git status
- `<Space>gS`: Git stash
- `<Space>gl`: Git log
- `<Space>gf`: 当前文件历史
- `<Space>gh*`: gitsigns hunk 操作

### 其他

- `<Space>e`: 打开 Oil
- `gcc` / `gbc`: 注释切换

## 选项

- 2 空格缩进
- 行号和相对行号
- 关闭 swapfile 和 backup
- 开启 undofile
- go / rust / java 使用 4 空格缩进

## 启动

```bash
NVIM_APPNAME=moonvim nvim
```

首次启动时会自动拉取 `lazy.nvim`，然后安装插件。

更新插件和 Treesitter parser：

```vim
:Lazy sync
:TSUpdate
```

## 版本策略

- 默认跟随插件仓库最新提交，不手动固定插件版本
- `lazy.nvim` 的 lockfile 位置已改到 `stdpath("state")`
- 仓库根目录不再保留 `lazy-lock.json`
