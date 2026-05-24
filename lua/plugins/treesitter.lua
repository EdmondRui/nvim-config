return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		opts = {
			install_dir = vim.fn.stdpath("data") .. "/site",
			ensure_install = {
				"bash",
				"css",
				"go",
				"html",
				"java",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"rust",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
		},
		config = function(_, opts)
			local treesitter = require("nvim-treesitter")
			treesitter.setup(opts)
			treesitter.install(opts.ensure_install)

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("moonvim_treesitter", { clear = true }),
				callback = function(args)
					local ok, parser = pcall(vim.treesitter.get_parser, args.buf)
					if not ok or not parser then
						return
					end

					vim.treesitter.start(args.buf)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				end,
			})
		end,
	},
}
