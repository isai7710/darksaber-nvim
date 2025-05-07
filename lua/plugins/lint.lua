return {
  'mfussenegger/nvim-lint',
  config = function()
    -- Load the plugin
    local lint = require('lint')

    -- Specify linters by filetype
    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      python = { 'ruff' },
    }

    -- Auto lint upon entering buffer, on save, and on leaving insert mode
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('lint', { clear = true }),
      callback = function()
        lint.try_lint()
      end
    })
  end
}
