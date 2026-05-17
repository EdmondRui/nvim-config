return {
  -- Git 操作
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
      { "<leader>gg", "<CMD>Git<CR>", desc = "Git 状态" },
      { "<leader>gc", "<CMD>Git commit<CR>", desc = "Git 提交" },
      { "<leader>gp", "<CMD>Git push<CR>", desc = "Git 推送" },
      { "<leader>gl", "<CMD>Git log<CR>", desc = "Git 日志" },
    },
  },

  -- Git 变化标记（行号旁显示 +/-/~）
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local map = function(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, lhs, rhs, opts)
          end
          map("n", "<leader>hs", gs.stage_hunk, { desc = "暂存块" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "重置块" })
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "暂存选中块" })
          map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "撤销暂存块" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "预览块" })
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "下一个变更" })
          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "上一个变更" })
        end,
      })
    end,
  },
}
