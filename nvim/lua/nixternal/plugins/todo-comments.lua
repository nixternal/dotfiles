-- Highlight todo, notes, etc in comments
return {
  "folke/todo-comments.nvim",
  event = "VimEnter",
  opts = {
    signs = false,
  },
}
