return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      renderer = {
        icons = {
          git_placement = "after"
        }
      }
    })
    vim.keymap.set('n', '<leader>fe', ':NvimTreeOpen <CR>', { desc = 'Show neo-tree file explorer ' })
  end,
}
