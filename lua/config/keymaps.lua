local map = vim.keymap.set
local function K(desc)
  return { noremap = true, silent = true, desc = desc }
end

-- 保留粘贴板不变
map("x", "p", '"_dP', K("Paste without overriding register"))

-- 更好用的移动（支持软换行）
map("n", "j", "v:count ? 'j' : 'gj'", { expr = true, desc = "Move down" })
map("n", "k", "v:count ? 'k' : 'gk'", { expr = true, desc = "Move up" })

-- 窗口管理
map("n", "<C-h>", "<C-w>h", K("Go to left window"))
map("n", "<C-j>", "<C-w>j", K("Go to lower window"))
map("n", "<C-k>", "<C-w>k", K("Go to upper window"))
map("n", "<C-l>", "<C-w>l", K("Go to right window"))
map("n", "<leader>wv", "<C-w>v", K("Split vertically"))
map("n", "<leader>ws", "<C-w>s", K("Split horizontally"))
map("n", "<leader>wd", "<C-w>c", K("Close window"))

-- buffer 切换
map("n", "<Tab>", ":bnext<CR>", K("Next buffer"))
map("n", "<S-Tab>", ":bprev<CR>", K("Previous buffer"))
map("n", "<leader>bd", ":bdelete<CR>", K("Delete buffer"))

-- 保持 visual mode 下选中的文本
map("v", "J", ":move '>+1<CR>gv-gv", K("Move line down"))
map("v", "K", ":move '<-2<CR>gv-gv", K("Move line up"))

-- 搜索居中
map("n", "n", "nzzzv", K("Next search result"))
map("n", "N", "Nzzzv", K("Previous search result"))
map("n", "*", "*zzzv", K("Search forward for word under cursor"))
map("n", "#", "#zzzv", K("Search backward for word under cursor"))
map("n", "g*", "g*zzzv", K("Search forward (partial match)"))
map("n", "g#", "g#zzzv", K("Search backward (partial match)"))

-- 快速退出终端模式
map("t", "<Esc>", "<C-\\><C-n>", K("Exit terminal mode"))

-- 保存 & 退出
map("n", "<leader>w", ":w<CR>", K("Save file"))
map("n", "<leader>q", ":q<CR>", K("Quit"))
