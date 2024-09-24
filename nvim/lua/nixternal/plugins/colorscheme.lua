return {
  "folke/tokyonight.nvim",
  priority = 1000,
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(hl)
      hl.LineNrAbove = {
        fg = "#777777",
      }
      hl.LineNrBelow = {
        fg = "#777777",
      }
      hl.LineNr = {
        fg = "#777777",
      }
    end,
  },
  init = function()
    vim.cmd.colorscheme("tokyonight")
  end,
}

-- vim: ts=2 sts=2 sw=2 et
