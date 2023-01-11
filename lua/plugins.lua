-- Packer (https://github.com/wbthomason/packer.nvim)
local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- Color Theme
	-- use({ "svrana/neosolarized.nvim", requires = { "tjdevries/colorbuddy.nvim" } })
	-- use("marko-cerovac/material.nvim")
	use("folke/tokyonight.nvim")

	-- Statusline
	use("nvim-lualine/lualine.nvim")

	-- LSP
	use("neovim/nvim-lspconfig") -- LSP Configuratios
	use("onsails/lspkind-nvim") -- Vscode-like pictograms
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")
			saga.init_lsp_saga({})
		end,
	}) -- LSP performant UI

	-- Auto Completion
	use("hrsh7th/cmp-buffer") -- Nvim-cmp source for buffer words
	use("hrsh7th/cmp-nvim-lsp") -- Nvim-cmp source for neovim's built-in LSP
	use("hrsh7th/nvim-cmp") -- Completion
	use({ "L3MON4D3/LuaSnip", tag = "v<CurrentMajor>.*" }) -- Snippet

	-- Syntax Highlighings
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use("nvim-treesitter/playground")

	-- Tag, Bracket 자동완성
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0", requires = { { "nvim-lua/plenary.nvim" } } })
	use("nvim-telescope/telescope-file-browser.nvim")

	-- File Icons
	use("nvim-tree/nvim-web-devicons")

	-- BufferLine
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	-- Colorizer for color code
	use("norcalli/nvim-colorizer.lua")

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- Code Formatting
	use("jose-elias-alvarez/null-ls.nvim") -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- Git
	use({
		"lewis6991/gitsigns.nvim", -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
	})
end)
