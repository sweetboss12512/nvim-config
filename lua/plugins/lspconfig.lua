-- local icons = require("config.icons")
local lsp = require("lsp")

for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    vim.fn.sign_define("DiagnosticSign" .. diag, {
        -- text = icons.diagnostics[string.lower(diag)],
        text = "",
        texthl = "DiagnosticSign" .. diag,
        linehl = "",
        numhl = "DiagnosticSign" .. diag,
    })
end

local lsp_config = {
    "neovim/nvim-lspconfig",
    enabled = not vim.g.vscode,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        "b0o/schemastore.nvim",
        "nvim-lua/plenary.nvim",
    },
    opts = {
        configs = {
            tooling_lsp = function()
                return {
                    default_config = {
                        cmd = { "tooling-language-server", "serve" },
                        filetypes = { "toml" },
                        name = "tooling_lsp",
                        root_dir = require("lspconfig").util.root_pattern(".git"),
                    },
                }
            end,
        },
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
                    -- This is stupid
                    cmd = vim.fn.has("win32") == 1 and { "vscode-json-language-server.cmd", "--stdio" } or nil,
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
                            validate = {
                                enable = true,
                            },
                        },
                    },
                }
            end,
            pyright = {
                settings = {
                    -- python = {
                    -- 	analysis = {
                    -- 		typeCheckingMode = "strict",
                    -- 	},
                    -- },
                },
            },
            html = { cmd = vim.fn.has("win32") == 1 and { "vscode-html-language-server.cmd", "--stdio" } or nil },
            cssls = { cmd = vim.fn.has("win32") == 1 and { "vscode-css-language-server.cmd", "--stdio" } or nil },
            tooling_lsp = {},
            gdscript = {},
            clangd = {},
            nil_ls = {},
        },
    },

    config = function(_, opts)
        local lspconfig = require("lspconfig")
        local lsp_configs = require("lspconfig.configs")
        local lsp_capabilities = lsp.capabilities()

        for server, config in pairs(opts.configs) do
            config = type(config) == "function" and config() or config
            lsp_configs[server] = config
        end

        for server, config in pairs(opts.servers) do
            config = type(config) == "function" and config() or config
            config.capabilities = vim.tbl_deep_extend("force", lsp_capabilities, config.capabilities or {})
            lspconfig[server].setup(config)
        end

        if vim.uv.os_uname().sysname ~= "Linux" then -- Nixos
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    -- "luau_lsp",
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
        })
    end,
}

return {
    lsp_config,
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
