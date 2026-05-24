return {
  -- 模糊搜索 (替代 CtrlP / fzf)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    cmd = "Telescope",
    keys = {
      { "<leader>ff", desc = "Find Files" },
      { "<leader>fg", desc = "Live Grep" },
      { "<leader>fb", desc = "Buffers" },
      { "<leader>fh", desc = "Help Tags" },
      { "<leader>f.", desc = "Recent Files" },
      { "<leader>gc", desc = "Git Commits" },
      { "<leader>gs", desc = "Git Status" },
      { "<leader>gS", desc = "Git Stash" },
      { "<leader>gl", desc = "Git Log" },
      { "<leader>gf", desc = "Git File History" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "target/", ".git/" },
        },
      })
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
      vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "Recent Files" })
      vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git Commits" })
      vim.keymap.set("n", "<leader>gl", builtin.git_commits, { desc = "Git Log" })
      vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })
      vim.keymap.set("n", "<leader>gS", builtin.git_stash, { desc = "Git Stash" })
      vim.keymap.set("n", "<leader>gf", builtin.git_bcommits, { desc = "Git File History" })
    end,
  },

  -- Tree-sitter: 更好的语法高亮和代码分析
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false, -- nvim-treesitter(main) rewrite: explicitly does not support lazy-loading
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "query",
          "python", "go", "rust",
          "typescript", "javascript", "java",
          "html", "css", "json", "yaml", "toml",
          "bash", "markdown",
        },
        install_dir = vim.fn.stdpath("data") .. "/site",
      })
    end,
  },

  -- 注释插件
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- 代码补全
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- 文件树 (Oil: 像编辑文件一样编辑目录)
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        view_options = { show_hidden = true },
      })
      vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "打开文件树" })
    end,
  },
}
