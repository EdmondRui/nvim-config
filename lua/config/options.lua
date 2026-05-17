local opt = vim.opt

opt.mouse = "a"
opt.encoding = "utf-8"

opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

opt.wrap = false
opt.breakindent = true

opt.ignorecase = true
opt.smartcase = true

opt.hlsearch = true
opt.incsearch = true

opt.termguicolors = true
opt.background = "dark"

opt.updatetime = 50
opt.timeoutlen = 300

opt.splitright = true
opt.splitbelow = true

opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.signcolumn = "yes"
opt.confirm = true

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.completeopt = "menu,menuone,noselect"

opt.shortmess:append({ c = true })

-- 不同文件类型的宽度设置
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "rust" },
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
  end,
})
