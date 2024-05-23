return { 
  "catppuccin/nvim", 
  opts = {
    flavour = 'mocha',
    styles = {
      comments = {},
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      mason = true,
      telescope = {
        enabled = true,
      },
      which_key = true,
    },
  },
  name = "catppuccin", 
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
}
