---@param path string The path to the file
---@return table
local function read_json(path)
    local fd = assert(vim.uv.fs_open(path, "r", 420)) -- 0644
    local stat = assert(vim.uv.fs_fstat(fd))
    local content = vim.uv.fs_read(fd, stat.size)
    vim.uv.fs_close(fd)

    ---@cast content string
    return vim.json.decode(content, { luanil = { object = true } })
end

return read_json
