return {
  -- Color Theme: catppuccin-mocha
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = {
        cmp = true,
        fidget = true,
        lsp_trouble = true,
        mason = true,
        mini = {
          enabled = true,
          indentscope_color = "text"
        },
        noice = true,
        notify = true,
        nvim_surround = true,
        telescope = {
          enabled = true,
        },
        treesitter = true,
        which_key = true,
      },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin-mocha")
      local hl_groups = { "DiagnosticUnderlineError" }
      for _, hl in ipairs(hl_groups) do
        vim.cmd.highlight(hl .. " gui=undercurl")
      end
    end
  },

  -- Bufferline: shows buffers like tabs
  {
    "akinsho/bufferline.nvim",
    after = "catppuccin",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    config = function()
      require("bufferline").setup {
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
        options = {
          show_buffer_close_icons = false,
          show_close_icon = false,
        }
      }
    end,
  },

  -- noice: Replace the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim"
    },
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
      -- routes = {
      --   {
      --     filter = { event = "msg_show" },
      --     view = "messages",
      --   },
      -- },
    },
  },

  -- notify: A fancy, configurable, notification manager
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 250,
      render = "wrapped-compact"
    }
  },

  -- Which Key: helps you remember your keymaps by showing available
  -- keybindings in a popup as you type.
  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>b', group = '[B]uffer' },
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle/[T]ab/[T]rouble' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- Visualize and operate on indent scope. Animates the indent while moving.
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      require("mini.indentscope").setup()
    end
  },

  -- Icon provider that is part of the mini.nvim library.
  {
    "echasnovski/mini.icons"
  },

  -- FileType icons for the various plugins that use them
  {
    "nvim-tree/nvim-web-devicons",
    enabled = vim.g.have_nerd_font,
  },

  -- A blazing fast and easy to configure statusline plugin like Airline &
  -- Powerline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local lualine = require("lualine")

      lualine.setup({
        options = {
          theme = "catppuccin",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        }
      })
    end
  },

  -- A file explorer tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    requires = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
}
