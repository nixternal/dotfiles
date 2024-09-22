-- [[ Basic Autocommands ]]
--   See ':help lua-guide-autocommands'

-- Disable "auto-comments" on new line
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

-- Highlight when yanking (copying) text
--   Try it with 'yap' in normal mode
--   See ':help vim.highlight.on_yank()'
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- vim: ts=2 sts=2 sw=2 et
