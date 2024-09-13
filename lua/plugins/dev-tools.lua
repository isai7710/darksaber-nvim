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
  }
}
