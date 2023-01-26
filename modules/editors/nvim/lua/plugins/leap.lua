return {
	"ggandor/leap.nvim",
	config = function()
		local keymap = vim.keymap
		local leap = require("leap")
		leap.add_default_mappings()
		local options = {
			max_phase_one_targets = nil,
			highlight_unlabeled_phase_one_targets = false,
			max_highlighted_traversal_targets = 10,
			case_sensitive = true,
			equivalence_classes = { " \t\r\n" },
			substitute_chars = { ["\r"] = "¬" },
			--[[ safe_labels = { "s", "f", "n", "u", "t" }, ]]
			--[[ labels = { "s", "f", "n", "j", "k" }, ]]
			special_keys = {
				repeat_search = "<enter>",
				next_phase_one_target = "<enter>",
				next_target = { "<enter>", ";" },
				prev_target = { "<s-enter>", "," },
				next_group = "<tab>",
				prev_group = "<s-tab>",
				multi_accept = "<enter>",
				multi_revert = "<backspace>",
			},
		}
		for k, v in pairs(options) do
			leap.opts[k] = v
		end
		keymap.set({ "n", "x", "o" }, "/", "<Plug>(leap-forward-to)")
		keymap.set({ "n", "x", "o" }, "?", "<Plug>(leap-backward-to)")
	end,
}
