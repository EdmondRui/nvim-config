return {
  -- Mason: LSP / DAP / Linter / Formatter 的包管理器
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- LSP 客户端配置 (vim.lsp.config API)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local function k(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
        end
        k("gd", vim.lsp.buf.definition, "Go to definition")
        k("K", vim.lsp.buf.hover, "Hover documentation")
        k("gi", vim.lsp.buf.implementation, "Go to implementation")
        k("<leader>rn", vim.lsp.buf.rename, "Rename")
        k("<leader>ca", vim.lsp.buf.code_action, "Code action")
        k("gr", vim.lsp.buf.references, "Find references")
        k("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
        k("]d", vim.diagnostic.goto_next, "Next diagnostic")
        k("<leader>d", vim.diagnostic.open_float, "Line diagnostics")
      end

      -- Lua 特殊配置
      vim.lsp.config.lua_ls = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }

      vim.lsp.config.gopls = {
        capabilities = capabilities,
        on_attach = on_attach,
      }

      vim.lsp.config.rust_analyzer = {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      }

      -- 启用所有支持的 LSP server
      local servers = { "lua_ls", "pyright", "rust_analyzer", "ts_ls", "gopls" }
      for _, server in ipairs(servers) do
        vim.lsp.enable(server)
      end

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },

  -- mason-lspconfig: 自动安装 LSP servers
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "lua_ls", "pyright", "rust_analyzer", "ts_ls", "gopls", "tailwindcss", "prettierd",
      },
      automatic_installation = false,
    },
  },

  -- 代码格式化
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "isort", "black" },
          javascript = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          go = { "gofmt", "goimports" },
          rust = { "rustfmt" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
      vim.keymap.set("n", "<leader>f", function()
        require("conform").format({ lsp_fallback = true })
      end, { desc = "格式化代码" })
    end,
  },
}
