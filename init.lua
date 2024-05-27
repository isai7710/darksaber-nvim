--[[ 
-- Welcome esteemed traveler to my personal neovim config
-- couldn't have started this config withou help from the kickstart.nvim and modular-kickstart.nvim repos, shout out TJ fr, I left a lot of helpful comments from those repositories here for help

10-15 min Lua guide:
  - https://learnxinyminutes.com/docs/lua/

Use `:help lua-guide` as a reference for how Neovim integrates Lua.
- :help lua-guide
- (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:
  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true 

-- NOTE: whenever we write ' require 'module' ' Neovim will look in the ~/.config/nvim/lua folder for the specific module/folder with submodules

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Basic Autocommands ]]
require 'autocmds'

-- [[ Bootstrap `lazy.nvim` plugin manager and install/configure plugins ]]
require 'lazy-config'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
