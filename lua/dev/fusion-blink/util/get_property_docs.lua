local read_json = require("dev.fusion-blink.util.read_json")

local api_docs_path = vim.fn.stdpath("config") .. "/lua/dev/fusion-blink/api-docs.json"
local api_docs = read_json(api_docs_path)

local docstring_format = [[
%s

[Learn More](%s)
]]

---@param str string
---@return string, any
local function replace_html_tags(str)
    return str:gsub("<code>(.*)</code>", "`%1`"):gsub("<strong>(.*)</strong>", "**%1**")
end

---@param class_name string
---@param property_name string
local function get_property_docs(class_name, property_name)
    -- if class_name == "Frame" then
    --     print(class_name, property_name)
    -- end

    local key = ("@roblox/globaltype/%s.%s"):format(class_name, property_name)
    local info = api_docs[key]

    if not info then
        return
    end

    return replace_html_tags(docstring_format:format(info.documentation, info.learn_more_link))
end

return get_property_docs
