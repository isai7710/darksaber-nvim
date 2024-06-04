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
      treesitter = true,
      mason = true,
      telescope = {
        enabled = true,
      },
      which_key = false,
      neotree = true,
    },
  },
  name = "catppuccin",
  priority = 1000,
  init = function()
    vim.cmd.colorscheme 'catppuccin'
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
  end,
}
