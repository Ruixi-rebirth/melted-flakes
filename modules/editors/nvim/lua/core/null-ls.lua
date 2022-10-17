require("null-ls").setup({
	sources = {
		-- you must download code formatter by yourself!
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.formatting.google_java_format,
		require("null-ls").builtins.formatting.gofmt,
	},
})
