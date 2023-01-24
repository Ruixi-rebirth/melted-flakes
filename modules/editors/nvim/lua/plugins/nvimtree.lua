return {
	"kyazdani42/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "tt", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
	},
	config = function()
		require("nvim-tree").setup({ -- BEGIN_DEFAULT_OPTS
			auto_reload_on_write = true,
			disable_netrw = false,
			hijack_cursor = false,
			hijack_netrw = true,
			hijack_unnamed_buffer_when_opening = false,
			ignore_buffer_on_setup = false,
			open_on_setup = false,
			open_on_tab = false,
			sort_by = "name",
			update_cwd = false,
			view = {
				--[[ width = 25, ]]
				--[[ height = 30, ]]
				float = {
					enable = true,
					open_win_config = {
						relative = "editor",
						--[[ border = "rounded", ]]
						width = 25,
						height = 20,
						row = 3,
						col = 120,
					},
				},
				--[[ side = "left", ]]
				preserve_window_proportions = false,
				number = false,
				relativenumber = false,
				signcolumn = "yes",
				mappings = {
					custom_only = false,
					list = {
						-- default mappings
						{ key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
						{ key = "<C-e>", action = "edit_in_place" },
						{ key = { "O" }, action = "edit_no_picker" },
						{ key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
						{ key = "<C-v>", action = "vsplit" },
						{ key = "<C-x>", action = "split" },
						{ key = "<C-t>", action = "tabnew" },
						{ key = "<", action = "prev_sibling" },
						{ key = ">", action = "next_sibling" },
						{ key = "P", action = "parent_node" },
						{ key = "<BS>", action = "close_node" },
						{ key = "<Tab>", action = "preview" },
						{ key = "K", action = "first_sibling" },
						{ key = "J", action = "last_sibling" },
						{ key = "I", action = "toggle_git_ignored" },
						{ key = "H", action = "toggle_dotfiles" },
						{ key = "R", action = "refresh" },
						{ key = "a", action = "create" },
						{ key = "d", action = "remove" },
						{ key = "D", action = "trash" },
						{ key = "r", action = "rename" },
						{ key = "<C-r>", action = "full_rename" },
						{ key = "x", action = "cut" },
						{ key = "c", action = "copy" },
						{ key = "p", action = "paste" },
						{ key = "y", action = "copy_name" },
						{ key = "Y", action = "copy_path" },
						{ key = "gy", action = "copy_absolute_path" },
						{ key = "[c", action = "prev_git_item" },
						{ key = "]c", action = "next_git_item" },
						{ key = "-", action = "dir_up" },
						{ key = "s", action = "system_open" },
						{ key = "q", action = "close" },
						{ key = "g?", action = "toggle_help" },
						{ key = "W", action = "collapse_all" },
						{ key = "S", action = "search_node" },
						{ key = "<C-k>", action = "toggle_file_info" },
						{ key = ".", action = "run_file_command" },
					},
				},
			},
			hijack_directories = {
				enable = true,
				auto_open = true,
			},
			update_focused_file = {
				enable = false,
				update_cwd = false,
				ignore_list = {},
			},
			ignore_ft_on_setup = {},
			system_open = {
				cmd = nil,
				args = {},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = false,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},
			filters = {
				dotfiles = false,
				custom = {},
				exclude = {},
			},
			git = {
				enable = true,
				ignore = true,
				timeout = 400,
			},
			actions = {
				change_dir = {
					enable = true,
					global = false,
				},
				open_file = {
					quit_on_open = false,
					resize_window = false,
					window_picker = {
						enable = true,
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
			},
			trash = {
				cmd = "trash",
				require_confirm = true,
			},
			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					git = false,
					profile = false,
				},
			},
		})
	end,
}
