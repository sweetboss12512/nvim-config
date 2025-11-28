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
    init = function()
        vim.lsp.config("luau-lsp", {
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
                        "Packages/**",
                        ".nvim.lua",

                        -- Pesde Stuff
                        ".pesde/**",
                        "*_packages/**",
                    },
                    completion = {
                        autocompleteEnd = false,
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
        })
    end,
    opts = {
        platform = {
            type = rojo_project() and "roblox" or "standard",
        },
        autostart = true,
        filetypes = { "luau" },
        -- fflags = {
        --     enable_new_solver = not rojo_project(),
        -- },
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
