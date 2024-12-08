return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use
  { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  "echasnovski/mini.icons",
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = function()
      require('nvim-highlight-colors').setup({
        render = "virtual",
        virtual_symbol_position = "eol"
      })
    end,
  }
}

-- vim: ts=2 sts=2 sw=2 et
