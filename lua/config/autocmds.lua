local general = vim.api.nvim_create_augroup("General", { clear = true })

-- 回到上次关闭时的光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
  group = general,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- 自动创建不存在的目录
vim.api.nvim_create_autocmd("BufWritePre", {
  group = general,
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- 高亮 yank 的内容
vim.api.nvim_create_autocmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

