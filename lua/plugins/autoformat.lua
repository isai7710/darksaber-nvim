return {
  'stevearc/conform.nvim',
  -- lazy load the autoformat plugin on the following events (we only need formatting when we're working inside a buffer)
  -- BufReadPre: when we open an already existing file
  -- BufNewFile: triggered when we open a buffer for a file that doesn't already exist
  event = { "BufReadPre", "BufNewFile" },
  -- set the following keymap to autoformat
  keys = {
    {
      '<leader>af',
      function()
        require('conform').format({
          async = true,
          lsp_fallback = true
        })
      end,
      mode = { 'n', 'v' },
      desc = '[A]uto[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      -- lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      python = { "isort", "black" },
      -- You can use a sublist to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
      javascriptreact = { "prettier" },
      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      markdown = { "prettier" },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
