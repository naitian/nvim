-- Trying to keep things minimal so it doesn't take over my life and then break
-- In keeping with this, using mini.deps for package management.

vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.smartindent = true
vim.o.undofile = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.g.mapleader = " "

vim.o.termguicolors = true
vim.o.winborder = "rounded"

vim.o.signcolumn = "yes"
vim.o.scrolloff = 3

-- Colorscheme
require("kanagawa").setup({
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none"
				}
			}
		}
	}
})
vim.cmd("colorscheme kanagawa")

-- Package management
local package_path = vim.fn.stdpath("config")
require("mini.deps").setup({ path = { package = package_path } })
local add = MiniDeps.add

add({ source = 'neovim/nvim-lspconfig' })
add({ source = 'williamboman/mason.nvim' })
add({ source = 'nvim-mini/mini.pick' })
add({ source = 'saghen/blink.cmp', checkout = "v1.8.0" })

require("mini.pick").setup()
require("blink.cmp").setup({
	keymap = { preset = 'enter' },

	-- (Default) Only show the documentation popup when manually triggered
	completion = { documentation = { auto_show = false } },

	-- Default list of enabled providers defined so that you can extend it
	-- elsewhere in your config, without redefining it, due to `opts_extend`
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},

	-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	--
	-- See the fuzzy documentation for more information
	fuzzy = { implementation = "prefer_rust_with_warning" }
})

-- LSP config
require("mason").setup()
vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "basic"
			}
		}
	}
})
vim.lsp.config("ruff", {
	init_options = {
		settings = {
			lint = {
				enable = false
			}
		}
	}
})
vim.lsp.enable({ "lua_ls", "biome", "ruff", "basedpyright" })

-- Keybindings
local map = vim.keymap.set
map('n', '<leader><leader>', ':b#<CR>')
map('n', '<leader>f', vim.lsp.buf.format)
map('n', '<leader>.', function() return vim.lsp.buf.code_action({}) end)
map('n', '<leader>o',
	function()
		return vim.lsp.buf.code_action({
			context = { diagnostics = {}, only = { "source.organizeImports" } },
			apply = true
		})
	end
)
map('n', '<leader>h', ':Pick help<CR>')
map('n', '<leader>i', ':Pick buffers<CR>')
map('n', '<leader>p', ':Pick files<CR>')
map('n', '<leader>n', ':noh<CR>')
map('n', '<leader>r', ':so ~/.config/nvim/init.lua')

-- Diagnostic
vim.diagnostic.config({ virtual_text = true })
