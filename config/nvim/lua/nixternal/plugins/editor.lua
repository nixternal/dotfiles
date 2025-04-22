return {
	-- Telescope: find, filter, preview, pick
	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			{
				-- FZF sorter for telescrope. If encountering errors, see
				-- telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{
				-- Sets vim.ui.select to telescope
				"nvim-telescope/telescope-ui-select.nvim",
			},
		},
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						hidden = true,
					},
				},
				defaults = {
					layout_strategy = "vertical",
					layout_config = {
						preview_height = 0.7,
						vertical = {
							size = {
								width = "95%",
								height = "95%",
							},
						},
					},
					file_ignore_patterns = {
						"^node_modules/",
						"__pycache__",
						"package%-lock.json",
						"%.o",
						"%.a",
						"%.out",
						"%.class",
						"%.pyc",
						"%.png",
						"%.jpg",
						"%.pdf",
						"%.mp4",
						"%.webp",
						"%.ico",
						"%.zip",
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See ':help telescope.builtin'
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch Current [W]ord" })
			vim.keymap.set(
				"n",
				"<leader>sy",
				"<cmd>Telescope notify<cr>",
				{ desc = "[S]earch Notifications Histor[Y]" }
			)
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = "[S]earch Recent Files ('.' for repeat)" })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find Existing Buffers" })
			vim.keymap.set("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end, { desc = "[S]earch [N]eovim Files" })
		end,
	},

	-- Trouble: a diagnostics, references, telescope results, quickfix and
	-- location list to help you solve all the trouble your code is causing.
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{ "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
		},
	},

	-- TODO Comments: highlight, list and search todo comments in your projects.
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		opts = {
			signs = false,
		},
	},

	-- Highlight colors w/ real-time highlighting like in CSS & such
	{
		"brenoprata10/nvim-highlight-colors",
		event = "VeryLazy",
		config = function()
			require("nvim-highlight-colors").setup({
				render = "virtual",
				virtual_symbol_position = "eol",
			})
		end,
	},

	-- Surround: add/change/delete surrounding delimiter pairs with ease.
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},

	-- Incremental LSP renaming based on neovim's command-preview feature.
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

	-- Minimalist plugin that auto pairs & closes brackets
	{
		"m4xshen/autoclose.nvim",
		config = function()
			require("autoclose").setup({
				keys = {
					[">"] = { escape = false, close = false, pair = "><" },
				},
			})
		end,
	},

	-- Illuminate: Automatically highlight other uses of the word under the
	-- cursor using either LSP, Tree-sitter, or regex matching
	{
		"RRethy/vim-illuminate",
		config = function(_, opts)
			require("illuminate").configure(opts)
			vim.keymap.set("n", "<C-n>", require("illuminate").goto_next_reference)
			vim.keymap.set("n", "<C-p>", require("illuminate").goto_prev_reference)
			vim.keymap.set("n", "<C-i>", require("illuminate").textobj_select)
		end,
	},

	-- Vim-Fugitive
	{
		"tpope/vim-fugitive",
	},
}
