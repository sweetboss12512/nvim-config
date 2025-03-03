local ts_utils = require("nvim-treesitter.ts_utils")
local read_json = require("dev.fusion-blink.util.read_json")
local get_property_docs = require("dev.fusion-blink.util.get_property_docs")
local config

local DEBUG = false
local _print = print
local print = function(...)
    if DEBUG then
        _print(...)
    end
end

local autocomplete_text = {
    CFrame = "CFrame.new($0)",
    Color3 = "Color3.new($0)",
    ColorSequence = "ColorSequence.new($0)",
    ColorSequenceKeypoint = "ColorSequenceKeypoint.new($0)",
    NumberRange = "NumberRange.new($0)",
    NumberSequence = "NumberSequence.new($0)",
    NumberSequenceKeypoint = "NumberSequenceKeypoint.new($0)",
    PhysicalProperties = "PhysicalProperties.new($0)",
    Ray = "Ray.new($0)",
    Rect = "Rect.new($0)",
    Region3 = "Region3.new($0)",
    Region3int16 = "Region3int16.new($0)",
    UDim = "UDim.new($0)",
    UDim2 = "UDim2.new($0)",
    Vector2 = "Vector2.new($0)",
    Vector2int16 = "Vector2int16.new($0)",
    Vector3 = "Vector3.new($0)",
    Vector3int16 = "Vector3int16.new($0)",
}

local api_dump_path = vim.fn.stdpath("config") .. "/lua/dev/fusion-blink/api-dump.json"
local api_dump = read_json(api_dump_path)

---@return string?
local function get_class_name()
    local node = ts_utils.get_node_at_cursor(0)

    if not node then
        return
    end

    while node:type() ~= "function_call" do
        -- handling the edge cases like `doctype` node
        if node:parent() == nil then
            print("FAILED TO GET NODE")
            return
        end

        node = node:parent()
    end

    local child = node:field("name")[1]

    if not child then
        return
    end

    child = child:field("arguments")[1]

    if not child then
        return
    end

    child = child:child(0)

    if not child then
        -- vim.notify("NO CHILD")
        return
    end

    local fixed = vim.treesitter.get_node_text(child, 0):gsub('"', "")
    return fixed
end

---@return boolean
local function is_in_new()
    local node = ts_utils.get_node_at_cursor(0)

    if not node then
        print("...No node?")
        return false
    end

    if not vim.tbl_contains({ "string_content", "string", "function_call", "table_constructor" }, node:type()) then
        print("NOT IN STRING", node:type())
        return false
    end

    ---@diagnostic disable-next-line: need-check-nil
    while node:type() ~= "function_call" do
        -- handling the edge cases like `doctype` node
        if node:parent() == nil then
            print("NODE NOT FOUND")
            return false
        end

        node = node:parent()
    end

    ---@diagnostic disable-next-line: need-check-nil
    local child = node:field("name")[1]

    if not child then
        vim.notify("NO CHILD")
        return false
    end

    local methodNode = child:field("method")[1]

    if not methodNode then
        print("NO METHoD")
        return false
    end

    -- vim.notify(vim.inspect(vim.treesitter.get_node_text(child, bufnr)))
    print(vim.treesitter.get_node_text(methodNode, 0))
    return vim.treesitter.get_node_text(methodNode, 0) == "New"
    -- or vim.treesitter.get_node_text(methodNode, 0) == "CreateElement"
end

---@return blink.cmp.CompletionItem[]
local function get_class_properties(class)
    local properties = {}

    for _, member in ipairs(class.Members) do
        if member.MemberType ~= "Property" then
            goto continue
        end

        if member.Tags then
            if vim.tbl_contains(member.Tags, "ReadOnly") then
                goto continue
            end
        end

        local type_text = autocomplete_text[member.ValueType.Name]

        if type_text then
            type_text = type_text .. ","
        else
            type_text = ""
        end

        if member.ValueType.Category == "Enum" then
            type_text = "Enum." .. member.ValueType.Name .. "."
        end

        table.insert(properties, {
            label = member.Name,
            kind = require("blink.cmp.types").CompletionItemKind.Property,
            -- insertText = ("%s = "):format(data.Name),
            insertTextFormat = vim.lsp.protocol.InsertTextFormat.Snippet,
            textEdit = { newText = ("%s = %s"):format(member.Name, type_text) },
            documentation = {
                kind = "markdown",
                value = get_property_docs(class.Name, member.Name) or "",
            },
        })

        ::continue::
    end

    if class.Superclass then
        for _, randomClass in ipairs(api_dump.Classes) do
            if randomClass.Name == class.Superclass then
                local inherited = get_class_properties(randomClass)
                for _, v in ipairs(inherited) do
                    table.insert(properties, v)
                end
            end
        end
    end

    return properties
end

local instance_names = {}
local properties_cache = {}

for _, class in ipairs(api_dump.Classes) do
    table.insert(instance_names, {
        kind = require("blink.cmp.types").CompletionItemKind.Class,
        label = class.Name,
        -- insertText = object.Name,
        textEdit = { newText = class.Name },
    })
    properties_cache[class.Name] = get_class_properties(class)
end

---@param items blink.cmp.CompletionItem[]
---@param context blink.cmp.Context
local function transform(items, context)
    return vim.tbl_map(function(entry)
        local tbl = vim.tbl_deep_extend("force", entry, {
            textEdit = {
                range = {
                    start = { line = context.cursor[1] - 1, character = context.bounds.start_col - 1 },
                    ["end"] = { line = context.cursor[1] - 1, character = context.cursor[2] },
                },
            },
        })

        return tbl
    end, items)
end

---@type blink.cmp.Source
local source = {}

function source.new(opts)
    local self = setmetatable({}, { __index = source })
    config = vim.tbl_deep_extend("keep", opts or {}, {
        insert = false,
    })
    return self
end

function source:enabled()
    return vim.bo.filetype == "luau" and (is_in_new() == true or get_class_name() ~= nil)
end

---@param context blink.cmp.Context
function source:get_completions(context, callback)
    ---@diagnostic disable-next-line: redefined-local
    local completions
    local class_name = get_class_name()

    if class_name then
        completions = properties_cache[class_name]
    elseif is_in_new() then
        completions = instance_names
    else
        return
    end

    completions = transform(completions, context)
    callback({
        -- is_incomplete_forward = true,
        -- is_incomplete_backward = true,
        is_incomplete_forward = false,
        is_incomplete_backward = false,
        -- items = is_char_trigger and transform(emojis, context) or {},
        items = completions,
        -- items = is_in_new() and transform(properties, context) or {},
        context = context,
    })
end

---`newText` is used for `ghost_text`, thus it is set to the emoji name in `emojis`.
---Change `newText` to the actual emoji when accepting a completion.
function source:resolve(item, callback)
    local resolved = vim.deepcopy(item)
    if config.insert then
        resolved.textEdit.newText = resolved.insertText
    end
    return callback(resolved)
end

return source
