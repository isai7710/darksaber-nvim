--[[ Bootstrap the lazy.nvim plugin manager ]]
--  NOTE: See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--[[ Install plugins using lazy ]]
--  NOTE: To check the current status of your plugins, run the following 
--    :Lazy
--  In this menu you can press '?' for help or use `:q` to close the window
--  To update plugins you can run
--    :Lazy update
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

require('lazy').setup({
  require 'plugins/init',
  require 'plugins/colorscheme',
  require 'plugins/gitsigns',
  require 'plugins/which-key',
  require 'plugins/telescope', 
  require 'plugins/todo-comments',
  require 'plugins/mini',
  -- TODO: figure out how to configure plugins below 
  -- require 'plugins/lspconfig',
  -- require 'plugins/conform',     (autoformat)
  -- require 'plugins/cmp',         (autocompletion)
  -- require 'plugins/treesitter',
  -- require 'plugins/nvim-tree',
  -- require 'plugins/treesitter',
  -- require 'plugins/nvim-tree',

  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  require 'plugins/indent-line'
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
