return {
	"neovim/nvim-lspconfig",
	--dependencies = { "williamboman/nvim-lsp-installer" },
	config = function()
		-- require("nvim-lsp-installer").setup({
		-- 	-- Automatically download the LSP server set in advance
		-- 	automatic_installation = true,
		-- })

		---------------------
		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer

		local lsp_formatting = function(bufnr)
			vim.lsp.buf.format({
				filter = function(client)
					-- apply whatever logic you want (in this example, we'll only use null-ls)
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
		end

		-- if you want to set up formatting on save, you can use this as a callback
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		local on_attach = function(client, bufnr)
			-- Mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			--local bufopts = { noremap = true, silent = true, buffer = bufnr }
			--vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
			--vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
			-- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
			--vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
			--vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
			--[[ vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts) ]]
			--[[ vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts) ]]
			--[[ vim.keymap.set("n", "<space>wl", function() ]]
			--[[ 	print(vim.inspect(vim.lsp.buf.list_workspace_folders())) ]]
			--[[ end, bufopts) ]]
			--vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
			--[[ vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts) ]]
			-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
			--[[ vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts) ]]
			-- add to your shared on_attach callback
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						lsp_formatting(bufnr)
					end,
				})
			end
		end

		-- Add additional capabilities supported by nvim-cmp
		-- nvim hasn't added foldingRange to default capabilities, users must add it manually
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		local nvim_lsp = require("lspconfig")

		---------------------
		-- setup languages --
		---------------------
		-- GoLang
		nvim_lsp["gopls"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				gopls = {
					experimentalPostfixCompletions = true,
					analyses = {
						unusedparams = true,
						shadow = true,
					},
					staticcheck = true,
				},
			},
			init_options = {
				usePlaceholders = true,
			},
		})
		--Rust
		-- require("rust-tools").setup({
		-- 	server = {
		-- 		capabilities = capabilities,
		-- 		on_attach = on_attach,
		-- 	},
		-- }) -- C
		nvim_lsp.clangd.setup({})
		--Python
		nvim_lsp.pyright.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						useLibraryCodeForTypes = true,
						typeCheckingMode = "off",
					},
				},
			},
		})

		--sumneko_lua
		nvim_lsp.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = {
						-- Get the language server to recognize the `vim` global
						globals = { "vim" },
					},
					workspace = {
						-- Make the server aware of Neovim runtime files
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			},
		})

		nvim_lsp.rust_analyzer.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
		nvim_lsp.html.setup({
			on_attach = on_attach,
			cmd = { "/home/ruixi/.npm-global/bin/vscode-html-language-server", "--stdio" },
		})

		nvim_lsp.cssls.setup({
			on_attach = on_attach,
			cmd = { "/home/ruixi/.npm-global/bin/vscode-css-language-server", "--stdio" },
		})

		nvim_lsp.zk.setup({
			cmd = { "zk", "lsp" },
		})

		nvim_lsp.tsserver.setup({
			on_attach = on_attach,
			cmd = { "/home/ruixi/.npm-global/bin/typescript-language-server", "--stdio" },
		})

		nvim_lsp.bashls.setup({
			cmd = { "/home/ruixi/.npm-global/bin/bash-language-server", "start" },
		})

		nvim_lsp.rnix.setup({
			on_attach = on_attach,
		})

		-- ebuild Syntastic(install dev-util/pkgcheck)
		vim.g.syntastic_ebuild_checkers = "pkgcheck"

		--------
		-- UI --
		--------
		--Change diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end
		vim.diagnostic.config({
			-- virtual_text = {
			-- 	source = "always", -- Or "if_many"
			-- },
			virtual_text = false,
			signs = true,
			underline = true,
			update_in_insert = true,
			severity_sort = false,
			float = {
				source = "always", -- Or "if_many"
			},
		})
	end,
}
