## :flower_playing_cards: Introduction

# ![Mando with Darksaber](https://static0.gamerantimages.com/wordpress/wp-content/uploads/2023/02/the-darksaber-din-djarin-the-mandalorian-book-of-boba-star-wars-feature.jpeg)

Hi, thanks for checking out my nvim config. At the moment it's a tangled but useful mess of plugins that I'm constantly tinkering with. I'm a beginner when it comes to Neovim and its configuration, but the journey has been incredibly instructional. I've found that writing down certain notes along with the config has helped me understand what's going on much better, so pardon the messy comments in every module that attempt to explain the codes functionality. Lots of comments are left from the kickstart.nvim's repository configuration (huge shout out to TJDevries, watch his [videos](https://www.youtube.com/@teej_dv) for more Neovim and Lua guides), but I added some more explanation here and there. If anything is uncertain, let me know.

I installed Neovim from source on my WSL 2 environment running the Ubuntu distribution. If you want a quick guide on how to do that, click [here](https://isai-portfolio.vercel.app/blog/neovim-installation)

## Plugins

Here's a list of the plugins used in this Neovim configuration, they were installed using the [lazy.nvim](https://lazy.folke.io/) plugin manager:

- **autocomplete.lua**: Provides autocompletion functionality for a smoother coding experience.

- **autoformat.lua**: Automatically formats code according to predefined rules or language-specific standards.

- **lint.lua**: Performs static code analysis to identify and report on patterns or errors in the code.

- **lsp-config.lua**: Configures the Language Server Protocol (LSP) for enhanced code intelligence features in Neovim.

- **treesitter.lua**: Implements tree-sitter for better syntax highlighting and code navigation.

- **bufferline.lua**: Adds a buffer line at the top of the editor for easy navigation between open files.

- **colorizer.lua**: Adds color highlighting to color keywords (hex, RGB, etc)

- **indent-line.lua**: Displays indentation guides/lines for better code readability (in my opinion).

- **lualine.lua**: A fast and customizable statusline plugin.

- **neo-tree.lua**: A file explorer tree for Neovim, written in Lua.

- **colorscheme.lua**: Manages and applies color schemes.

- **dap.lua**: Debug Adapter Protocol client implementation for Neovim.

- **dev-tools.lua**: A collection of development tools and utilities for Neovim.

- **flash.lua**: Code navigation tool with search labels and treesitter integration.

- **gitsigns.lua**: Adds git-related signs to the gutter and provides related functionality.

- **mini.lua**: A collection of minimal and fast Lua modules for Neovim from the mini.nvim library.

- **multicursor.lua**: Adds multicursor functionality to Neovim

- **nvim-surround.lua**: Provides utilities for manipulating and working with surrounding characters (parentheses, brackets, quotes, etc.).

- **telescope.lua**: A highly extendable fuzzy finder over lists for file and text navigation.

- **todo-comments.lua**: Highlights and provides utilities for working with TODO comments.

- **toggleterm.lua**: A Neovim plugin for persisting and toggling multiple terminals.

- **which-key.lua**: Displays available keybindings in a popup, making it easier to remember keymaps and such.
