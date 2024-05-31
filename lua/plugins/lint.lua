return {
  'mfussenegger/nvim-lint',
  -- similar to the formatter plugin conform.lua, we want to load this plugin on the following events:
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    -- load the plugin
    local lint = require('lint')

    -- specify linters by filetype, ensure these were installed by the mason-tool-installer
    -- which is found as a dependency of nvim-lspconfig in the lsp-config.lua file OR manually
    -- install them (through the Mason UI or other means)
    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      python = { 'pylint' },
    }
    -- auto lint upon entering buffer, on save, and on leaving insert mode
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('lint', { clear = true }),
      callback = function()
        lint.try_lint()
      end
    })

    vim.keymap.set('n', '<leader>l', function()
      lint.try_lint()
    end, { desc = 'Trigger [L]inting for current file' })
  end
}
