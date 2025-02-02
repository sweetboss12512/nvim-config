-- tee hee vscode
local associations = {
    [".darklua.json"] = "jsonc",
    [".luaurc"] = "json",
    [".luarc"] = "json",
    [".code-snippets"] = "jsonc",
    ["settings.json"] = "jsonc",
}

if vim.g.vscode then
    associations[".luau"] = "lua" -- Allow treesitter texobjects to be used.
end

for k, v in pairs(associations) do
    vim.filetype.add({ filename = { [k] = v } })
end

vim.filetype.add({
    extension = {
        jinja = "jinja",
        jinja2 = "jinja",
        j2 = "jinja",
    },
})
