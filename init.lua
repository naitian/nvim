-- Trying to keep things minimal so it doesn't take over my life and then break
-- In keeping with this, using mini.deps for package management.

vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.g.mapleader = " "

vim.o.termguicolors = true

local package_path = vim.fn.stdpath("config")
require("mini.deps").setup({ path = { package= package_path} })

MiniDeps.add({
source = 'neovim/nvim-lspconfig',

})
