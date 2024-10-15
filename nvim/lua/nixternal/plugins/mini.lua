-- All of Evgeni Chasnovski's mini. plugins
return {
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      require('mini.indentscope').setup({})
    end
  }
}
