local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

local keymap = vim.keymap.set
local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
	vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup_format,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({ bufnr = bufnr })
		end,
	})
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions (https://github.com/neovim/nvim-lspconfig#suggested-configuration)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
	keymap("n", "gd", vim.lsp.buf.definition, bufopts)
	keymap("n", "K", vim.lsp.buf.hover, bufopts)
	keymap("n", "gi", vim.lsp.buf.implementation, bufopts)
end

-- Setup LSP
nvim_lsp.tsserver.setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server", "--stdio" },
})

nvim_lsp.sumneko_lua.setup({
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},

			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})
