return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- format(async)
    local async_formatting = function(bufnr)
      bufnr = bufnr or vim.api.nvim_get_current_buf()

      vim.lsp.buf_request(
        bufnr,
        "textDocument/formatting",
        vim.lsp.util.make_formatting_params({}),
        function(err, res, ctx)
          if err then
            local err_msg = type(err) == "string" and err or err.message
            -- you can modify the log message / level (or ignore it completely)
            vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
            return
          end

          -- don't apply results if buffer is unloaded or has been modified
          if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
            return
          end

          if res then
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
            vim.api.nvim_buf_call(bufnr, function()
              vim.cmd("silent noautocmd update")
            end)
          end
        end
      )
    end
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local callback = function()
      vim.lsp.buf.format({
        bufnr = bufnr,
        filter = function(client)
          return client.name == "null-ls"
        end,
      })
    end
    require("null-ls").setup({
      sources = {
        -- you must download code formatter by yourself!
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.prettier,
        require("null-ls").builtins.formatting.gofmt,
        require("null-ls").builtins.formatting.nixpkgs_fmt,
        require("null-ls").builtins.formatting.beautysh,
        require("null-ls").builtins.formatting.rustfmt,
        require("null-ls").builtins.formatting.stylish_haskell,
      },
      debug = false,
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePost", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              async_formatting(bufnr)
            end,
          })
        end
      end,
    })
  end,
}
