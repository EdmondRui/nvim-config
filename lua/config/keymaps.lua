local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 保留粘贴板不变
map("x", "p", '"_dP', opts)

-- 更好用的移动
map("n", "j", "v:count ? 'j' : 'gj'", { expr = true, noremap = true })
map("n", "k", "v:count ? 'k' : 'gk'", { expr = true, noremap = true })

-- 窗口管理
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<leader>wv", "<C-w>v", opts)
map("n", "<leader>ws", "<C-w>s", opts)
map("n", "<leader>wd", "<C-w>c", opts)

-- buffer 切换
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprev<CR>", opts)
map("n", "<leader>bd", ":bdelete<CR>", opts)

-- 保持 visual mode 下选中的文本
map("v", "J", ":move '>+1<CR>gv-gv", opts)
map("v", "K", ":move '<-2<CR>gv-gv", opts)

-- 最佳实践：不覆盖粘贴板
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "*", "*zzzv", opts)
map("n", "#", "#zzzv", opts)
map("n", "g*", "g*zzzv", opts)
map("n", "g#", "g#zzzv", opts)

-- 快速退出终端模式
map("t", "<Esc>", "<C-\\><C-n>", opts)

-- 保存
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
