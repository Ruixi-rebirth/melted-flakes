require("base")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
if os.getenv("GTK_THEME") == "Nordic" then
	vim.cmd([[colorscheme nord ]])
elseif os.getenv("GTK_THEME") == "Catppuccin-Frappe-Pink" then
	vim.cmd([[colorscheme catppuccin-frappe ]])
else
	vim.cmd([[colorscheme catppuccin-latte ]])
end
