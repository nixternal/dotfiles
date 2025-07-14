-- Re-detect file type on write if no filetype dected
--   this is for when you create file: foo and do #!/bin/sh
--   this will detect the file as a shell file on write. Good
--   for when you don't use an extension with the file name
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "" then
      vim.cmd("filetype detect")
    end
  end,
})

-- Disable 'auto-comments' on newline
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Highlight yanked text using the "IncSearch" highlight group for 250ms
local HighlightYank = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = HighlightYank,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 250,
    })
  end,
})

-- Return to the last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})

-- CleanOnSave: Remove training whitespace from all lines before saving a file
local CleanOnSave = vim.api.nvim_create_augroup("CleanOnSave", {})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = CleanOnSave,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- LspRestart: Restart LSP on Save. Definitely fixes import foobar working
-- after pip installing foobar.
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function()
    vim.cmd("LspRestart")
  end,
})
