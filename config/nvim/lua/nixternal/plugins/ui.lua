return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        --mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  --{
  --  "rcarriga/nvim-notify",
  --  opts = {
  --    timeout = 10000,
  --  },
  --},
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        lsp_doc_border = true,
        inc_rename = true,
      },
      routes = {
        {
          view = "notify",
          filter = { event = "msg_showmode" }
        }
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      --"rcarriga/nvim-notify",
    },
  },
}
