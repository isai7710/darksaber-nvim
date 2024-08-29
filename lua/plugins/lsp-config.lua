--[[ LSP Configuration w Mason and nvim-lspconfig ]]
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
-- NOTE: It is important for the following plugins to be loaded in this order (we could have also just done dependencies but oh well)
return {
  -- 1. mason.nvim package manager
  --  Mason installs LSPs, Linters, and other tools for us
  --  To check the current status of installed tools and/or manually install other tools, you can run
  --    :Mason
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {}
  },
  -- 2. mason-lspconfig.nvim
  --  Enables communication between Mason (above) and LSP configs (the nvim-lspconfig plugin below)
  --  Allows us to ensure the installation of specific language protocol servers (LSPs) such as 'lua_ls'
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          -- INFO: LSPs can be added here simply as a string or as a table variable that contains specific override
          -- configurations for that LSP
          -- Available keys for the LSP table variables are:
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
          --'pylsp', this one was a little sus, some reddit threads recommended jedi_language_server
          'jedi_language_server',
          'clangd',
          'tsserver',
          -- The 'emmet_ls' LSP was fine but it provided super noisy completion for html, any text you wrote could get
          -- autocompleted into an arbitrary HTML tag that isnt useful, so I added the 'emmet_language_server' LSP instead to fix that
          -- 'emmet_ls'
          'emmet_language_server',
          'tailwindcss'
          -- NOTE: we have to configure each of these LSPs under the config function in the nvim-lspconfig plugin below and
          -- broadcast the cmp plugin's capabilities
          -- (cmp is the snippet and autocomplete plugin)
        }
      })
    end
  },
  -- 3. nvim-lspconfig
  --  where most of the LSP configurations for Neovim reside such as LSP related keymaps, LSP event attaching, etc
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        -- By using the mason-tool-installer plugin we can add tools other than LSPs that we want Mason to install
        --  automatically by passing them as a table to ensure_installed in the setup function. This includes any DAPs, Linters, or Formatters
        -- This way we ensure more consistency throughout different systems as we don't have to use the Mason UI to
        --  manually install tools every time we switch systems
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = function()
          local formatters = {
            --'stylua',
            'prettierd',
            'prettier',
            'isort',
            'black',
          }
          local linters = {
            'eslint',
            'eslint_d',
            'stylelint',
            'htmlhint',
            'ruff'
            --pylint (pylint was a little slow for me so I went with ruff instead)
          }
          local tools = vim.list_extend(formatters, linters)
          require('mason-tool-installer').setup({
            ensure_installed = tools
          })
        end
      },
      -- Extensible UI for Neovim notifs and useful status updates for LSP.
      { 'j-hui/fidget.nvim',  opts = {} },

      -- lazydev is neodev's replacement and configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/lazydev.nvim', ft = 'lua', opts = {} }
    },

    -- [[ Main LSP Configurations ]]
    config = function()
      -- LSP servers and clients are able to communicate to each other on what features they support, but we have to define
      --  those features.
      -- By default, Neovim doesn't support everything that is in an LSP specification.
      -- When you add and configure other plugins like nvim-cmp, luasnip, etc (see cmp.lua module) Neovim now has *more* capabilities.
      -- So, we created these new capabilities with nvim cmp, let's call it and extract its capabilities here:
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- IMPORTANT: manually set up individual language servers and broadcast cmp's capabilities to them
      -- we can also write server specific settings if necessary
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({
        -- broadcast nvim cmp capabilities on every lsp if you want cmp capabilities
        capabilities = capabilities
      })
      lspconfig.clangd.setup({
        capabilities = capabilities
      })
      lspconfig.jedi_language_server.setup({
        capabilities = capabilities
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      lspconfig.emmet_language_server.setup({
        capabilities = capabilities
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities
      })

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'keymaps for LSP features using telescope functionality',
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Lets create a helper function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- [[ Jump to the definition of the word under your cursor ]]
          --  This can be where a variable was first declared, where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- [[ Find references for the word under your cursor ]]
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- [[ Jump to the implementation of the word under your cursor ]]
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- [[ Jump to the type of the word under your cursor ]]
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- [[ Fuzzy find all the symbols in your current document ]]
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- [[ Fuzzy find all the symbols in your current workspace ]]
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- [[ Rename the variable under your cursor ]]
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- [[ Execute a code action, usually your cursor needs to be on top of an error ]]
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- [[ Opens a popup that displays documentation about the word under your cursor ]]
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- [[ Cursor Hold and Move Autocommands ]]
          -- first get the LSP client ID
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- check if LSP client exists and supports document highlighting
          if client and client.server_capabilities.documentHighlightProvider then
            -- The following autocommand is used to highlight references of the word under your cursor when
            -- your cursor rests there for a little while.
            --    See `:help CursorHold` for information about when this is executed
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            -- and then when you move your cursor, the highlights will be cleared
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            -- upon detachment of LSP client from the buffer (LspDetach) ensure highlights are cleared and autocommands
            -- above are removed
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })
    end
  }
}
