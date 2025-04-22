return {
  -- Auto Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      -- Snippets Engine
      {
        "L3MON4D3/LuaSnip",
        build = (function()
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- Friendly Snippets: contains a variety of premade snippets
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
              require("luasnip.loaders.from_snipmate").lazy_load({
                paths = { "./lua/nixternal/snippets" },
              })
              require("luasnip.loaders.from_lua").lazy_load({ paths = { "./lua/nixternal/snippets" } })
            end,
          },
        },
      },
      -- LuaSnip completion source
      "saadparwaiz1/cmp_luasnip",
      -- LSP client completion source
      "hrsh7th/cmp-nvim-lsp",
      -- Filesystem path completion source
      "hrsh7th/cmp-path",
    },
    config = function()
      -- See ":help cmp"
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      luasnip.config.setup({})

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        -- To understand the following mappings & why they were chose, you will
        -- need to read ":help ins-completion"
        mapping = cmp.mapping.preset.insert({
          -- Select the [n]ext item
          ["<C-n>"] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          -- Scroll the documentation window [b]ack / [f]orward
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          -- Accept ([y]es) the completion
          --   this will auto-import if your LSP supports it & will expand
          --   snippets if the LSP sent a snippet.
          ["<C-y"] = cmp.mapping.confirm({ select = true }),
          -- Manually trigger a completion from nvim-cmp.
          ["<C-Space>"] = cmp.mapping.complete({}),
          -- Move forwards in expansion location
          ["<C-l>"] = cmp.mapping(function()
            if luansip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { "i", "s" }),
          -- Move backwards in expansion locations
          ["<C-h>"] = cmp.mapping(function()
            if luansip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { "i", "s" }),
        }),
        sources = {
          {
            name = "lazydev",
            -- set group index to 0 to skip loading LuaLS completions as
            -- lazydev recommends it
            group_index = 0,
          },
          {
            name = "nvim_lsp",
          },
          {
            name = "luasnip",
          },
          {
            name = "path",
          },
        },
      })
    end,
  },

  -- Treesitter configurations & abstraction layer: Highlight, edit & navigate
  -- code
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "arduino",
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "csv",
        "cue",
        "desktop",
        "diff",
        "gitignore",
        "go",
        "html",
        "javascript",
        "json",
        "latex",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "php",
        "python",
        "query",
        "regex",
        "rust",
        "tmux",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {
          "ruby",
        },
      },
      indent = {
        enable = true,
        disable = {
          "python",
          "ruby",
          "yaml",
        },
      },
    },
  },

  -- Use Treesitter to auto close and auto rename HTML tag
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Use Treesitter to show code context
  {
    "nvim-treesitter/nvim-treesitter-context",
    vim.api.nvim_set_hl(0, "TreesitterContextBottom", { underline = true }),
  },

  -- Asynchronous linter complementary to the built-in LSP support.
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        python = { "flake8" },
        svelte = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>cl", function()
        lint.try_lint()
      end, { desc = "Trigger [C]ode [L]inting for current file" })
    end,
  },
}
