return {
  -- lazygit
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Lazygit (root dir)" },
      { "<leader>gG", "<cmd>LazyGit<cr>", desc = "Lazygit (cwd)" },
    },
    config = function()
      require("lazygit").setup({})
    end,
  },

  -- Git 变化标记（行号旁显示 +/-/~）
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▃" },
        topdelete = { text = "▃" },
        changedelete = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▃" },
        topdelete = { text = "▃" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- hunk 导航
        map("n", "]h", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Next Hunk" })
        map("n", "[h", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Prev Hunk" })
        map("n", "]H", function() gs.nav_hunk("last") end, { desc = "Last Hunk" })
        map("n", "[H", function() gs.nav_hunk("first") end, { desc = "First Hunk" })

        -- hunk 操作
        map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
        map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
        map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>ghp", gs.preview_hunk_inline, { desc = "Preview Hunk Inline" })
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
        map("n", "<leader>ghB", function() gs.blame() end, { desc = "Blame Buffer" })
        map("n", "<leader>ghd", gs.diffthis, { desc = "Diff This" })
        map("n", "<leader>ghD", function() gs.diffthis("~") end, { desc = "Diff This ~" })
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk" })
      end,
    },
  },

  -- gitsigns 开关
  {
    "lewis6991/gitsigns.nvim",
    keys = {
      {
        "<leader>uG",
        function()
          local cfg = require("gitsigns.config").config
          require("gitsigns").toggle_signs(not cfg.signcolumn)
        end,
        desc = "Toggle Git Signs",
      },
    },
  },
}
