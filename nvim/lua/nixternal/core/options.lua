--[[ Main Options ]]
local g = vim.g
local opt = vim.opt

-- Set <space> as the leader key
--   See ':help mapleader'
--   NOTE: Must happen before plugins are loaded!
g.mapleader = " "
g.maplocalleader = " "

-- Nerd Font
g.have_nerd_font = true

-- Make line numbers default
opt.number = true
opt.relativenumber = true

-- Tab & Indent
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.smartindent = true
opt.expandtab = true

-- Enable mouse mode
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS & Neovim
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case insensitive searching UNLESS \c or one or more capital
-- letters in search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time. Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how Neowill display certain whitespace characters in the editor.
--   See ':help list'
--   and ':help listchars'
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live as you type
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

ui = {
  -- If you are using a Nerd Font: set icons to an empty table which will use the
  -- default lazy.undefined Nerd Font icons, otherwise define a unicode icons table
  icons = g.have_nerd_font and {} or {
    cmd = '⌘',
    config = '🛠',
    event = '📅',
    ft = '📂',
    init = '⚙',
    keys = '🗝',
    plugin = '🔌',
    runtime = '💻',
    require = '🌙',
    source = '📄',
    start = '🚀',
    task = '📌',
    lazy = '💤 ',
  },
}

--  ts=2 sts=2 sw=2 et
