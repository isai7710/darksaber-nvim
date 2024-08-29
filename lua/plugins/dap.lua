return {
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      {
        "mfussenegger/nvim-dap",
        config = function()
          vim.keymap.set('n', '<leader>db', "<cmd> DapToggleBreakpoint <CR>", { desc = 'add a [d]ebugger [b]reakpoint' })
          vim.keymap.set('n', '<leader>dr', "<cmd> DapContinue <CR>", { desc = '[d]ebugger [r]un' })
        end
      }
    },
    opts = {
      handlers = {}
    },
  }
}
