local function load_snippets()
    local cwd = vim.fn.getcwd()
    local snippet_files = vim.split(vim.fn.glob(".vscode/*.code-snippets"), "\n", { trimempty = true })

    for _, v in ipairs(snippet_files) do
        local path = string.format("%s/%s", cwd, v)
        require("luasnip.loaders.from_vscode").load_standalone({
            path = path,
        })
    end
end

return {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
        load_snippets()
        vim.api.nvim_create_user_command("SnippetsReload", load_snippets, {})
    end,
}
