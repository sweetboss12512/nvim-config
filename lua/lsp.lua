local icons = require("config.icons")
local module = {}

local BORDER = "single"

vim.diagnostic.config({
    underline = true,
    virtual_text = true,
    virtual_lines = false,
    signs = {
        text = {
            -- [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
            -- [vim.diagnostic.severity.WARN] = icons.diagnostics.warn,
            -- [vim.diagnostic.severity.INFO] = icons.diagnostics.info,
            -- [vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
        },
    },
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
    local capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)
    -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    return capabilities
end

local function on_lsp_attach(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions

    -- Pasted from LSP zero source
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover({ border = BORDER, silent = true })
    end, { buffer = bufnr })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to LSP definition", buffer = bufnr })
    vim.keymap.set("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Go to LSP definition", buffer = bufnr })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to LSP declaration", buffer = bufnr })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to LSP implementation", buffer = bufnr })
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, { desc = "Go to LSP type definition", buffer = bufnr })
    vim.keymap.set("i", "<C-s>", function()
        vim.lsp.buf.signature_help({ border = BORDER })
    end)
    -- vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = bufnr })
    -- vim.keymap.set("n", "<F3>", vim.lsp.buf.format)
    -- vim.keymap.set("x", "<F3>", vim.lsp.buf.format)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, { desc = "Next LSP diagnostic", buffer = bufnr })
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, { desc = "Previous LSP diagnostic", buffer = bufnr })

    vim.keymap.set("n", "<leader>i", vim.diagnostic.open_float, { desc = "Open LSP diagnostics" })
    -- vim.keymap.set("n", "<leader>fe", vim.diagnostic.setqflist, { desc = "Open LSP diagnostics (Quickfix)" })
    -- vim.keymap.set("n", "<leader>fE", vim.diagnostic.setloclist, { desc = "Open LSP diagnostics (Quickfix)" })

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
    end
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
