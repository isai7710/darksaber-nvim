-- bufferline: visual line at top of editor showing all open buffers (sort of like tabs)
return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    -- the bufdelete plugin makes deleting buffers much less annoying, without this the window layout was shifty
    -- upon default buffer deletion command (:bd), now if you execute :Bd the window won't shift and next buffer opens automatically
    'famiu/bufdelete.nvim',
  },
  config = function()
    vim.opt.termguicolors = true
    vim.keymap.set('n', '[b', ':bp<CR>', { desc = 'Go to previous buffer' })
    vim.keymap.set('n', ']b', ':bp<CR>', { desc = 'Go to next buffer' })
    vim.keymap.set('n', '<leader>bd', ':Bdelete<CR>', { desc = 'Delete current buffer without shifting window layout' })
    vim.keymap.set('n', '<leader>bl', ':BufferLineMoveNext', { desc = 'Reorder current buffer right' })
    vim.keymap.set('n', '<leader>bh', ':BufferLineMovePrev', { desc = 'Reorder current buffer left' })
    vim.keymap.set('n', '<leader>bp', ':BufferLineTogglePin', { desc = 'Pin current buffer' })
    require('bufferline').setup({
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "slant",
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
