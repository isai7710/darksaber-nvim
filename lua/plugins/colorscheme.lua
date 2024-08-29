return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    dim_inactive = {
      enabled = true,
      shade = 'dark',
      percentage = 0.5,
    },
    term_colors = true,
    flavour = 'mocha',
    integrations = {
      bufferline = false,
      cmp = true,
      gitsigns = true,
      indent_blankline = {
        enabled = true,
        scope_color = "",
        colored_indent_levels = false,
      },
      treesitter = true,
      mason = true,
      telescope = {
        enabled = true,
      },
      which_key = true,
      neotree = true,
    },
  },
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end
}
