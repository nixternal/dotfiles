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
        gitsigns = true,
        illuminate = true,
        lsp_trouble = true,
        mason = true,
        mini = {
          enabled = true,
          indentscope_color = "text",
        },
        noice = true,
        notify = true,
        nvim_surround = true,
        nvimtree = true,
        telescope = {
          enabled = true,
        },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    init = function()
      vim.cmd.colorscheme("catppuccin-mocha")
      local hl_groups = { "DiagnosticUnderlineError" }
      for _, hl in ipairs(hl_groups) do
        vim.cmd.highlight(hl .. " gui=undercurl")
      end
    end,
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
      require("bufferline").setup({
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
        options = {
          show_buffer_close_icons = false,
          show_close_icon = false,
        },
      })
    end,
  },

  -- noice: Replace the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
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
      render = "wrapped-compact",
    },
  },

  -- Which Key: helps you remember your keymaps by showing available
  -- keybindings in a popup as you type.
  {
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ",
          NL = "<NL> ",
          BS = "<BS> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },
      },

      -- Document existing key chains
      spec = {
        { "<leader>b", group = "[B]uffer" },
        { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>g", group = "[G]it Hunk", mode = { "n", "v" } },
        { "<leader>r", group = "[R]ename" },
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle/[T]ab/[T]rouble" },
        { "<leader>w", group = "[W]orkspace" },
      },
    },
  },

  -- Visualize and operate on indent scope. Animates the indent while moving.
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      require("mini.indentscope").setup()
    end,
  },

  -- Icon provider that is part of the mini.nvim library.
  -- {
  --   "echasnovski/mini.icons"
  -- },

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
        },
      })
    end,
  },

  -- A file explorer tree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    requires = {
      "nvim-tree/nvim-web-devicons",
      -- "echasnovski/mini.icons"
    },
    config = function()
      require("nvim-tree").setup({})
    end,
  },

  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        numhl = true,
        -- linehl = true,
        current_line_blame = false, -- Toggle :Gitsigns toggle_current_line_blame
        current_line_blame_opts = {
          virt_text = true,
        },
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end)

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end)

          -- Actions
          vim.keymap.set("n", "<leader>gb", gitsigns.toggle_current_line_blame, { desc = "[B]lame Toggle" })
          vim.keymap.set("n", "<leader>gd", gitsigns.diffthis, { desc = "[D]iff View" })
          vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "[P]review Hunk" })
        end,
      })
    end,
  },

  -- Smear Cursor - plugin to animate the cursor with a smear effect
  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  },

  -- Neoscroll - smooth scrolling plugin
  {
    "karb94/neoscroll.nvim",
    opts = {},
  },

  -- ToggleTerm - plugin to help easily manage multiple terminal windows
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      open_mapping = [[<c-t>]], -- C-t to toggle
      direction = "float",
    },
  },
}
