return {

	-- 主题
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = false,
				integrations = {
					cmp = true,
					gitsigns = true,
					telescope = true,
					which_key = true,
				},
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- 状态栏
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = {
						require("util").pretty_path(),
					},
					lualine_x = {
						{
							"diagnostics",
							symbols = { error = "E:", warn = "W:", info = "I:", hint = "H:" },
						},
					},
					lualine_y = {
						{
							"diff",
							symbols = { added = "+", modified = "~", removed = "-" },
							source = function()
								local status = vim.b.gitsigns_status_dict
								if status then
									return {
										added = status.added,
										modified = status.changed,
										removed = status.removed,
									}
								end
							end,
						},
						"filetype",
					},
					lualine_z = {
						{ "progress" },
						{ "location" },
					},
				},
			})
		end,
	},

}
