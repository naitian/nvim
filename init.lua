-- Trying to keep things minimal so it doesn't take over my life and then break
-- In keeping with this, using mini.deps for package management.

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.g.mapleader = " "

vim.o.termguicolors = true
vim.o.winborder = "rounded"

vim.o.signcolumn = "yes"
vim.o.scrolloff = 3

-- Colorscheme
require("vague").setup()
vim.cmd("colorscheme vague")

-- Package management
local package_path = vim.fn.stdpath("config")
require("mini.deps").setup({ path = { package = package_path } })
local add = MiniDeps.add

add({
	source = 'neovim/nvim-lspconfig'
})
add({
	source = 'williamboman/mason.nvim'
})
add({
	source = 'nvim-mini/mini.pick'
})
add({
  source = 'saghen/blink.cmp'
})

require("mini.pick").setup()

-- LSP config
require("mason").setup()
vim.lsp.enable({ "lua_ls", "biome" })

-- Keybindings
vim.keymap.set('n', '<leader><leader>', ':b#<CR>')
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>i', ':Pick buffers<CR>')
vim.keymap.set('n', '<leader>p', ':Pick files<CR>')
vim.keymap.set('n', '<leader>n', ':noh<CR>')
