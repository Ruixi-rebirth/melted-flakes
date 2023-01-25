return {
	"glepnir/lspsaga.nvim",
	event = "BufRead",
	config = function()
		local colors, kind
		if os.getenv("GTK_THEME") == "Catppuccin-Frappe-Pink" or os.getenv("GTK_THEME") == "Catppuccin-Latte-Green" then
			colors = require("catppuccin.groups.integrations.lsp_saga").custom_colors()
			kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind()
		end
		require("lspsaga").setup({
			ui = {
				colors = colors,
				kind = kind,
			},
		})
		--Switch theme again after lspsaga loaded from
		if os.getenv("GTK_THEME") == "Nordic" then
			vim.cmd([[ colorscheme nord ]])
		end
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
