return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      transparent_background = true,
      term_colors = true,
      flavour = 'mocha',
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        mason = true,
        telescope = {
          enabled = false,
        },
        which_key = false,
        neotree = true,
      },
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end
  },
}
