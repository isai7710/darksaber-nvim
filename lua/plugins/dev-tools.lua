--[[ A small collection of development tools to help with my workflow ]]
return {
  {
    -- provides a good workflow with CMake projects comparable to the vscode-cmake-tools extension
    'Civitasv/cmake-tools.nvim',
  },
  {
    -- leverages tailwind LSP and treesitter to provide some cool tailwind tools
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },
  {
    "MaximilianLloyd/tw-values.nvim",
    keys = {
      { "<leader>sv", "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
    },
    opts = {
      border = "rounded",          -- Valid window border style,
      show_unknown_classes = true, -- Shows the unknown classes popup
      focus_preview = true,        -- Sets the preview as the current window
      copy_register = "",          -- The register to copy values to,
      keymaps = {
        copy = "<C-y>"             -- Normal mode keymap to copy the CSS values between {}
      }
    }
  },
}
