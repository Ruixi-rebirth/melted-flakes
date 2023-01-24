return {
	"glepnir/lspsaga.nvim",
	event = "BufRead",
	config = function()
		require("lspsaga").setup({})
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
