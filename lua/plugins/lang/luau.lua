local util = require("util")

local directoryAliases
local fileAliases

local function update_aliases()
    local vscodeSettings = util.vscode_settings()

    if vscodeSettings then
        directoryAliases = vscodeSettings["luau-lsp.require.directoryAliases"]
        fileAliases = vscodeSettings["luau-lsp.require.fileAliases"]
    end
end

return {
    "lopi-py/luau-lsp.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "luau" },
    cmd = { "LuauLsp" },
    config = function()
        local luau_lsp = require("luau-lsp")
        update_aliases()
        luau_lsp.setup({
            autostart = true,
            server = {
                filetypes = { "luau" },
                settings = {
                    ["luau-lsp"] = {
                        require = {
                            directoryAliases = directoryAliases,
                            fileAliases = fileAliases,
                            inlayHints = {
                                functionReturnTypes = true,
                                parameterTypes = true,
                            },
                        },
                        ignoreGlobs = {
                            -- Wally
                            "**/_Index/**",
                            ".nvim.lua",

                            -- Pesde Stuff
                            ".pesde/**",
                            "*_packages/**",
                        },
                        completion = {
                            -- autocompleteEnd = true,
                            fillCallArguments = false,
                            addParentheses = false,
                            imports = {
                                enabled = true,
                                suggestServices = true,
                                suggestRequires = true,
                                requireStyle = "alwaysAbsolute",
                                ignoreGlobs = {
                                    -- Wally
                                    "**/_Index/**",

                                    -- Pesde Stuff
                                    ".pesde/**",
                                    "*_packages/.pesde/**",
                                },
                            },
                        },
                    },
                },
            },
            platform = {
                type = "standard",
            },
            plugin = {
                enabled = false,
                port = 3667,
            },
            sourcemap = {
                enabled = false,
                autogenerate = false,
            },
            types = {
                -- roblox_security_level = "PluginSecurity",
            },
        })
    end,
}
