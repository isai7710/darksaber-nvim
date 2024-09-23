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

    -- Function to display linters
    local function display_linters()
      local running_linters = lint.get_running()
      if #running_linters == 0 then
        vim.notify("No linters running", vim.log.levels.INFO)
      else
        vim.notify("󰦕 Running linters: " .. table.concat(running_linters, ", "), vim.log.levels.INFO)
      end
    end

    -- Auto lint upon entering buffer, on save, and on leaving insert mode
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('lint', { clear = true }),
      callback = function()
        lint.try_lint()
      end
    })

    -- Keymap to trigger linting and display the lint progress
    vim.keymap.set('n', '<leader>l', function()
      display_linters()
    end, { desc = 'Display [l]inters' })
  end
}
