return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    window = {
      position = 'left',
      width = 30
    }
  },
  config = function(_, opts)
    vim.keymap.set('n', '<leader>fe', ':Neotree <CR>', { desc = 'Show neo-tree file explorer ' })
    require("neo-tree").setup(opts)
  end
}
