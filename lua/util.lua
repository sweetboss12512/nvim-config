local module = {}

function module.read_file(file)
    local fd = assert(io.open(file, "r"))
    ---@type string
    local data = fd:read("*a")
    fd:close()
    return data
end

---@return table?
function module.vscode_settings()
    local filePath = ".vscode/settings.json"

    if vim.fn.filereadable(filePath) == 1 then
        local _, settings = pcall(function() -- Don't have a heart attack if the file isn't valid json.
            return vim.json.decode(module.read_file(filePath))
        end)

        return settings
    end
end

function module.get_git_branch()
    local name = vim.fn.getcwd()
    local branch = vim.trim(vim.fn.system("git branch --show-current"))
    if vim.v.shell_error == 0 then
        return name .. branch
    else
        return name
    end
end

return module
