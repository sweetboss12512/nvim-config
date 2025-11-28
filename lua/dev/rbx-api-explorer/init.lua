local fzf = require("fzf-lua")
local builtin = require("fzf-lua.previewer.builtin")
local read_json = require("dev.rbx-api-explorer.util.read_json")
local keys = {}

local api_docs = read_json(vim.fn.stdpath("config") .. "/lua/dev/fusion-blink/api-docs.json")

---@param str string
---@return string, any
local function replace_html_tags(str)
    return str:gsub("<code>(.*)</code>", "`%1`"):gsub("<strong>(.*)</strong>", "**%1**")
end

-- Inherit from "base" instead of "buffer_or_file"
local MyPreviewer = builtin.base:extend("buffer_or_file")

function MyPreviewer:new(o, opts, fzf_win)
    MyPreviewer.super.new(self, o, opts, fzf_win)
    setmetatable(self, MyPreviewer)
    return self
end

function MyPreviewer:populate_preview_buf(entry_str)
    local global_type = api_docs["@roblox/globaltype/" .. entry_str]
    local docstring = ([[
# %s

## Documentation
%s

[Learn More](%s)
]]):format(entry_str, replace_html_tags(global_type.documentation), global_type.learn_more_link)

    local tmpbuf = self:get_tmp_buffer()
    vim.bo[tmpbuf].filetype = "markdown"
    vim.api.nvim_cmd({ cmd = "Markview", args = { tmpbuf } }, {})
    vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, vim.split(docstring, "\n"))
    self:set_preview_buf(tmpbuf)
end

-- Disable line numbering and word wrap
function MyPreviewer:gen_winopts()
    local new_winopts = {
        wrap = false,
        number = false,
        -- filetype = "markdown",
    }
    return vim.tbl_extend("force", self.winopts, new_winopts)
end

for key, info in pairs(api_docs) do
    local property = string.match(key, "@roblox/globaltype/(.*)")
    if not property then
        goto continue
    end

    table.insert(keys, property)
    ::continue::
end

fzf.fzf_exec(keys, {
    previewer = MyPreviewer,
    preview = {
        fn = function(items, _, bufnr)
            local global_type = api_docs["@roblox/globaltype/" .. items[1]]

            return ([[
# %s

## Documentation
%s
            ]]):format(items[1], global_type.documentation)
        end,
    },
})
