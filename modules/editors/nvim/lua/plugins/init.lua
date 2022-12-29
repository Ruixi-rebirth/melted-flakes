local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()
----autocommand that reload neovim whenever you save the init.lua
--vim.cmd([[
--  augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost init.lua source <afile> | PackerCompile
--  augroup end
--]])
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end
-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return require("packer").startup(function(use)
	--------------------
	-- Add Plug Start --
	--------------------
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- startup time show --
	use({
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	})
	--[ colorscheme ]--
	--use("shaunsingh/nord.nvim")
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
			require("catppuccin").setup()
			vim.api.nvim_command("colorscheme catppuccin")
		end,
	})
	--[ icon ]--
	use({ "kyazdani42/nvim-web-devicons" })
	-- mprove startup time for Neovim --
	use({
		"lewis6991/impatient.nvim",
		config = "require('plugins.configs.impatient')",
	})
	--[ statusline ]--
	use({
		"nvim-lualine/lualine.nvim",
		config = "require('plugins.configs.lualine')",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		event = "BufWinEnter",
	})
	--[ bufferline ]--
	use({
		"akinsho/bufferline.nvim",
		config = "require('plugins.configs.bufferline')",
		requires = "kyazdani42/nvim-web-devicons",
	})
	--[ cmp && lsp ]--
	use({ "rafamadriz/friendly-snippets", event = "InsertEnter" })
	use({ "hrsh7th/nvim-cmp", config = "require('plugins.configs.cmp')", after = "friendly-snippets" })
	use({ "L3MON4D3/LuaSnip", after = "nvim-cmp" })
	use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" })
	use({ "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" })
	use({ "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-buffer", after = "cmp-nvim-lua" })
	use({ "hrsh7th/cmp-path", after = "cmp-buffer" })
	use({ "hrsh7th/cmp-cmdline", after = "cmp-path" })
	use({ "neovim/nvim-lspconfig" })
	-- use({ "simrat39/rust-tools.nvim", config = "require('plugins.configs.rust-tools')" })
	-- use({ "williamboman/nvim-lsp-installer" })
	use({ "glepnir/lspsaga.nvim", config = "require('plugins.configs.lspsaga')", branch = "main" })
	--[ debug ]--
	use({
		"rcarriga/nvim-dap-ui",
		requires = { "mfussenegger/nvim-dap" },
		config = "require('plugins.configs.dapui')",
	})
	use({
		"leoluz/nvim-dap-go",
		ft = { "go" },
		config = function()
			require("dap-go").setup()
		end,
	})
	--[ format code ]--
	use({ "jose-elias-alvarez/null-ls.nvim" })
	--[ A super powerful autopair plugin for Neovim that supports multiple characters. ]--
	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = "require('plugins.configs.autopairs')",
		after = "nvim-cmp",
	})
	use({
		"gentoo/gentoo-syntax",
		ft = { "ebuild" },
	})
	--[  Smart and Powerful commenting plugin for neovim ]--
	use({
		"numToStr/Comment.nvim",
		config = "require('plugins.configs.comment')",
		event = "BufReadPost",
	})
	-- For example, Vue files can have many different sections, each of which can have a different style for comments --
	use("JoosepAlviste/nvim-ts-context-commentstring")
	--[ File explorer ]--
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		config = "require('plugins.configs.nvim-tree')",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icon
		},
	})
	--[ An implementation of the Popup API from vim in Neovim ]--
	use({
		"nvim-lua/popup.nvim",
	})
	--[ Indent Blankline ]--
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = "require('plugins.configs.indent-blankline')",
	})
	--[ Neovim Treesitter configurations and abstraction layer ]--
	use({
		"nvim-treesitter/nvim-treesitter",
		config = "require('plugins.configs.treesitter')",
		run = ":TSUpdate",
		event = "BufRead",
	})
	use({
		"p00f/nvim-ts-rainbow",
	})
	--[ Surround.vim is all about "surroundings": parentheses, brackets, quotes, XML tags, and more. The plugin provides mappings to easily delete, change and add such surroundings in pairs.It's easiest to explain with examples. Press cs"' inside ]--
	use({
		"tpope/vim-surround",
		event = "BufReadPost",
	})
	--[ History modification record ]--
	use({
		"mbbill/undotree",
		event = "InsertEnter",
	})
	--[ Markdown preview ]--
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})
	--[ A fast and lua alternative to filetype.vim. It is ~175x faster than filetype.vim ]--
	-- use({ "nathom/filetype.nvim" })
	--[ A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.]--
	use({
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})
	-- Super fast git decorations implemented purely in lua/teal --
	use({
		"lewis6991/gitsigns.nvim",
		config = "require('plugins.configs.gitsigns')",
		event = "BufRead",
	})
	-- Git diff view
	use({
		"sindrets/diffview.nvim",
		config = "require('plugins.configs.diffview')",
		requires = "nvim-lua/plenary.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewRefresh",
			"DiffviewFocusFiles",
			"DiffviewToggleFiles",
			"DiffviewFileHistory",
		},
	})
	--[ highly extendable fuzzy finder over lists]--
	use({
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		requires = "nvim-telescope/telescope-media-files.nvim",
		config = "require('plugins.configs.telescope')",
	})
	-- Plugin for calling lazygit from within neovim
	use({ "kdheepak/lazygit.nvim", cmd = "LazyGit" })
	--A neovim plugin to persist and toggle multiple terminals during an editing session--
	use({
		"akinsho/toggleterm.nvim",
		-- cmd = "ToggleTerm",
		config = "require('plugins.configs.toggleterm')",
	})
	-- use({
	-- 	"kristijanhusak/vim-dadbod-ui",
	-- 	config = "require('plugins.configs.vim-dadbod')",
	-- 	cmd = { "DBUI" },
	-- 	required = { "tpope/vim-dadbod" },
	-- })
	------------------
	-- Add Plug End --
	------------------
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
