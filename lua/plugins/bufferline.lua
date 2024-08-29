-- bufferline: visual line at top of editor showing all open buffers (sort of like tabs)
return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    -- the bufdelete plugin makes deleting buffers much less annoying with the provided :Bdelete command, default buffer deletion was :bd
    'famiu/bufdelete.nvim',
  },
  config = function()
    vim.opt.termguicolors = true

    -- a couple of keymaps to cycle through, delete, reorder, and pin buffers
    vim.keymap.set('n', '[b', ':bp<CR>', { desc = 'Go to previous buffer' })
    vim.keymap.set('n', ']b', ':bp<CR>', { desc = 'Go to next buffer' })
    vim.keymap.set('n', '<leader>bd', ':Bdelete<CR>', { desc = 'Delete current buffer without shifting window layout' })
    vim.keymap.set('n', '<leader>bl', ':BufferLineMoveNext', { desc = 'Reorder current buffer right' })
    vim.keymap.set('n', '<leader>bh', ':BufferLineMovePrev', { desc = 'Reorder current buffer left' })
    vim.keymap.set('n', '<leader>bp', ':BufferLineTogglePin', { desc = 'Pin current buffer' })

    local bufferline = require('bufferline')
    bufferline.setup({
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "thick",
        show_close_icon = false,
        show_tab_indicators = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = function()
              return vim.fn.getcwd()
            end,
            highlight = "Directory",
            text_align = "left"
          }
        },
      },
      highlights = require("catppuccin.groups.integrations.bufferline").get {
        styles = { "italic", "bold" },
      },
    })
  end
}