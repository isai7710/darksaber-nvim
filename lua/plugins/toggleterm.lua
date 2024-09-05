return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require('toggleterm').setup({
      size = 15,
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = {
        border = 'rounded',
        width = 100,
        height = 20
      }
    })
  end,
}
