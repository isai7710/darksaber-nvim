return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = 'macchiato',
    transparent_background = true,
    highlight_overrides = {
      all = function(colors)
      local u = require("catppuccin.utils.colors")
          return {
            CursorLine = {
              bg = u.vary_color(
                { macchiato = u.lighten(colors.mantle, 0.70, colors.base) },
                u.darken(colors.surface0, 0.64, colors.base)
              ),
            },
          }
      end,
    },
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
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
          ok = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
          ok = { "underline" },
        },
        inlay_hints = {
          background = true,
        },
      },
    },
  },
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end
}
