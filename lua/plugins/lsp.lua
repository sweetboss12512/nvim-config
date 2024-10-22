---@diagnostic disable-next-line: unused-local
local function on_lsp_attach(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	-- lsp_zero.default_keymaps({ buffer = bufnr })

	-- Pasted from LSP zero source
	vim.keymap.set("n", "K", vim.lsp.buf.hover)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to LSP definition" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to LSP declaration" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to LSP implementation" })
	vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { desc = "Go to LSP type definition" })
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show LSP references" })
	vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
	-- vim.keymap.set("n", "<F3>", vim.lsp.buf.format)
	-- vim.keymap.set("x", "<F3>", vim.lsp.buf.format)
	vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action)
	vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next LSP diagnostic" })
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous LSP diagnostic" })

	vim.keymap.set("n", "<leader>i", vim.diagnostic.open_float, { desc = "Open LSP diagnostics" })
	-- local navic = require("nvim-navic")
	-- navic.attach(client, bufnr)
end

local lsp_zero = {
	"VonHeikemen/lsp-zero.nvim",
	enabled = not vim.g.vscode,
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "neovim/nvim-lspconfig" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/nvim-cmp" },
		{ "L3MON4D3/LuaSnip" },

		"nvim-lua/plenary.nvim",
	},

	config = function()
		local lsp_zero = require("lsp-zero")
		local lspconfig = require("lspconfig")
		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

		lsp_zero.extend_lspconfig()
		lsp_zero.on_attach(on_lsp_attach)

		if vim.fn.has("win32") == 1 then
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"luau_lsp",
					"clangd",
					"pyright",
				},
			})
		end
		require("mason-lspconfig").setup_handlers({
			lsp_zero.default_setup,

			luau_lsp = function()
				-- require("plugins.lang.luau")
			end,

			lua_ls = function()
				require("lspconfig")["lua_ls"].setup({
					capabilities = lsp_capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,

			pyright = function()
				lspconfig.pyright.setup({
					capabilities = lsp_capabilities,
					settings = {
						-- python = {
						-- 	analysis = {
						-- 		typeCheckingMode = "strict",
						-- 	},
						-- },
					},
				})
			end,
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single",
		})

		local extension

		if vim.fn.has("win32") == 1 then
			extension = ".CMD"
		elseif vim.fn.has("unix") then
			extension = ""
			lspconfig.nil_ls.setup({})
		end

		lspconfig["html"].setup({
			cmd = { "vscode-html-language-server" .. extension, "--stdio" },
			capabilities = lsp_capabilities,
		})

		lspconfig.cssls.setup({
			cmd = { "vscode-css-language-server" .. extension, "--stdio" },
			capabilities = lsp_capabilities,
		})

		lspconfig.jsonls.setup({
			cmd = { "vscode-json-language-server" .. extension, "--stdio" },
		})
		--
		-- lspconfig["eslint"].setup({})

		require("lspconfig.configs").tooling_lsp = {
			default_config = {
				cmd = { "tooling-language-server", "serve" },
				filetypes = { "toml" },
				name = "tooling_lsp",
				root_dir = lspconfig.util.root_pattern(".git"),
			},
		}

		lspconfig.tooling_lsp.setup({
			on_attach = on_lsp_attach,
			capabilities = lsp_capabilities,
		})
	end,
}
local lsp_file_operations = {
	"antosha417/nvim-lsp-file-operations",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-tree.lua",
	},
	config = function()
		require("lsp-file-operations").setup()
	end,
}

return {
	lsp_zero,
	lsp_file_operations,
}
