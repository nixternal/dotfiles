local cmp_nvim_lsp = require "cmp_nvim_lsp"
return {
  -- Faster LuaLS setup
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        {
          path = "luvit-meta/library",
          words = { "vim%.uv" },
        },
      },
    },
  },

  -- Meta type definitions for the Lua platform Luvit
  {
    "Bilal2453/luvit-meta",
    lazy = true,
  },

  -- Main LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Mason: Portable package manager that installs & manages LSP servers,
      -- DAP servers, linters, and formatters
      {
        "williamboman/mason.nvim",
        config = true,
      },

      -- Extension to mason.nvim that makes it easier to use lspconfig with
      -- mason.nvim
      "williamboman/mason-lspconfig.nvim",

      -- Install and upgrade 3rd party tools automatically
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Extensible UI for notifications & LSP progress messages
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          }
        },
      },

      -- Source for builtin LSP client
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- This function gets run when an LSP attaches to a particular buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          -- Function that lets us more easily define mappings specific for LSP
          -- related items. It sets the mode, buffer and description each time.
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Jump to the definition of the word under your cursor. To jump
          -- back, press <C-t>
          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

          -- Find references for the word under your cursor.
          map("gf", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

          -- Jump to the implementation of the word under your cursor.
          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]implementation")

          -- Jump to the type of the word under your cursor.
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

          -- Fuzzy find all the symbols in your current document.
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

          -- Fuzzy find all the symbols in your current workspace.
          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

          -- Rename the variable under your cursor.
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

          -- Execute a code action, usually your cursor needs to be on top of
          -- an error or a suggestion from your LSP for this to activate.
          map("<eader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- The following 2 autocmd's are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little
          -- while. See ":help CursorHold" for info about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the 2nd
          -- autocmd).
          local client = vim.lsp.get_client_by_id(event.data_client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd({ "LspDetach" }, {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the LSP you are using supports them.
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map("<leader>th", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "[T]oggle Inlay [H]ints")
          end
        end,
      })

      -- LSP servers and client are able to communicate to each other what
      -- features they support.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- [[  LANGUAGE SERVERS ]] --
      -- Enable the following language servers
      local servers = {
        bashls = {},
        cssls = {},
        clangd = {},
        emmet_language_server = {},
        gopls = {},
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        pyright = {},
        rust_analyzer = {},
        ts_ls = {},
      }

      -- Ensure the servers & tools above are installed. To check the current
      -- status of installed tools and/or manually install other tools, you can
      -- run ":Mason". You can press "g?" for help in this menu.
      require("mason").setup()

      -- You can add other tools here that you want Mason to install for you,
      -- so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "flake8", -- Python
        "stylua", -- Lua
      })
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      require("mason-lspconfig").setup{
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
        ensure_installed = {
          "arduino_language_server",
          "clangd",
        },
      }
    end
  },
}