return {
  'mfussenegger/nvim-lint',
  -- similar to the formatter plugin conform.lua, we want to load this plugin on the following events:
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('lint').linters_by_ft = {
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      python = { 'pylint' },
    }
  end
}
