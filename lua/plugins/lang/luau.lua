local function rojo_project()
    return vim.fs.root(0, function(name)
        return name:match(".+%.project%.json$")
    end)
end

return {
    "lopi-py/luau-lsp.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "luau" },
    cmd = { "LuauLsp" },
    opts = {
        platform = {
            type = rojo_project() and "roblox" or "standard",
        },
        autostart = true,
        server = {
            settings = {
                ["luau-lsp"] = {
                    require = {
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
        plugin = {
            enabled = rojo_project() ~= nil,
            port = 3667,
        },
        sourcemap = {
            enabled = false,
            autogenerate = false,
        },
        types = {
            -- roblox_security_level = "PluginSecurity",
        },
    },
}
