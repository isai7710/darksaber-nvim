-- This plugin provides the following mappings which allow you to move between Vim panes and tmux splits seamlessly.
-- Note - you don't need to use your tmux prefix key sequence before using the mappings.
return {
  'christoomey/vim-tmux-navigator',
  -- Lazy-load the plugin on the following commands and keymaps
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-p>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}
