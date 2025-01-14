local BORDER = "single"
local module = {}

local diagnostic_signs = {
	text = {},
	signs = {},
	texthl = {},
	linehl = {},
	numhl = {},
}

for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
	-- diagnostic_signs.text[vim.diagnostic.severity[diag]] = ""
	diagnostic_signs.texthl = "DiagnosticSign" .. diag
	diagnostic_signs.linehl = ""
	diagnostic_signs.numhl = "DiagnoticSign" .. diag
end

vim.diagnostic.config({
	underline = true,
	float = {
		border = BORDER,
	},
	signs = diagnostic_signs,
})

-- vim.lsp.handlers["textDocument/hover"] = function() -- Doesn't work anymore...?
--     vim.lsp.buf.hover({ border = "single" })
-- end
--
-- vim.lsp.handlers["textDocument/signatureHelp"] = function()
--     vim.lsp.buf.signature_help({ border = "single" })
-- end
--
-- vim.diagnostic.config({
--     underline = true,
--     float = {
--         border = "single",
--         -- close_events = {
--             -- 	"BufLeave",
--             -- 	"CursorMoved",
--             -- 	"InsertEnter",
--             -- 	"FocusLost",
--             -- 	"BufHidden",
--             -- 	"WinLeave",
--             -- },
--         },
--     })

-- for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
--     vim.fn.sign_define("DiagnosticSign" .. diag, {
--         -- text = icons.diagnostics[string.lower(diag)],
--         text = "",
--         texthl = "DiagnosticSign" .. diag,
--         linehl = "",
--         numhl = "DiagnosticSign" .. diag,
--     })
-- end

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
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover({
			border = BORDER,
		})
	end)
	-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to LSP definition", buffer = bufnr })
	vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Go to LSP definition", buffer = bufnr })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to LSP declaration", buffer = bufnr })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to LSP implementation", buffer = bufnr })
	vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { desc = "Go to LSP type definition", buffer = bufnr })
	-- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Show LSP references" }) -- Replaced with trouble (lua\plugins\trouble.lua)
	vim.keymap.set("n", "gs", function()
		vim.lsp.buf.signature_help({
			border = BORDER,
		})
	end, { desc = "LSP signature help", buffer = bufnr })
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = bufnr })
	-- vim.keymap.set("n", "<F3>", vim.lsp.buf.format)
	-- vim.keymap.set("x", "<F3>", vim.lsp.buf.format)
	vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action)
	vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end, { desc = "Next LSP diagnostic" })
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end, { desc = "Previous LSP diagnostic" })

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
