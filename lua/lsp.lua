local BORDER = "single"
local module = {}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = BORDER,
	close_events = {
		-- "BufLeave",
		"InsertEnter",
		"CursorMoved",
		-- "FocusLost",
	},
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = BORDER })

vim.diagnostic.config({
	underline = true,
	float = {
		border = BORDER,
		-- close_events = {
		-- 	"BufLeave",
		-- 	"CursorMoved",
		-- 	"InsertEnter",
		-- 	"FocusLost",
		-- 	"BufHidden",
		-- 	"WinLeave",
		-- },
	},
})

function module.capabilities()
	local capabilities = require("blink.cmp").get_lsp_capabilities()
	-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	return capabilities
end

local function on_lsp_attach(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions

	-- Pasted from LSP zero source
	vim.keymap.set("n", "K", vim.lsp.buf.hover)
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to LSP definition", buffer = bufnr })
	vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Go to LSP definition", buffer = bufnr })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to LSP declaration", buffer = bufnr })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to LSP implementation", buffer = bufnr })
	vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { desc = "Go to LSP type definition", buffer = bufnr })
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show LSP references" }) -- Replaced with trouble (lua\plugins\trouble.lua)
	vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "LSP signature help", buffer = bufnr })
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = bufnr })
	-- vim.keymap.set("n", "<F3>", vim.lsp.buf.format)
	-- vim.keymap.set("x", "<F3>", vim.lsp.buf.format)
	vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action)
	vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next LSP diagnostic", buffer = bufnr })
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous LSP diagnostic", buffer = bufnr })

	vim.keymap.set("n", "<leader>i", vim.diagnostic.open_float, { desc = "Open LSP diagnostics" })
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

return module
