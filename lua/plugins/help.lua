return {

	-- Which-key: 帮助你记住快捷键
	{
		"folke/which-key.nvim",
		config = function()
			local wk = require("which-key")
			wk.setup({})
			wk.add({
				{ "<leader>g", group = "git" },
				{ "<leader>gh", group = "hunks" },
			})
		end,
	},

}
