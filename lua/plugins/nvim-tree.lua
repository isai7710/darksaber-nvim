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
        hidden_display = "simple",
        highlight_git = "name",
        indent_markers = {
          enable = true,
        },
        icons = {
          git_placement = "after",
          modified_placement = "right_align",
          show = {
            folder_arrow = false,
          },
        }
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = "󰌶",
          info = "󰋽",
          warning = "󰀪",
          error = "󰅚"
        }
      },
      modified = {
        enable = true,
      },
      git = {
        show_on_dirs = true,
        show_on_open_dirs = false,
      }
    })
    vim.keymap.set('n', '<leader>fe', ':NvimTreeOpen <CR>', { desc = 'Show neo-tree file explorer ' })
  end,
}
