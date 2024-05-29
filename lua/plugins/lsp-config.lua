--[[ LSP Configuration w Mason and nvim-lspconfig ]]
--
------------------------------------------------------
-- LSP stands for Language Server Protocol
-- It is a protocol that helps editors like Neovim and specific language servers (like 'gopls', 'lua_ls', etc.) communicate
--  back and forth in a standardized fashion
-- LSPs provide Neovim with features such as...
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
-- LSPs must be installed separately from Neovim, which is where Mason.nvim comes into play
-------------------------------------------------------
-- It is important for the following plugins to be loaded in this order
return {
  -- 1. mason.nvim package manager
  -- To check the current status of installed tools and/or manually install other tools, you can run
  --    :Mason
  {
    'williamboman/mason.nvim',
    opts = {}
  },
  -- 2. mason-lspconfig.nvim connects Mason (above) to the nvim-lspconfig plugin (below) and allows us to ensure the installation of
  --    specific language protocol servers (LSPs) such as 'lua_ls'
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      ensure_installed = {
        -- LSPs can be added here simply as a string or as a table variable that contains specific override
        -- configurations for that LSP
        -- Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            }
          }
        },
        'clangd',
      }
    }
  },
  -- 3. nvim-lspconfig where most of the LSP configurations reside such as LSP related keymaps, LSP event attaching, etc
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Extensible UI for Neovim notifs and useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} }
    },
    config = function()
      -- LSP servers and clients are able to communicate to each other on what features they support, but we have to define
      --  those features
      -- By default, Neovim doesn't support everything that is in an LSP specification.
      -- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      -- So, we create new capabilities with nvim cmp, and then broadcast that to the servers here:
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      --
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({})
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
    end
  }
}
