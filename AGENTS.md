# AGENTS.md

适用于 `/Users/moon/.config/moonvim` 这个 Neovim 配置目录。

## 基本约定

- 永远使用中文回答，技术名词可以保留英文。
- 这是通过 `NVIM_APPNAME=moonvim` 验证的独立 Neovim 配置，不要默认它等同于 `~/.config/nvim`。
- 不要随意删除、重置或覆盖用户已有改动。
- 需要在 bash 里表达 `rm` 时，优先用 `trash` 替代。
- 只在必要时改动文档；不要为了“看起来整齐”去重排大量无关内容。

## 目录结构

- `init.lua` 是唯一入口，负责：
  - 自动引导 `lazy.nvim`
  - 设置 `mapleader`
  - 加载 `config.*` 与 `plugins.*`
- `lua/config/options.lua` 放全局选项和基础自动命令。
- `lua/config/keymaps.lua` 放通用快捷键。
- `lua/config/autocmds.lua` 放通用自动命令。
- `lua/plugins/*.lua` 按功能拆分插件声明。
- `lua/util.lua` 放共享工具函数，当前主要给 `lualine` 和路径处理使用。

## 当前技术栈

- 插件管理器是 `lazy.nvim`，入口会在缺失时自动克隆。
- 主题是 `catppuccin`，当前配置使用 `mocha`。
- 版本策略是跟随插件仓库最新提交，不手动固定插件版本。
- `lazy.nvim` 的 lockfile 位置已改到 `stdpath("state")`，仓库根目录不保留 `lazy-lock.json`。
- 核心插件包括：
  - `telescope.nvim`
  - `nvim-treesitter`
  - `nvim-cmp`
  - `oil.nvim`
  - `gitsigns.nvim`
  - `lualine.nvim`
  - `which-key.nvim`
  - `Comment.nvim`
  - `lazygit.nvim`
- 当前没有独立的 LSP 配置文件，也没有 `mason.nvim`、`nvim-lspconfig`、`conform.nvim`。
- `README.md` 可能滞后，修改前以 `init.lua` 和 `lua/` 目录下的实现为准。

## 模块约定

### `init.lua`

- 保持入口短小，只做引导和加载。
- 新逻辑优先放到 `lua/config/` 或 `lua/plugins/`。
- 不要把插件配置、复杂工具函数、业务逻辑继续堆进入口文件。

### `lua/config/options.lua`

- 只放影响全局体验的编辑器选项。
- 文件类型差异化设置优先通过 `FileType` autocmd 实现。
- 只在确实需要时修改默认值，避免和插件默认行为冲突。

### `lua/config/keymaps.lua`

- 只放稳定、全局、和模式无关的快捷键。
- 约定上：
  - `<Space>` 是 leader
  - `<leader>f*` 偏搜索
  - `<leader>g*` 偏 Git
  - `<leader>w*` 偏窗口
- 已有占用键位时，优先调整功能归属，不要硬叠多个语义。

### `lua/config/autocmds.lua`

- 只放跨文件类型、跨插件的通用自动命令。
- 适合放：
  - 打开文件后回到上次光标
  - 保存前自动建目录
  - yank 高亮
- 文件类型专属逻辑不要放这里，优先放到对应插件或 options 文件。

### `lua/plugins/*.lua`

- 一个文件按功能分组，不要把所有插件混在一个文件里。
- 现有拆分方式：
  - `editor.lua`：搜索、Treesitter、补全、文件树
  - `ui.lua`：主题、状态栏、提示类 UI
  - `git.lua`：Git 相关
  - `help.lua`：快捷键提示
- 新增插件时优先遵循这个分层。
- 如果一个插件的配置明显变复杂，可以单独拆出新文件。

### `lua/util.lua`

- 只放无副作用、可复用的纯工具函数。
- 这里的函数被状态栏等核心 UI 直接依赖，改动要保守。
- 如果新增函数，先判断它是不是应该留在这里，还是更适合放到单独模块。

## 键位规范

- 已经使用的高频区：
  - `<C-h/j/k/l>`：窗口切换
  - `<Tab>` / `<S-Tab>`：buffer 切换
  - `<leader>ff/fg/fb/fh/f.`：Telescope
  - `<leader>gg/gc/gl/gf/gS/gs`：Git
  - `<leader>gh*`：hunk 操作
  - `<leader>e`：Oil
  - `<leader>w*`：窗口/保存相关
- 改键前先检查：
  - 是否和 `cmp` 的插入模式键位冲突
  - 是否和 `gitsigns` 的 hunk 操作冲突
  - 是否和 `which-key` 的分组语义冲突
- 如果一个键位有多个候选语义，优先保留最常用、最稳定的那个。

## 插件改动规则

- 新增插件：
  - 优先选择和现有目录结构一致的文件
  - 尽量使用 `lazy.nvim` 的标准声明格式
  - 能懒加载就懒加载，不能懒加载再明确 `lazy = false`
- 不要重新引入仓库根目录的 `lazy-lock.json`。
- 修改已有插件：
  - 尽量保持原有行为
  - 先确认是否会影响相关快捷键
  - 注意插件默认值和本地显式配置的覆盖关系
- 删除插件：
  - 先确认是否有键位、自动命令或 `util.lua` 里的依赖
  - 再检查 `README.md` 是否需要同步

## 这套配置的已知边界

- 没有完整 LSP 栈，不能默认存在 `LspAttach`、`mason`、`lspconfig`、`conform`。
- `telescope` 的 Git 命令当前只覆盖了部分场景，某些映射可能复用同一个 builtin。
- `gitsigns` 和 `lualine` 有直接耦合，改 Git 相关逻辑时要检查状态栏是否还正常。
- `oil.nvim` 当前被设为默认文件浏览器，别再默认依赖传统 netrw 行为。

## 修改前检查

- 确认目标文件是不是当前职责内的最小改动范围。
- 检查有没有更合适的既有模块可以复用。
- 先读相关文件，再改，不要只改表面映射。
- 如果会影响多个文件，先确定改动顺序，避免来回覆盖。

## 修改后检查

- 用 `NVIM_APPNAME=moonvim nvim` 启动确认能正常进入。
- 修改插件后，检查 `:Lazy` 是否可用，至少确认能打开界面。
- 修改快捷键后，人工确认：
  - 文件搜索
  - 窗口切换
  - Git
  - Oil
  - 补全
  - 注释
- 修改 `lua/util.lua` 后，确认 `lualine` 仍能正常显示路径。
- 如果改了文档或注释，确认没有和实现冲突。

## 重点文件

- `init.lua`
- `lua/config/options.lua`
- `lua/config/keymaps.lua`
- `lua/config/autocmds.lua`
- `lua/plugins/editor.lua`
- `lua/plugins/ui.lua`
- `lua/plugins/git.lua`
- `lua/plugins/help.lua`
- `lua/util.lua`

## 建议的维护顺序

1. 先判断是配置、插件还是工具函数的问题。
2. 再定位对应文件。
3. 最后再动映射或 UI 细节。
