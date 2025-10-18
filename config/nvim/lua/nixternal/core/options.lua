local g = vim.g
local opt = vim.opt
local ft = vim.filetype

-- Set Leader Key: <space>
g.mapleader = " "
g.maplocalleader = " "

-- Nerd Font
g.have_nerd_font = true

-- 24-bit RGB color use in terminal
opt.termguicolors = true

-- Spelling
opt.spelllang = "en_us"
opt.spell = true

-- Encoding
opt.encoding = "utf-8"

-- Word Wrap: 79
opt.wrap = true
opt.textwidth = 79

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Tab & Indent
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Mouse Mode
opt.mouse = "c"

-- Don't show the mode since it it is already in the status line
opt.showmode = false

-- Clipboard: sync between OS & neovim
-- vim.schedule(function()
--   opt.clipboard = 'unnamedplus'
-- end)

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case insensitive searching UNLESS \c or one or more capital letters in
-- search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time. Displays which-key pop-up sooner
opt.timeoutlen = 1000

-- Configure hwo new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Set how neovim will display certain whitespace characters in the editor
--   See ':help list' and ':help listchars'
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live as you type
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above & below the cursor.
opt.scrolloff = 10

-- Ignore providers
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- FileType Extensions
ft.add({
  extension = {
    njk = "html",
  },
})

-- LSP Logging
-- vim.lsp.set_log_level("warn")    <- Default
-- vim.lsp.set_log_level("debug")
vim.lsp.set_log_level("off")
