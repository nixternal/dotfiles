return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      }
    })
  end,
}
