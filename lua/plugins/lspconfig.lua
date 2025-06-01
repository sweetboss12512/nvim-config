local lsp = require("lsp")

--- Mason adds '.cmd' to exe names on Windows... fun!
---@param exeName string
---@return string
local function fix_mason_extension(exeName)
    return vim.fn.has("win32") == 1 and exeName .. ".cmd" or exeName
end

return {
    {
        "mason-org/mason-lspconfig.nvim",
        enabled = vim.uv.os_uname().sysname ~= "Linux", -- I don't want to use mason-lspconfig on NixOS
        opts = { automatic_enable = { exclude = { "luau_lsp" } }, ensure_installed = { "lua_ls" } },
        dependencies = { { "mason-org/mason.nvim", opts = {} }, "neovim/nvim-lspconfig" },
    },
    {

        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "b0o/schemastore.nvim" },
        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
                jsonls = function()
                    return {
                        cmd = { fix_mason_extension("vscode-json-language-server"), "--stdio" },
                        settings = {
                            json = {
                                schemas = require("schemastore").json.schemas({
                                    extra = {
                                        {
                                            name = "default.project.json",
                                            description = "JSON schema for Rojo project files",
                                            fileMatch = { "*.project.json" },
                                            url = "https://raw.githubusercontent.com/rojo-rbx/vscode-rojo/master/schemas/project.template.schema.json",
                                        },
                                    },
                                }),
                                validate = { enable = true },
                            },
                        },
                    }
                end,
                pyright = {
                    settings = {
                        python = { analysis = { typeCheckingMode = "strict" } },
                    },
                },
                html = {
                    cmd = { fix_mason_extension("vscode-html-language-server"), "--stdio" },
                    filetypes = { "html", "htmldjango" },
                },
                cssls = { cmd = { fix_mason_extension("vscode-css-language-server"), "--stdio" } or nil },
                rbx_tooling_lsp = {
                    cmd = { "tooling-language-server", "serve" },
                    filetypes = { "toml" },
                    name = "tooling_lsp",
                    root_markers = { ".git" },
                },
                gdscript = {},
                clangd = {},
                nil_ls = {},
            },
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            local lsp_configs = require("lspconfig.configs")
            local lsp_capabilities = lsp.capabilities()

            for server, config in pairs(opts.servers) do
                config = type(config) == "function" and config() or config

                if vim.lsp.config then
                    vim.lsp.config(server, config)
                    vim.lsp.enable(server)
                else
                    -- School Mac stuck on 0.10
                    config.capabilities = vim.tbl_deep_extend("force", lsp_capabilities, config.capabilities or {})
                    lsp_configs[server] = config
                    lspconfig[server].setup()
                end
            end
        end,
    },
    {
        "artemave/workspace-diagnostics.nvim",
        keys = {
            {
                "<leader>fx",
                function()
                    for _, client in ipairs(vim.lsp.get_clients()) do
                        require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
                    end
                end,
                desc = "Populate Workspace Diagnostics",
            },
        },
    },
}
