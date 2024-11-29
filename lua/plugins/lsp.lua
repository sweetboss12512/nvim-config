local icons = require("config.icons")

---@diagnostic disable-next-line: unused-local
local function on_lsp_attach(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions

	-- Pasted from LSP zero source
	vim.keymap.set("n", "K", vim.lsp.buf.hover)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to LSP definition" })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to LSP declaration" })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to LSP implementation" })
	vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { desc = "Go to LSP type definition" })
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show LSP references" }) -- Replaced with trouble (lua\plugins\trouble.lua)
	vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename)
	-- vim.keymap.set("n", "<F3>", vim.lsp.buf.format)
	-- vim.keymap.set("x", "<F3>", vim.lsp.buf.format)
	vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action)
	vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next LSP diagnostic" })
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous LSP diagnostic" })

	vim.keymap.set("n", "<leader>i", vim.diagnostic.open_float, { desc = "Open LSP diagnostics" })
end

for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
	vim.fn.sign_define("DiagnosticSign" .. diag, {
		text = icons.diagnostics[string.lower(diag)],
		texthl = "DiagnosticSign" .. diag,
		linehl = "",
		numhl = "DiagnosticSign" .. diag,
	})
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if not client then
			return
		end

		on_lsp_attach(client, event.buf)
	end,
})

local lsp_config = {
	"neovim/nvim-lspconfig",
	enabled = not vim.g.vscode,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/nvim-cmp" },
		{ "L3MON4D3/LuaSnip" },

		"nvim-lua/plenary.nvim",
	},

	config = function()
		local lspconfig = require("lspconfig")
		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- vim.notify(vim.inspect(lsp_capabilities))
		lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true

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
			function(server_name)
				require("lspconfig")[server_name].setup({
					capabilities = lsp_capabilities,
				})
			end,

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

		vim.diagnostic.config({
			float = { border = "single" },
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
			capabilities = lsp_capabilities,
		})

		lspconfig.gdscript.setup({
			capabilities = lsp_capabilities,
		})
	end,
}

return {
	lsp_config,
}
