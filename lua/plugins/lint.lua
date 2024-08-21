return {
  'mfussenegger/nvim-lint',
  -- similar to the formatter plugin conform.lua, we want to load this plugin on the following events:
  config = function()
    -- load the plugin
    local lint = require('lint')

    -- [[ specify linters by filetype ]]
    -- Ensure these were installed by the mason-tool-installer which is found as a dependency of the nvim-lspconfig plugin
    -- (in the lsp-config.lua file) OR manually install them through the Mason UI or other means
    lint.linters_by_ft = {
      javascript = { 'eslint_d', 'eslint' },
      javascriptreact = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      python = { 'pylint' },
    }

    -- [[ customize built-in linters ]]
    -- let's say I want to disable docstring warnings from pylint
    -- I can import the pylint.lua file from the nvim-lint plugin (see repo for specific linter files)
    --    local pylint = require('lint').linters.pylint
    -- and customize any of its properties with the following
    --    pylint.args = {
    --      '-f',
    --      'json',
    --      '--from-stdin',
    --      '--disable=missing-function-docstring,missing-module-docstring', -- *this line disables the warning
    --      function()
    --        return vim.api.nvim_buf_get_name(0)
    --      end,
    -- }

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
