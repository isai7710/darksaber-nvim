return {
  -- Highlight todo, notes, etc in comments
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    signs = true,
    keywords = {
      IMPORTANT = { icon = " ", color = "warning" }
    },
    merge_keywords = true
  }
}
